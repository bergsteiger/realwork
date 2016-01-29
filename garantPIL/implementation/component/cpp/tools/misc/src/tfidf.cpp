#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/fix/InitOrder.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

#include "ContextStreamReader.h"

INIT_ORDER_BEGIN
INIT_ORDER_END

Base* aBase = 0;

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );
	Index* index = aBase->FindIndex ("NWCntxt");
	std::vector<std::string> lemmas;
	typedef std::vector<__int64> lemmacounts_packed;
	std::map<long, long> lemma_in_docs; //лемма.в скольких документах встречаетс€
	std::map<long, double> lemma_idf;
	std::map<long, long> doc_words; //документ.сколько в нем слов
	std::map<long,lemmacounts_packed> doc_lemmas_counts_packed;
	long lemma = 0;
	for (BTIterator btit (index); !btit.End (); ++btit) {
		const char* key = (const char*)btit.Key ();
		if (key[0] & 0x80)
			break;
		Stream* str = index->Open (key);
		char *qqq = strdup (key+1);
		Recoding (cd_win, cd_dos, qqq);
		printf ("%s\r", qqq); fflush (stdout);
		free (qqq);
		if (str) {
			lemmas.push_back (key+1);
			ContextStreamReader reader (str,-1);
			Ref ref = {0,0};
			long prev_id = 0;
			long count_in_doc = 0; //сколько раз в документе встречаетс€ лемма
			long count_in_base = 0; //сколько раз в базе встречаетс€ лемма
			long docs = 1; //в скольки документах встречаетс€ лемма
			while (reader.getNextRef (ref)) {
				if (ref.DocId != prev_id) {
					if (prev_id) {
						std::map<long, lemmacounts_packed>::iterator it = doc_lemmas_counts_packed.find (prev_id);
						if (it == doc_lemmas_counts_packed.end ())
							it = doc_lemmas_counts_packed.insert (std::map<long,lemmacounts_packed>::value_type (prev_id, lemmacounts_packed ())).first;
						__int64 put = ((__int64)lemma << 32) + count_in_doc;
						it->second.push_back (put);						
					}
					docs++;
					prev_id = ref.DocId;
					count_in_doc = 0;
				}				
				count_in_base++;
				count_in_doc++;
			}
			if (count_in_base) { //может быть так, что леммы не в тексте, а только в названии
				std::map<long, lemmacounts_packed>::iterator it = doc_lemmas_counts_packed.find (ref.DocId);
				if (it == doc_lemmas_counts_packed.end ())
					it = doc_lemmas_counts_packed.insert (std::map<long,lemmacounts_packed>::value_type (ref.DocId, lemmacounts_packed ())).first;
				__int64 put = ((__int64)lemma << 32) + count_in_doc;
				it->second.push_back (put);

				lemma_in_docs.insert (std::map<long,long>::value_type (lemma, docs));
			}

			index->Close (str);
			lemma++;
		}
	}
	printf ("\n");

	for (std::map<long, lemmacounts_packed>::const_iterator doc_lemmas_counts_it = doc_lemmas_counts_packed.begin (); doc_lemmas_counts_it != doc_lemmas_counts_packed.end (); doc_lemmas_counts_it++) {
		std::map<long,long>::iterator doc_words_it = doc_words.insert (std::map<long,long>::value_type (doc_lemmas_counts_it->first, 1)).first;
		lemmacounts_packed::const_iterator it = doc_lemmas_counts_it->second.begin ();
		if (it != doc_lemmas_counts_it->second.end ()) for (it++; it != doc_lemmas_counts_it->second.end (); it++)
			doc_words_it->second++;
	}

	DocCollection* alldocs = aBase->AllDocs ();
	long C = alldocs->ItemCount, W = 0;
	double log_C_plus_1 = log (C+1.0);
	for (std::map<long,long>::const_iterator doc_words_it = doc_words.begin (); doc_words_it != doc_words.end (); doc_words_it++)
		W += doc_words_it->second;
	W /= C;
	printf ("W = %ld\n", W);
	W = 380; //ƒобров

	for (std::map<long,long>::const_iterator lemmas_in_docs_it = lemma_in_docs.begin (); lemmas_in_docs_it != lemma_in_docs.end (); lemmas_in_docs_it++ ) {
		long lemma = lemmas_in_docs_it->first;
		long Cw = lemmas_in_docs_it->second;
		double idf = log((C+0.5)/Cw)/log_C_plus_1;
		lemma_idf.insert (std::map<long,double>::value_type (lemma, idf));
	}
	printf ("idf calculated\n");
	
	for (int i = 0; i < C; i++) {
		long id = (*alldocs)[i];
		printf ("Processing doc %ld\r", id);
		if (doc_words.find (id) == doc_words.end ())
			continue;
		long Wi = doc_words.find (id)->second;
		std::map<long, lemmacounts_packed>::const_iterator doc_i = doc_lemmas_counts_packed.find (id);

		long tfidfs_size = sizeof (lemma_tfidf) * doc_i->second.size ();
		lemma_tfidf *tfidfs = (lemma_tfidf*) malloc (tfidfs_size);
		lemma_tfidf *tfidf  = tfidfs;
		for (lemmacounts_packed::const_iterator lemmas_in_i = doc_i->second.begin (); lemmas_in_i != doc_i->second.end (); lemmas_in_i++, tfidf++) {
			__int64 at_it = *lemmas_in_i;
			long lemma = (long) (at_it >> 32);
			long Nwi = (long)at_it;
			double tf = Nwi / (Nwi + 0.5 + 1.5 * (Wi / W));
			double idf = lemma_idf.find (lemma)->second;
			strncpy (tfidf->lemma, lemmas.at (lemma).c_str (), 31);
			tfidf->tfidf = tf*idf;
		}
		aBase->PutAttr (id, IDD_TFIDF, tfidfs, tfidfs_size);
		free (tfidfs);
	}
	printf ("\ntfidf calculated\n");

	delete aBase;
	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
