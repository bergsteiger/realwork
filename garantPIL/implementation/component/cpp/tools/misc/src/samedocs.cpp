#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>

#include "ace/OS.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "recode.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

#include <utility>
#include <math.h>

Base* aBase = 0;

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	return mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE * 2);
}

typedef std::deque<u_int64_t> lemmacounts_packed;
std::map<long,lemmacounts_packed> *doc_lemmas_counts_packed = new std::map<long,lemmacounts_packed>;
std::map<long,long> gd;
std::map< long,std::deque<long> > *map_docs_resps = new std::map< long,std::deque<long> >;
std::map< long,std::deque<u_int64_t> > *map_refs_resps = new std::map< long,std::deque<u_int64_t> >;
std::map<long, long> doc_words; //äîêóìåíò.ñêîëüêî â íåì ñëîâ
std::set<long> lemmas_to_skip; //ıòè ëåììû íå áóäóò ğàññìàòğèâàòüñÿ ïğè ñğàâíåíèè îáùèõ
std::map<long, double> lemma_idf;
std::map<long,double> tfidf;
std::deque<std::string> lemmas;
long	W = 0;
std::set<long>	year_docs;

double	calculate_w_link (long doc_id_i, long doc_id_j)
{
	double w_link = 0.0;
	if (gd.find (doc_id_i) != gd.end ()) {
		long gdi = gd.find (doc_id_i)->second;
		if (gd.find (doc_id_j) != gd.end ()) {
			long gdj = gd.find (doc_id_j)->second;
			std::map< long,std::deque<long> >::const_iterator map_docs_resps_i, map_docs_resps_j;
			std::map< long,std::deque<u_int64_t> >::const_iterator map_refs_resps_i, map_refs_resps_j;

			map_docs_resps_i = map_docs_resps->find (doc_id_i);
			map_docs_resps_j = map_docs_resps->find (doc_id_j);
			map_refs_resps_i = map_refs_resps->find (doc_id_i);
			map_refs_resps_j = map_refs_resps->find (doc_id_j);

			//íàäî ïîäñ÷èòàòü ÷èñëî îáùèõ ññûëîê ó äîêóìåíòîâ i è j
			std::deque<long>::const_iterator doc_resps_iter_i = map_docs_resps_i->second.begin(), doc_resps_iter_j = map_docs_resps_j->second.begin ();
			std::deque<long>::const_iterator doc_resps_last_i = map_docs_resps_i->second.end(),   doc_resps_last_j = map_docs_resps_j->second.end ();

			long c1ij = 0;
			while (doc_resps_iter_i != doc_resps_last_i && doc_resps_iter_j != doc_resps_last_j ) {
				if (*doc_resps_iter_i == *doc_resps_iter_j) {
					c1ij++;
					doc_resps_iter_i++;
					doc_resps_iter_j++;
				} else
				if (*doc_resps_iter_i < *doc_resps_iter_j)
					doc_resps_iter_i++;
				else
					doc_resps_iter_j++;
			}

			std::deque<u_int64_t>::const_iterator refs_resps_iter_i = map_refs_resps_i->second.begin(), refs_resps_iter_j = map_refs_resps_j->second.begin ();
			std::deque<u_int64_t>::const_iterator refs_resps_last_i = map_refs_resps_i->second.end(),   refs_resps_last_j = map_refs_resps_j->second.end ();

			long c2ij = 0;
			while (refs_resps_iter_i != refs_resps_last_i && refs_resps_iter_j != refs_resps_last_j ) {
				if (*refs_resps_iter_i == *refs_resps_iter_j) {
					c2ij++;
					refs_resps_iter_i++;
					refs_resps_iter_j++;
				} else
				if (*refs_resps_iter_i < *refs_resps_iter_j)
					refs_resps_iter_i++;
				else
					refs_resps_iter_j++;
			}

			w_link = (double) ((c1ij + 3*c2ij)) / (4*sqrt ((double) (gdi*gdj)));
		}
	}
	return w_link;
}

double	calculate_w_lem (long doc_id_i, long doc_id_j, long Wi)
{
	long Wj = doc_words.find (doc_id_j)->second;
	//printf ("\ncalulate w_lem for doc %ld (%ld words) and doc %ld (%ld words), tfidf_i: %f, tfidf_j: %f\n", doc_id_i, Wi, doc_id_j, Wj, tfidf.find (doc_id_i)->second, tfidf.find (doc_id_j)->second);

	//âû÷èñëèòü îáùèå ëåììû
	std::map<long, lemmacounts_packed>::const_iterator doc_i = doc_lemmas_counts_packed->find (doc_id_i);
	std::map<long, lemmacounts_packed>::const_iterator doc_j = doc_lemmas_counts_packed->find (doc_id_j);
	lemmacounts_packed::const_iterator lemmas_in_i = doc_i->second.begin (), lemmas_in_j = doc_j->second.begin ();
	std::deque<long> common_lemmas, common_lemmas_count;

	long lemma_i = (long)(*lemmas_in_i >> 32), lemma_j = (long)(*lemmas_in_j >> 32);
	lemmacounts_packed::const_iterator doc_i_end = doc_i->second.end ();
	lemmacounts_packed::const_iterator doc_j_end = doc_j->second.end ();

	double sum = 0.0;
	for (;;){
		if (lemma_i == lemma_j) {
			long Nwi = (long)(*lemmas_in_i & 0xffffffff);
			long Nwj = (long)(*lemmas_in_j & 0xffffffff);
			if (lemmas_to_skip.find (lemma_i) == lemmas_to_skip.end ()) {
				double tf_i = Nwi / (Nwi + 0.5 + 1.5 * (Wi / W));
				double tf_j = Nwj / (Nwj + 0.5 + 1.5 * (Wj / W));
				double idf = lemma_idf.find (lemma_i)->second;
				sum += (0.4+0.6*tf_i*idf)*(0.4+0.6*tf_j*idf);
				//printf ("lemma %s, sum now: %f\n", lemmas.at (lemma_i).c_str (), sum);
			}

			lemmas_in_i++;
			lemmas_in_j++;
			if (lemmas_in_i == doc_i_end || lemmas_in_j == doc_j_end)
				break;
			lemma_i = (long)(*lemmas_in_i >> 32);
			lemma_j = (long)(*lemmas_in_j >> 32);
		} else if (lemma_i < lemma_j) {
			lemmas_in_i++;
			if (lemmas_in_i == doc_i_end)
				break;
			lemma_i = (long)(*lemmas_in_i >> 32);
		} else {
			lemmas_in_j++;
			if (lemmas_in_j == doc_j_end)
				break;
			lemma_j = (long)(*lemmas_in_j >> 32);
		}
	}
	//printf ("final: w_lem = %f\n", sum / (tfidf.find (doc_id_i)->second * tfidf.find (doc_id_j)->second));
	return (sum / (tfidf.find (doc_id_i)->second * tfidf.find (doc_id_j)->second));
}

template <typename T>
class IndexDataLoader {
public:
	IndexDataLoader (const bool is_array = true) : m_is_array (is_array) {
	}

	T* load (YBase* base, const long doc_id, const int tag, long& count) {
		Core::Aptr <T> ret;
		count = 0;

		if (tag == IDD2_PARAIDS) {
			ret = (T*)base->LoadAttrEx (doc_id, tag, count);
		} else {
			ret = (T*)base->LoadAttr (doc_id, tag, count);
		}

		if (ret.ptr ()) {
			if (m_is_array) {
				count = count / sizeof (T);
			}
		} else {
			count = 0;
		}

		return ret._retn ();
	}
private:
	bool m_is_array;
};

#define	MAX_THREADS	16
typedef std::deque<long> docs_vector;

struct thread_data_struct {
	long from;
	long to;
	std::map<long, std::deque<DocRele> > samedocs_map;
	volatile int done;
};

thread_data_struct thread_data [MAX_THREADS], thread_data_2 [MAX_THREADS];

DocCollection *alldocs, *new_docs = 0, *old_docs = 0;
std::set<long> part_documents;
std::map<long,long> part_documents_from, part_documents_to;
long	C;

void	calculate_samedocs (int* thread_id)
{
	int this_thread_id = *thread_id;
	long calculated = 0, skipped = 0;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	long prev_percent = -1, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (int i = thread_data_ptr->from; i < thread_data_ptr->to; i++, pos++) {
		if ((pos * 100) / max_C != prev_percent) {
			prev_percent = (pos * 100) / max_C;
			printf ("%ld.%ld%% ", this_thread_id, prev_percent); fflush (stdout);
		}
		//printf ("\rcalc: %ld, skip: %ld ", calculated, skipped);
		long doc_id_i = (*alldocs)[i];

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		if (year_docs.size () && year_docs.find (doc_id_i) == year_docs.end ()) {
			skipped++;
			continue;
		}

		//ACE_hrtime_t m_start_count = Core::GDS::HiResCounterSingl::instance()->get_count ();

		calculated++;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < C; j++ ) {
			long doc_id_j = (*alldocs)[j];
			
			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;

			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900 || same_docs.size () == 30)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					if (same_docs.size () == 30)
						break;
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));

		/*
		unsigned sec;
		unsigned msec;
		unsigned usec;
		Core::GDS::HiResCounterSingl::instance()->tiks_to_time(Core::GDS::HiResCounterSingl::instance()->get_count () - m_start_count, sec, msec, usec);
		if (this_thread_id == 0)
			printf ("%ld.%ld.%ld ", sec, msec, usec);
		*/
	}
	thread_data_ptr->done = 1;
}

void	calculate_samedocs_new (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	long prev_percent = -1, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (int i = thread_data_ptr->from; i < thread_data_ptr->to; i++, pos++) {
		if ((pos * 100) / max_C != prev_percent) {
			prev_percent = (pos * 100) / max_C;
			printf ("%ld.%ld%% ", this_thread_id, prev_percent); fflush (stdout);
		}
		long doc_id_i = (*new_docs)[i];

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < C; j++ ) {
			long doc_id_j = (*alldocs)[j];

			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;

			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900/* || same_docs.size () == 30*/)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					/*
					if (same_docs.size () == 30)
						break;
					*/
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
	}
	thread_data_ptr->done = 1;
}

ACE_Recursive_Thread_Mutex new_doc_mutex;
long new_doc_it = 0;
long	get_new_doc (bool next)
{
	RWRITE_GUARD (new_doc_mutex) {
		if (new_doc_it == new_docs->ItemCount)
			return 0;
		long result = (*new_docs) [new_doc_it];
		if (next)
			new_doc_it++;
		return result;
	}
}

void	calculate_samedocs_new_78 (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	long prev_percent = -1, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (;;) {
		long doc_id_i = get_new_doc (true);
		if (!doc_id_i) {
			printf ("thread %ld finished\n", this_thread_id); fflush (stdout);
			break;
		}

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < C; j++ ) {
			long doc_id_j = (*alldocs)[j];

			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;

			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900/* || same_docs.size () == 30*/)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					/*
					if (same_docs.size () == 30)
						break;
					*/
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
	}
	thread_data_ptr->done = 1;
}


void	calculate_samedocs_old (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data_2 [this_thread_id]);
	long prev_percent = 0, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (int i = thread_data_ptr->from; i < thread_data_ptr->to; i++, pos++) {
		if ((pos * 100) / max_C != prev_percent) {
			prev_percent = (pos * 100) / max_C;
			printf ("%ld.%ld%% ", this_thread_id, prev_percent); fflush (stdout);
		}
		long doc_id_i = (*old_docs)[i];

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < new_docs->ItemCount; j++ ) {
			long doc_id_j = (*new_docs)[j];

			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;
			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900 || same_docs.size () == 30)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					if (same_docs.size () == 30)
						break;
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
		else {
			DocRele doc_rele = {0,0};
			same_docs.push_back (doc_rele);
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
		}
	}
	thread_data_ptr->done = 1;
}

extern	void	BuildPatternM (ContextPattern&, char*);

char*	findkey_woprefix (Index* index, char* _key)
{
	char *key = strdup (_key), *token = strtok (key, "\\"), *result = (char*) malloc (1024);
	result [0] = 0;
	long par_id = 0, next_id;
	while (token) {
		bool found = false;
		for (BTIterator it(index); !it.End () && !found; ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			if (key->parent == par_id && !strcmp (key->text + 4, token)) {
				found = true;
				next_id = key->id;
				if (strlen (result))
					strcat (result, "\\");
				strcat (result, key->text);
			}
		}
		if (!found)
			return 0;
		par_id = next_id;
		token = strtok (0, "\\");
	}
	return result;
}

void get_alldocs (int run_mode, bool show_errors, bool use_turbo)
{
	part_documents.clear ();
	part_documents_from.clear ();
	part_documents_to.clear ();
	switch (run_mode) {
		case 1:
			{
			alldocs = new DocCollection ();

			DocCollection letter_docs;
			long comments_id = 0, count = 0;
			BTIterator *btit;
			for (btit = new BTIterator (aBase->FindIndex ("Type")); !btit->End () && count < 2; ++(*btit)) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit->Key();
				if (hkey->level==0 && !strcmp (hkey->text+4, "Êîììåíòàğèè")) {
					comments_id = hkey->id;
					count++;
				}
				if (hkey->level==0 && !strcmp (hkey->text+4, "Ïèñüìî")) {
					Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
					if (str) {
						letter_docs.FastLoadRefs (str);
						aBase->FindIndex ("Type")->Close (str);
					}
					count++;
				}
			}
			delete btit;
			for (btit = new BTIterator (aBase->FindIndex ("Type")); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit->Key();
				if (hkey->level==1 && hkey->parent == comments_id && !strcmp (hkey->text+4, "Âîïğîñ-îòâåò")) {
					Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
					if (str) {						
						alldocs->FastLoadRefs (str);
						aBase->FindIndex ("Type")->Close (str);
						break;
					}
				}
			}
			delete btit;
			for (btit = new BTIterator (aBase->FindIndex ("Type")); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit->Key();
				if (hkey->level==1 && hkey->parent == comments_id && (!strcmp (hkey->text+4, "Ñòàòüÿ") || !strcmp (hkey->text+4, "Êíèãà"))) {
					Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
					if (str) {
						DocCollection minus_docs;
						minus_docs.FastLoadRefs (str);
						aBase->FindIndex ("Type")->Close (str);
						alldocs->Minus (minus_docs);
					}
				}
			}
			delete btit;

			char *adopteds[] = {
				"Ôåäåğàëüíûå ìèíèñòåğñòâà è âåäîìñòâà\\Ìèíòğóä Ğîññèè (Ìèíèñòåğñòâî òğóäà è ñîöèàëüíîãî ğàçâèòèÿ ĞÔ)",
				"Ôåäåğàëüíûå ìèíèñòåğñòâà è âåäîìñòâà\\Ğîñòğóä (Ôåäåğàëüíàÿ ñëóæáà ïî òğóäó è çàíÿòîñòè)",
				"Ãîñóäàğñòâåííûå ôîíäû\\Ïåíñèîííûé Ôîíä Ğîññèè",
				"Ãîñóäàğñòâåííûå ôîíäû\\ÔÑÑ ĞÔ (Ôîíä ñîöèàëüíîãî ñòğàõîâàíèÿ Ğîññèéñêîé Ôåäåğàöèè)",
				"Îğãàíû âëàñòè ã. Ìîñêâû\\Îòäåëåíèå ÏÔĞ ïî ã. Ìîñêâå",
				"Îğãàíû âëàñòè ã. Ìîñêâû\\Îòäåëåíèå ÏÔĞ ïî ã. Ìîñêâå è Ìîñêîâñêîé îáëàñòè",
				"Îğãàíû âëàñòè Ìîñêîâñêîé îáëàñòè\\Îòäåëåíèå ÏÔĞ ïî ÌÎ (Îòäåëåíèå Ïåíñèîííîãî ôîíäà ĞÔ ïî Ìîñêîâñêîé îáëàñòè)",
				"Îğãàíû âëàñòè Ìîñêîâñêîé îáëàñòè\\ÃÓ-ÌÎĞÎ ÔÑÑ ĞÔ (ÃÓ Ìîñêîâñêîå îáëàñòíîå Ğåãèîíàëüíîå îòäåëåíèå ÔÑÑ ĞÔ)",
				"Îğãàíû âëàñòè ã. Ñàíêò-Ïåòåğáóğãà\\Îòäåëåíèå ÏÔĞ ïî ã. Ñàíêò-Ïåòåğáóğãó",
				"Îğãàíû âëàñòè Óäìóğòñêîé Ğåñïóáëèêè\\ÃÓ-ĞÎ ÔÑÑ ĞÔ ïî ÓĞ",
				"Îğãàíû âëàñòè Àìóğñêîé îáëàñòè\\ÃÓ Àìóğñêîå ğåãèîíàëüíîå îòäåëåíèå ÔÑÑ",
				"Îğãàíû âëàñòè Àğõàíãåëüñêîé îáëàñòè\\Îòäåëåíèå ÏÔĞ ïî Àğõàíãåëüñêîé îáëàñòè",
				"Îğãàíû âëàñòè Êîñòğîìñêîé îáëàñòè\\Êîñòğîìñêîå ğåãèîíàëüíîå îòäåëåíèå ÔÑÑ ĞÔ",
				"Îğãàíû âëàñòè Íèæåãîğîäñêîé îáëàñòè\\Íèæåãîğîäñêîå ğåãèîíàëüíîå îòäåëåíèå ÔÑÑ",
				"Îğãàíû âëàñòè Êàì÷àòñêîãî êğàÿ\\Îğãàíû âëàñòè Êàì÷àòñêîé îáëàñòè\\Êàì÷àòñêîå ğåãèîíàëüíîå îòäåëåíèå ÔÑÑ ĞÔ",
				"Ôåäåğàëüíûå ìèíèñòåğñòâà è âåäîìñòâà\\Ìèíôèí Ğîññèè (Ìèíèñòåğñòâî ôèíàíñîâ ĞÔ)",
				"Ôåäåğàëüíûå ìèíèñòåğñòâà è âåäîìñòâà\\ÔÍÑ Ğîññèè (Ôåäåğàëüíàÿ íàëîãîâàÿ ñëóæáà)",
				"Îğãàíû âëàñòè Óäìóğòñêîé Ğåñïóáëèêè\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî Ëåíèíñêîìó ğàéîíó ã.Èæåâñêà ÓĞ",
				"Îğãàíû âëàñòè Óäìóğòñêîé Ğåñïóáëèêè\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 8 ïî ÓĞ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî ×óâàøñêîé Ğåñïóáëèêå",
				"Îğãàíû âëàñòè Êğàñíîäàğñêîãî êğàÿ\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî Êğàñíîäàğñêîìó êğàş",
				"Îğãàíû âëàñòè Àğõàíãåëüñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî Àğõàíãåëüñêîé îáëàñòè è Íåíåöêîìó àâòîíîìíîìó îêğóãó",
				"Îğãàíû âëàñòè Âëàäèìèğñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî Âëàäèìèğñêîé îáëàñòè",
				"Îğãàíû âëàñòè Âîëãîãğàäñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî Âîëãîãğàäñêîé îáëàñòè",
				"Îğãàíû âëàñòè Êàëèíèíãğàäñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ïî Êàëèíèíãğàäñêîé îáëàñòè",
				"Îğãàíû âëàñòè Êåìåğîâñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ïî Êåìåğîâñêîé îáëàñòè",
				"Îğãàíû âëàñòè Êîñòğîìñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî Êîñòğîìñêîé îáëàñòè",
				"Îğãàíû âëàñòè Íîâîñèáèğñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî Íîâîñèáèğñêîé îáëàñòè",
				"Îğãàíû âëàñòè Îìñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ïî Îìñêîé îáëàñòè",
				"Îğãàíû âëàñòè Ğîñòîâñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî Ğîñòîâñêîé îáëàñòè",
				"Îğãàíû âëàñòè Ñìîëåíñêîé îáëàñòè\\ÔÍÑ Ğîññèè (Ôåäåğàëüíàÿ íàëîãîâàÿ ñëóæáà) ïî Ñìîëåíñêîé îáëàñòè",
				"Îğãàíû âëàñòè Òîìñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ïî Òîìñêîé îáëàñòè",
				"Îğãàíû âëàñòè Òóëüñêîé îáëàñòè\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ Ğîññèè ïî êğóïíåéøèì íàëîãîïëàòåëüùèêàì Òóëüñêîé îáëàñòè",
				"Îğãàíû âëàñòè Òóëüñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî Òóëüñêîé îáëàñòè",
				"Îğãàíû âëàñòè Òşìåíñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî Òşìåíñêîé îáëàñòè",
				"Îğãàíû âëàñòè ×åëÿáèíñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî ×åëÿáèíñêîé îáëàñòè",
				"Îğãàíû âëàñòè ßğîñëàâñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî ßğîñëàâñêîé îáëàñòè",
				"Îğãàíû âëàñòè ßìàëî-Íåíåöêîãî àâòîíîìíîãî îêğóãà\\Óïğàâëåíèå ÔÍÑ ïî ßÍÀÎ",
				"Îğãàíû âëàñòè Ğåñïóáëèêè Êàğåëèÿ\\Òåğğèòîğèàëüíûå îğãàíû ôåäåğàëüíûõ îğãàíîâ èñïîëíèòåëüíîé âëàñòè\\Óïğàâëåíèå ÔÍÑ (Ôåäåğàëüíîé íàëîãîâîé ñëóæáû) ĞÔ ïî Ğåñïóáëèêå Êàğåëèÿ",
				"Îğãàíû âëàñòè Ğåñïóáëèêè Ìàğèé İë\\Òåğğèòîğèàëüíûå îğãàíû ôåäåğàëüíûõ îğãàíîâ èñïîëíèòåëüíîé âëàñòè\\Óïğàâëåíèå ÔÍÑ (Ôåäåğàëüíîé íàëîãîâîé ñëóæáû) ĞÔ ïî Ğåñïóáëèêå Ìàğèé İë",
				"Îğãàíû âëàñòè Êàì÷àòñêîãî êğàÿ\\Îğãàíû âëàñòè Êàì÷àòñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî Êàì÷àòñêîé îáëàñòè è Êîğÿêñêîìó ÀÎ",
				"Îğãàíû âëàñòè Ñâåğäëîâñêîé îáëàñòè\\Ìèíèñòåğñòâà è âåäîìñòâà Ñâåğäëîâñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ ĞÔ ïî Ñâåğäëîâñêîé îáëàñòè",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ã. ×åáîêñàğû\\Èíñïåêöèÿ ÔÍÑ ĞÔ ïî ã. ×åáîêñàğû",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ã. ×åáîêñàğû\\Èíñïåêöèÿ ÔÍÑ ĞÔ ïî Ëåíèíñêîìó ğàéîíó ã. ×åáîêñàğû",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ã. Íîâî÷åáîêñàğñê\\Èíñïåêöèÿ ÔÍÑ ĞÔ ïî ã. Íîâî÷åáîêñàğñê",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ã. Àëàòûğü\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 1 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ã. Êàíàø\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 4 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ã. Øóìåğëÿ\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 8 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Àëàòûğñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 1 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Àëèêîâñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 3 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Áàòûğåâñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 2 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Âóğíàğñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 3 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Èáğåñèíñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 3 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Êàíàøñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 4 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Êîçëîâñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 7 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Êîìñîìîëüñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 2 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Êğàñíîàğìåéñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 7 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Êğàñíî÷åòàéñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 6 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Ìàğèèíñêî-Ïîñàäñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 5 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Ìîğãàóøñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 6 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Ïîğåöêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 8 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Óğìàğñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 7 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Öèâèëüñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 7 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\×åáîêñàğñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 5 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Øåìóğøèíñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 2 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\Øóìåğëèíñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 8 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ßäğèíñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 6 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ßëü÷èêñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 2 ïî ×Ğ",
				"Îğãàíû âëàñòè ×óâàøñêîé Ğåñïóáëèêè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ ×óâàøñêîé Ğåñïóáëèêè\\ßíòèêîâñêèé ğàéîí\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ ĞÔ N 4 ïî ×Ğ",
				"Îğãàíû âëàñòè Ñòàâğîïîëüñêîãî êğàÿ\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ KMB\\ã. Ïÿòèãîğñê\\Èíñïåêöèÿ ÔÍÑ ĞÔ ïî ã. Ïÿòèãîğñêó",
				"Îğãàíû âëàñòè Àğõàíãåëüñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Àğõàíãåëüñêîé îáëàñòè\\ã. Àğõàíãåëüñê\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî ã. Àğõàíãåëüñê",
				"Îğãàíû âëàñòè Àğõàíãåëüñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Àğõàíãåëüñêîé îáëàñòè\\ã. Àğõàíãåëüñê\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ Ğîññèè N 7 ïî Àğõàíãåëüñêîé îáëàñòè è Íåíåöêîìó ÀÎ",
				"Îğãàíû âëàñòè Àğõàíãåëüñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Àğõàíãåëüñêîé îáëàñòè\\ã. Íîâîäâèíñê\\Ìåæğàéîííàÿ èíñïåêöèÿ ÔÍÑ Ğîññèè N 3 ïî Àğõàíãåëüñêîé îáëàñòè è Íåíåöêîìó ÀÎ",
				"Îğãàíû âëàñòè Àğõàíãåëüñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Àğõàíãåëüñêîé îáëàñòè\\ã. Ñåâåğîäâèíñê\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî ã. Ñåâåğîäâèíñêó",
				"Îğãàíû âëàñòè Èâàíîâñêîé îáëàñòè\\Óïğàâëåíèå Ôåäåğàëüíîé íàëîãîâîé ñëóæáû ïî Èâàíîâñêîé îáëàñòè",
				"Îğãàíû âëàñòè Ìóğìàíñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Ìóğìàíñêîé îáëàñòè\\ã. Àïàòèòû\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî ã. Àïàòèòû",
				"Îğãàíû âëàñòè Ìóğìàíñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Ìóğìàíñêîé îáëàñòè\\ã. Ìîí÷åãîğñê\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî ã. Ìîí÷åãîğñêó",
				"Îğãàíû âëàñòè Ìóğìàíñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Ìóğìàíñêîé îáëàñòè\\ã. Ìóğìàíñê\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî ã. Ìóğìàíñêó",
				"Îğãàíû âëàñòè Ìóğìàíñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Ìóğìàíñêîé îáëàñòè\\Ïå÷åíãñêèé ğàéîí\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî Ïå÷åíãñêîìó ğàéîíó",
				"Îğãàíû âëàñòè Ïåíçåíñêîé îáëàñòè\\Îğãàíû èñïîëíèòåëüíîé âëàñòè Ïåíçåíñêîé îáëàñòè\\Ìèíèñòåğñòâà è âåäîìñòâà Ïåíçåíñêîé îáëàñòè\\Óïğàâëåíèå ÔÍÑ Ğîññèè ïî Ïåíçåíñêîé îáëàñòè",
				"Îğãàíû âëàñòè Ñàìàğñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Ñàìàğñêîé îáë.\\ã.Ñàìàğà\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî Îêòÿáğüñêîìó ğàéîíó ã.î. Ñàìàğû",
				"Îğãàíû âëàñòè Ñàìàğñêîé îáëàñòè\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Ñàìàğñêîé îáë.\\ã.Òîëüÿòòè\\Ìåæğàéîííàÿ Èíñïåêöèÿ ÔÍÑ Ğîññèè N 2 ïî Ñàìàğñêîé îáëàñòè",
				"Îğãàíû âëàñòè Õàíòû-Ìàíñèéñêîãî àâòîíîìíîãî îêğóãà\\Îğãàíû âëàñòè ãîğîäîâ è ğàéîíîâ Õàíòû-Ìàíñèéñêîãî àâòîíîìíîãî îêğóãà\\Ãîğîä Ñóğãóò\\Èíñïåêöèÿ ÔÍÑ Ğîññèè ïî ã.Ñóğãóòó"
			};

			{
			Index* index = aBase->FindIndex ("Category");
			char* key = "Îáùèå";
			Stream* str = index->Open (key);
			if (str) {
				DocCollection category_docs;
				category_docs.Get (str);
				index->Close (str);
				letter_docs.Intersect (category_docs);
			}
			}

			{
			DocCollection adopted_docs;
			Index* index = aBase->FindIndex ("Adopted");
			for (long i = 0; i < sizeof (adopteds) / sizeof (char*); i++) {
				char* key = findkey_woprefix (index, adopteds [i]);
				if (!key) {
					if (show_errors) printf ("ERROR: bad key %s\n", adopteds [i]);
				} else {
					Stream* str = index->Open (key);
					if (str) {
						DocCollection ado_docs;
						ado_docs.Get (str);
						index->Close (str);
						adopted_docs.Merge (ado_docs);
					}
					gk_free (key);
				}
			}
			letter_docs.Intersect (adopted_docs);

			if (use_turbo) {
				Index *swords_index = aBase->FindIndex ("SWords");			
				for (int i = 0; i < letter_docs.ItemCount; i++) {
					long doc_id = letter_docs [i];
					part_documents.insert (doc_id);

					Document* doc = aBase->GetDoc (doc_id);
					long para1 = -1, para2 = -1;
					bool b_found_text = false;
					for (int para = 0; para < doc->Stat.ParaCount && (para1 == -1 || para2 == -1); para++) {
						long flags = doc->EVDFlags (doc->GetPara (para));
						if (flags & ENDT_SBS) {
							if (para2 == -1)
								para2 = para;
						}
						else
						if (flags & ENDT_HEADER) {
							if (para1 == -1)
								para1 = para;
						}
						else
						if (para1 != -1 && !b_found_text) {
							b_found_text = true;
							para1 = para;
						}
					}
					if (para1 == -1)
						para1 = 0;
					if (para2 == -1)
						para2 = doc->Stat.ParaCount-1;
					delete doc;
					Stream *str = swords_index->Open (&doc_id);
					if (str) {
						char* swords = (char*) malloc (str->Length ()+4);
						str->Read (swords, str->Length ());
						swords_index->Close (str);
						long from = ((*(long*) (swords + 3*para1)) & 0xFFFFFF) + 1, to = ((*(long*) (swords + 3*para2)) & 0xFFFFFF) + 1;
						part_documents_to.insert (std::map<long,long>::value_type (doc_id, to));
						gk_free (swords);
					}
				}
			}
			alldocs->Merge (letter_docs);
			}

			}

			break;

		case 2:
			{
			alldocs = new DocCollection;
			Index *types_index = aBase->FindIndex ("Type"), *adopted_index = aBase->FindIndex ("Adopted"), *swords_index = aBase->FindIndex ("SWords");
			BTIterator *btit;
			DocCollection part1, part2, part3, part4, part5, part6;
			for (btit = new BTIterator (types_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				if (!key->level) {
					Stream* str = types_index->Index::OpenN (key, 0);
					if (!strcmp (key->text+4, "Ïîñòàíîâëåíèå")) {
						part1.FastLoadRefs (str);
						part2.Merge (part1);
					}
					if (!strcmp (key->text+4, "Ğåøåíèå"))
						part3.FastLoadRefs (str);
					if (!strcmp (key->text+4, "Ğåøåíèå") || !strcmp (key->text+4, "Îïğåäåëåíèå") || !strcmp (key->text+4, "Ïîñòàíîâëåíèå") || !strcmp (key->text+4, "Ïğèãîâîğ")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part4.Merge (part);
					}
					if (!strcmp (key->text+4, "Ïîñòàíîâëåíèå") || !strcmp (key->text+4, "Îïğåäåëåíèå")) {
						str->Seek (0);
						part6.FastLoadRefs (str);
					}
					/*
					if (!strcmp (key->text+4, "Ïîñòàíîâëåíèå") || !strcmp (key->text+4, "Îïğåäåëåíèå")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part6.Merge (part);
					}
					if (!strcmp (key->text+4, "Ïîñòàíîâëåíèå") || !strcmp (key->text+4, "Ğåøåíèå")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part5.Merge (part);
					}
					*/
					types_index->Close (str);
				}
			}
			delete btit;
			DocCollection a_part4, a_part5, a_part6;
			bool a_part3 = false, a_part2 = false, a_part1 = false;
			for (btit = new BTIterator (adopted_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				Stream* str = adopted_index->Index::OpenN (key, 0);
				DocCollection adopteds;
				adopteds.Get (str);
				adopted_index->Close (str);
				if (!strcmp (key->text+4, "Ôåäåğàëüíûå àğáèòğàæíûå ñóäû îêğóãîâ")) {
					part1.Intersect (adopteds);
					a_part1 = true;
				}
				if (!strcmp (key->text+4, "Ïğåçèäèóì ÂÀÑ ĞÔ")) {
					part2.Intersect (adopteds);
					a_part2 = true;
				}
				if (!strcmp (key->text+4, "Âûñøèé Àğáèòğàæíûé Ñóä Ğîññèè (ÂÀÑ ĞÔ)")) {
					part3.Intersect (adopteds);
					a_part3 = true;
				}
				if (!strcmp (key->text+4, "Ïğåçèäèóì Âåğõîâíîãî Ñóäà Ğîññèè") || !strcmp (key->text+4, "Êàññàöèîííàÿ êîëëåãèÿ Âåğõîâíîãî Ñóäà Ğîññèè") || !strcmp (key->text+4, "Âîåííàÿ êîëëåãèÿ Âåğõîâíîãî Ñóäà Ğîññèè") || !strcmp (key->text+4, "Ñóäåáíàÿ êîëëåãèÿ ïî ãğàæäàíñêèì äåëàì Âåğõîâíîãî Ñóäà Ğîññèè") || !strcmp (key->text+4, "Ñóäåáíàÿ êîëëåãèÿ ïî óãîëîâíûì äåëàì Âåğõîâíîãî Ñóäà Ğîññèè") || !strcmp (key->text+4, "Ñóäû îáùåé şğèñäèêöèè"))
					a_part4.Merge (adopteds);
				if (!strcmp (key->text+4, "Àğáèòğàæíûå ñóäû ñóáúåêòîâ Ğîññèéñêîé Ôåäåğàöèè") || !strcmp (key->text+4, "Àğáèòğàæíûå àïåëëÿöèîííûå ñóäû"))
					a_part5.Merge (adopteds);
				if (!strcmp (key->text+4, "Êîíñòèòóöèîííûé Ñóä Ğîññèè (ÊÑ ĞÔ)") || !strcmp (key->text+4, "Êîíñòèòóöèîííûå è óñòàâíûå Ñóäû ñóáúåêòîâ ĞÔ"))
					a_part6.Merge (adopteds);
			}
			if (!a_part1) part1.FreeAll ();
			if (!a_part2) part2.FreeAll ();
			if (!a_part3) part3.FreeAll ();
			part4.Intersect (a_part4);
			part5.Intersect (a_part5);
			part6.Intersect (a_part6);

			delete btit;
			long i;
			for (i = 0; i < part1.ItemCount; i++)
				part_documents.insert (part1 [i]);
			
			/*
			DocCollection name_docs;
			char doc_name [DOC_NAME_SIZE];
			ContextPattern pattern;
			for (i = 0; i < part2.ItemCount; i++) {
				long id = part2 [i];
				aBase->FindDocName (id, doc_name);
				BuildPatternM (pattern, doc_name);
				bool contains = false;
				for (int j = 0; j < pattern.WordCount - 3 && !contains; j++)
					if (!strcmp (pattern.Word [j], "ÏËÅÍÓÌÀ") && !strcmp (pattern.Word [j+1], "ÂÛÑØÅÃÎ") && !strcmp (pattern.Word [j+2], "ÀĞÁÈÒĞÀÆÍÎÃÎ") && !strcmp (pattern.Word [j+3], "ÑÓÄÀ")) {
						contains = true;
						name_docs.Collection::Add (&id);
					}
			}
			part2.Minus (name_docs);
			*/
			for (i = 0; i < part2.ItemCount; i++)
				part_documents.insert (part2 [i]);

			alldocs->Merge (part1);
			alldocs->Merge (part2);
			alldocs->Merge (part3);
			alldocs->Merge (part4);
			alldocs->Merge (part5);
			alldocs->Merge (part6);

			//ïğîâåğèòü part_documents
			DocCollection bad_docs;
			for (std::set<long>::const_iterator it = part_documents.begin (); it != part_documents.end (); it++) {
				long id = *it, sub_count, para1 = -1, para2 = -1;
				SubDescEx *subs_ex = (SubDescEx*) aBase->LoadAttr (id, IDD_SUBS_EX, sub_count), *saved_subs_ex = subs_ex;
				sub_count /= sizeof (SubDescEx);
				if (sub_count) {
					for (i = 0; i < sub_count && (para1 == -1 || para2 == -1); i++, subs_ex++) {
						if ((subs_ex->Flags == SUBDESCEX_SUB || subs_ex->Flags == SUBDESCEX_BLOCK) && (subs_ex->Sub == 20005))
							para1 = subs_ex->Para;
						else
						if ((subs_ex->Flags == SUBDESCEX_SUB || subs_ex->Flags == SUBDESCEX_BLOCK) && (subs_ex->Sub == 30005))
							para2 = subs_ex->Para;
					}
					gk_free (saved_subs_ex);
				} else {
					SubDesc *subs = (SubDesc*) aBase->LoadAttr (id, IDD_SUBS, sub_count), *saved_subs = subs;
					sub_count /= sizeof (SubDesc);
					for (i = 0; i < sub_count && (para1 == -1 || para2 == -1); i++, subs++) {
						if (subs->Sub == 20005)
							para1 = subs->Para;
						else
						if (subs->Sub == 30005)
							para2 = subs->Para;
					}
					gk_free (saved_subs);
				}

				if (para2 == -1) {
					DocInfo docinfo;
					aBase->FindDocInfo (id, docinfo);
					para2 = docinfo.ParaCount - 1;
				}
				if (para1 == -1/* || para2 == -1*/) {
					if (show_errors)
						printf ("Ó äîêóìåíòà %ld íåò 20005 èëè 30005 ñàáà\n", id);
					bad_docs.Collection::Add (&id);
				} else {
					//ñîñòàâèòü ìàïó, ñ êàêîãî ïî êàêîå ñëîâî ÷èòàòü ëåêñåìû
					if (use_turbo) {
						Stream *str = swords_index->Open (&id);
						if (str) {
							char* swords = (char*) malloc (str->Length ()+4);
							str->Read (swords, str->Length ());
							swords_index->Close (str);
							long from = ((*(long*) (swords + 3*para1)) & 0xFFFFFF) + 1, to = ((*(long*) (swords + 3*para2)) & 0xFFFFFF) + 1;
							gk_free (swords);
							part_documents_from.insert (std::map<long,long>::value_type (id, from));
							part_documents_to.insert (std::map<long,long>::value_type (id, to));
						} else {
							bad_docs.Collection::Add (&id);
						}
					}
				}
			}
			alldocs->Minus (bad_docs);
			}

			break;

		case 3:
			{
			alldocs = new DocCollection;
			Index *types_index = aBase->FindIndex ("Type"), *adopted_index = aBase->FindIndex ("Adopted");
			BTIterator *btit;
			DocCollection part5;
			for (btit = new BTIterator (types_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				if (!key->level) {
					Stream* str = types_index->Index::OpenN (key, 0);
					if (!strcmp (key->text+4, "Ïîñòàíîâëåíèå") || !strcmp (key->text+4, "Ğåøåíèå")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part5.Merge (part);
					}
					types_index->Close (str);
				}
			}
			delete btit;

			DocCollection a_part5;
			for (btit = new BTIterator (adopted_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				if (!strcmp (key->text+4, "Àğáèòğàæíûå àïåëëÿöèîííûå ñóäû")) {
					Stream* str = adopted_index->Index::OpenN (key, 0);
					a_part5.Get (str);
					adopted_index->Close (str);
				}
			}
			delete btit;
			part5.Intersect (a_part5);

			alldocs->Merge (part5);
			}

			break;
	}

	if (alldocs && alldocs->ItemCount) {
		DocCollection fresh_docs;
		date date_1_1_2011;
		date_1_1_2011.da_day = 1;
		date_1_1_2011.da_mon = 1;
		date_1_1_2011.da_year = 2011;

		Index* dates_index   = aBase->FindIndex ("Date");
		for (BTIterator it (dates_index, &date_1_1_2011); !it.End (); ++it) {
			date _date = *((date*) it.Key ());
			Stream *str = dates_index->Open (it.Key ());
			if (str) {
				DocCollection dates_docs;
				dates_docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (dates_docs);
			}
		}
		alldocs->Intersect (fresh_docs);
	}
}

void localrev_adddays (revision& theRev, const int days) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = localtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 

int main_logic ( int argc, char *argv[] )
{
	if (argc < 3)
		exit (EXIT_FAILURE);

	int run_mode = 0;
	bool b_print_topics = false;
	bool b_merge = false;
	if (!stricmp (argv [1], "QA"))
		run_mode = 1;
	else
	if (!stricmp (argv [1], "Court"))
		run_mode = 2;
	else
	if (!stricmp (argv [1], "Apell"))
		run_mode = 3;
	else
	if (!stricmp (argv [1], "QA-read")) {
		run_mode = 1;
		b_print_topics = true;
	} else
	if (!stricmp (argv [1], "Court-read")) {
		run_mode = 2;
		b_print_topics = true;
	} else
	if (!stricmp (argv [1], "Apell-read")) {
		run_mode = 3;
		b_print_topics = true;
	} else
	if (!stricmp (argv [1], "QA-merge")) {
		run_mode = 1;
		b_merge = true;
	} else
	if (!stricmp (argv [1], "Court-merge")) {
		run_mode = 2;
		b_merge = true;
	} else
	if (!stricmp (argv [1], "Apell-merge")) {
		run_mode = 3;
		b_merge = true;
	} else
		exit (EXIT_FAILURE);

	bool two_bases = argc > 3 && !atol (argv [3]);
	aBase = new YBase (argv [2], ACE_OS_O_RDONLY);
	aBase->IsOk ();

	std::set<long> fresh_set;

	if (b_print_topics) {
		get_alldocs (run_mode, false, false);
		DocCollection *all_docs = aBase->AllDocs ();
		alldocs->Intersect (*all_docs);
		delete all_docs;

		{
		DocCollection fresh_docs;
		date date_1_1_2011;
		date_1_1_2011.da_day = 1;
		date_1_1_2011.da_mon = 1;
		date_1_1_2011.da_year = 2011;

		Index* dates_index   = aBase->FindIndex ("Date");
		for (BTIterator it (dates_index, &date_1_1_2011); !it.End (); ++it) {
			date _date = *((date*) it.Key ());
			Stream *str = dates_index->Open (it.Key ());
			if (str) {
				DocCollection dates_docs;
				dates_docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (dates_docs);
			}
		}
		for (int i = 0; i < fresh_docs.ItemCount; i++)
			fresh_set.insert (fresh_docs [i]);
		}

#ifndef	WIN64
		delete aBase;
#endif
		
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			if (fresh_set.find (id) != fresh_set.end ())
				printf ("%ld\n", id);
		}
		exit (EXIT_SUCCESS);
	}

	get_alldocs (run_mode, !two_bases, b_merge ? false : true);
	if (!two_bases && !alldocs->ItemCount)
		exit (EXIT_FAILURE);

	{
	DocCollection *all_docs = aBase->AllDocs ();
	alldocs->Intersect (*all_docs);
	delete all_docs;
	}

	Base* old_base = 0;
	if (two_bases) {
		//ïåğâàÿ áàçà - ñòàğàÿ, âòîğàÿ áàçà - íîâàÿ
		old_base = aBase;
		old_docs = new DocCollection (*alldocs);
		if (!stricmp (argv [3], "read")) {
			char part_file_name [32], str_to_write [32];
			sprintf (part_file_name, "samedocs_%s.next_week", argv [1]);
			FILE *part_file = mpcxc_fopen (part_file_name, "w" );

			IndexLoader old_loader (old_base);
			for (int i = 0; i < old_docs->ItemCount; i++) {
				long doc_id_i = (*old_docs)[i], old_same_docs_count;
				INDEX_DATA (DocRele) old_same_docs = old_loader.load <DocRele> (doc_id_i, IDD_SAMEDOCS, old_same_docs_count, true);
				if (old_same_docs.ptr ()) {
					sprintf (str_to_write, "%ld: ", doc_id_i);
					fputs (str_to_write, part_file);
					DocRele* old_same_docs_ptr = old_same_docs.ptr ();
					for (int docs = 0; docs < old_same_docs_count; docs++, old_same_docs_ptr++ ) {
						sprintf (str_to_write, "%ld.%ld ", old_same_docs_ptr->DocId, old_same_docs_ptr->Rele);
						fputs (str_to_write, part_file);
					}
					sprintf (str_to_write, "\n");
					fputs (str_to_write, part_file);
				}
			}
			fclose (part_file);
			delete old_base;
			exit (EXIT_SUCCESS);
		}

		aBase = new YBase (argv [3], ACE_OS_O_RDONLY);
		aBase->IsOk ();
		delete alldocs;
		get_alldocs (run_mode, true, true);

		{
		DocCollection fresh_docs;
		date date_1_1_2011;
		date_1_1_2011.da_day = 1;
		date_1_1_2011.da_mon = 1;
		date_1_1_2011.da_year = 2011;

		Index* dates_index   = aBase->FindIndex ("Date");
		for (BTIterator it (dates_index, &date_1_1_2011); !it.End (); ++it) {
			date _date = *((date*) it.Key ());
			Stream *str = dates_index->Open (it.Key ());
			if (str) {
				DocCollection dates_docs;
				dates_docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (dates_docs);
			}
		}
		for (int i = 0; i < fresh_docs.ItemCount; i++)
			fresh_set.insert (fresh_docs [i]);
		}

		{
			DocCollection* all_docs = aBase->AllDocs ();
			alldocs->Intersect (*all_docs);
			delete all_docs;
		}

		new_docs = new DocCollection (*alldocs);
		new_docs->Minus (*old_docs);
		printf ("old_docs: %ld, new_docs: %ld, all_docs: %ld\n", old_docs->ItemCount, new_docs->ItemCount, alldocs->ItemCount);
	} else {
		printf ("all_docs: %ld\n", alldocs->ItemCount);
	}

	DocCollection *all_docs = aBase->AllDocs ();

	if (two_bases && argc == 5 && !stricmp (argv [4], "vincluded")) {
		printf ("change VINCLUDED\n");
		delete aBase;
		aBase = new StdBigBase (argv [3], ACE_OS_O_RDWR);
		Index *attrs = aBase->FindIndex ("Attrs"), *dates = aBase->FindIndex ("VIncluded");
		AttrKey included_key = {0, IDD_VINCLUDED};
		date	included_date;

		char part_file_name [32], str_to_write [32];
		sprintf (part_file_name, "vincluded_%s.lst", argv [1]);
		FILE *part_file = mpcxc_fopen (part_file_name, "w" );

		for (int i = 0; i < new_docs->ItemCount; i++) {
			long doc_id_i = (*new_docs)[i];
			included_key.DocId = doc_id_i;
			Stream *str = attrs->Open (&included_key);
			if (str) {
				sprintf (str_to_write, "%ld\n", doc_id_i);
				fputs (str_to_write, part_file);
				str->Read (&included_date, sizeof (date));
				attrs->Close (str);
				revision rev;
				gk_bzero (&rev, sizeof (rev));
				rev.RevisionDate = included_date;
				localrev_adddays (rev, -(8*7));
				aBase->ReplaceAttr (doc_id_i, IDD_VINCLUDED, &rev.RevisionDate, sizeof (date));
				str = dates->Index::OpenN (&included_date, 0);
				if (str) {
					DocCollection docs;
					docs.Get (str);
					long item = docs.IndexOf (&doc_id_i);
					if (item != -1) {
						docs.atDelete (item);
						str->Seek (0);
						docs.Put (str);
						str->Trunc ();
					}
					dates->Close (str);
					if (!docs.ItemCount)
						dates->Delete (&included_date);
				}
				str = dates->Index::OpenN (&rev.RevisionDate, 0);
				if (str) {
					DocCollection docs;
					docs.Get (str);
					docs.Insert (&doc_id_i);
					str->Seek (0);
					docs.Put (str);
					str->Trunc ();
					dates->Close (str);
				}
			}
		}
		fclose (part_file);
		delete aBase;
		exit (EXIT_SUCCESS);
	}

	if (b_merge) {
		typedef std::vector<u_int64_t> map_doc_cos;
		std::map<long,map_doc_cos*> map_doc_sames;

		FILE* out_file = mpcxc_fopen (argv [argc-1], "w");
		char str_to_write [32];

		std::set<long> new_docs;

		char* str = new char [64 * 1048576];
		printf ("read files step 1");
		std::map<long,long> map_doc_count;
		for (int afile = 4; afile < argc - 1; afile++) {
			FILE* part_file = mpcxc_fopen (argv [afile], "rt");
			if (part_file) {
				char ref_str [32];
				while (!feof (part_file)) {
					if (!fgets (str, 64 * 1048576, part_file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					char* delimiter = strchr (str, ':');
					strncpy (ref_str, str, delimiter - str);
					ref_str [delimiter - str] = 0;
					long id = atol (str), size = 0;

					new_docs.insert (id);

					for (char* ptr = delimiter+2; *ptr; ) {
						Ref same_ref;
						same_ref.DocId = atol (ptr);
						same_ref.Sub = atol (strchr (ptr, '.') + 1);

						std::map<long,long>::iterator map_it = map_doc_count.find (same_ref.DocId);
						if (map_it == map_doc_count.end ()) {
							map_doc_count.insert (std::map<long,long>::value_type (same_ref.DocId, 1));
						} else {
							map_it->second++;
						}

						char* next_ptr = strchr (ptr, ' ');
						if (!next_ptr)
							break;
						ptr = next_ptr + 1;
					}
				}
			}
			fclose (part_file);
		}

		for (std::map<long,long>::const_iterator map_it = map_doc_count.begin (); map_it != map_doc_count.end (); map_it++) {
			map_doc_cos *empty = new map_doc_cos;
			empty->reserve (map_it->second);
			map_doc_sames.insert (std::map<long,map_doc_cos*>::value_type (map_it->first, empty));
		}

		printf ("read files step 2");
		for (int afile = 4; afile < argc - 1; afile++) {
			FILE* part_file = mpcxc_fopen (argv [afile], "rt");
			if (part_file) {
				char ref_str [32];
				while (!feof (part_file)) {
					if (!fgets (str, 64 * 1048576, part_file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					char* delimiter = strchr (str, ':');
					strncpy (ref_str, str, delimiter - str);
					ref_str [delimiter - str] = 0;
					long id = atol (str), size = 0;

					if (fresh_set.find (id) == fresh_set.end ())
						continue;

					sprintf (str_to_write, "%ld: ", id);
					fputs (str_to_write, out_file);
					for (char* ptr = delimiter+2; *ptr; ) {
						Ref same_ref;
						same_ref.DocId = atol (ptr);
						same_ref.Sub = atol (strchr (ptr, '.') + 1);
						if (same_ref.Sub >= 2900 && size < 100) {
							if (fresh_set.find (same_ref.DocId) != fresh_set.end ()) {
								sprintf (str_to_write, "%ld.%ld ", same_ref.DocId, same_ref.Sub);
								fputs (str_to_write, out_file);
								size++;
							}
						}

						u_int64_t to_insert = (((u_int64_t) id) << 32) + same_ref.Sub;
						std::map<long,map_doc_cos*>::iterator map_it = map_doc_sames.find (same_ref.DocId);
						if (map_it != map_doc_sames.end ())
							map_it->second->push_back (to_insert);

						char* next_ptr = strchr (ptr, ' ');
						if (!next_ptr)
							break;
						ptr = next_ptr + 1;
					}

					sprintf (str_to_write, "\n");
					fputs (str_to_write, out_file);

				}
				fclose (part_file);
			}
		}
		printf ("done\n");

		IndexLoader old_loader (old_base);
		for (long i = 0; i < old_docs->ItemCount; i++) {
			long doc_id_i = (*old_docs) [i];
			if (alldocs->IndexOf (&doc_id_i) == -1 || all_docs->IndexOf (&doc_id_i) == -1)
				continue;

			if (new_docs.find (doc_id_i) != new_docs.end ())
				continue;

			if (fresh_set.find (doc_id_i) == fresh_set.end ())
				continue;

			std::set<short> cos_set;
			std::map<short, docs_vector> map_cos;
			std::set<long> _same_docs;

			long old_same_docs_count;
			INDEX_DATA (DocRele) old_same_docs = old_loader.load <DocRele> (doc_id_i, IDD_SAMEDOCS, old_same_docs_count, true);
			if (old_same_docs.ptr ()) {
				DocRele* old_same_docs_ptr = old_same_docs.ptr ();
				for (int docs = 0; docs < old_same_docs_count; docs++, old_same_docs_ptr++ ) {
					long id = old_same_docs_ptr->DocId;
					if (all_docs->IndexOf (&id) == -1 || alldocs->IndexOf (&id) == -1 || _same_docs.find (id) != _same_docs.end () || fresh_set.find (id) == fresh_set.end ())
						continue;
					_same_docs.insert (id);
					short long_cos = old_same_docs_ptr->Rele;
					cos_set.insert (long_cos);
					std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
					map_cos_iter->second.push_back (id);
				}
			}

			std::map<long,map_doc_cos*>::iterator same_docs_iter = map_doc_sames.find (doc_id_i);
			if (same_docs_iter != map_doc_sames.end ()) {
				std::stable_sort (same_docs_iter->second->begin (), same_docs_iter->second->end ());
				for (map_doc_cos::const_iterator it = same_docs_iter->second->begin (); it != same_docs_iter->second->end (); it++) {
					//long doc_id_j = it->first;
					long doc_id_j = (long)(*it >> 32);
					if (_same_docs.find (doc_id_j) != _same_docs.end () || fresh_set.find (doc_id_j) == fresh_set.end ())
						continue;

					//short long_cos = it->second;
					short long_cos = (short)(*it & 0xFFFF);
					cos_set.insert (long_cos);
					std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
					map_cos_iter->second.push_back (doc_id_j);
				}
			}

			std::deque<DocRele> same_docs;
			for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
				short long_cos = *cos_set_it;
				if (long_cos < 2900 || same_docs.size () == 100)
					break;
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					if (same_docs.size () == 100)
						break;
				}
			}

			if (same_docs.size ()) {
				sprintf (str_to_write, "%ld: ", doc_id_i);
				fputs (str_to_write, out_file);
				for (std::deque<DocRele>::const_iterator same_docs_iter = same_docs.begin (); same_docs_iter != same_docs.end (); same_docs_iter++) {
					sprintf (str_to_write, "%ld.%ld ", same_docs_iter->DocId, same_docs_iter->Rele);
					fputs (str_to_write, out_file);
				}
				sprintf (str_to_write, "\n");
				fputs (str_to_write, out_file);
			}
		}

		fclose (out_file);

		exit (EXIT_SUCCESS);
	}

	Index* index = aBase->FindIndex ("NWCntxt");
	std::map<long, long> lemma_in_docs; //ëåììà.â ñêîëüêèõ äîêóìåíòàõ âñòğå÷àåòñÿ
	long lemma = 0;

	std::set<std::string> skip_lemmas;
#ifndef	_DEBUG
	if (run_mode == 1) {
		skip_lemmas.insert ("À");		skip_lemmas.insert ("Â");		skip_lemmas.insert ("Ã");		skip_lemmas.insert ("È");
		skip_lemmas.insert ("Ê");		skip_lemmas.insert ("Î");		skip_lemmas.insert ("Ñ");		skip_lemmas.insert ("Ó");
		skip_lemmas.insert ("ÄÎ");		skip_lemmas.insert ("ÇÀ");		skip_lemmas.insert ("ÈÇ");		skip_lemmas.insert ("ÈÕ");
		skip_lemmas.insert ("ËÈ");		skip_lemmas.insert ("ÍÀ");		skip_lemmas.insert ("ÍÅ");		skip_lemmas.insert ("ÍÊ");
		skip_lemmas.insert ("ÎÁ");		skip_lemmas.insert ("ÎÍ");		skip_lemmas.insert ("ÎÒ");		skip_lemmas.insert ("ÏÎ");
		skip_lemmas.insert ("ĞÔ");		skip_lemmas.insert ("ÑÎ");		skip_lemmas.insert ("ÒÎ");		skip_lemmas.insert ("ÔÇ");
		skip_lemmas.insert ("ÂÈÄ");		skip_lemmas.insert ("ÂÑÅ");		skip_lemmas.insert ("ÃÎÄ");		skip_lemmas.insert ("ÄËß");
		skip_lemmas.insert ("ÅÃÎ");		skip_lemmas.insert ("ÈËÈ");		skip_lemmas.insert ("ÊÀÊ");		skip_lemmas.insert ("ÎÍÀ");
		skip_lemmas.insert ("ÎÍÈ");		skip_lemmas.insert ("ÎÍÎ");		skip_lemmas.insert ("ÏĞÈ");		skip_lemmas.insert ("ÒÎÌ");
		skip_lemmas.insert ("ÒÎÒ");		skip_lemmas.insert ("×ÒÎ");		skip_lemmas.insert ("İÒÎ");		skip_lemmas.insert ("ÁÛÒÜ");
		skip_lemmas.insert ("ÂÅÑÜ");		skip_lemmas.insert ("ÄÀÒÜ");		skip_lemmas.insert ("ÅÑËÈ");		skip_lemmas.insert ("ÈÍÎÉ");
		skip_lemmas.insert ("ËÈÖÎ");		skip_lemmas.insert ("ÌÎ×Ü");		skip_lemmas.insert ("ÑÂÎÉ");		skip_lemmas.insert ("Ñ×ÅÒ");
		skip_lemmas.insert ("Ó×ÅÒ");		skip_lemmas.insert ("ÖÅËÜ");		skip_lemmas.insert ("İÒÎÒ");		skip_lemmas.insert ("ÇÀÊÎÍ");
		skip_lemmas.insert ("ÈÌÅÒÜ");		skip_lemmas.insert ("ÊÀÊÎÉ");		skip_lemmas.insert ("ÎÁĞÀÇ");		skip_lemmas.insert ("ÎĞÃÀÍ");
		skip_lemmas.insert ("ÎÒÂÅÒ");		skip_lemmas.insert ("ÏĞÀÂÎ");		skip_lemmas.insert ("ÏÓÍÊÒ");		skip_lemmas.insert ("ÑÂßÇÜ");
		skip_lemmas.insert ("ÑÓÌÌÀ");		skip_lemmas.insert ("ÒÀÊÆÅ");		skip_lemmas.insert ("ÒÀÊÎÉ");		skip_lemmas.insert ("×ÀÑÒÜ");
		skip_lemmas.insert ("×ÈÑËÎ");		skip_lemmas.insert ("ÂÎÏĞÎÑ");		skip_lemmas.insert ("ÄÀÍÍÛÉ");		skip_lemmas.insert ("ÄĞÓÃÎÉ");
		skip_lemmas.insert ("ÊÎÄÅÊÑ");		skip_lemmas.insert ("ÌÈÍÔÈÍ");		skip_lemmas.insert ("ÎÁÚÅÊÒ");		skip_lemmas.insert ("ÏÅĞÅÒÜ");
		skip_lemmas.insert ("ÏÅĞÈÎÄ");		skip_lemmas.insert ("ÏÈÑÜÌÎ");		skip_lemmas.insert ("ÏĞÀÂÛÉ");		skip_lemmas.insert ("ĞÎÑÑÈß");
		skip_lemmas.insert ("ÑËÓÆÁÀ");		skip_lemmas.insert ("ÑËÓ×ÀÉ");		skip_lemmas.insert ("ÑÒÀÒÜß");		skip_lemmas.insert ("ÒÎËÜÊÎ");
		skip_lemmas.insert ("ßÂËßÒÜ");		skip_lemmas.insert ("ÄÎËÆÍÛÉ");		skip_lemmas.insert ("ÊÎÒÎĞÛÉ");		skip_lemmas.insert ("ÏÎĞßÄÎÊ");
		skip_lemmas.insert ("ÏĞÈÁÛËÜ");		skip_lemmas.insert ("ÓÊÀÇÀÒÜ");		skip_lemmas.insert ("ÓÑËÎÂÈÅ");		skip_lemmas.insert ("ÂÊËŞ×ÀÒÜ");
		skip_lemmas.insert ("ÄÎÊÓÌÅÍÒ");		skip_lemmas.insert ("ÎÒÍÎÑÈÒÜ");		skip_lemmas.insert ("ÏÎËÓ×ÈÒÜ");		skip_lemmas.insert ("ÏĞÈÇÍÀÒÜ");
		skip_lemmas.insert ("ÑÎÃËÀÑÍÎ");		skip_lemmas.insert ("ÑĞÅÄÑÒÂÀ");		skip_lemmas.insert ("ÑĞÅÄÑÒÂÎ");		skip_lemmas.insert ("ÎÑÍÎÂÀÍÈÅ");
		skip_lemmas.insert ("ÏÎÄËÅÆÀÒÜ");		skip_lemmas.insert ("ÏÎËÎÆÅÍÈÅ");		skip_lemmas.insert ("ÑËÅÄÎÂÀÒÜ");		skip_lemmas.insert ("ÑËÅÄÓŞÙÈÉ");
		skip_lemmas.insert ("ÑÎÃËÀÑÍÛÉ");		skip_lemmas.insert ("ÓÊÀÇÀÍÍÛÉ");		skip_lemmas.insert ("ÓÒÂÅĞÄÈÒÜ");		skip_lemmas.insert ("Ó×ÈÒÛÂÀÒÜ");
		skip_lemmas.insert ("ÔÅÄÅĞÀÖÈß");		skip_lemmas.insert ("ÎÏĞÅÄÅËßÒÜ");		skip_lemmas.insert ("ÏĞÈÇÍÀÂÀÒÜ");		skip_lemmas.insert ("ÏĞÈÌÅÍÅÍÈÅ");
		skip_lemmas.insert ("ĞÅÀËÈÇÀÖÈß");		skip_lemmas.insert ("ĞÎÑÑÈÉÑÊÈÉ");		skip_lemmas.insert ("ÓÑÒÀÍÎÂÈÒÜ");		skip_lemmas.insert ("ÎĞÃÀÍÈÇÀÖÈß");
		skip_lemmas.insert ("ÏĞÎÈÇÂÎÄÈÒÜ");		skip_lemmas.insert ("ÔÅÄÅĞÀËÜÍÛÉ");		skip_lemmas.insert ("ÄÅßÒÅËÜÍÎÑÒÜ");		skip_lemmas.insert ("ÎÑÓÙÅÑÒÂËßÒÜ");
		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÈÅ");		skip_lemmas.insert ("ÏĞÅÄÓÑÌÎÒĞÅÒÜ");		skip_lemmas.insert ("ÃÎÑÓÄÀĞÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÍÀËÎÃÎÎÁËÎÆÅÍÈÅ");
		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÎÂÀÒÜ");		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÓŞÙÈÉ");		skip_lemmas.insert ("ÇÀÊÎÍÎÄÀÒÅËÜÑÒÂÎ");
	} else if (run_mode == 3) {
		skip_lemmas.insert ("À");		skip_lemmas.insert ("Á");		skip_lemmas.insert ("Â");		skip_lemmas.insert ("Ã");
		skip_lemmas.insert ("Ä");		skip_lemmas.insert ("Å");		skip_lemmas.insert ("È");		skip_lemmas.insert ("Ê");
		skip_lemmas.insert ("Ì");		skip_lemmas.insert ("Í");		skip_lemmas.insert ("Î");		skip_lemmas.insert ("Ğ");
		skip_lemmas.insert ("Ñ");		skip_lemmas.insert ("Ò");		skip_lemmas.insert ("Ó");		skip_lemmas.insert ("ÁÛ");
		skip_lemmas.insert ("ÂÎ");		skip_lemmas.insert ("ÃÊ");		skip_lemmas.insert ("ÄÎ");		skip_lemmas.insert ("ÅÅ");
		skip_lemmas.insert ("ÆÅ");		skip_lemmas.insert ("ÇÀ");		skip_lemmas.insert ("ÈÇ");		skip_lemmas.insert ("ÈÕ");
		skip_lemmas.insert ("ÊÂ");		skip_lemmas.insert ("ÍÀ");		skip_lemmas.insert ("ÍÅ");		skip_lemmas.insert ("ÍÎ");
		skip_lemmas.insert ("ÎÁ");		skip_lemmas.insert ("ÎÍ");		skip_lemmas.insert ("ÎÒ");		skip_lemmas.insert ("ÏÎ");
		skip_lemmas.insert ("ĞÔ");		skip_lemmas.insert ("ÑÎ");		skip_lemmas.insert ("ÑÒ");		skip_lemmas.insert ("ÒÎ");
		skip_lemmas.insert ("ÓË");		skip_lemmas.insert ("ÔÇ");		skip_lemmas.insert ("ÀÊÒ");		skip_lemmas.insert ("ÁÅÇ");
		skip_lemmas.insert ("ÂÈÄ");		skip_lemmas.insert ("ÂÑÅ");		skip_lemmas.insert ("ÃÎÄ");		skip_lemmas.insert ("ÄÂÀ");
		skip_lemmas.insert ("ÄËß");		skip_lemmas.insert ("ÅÃÎ");		skip_lemmas.insert ("ÈËÈ");		skip_lemmas.insert ("ÈÌß");
		skip_lemmas.insert ("ÈÑÊ");		skip_lemmas.insert ("ÊÀÊ");		skip_lemmas.insert ("ÊÎÏ");		skip_lemmas.insert ("ÌÀÉ");
		skip_lemmas.insert ("ÎÍÀ");		skip_lemmas.insert ("ÎÍÈ");		skip_lemmas.insert ("ÎÍÎ");		skip_lemmas.insert ("ÏÎÄ");
		skip_lemmas.insert ("ÏĞÈ");		skip_lemmas.insert ("ĞÓÁ");		skip_lemmas.insert ("ÑÀÌ");		skip_lemmas.insert ("ÑÓÄ");
		skip_lemmas.insert ("ÒÀÊ");		skip_lemmas.insert ("ÒÅÌ");		skip_lemmas.insert ("ÒÎÌ");		skip_lemmas.insert ("ÒÎÒ");
		skip_lemmas.insert ("ÕÎÄ");		skip_lemmas.insert ("×ÅÌ");		skip_lemmas.insert ("×ÒÎ");		skip_lemmas.insert ("İÒÎ");
		skip_lemmas.insert ("ÁÛËÎ");		skip_lemmas.insert ("ÁÛËÜ");		skip_lemmas.insert ("ÁÛÒÜ");		skip_lemmas.insert ("ÂÅÑÜ");
		skip_lemmas.insert ("ÄÀÒÀ");		skip_lemmas.insert ("ÄÀÒÜ");		skip_lemmas.insert ("ÄÅËÎ");		skip_lemmas.insert ("ÄÅÍÜ");
		skip_lemmas.insert ("ÄÅÒÜ");		skip_lemmas.insert ("ÅÑËÈ");		skip_lemmas.insert ("ÅÑÒÜ");		skip_lemmas.insert ("ÈÍÎÉ");
		skip_lemmas.insert ("ÈŞËÜ");		skip_lemmas.insert ("ÈŞÍÜ");		skip_lemmas.insert ("ÊĞÀÉ");		skip_lemmas.insert ("ËÈÁÎ");
		skip_lemmas.insert ("ËÈÖÎ");		skip_lemmas.insert ("ËÈØÜ");		skip_lemmas.insert ("ÌÀĞÒ");		skip_lemmas.insert ("ÌÅĞÀ");
		skip_lemmas.insert ("ÌÎ×Ü");		skip_lemmas.insert ("ÎÄÈÍ");		skip_lemmas.insert ("ÏÓÒÜ");		skip_lemmas.insert ("ÑÀÉÒ");
		skip_lemmas.insert ("ÑÂÎÉ");		skip_lemmas.insert ("ÑÅÁß");		skip_lemmas.insert ("ÑÈËÀ");		skip_lemmas.insert ("ÑÈËÎ");
		skip_lemmas.insert ("ÑÏÎĞ");		skip_lemmas.insert ("ÒÅÌÀ");		skip_lemmas.insert ("ÒÎÃÎ");		skip_lemmas.insert ("ÒÜÌÀ");
		skip_lemmas.insert ("ÔÀÊÒ");		skip_lemmas.insert ("ÖÅËÜ");		skip_lemmas.insert ("İÒÎÒ");		skip_lemmas.insert ("ÁÎËÅÅ");
		skip_lemmas.insert ("ÂËÅ×Ü");		skip_lemmas.insert ("ÂÛÂÎÄ");		skip_lemmas.insert ("ÃËÀÂÀ");		skip_lemmas.insert ("ÄÀËÅÅ");
		skip_lemmas.insert ("ÄÎÂÎÄ");		skip_lemmas.insert ("ÇÀÊÎÍ");		skip_lemmas.insert ("ÈÌÅÒÜ");		skip_lemmas.insert ("ÈÑÒÅÖ");
		skip_lemmas.insert ("ÊÀÊÎÉ");		skip_lemmas.insert ("ÊÎÃÄÀ");		skip_lemmas.insert ("ÊÎÏÈß");		skip_lemmas.insert ("ÊĞÎÌÅ");
		skip_lemmas.insert ("ËŞÁÎÉ");		skip_lemmas.insert ("ÌÀĞÒÀ");		skip_lemmas.insert ("ÌÀßÒÜ");		skip_lemmas.insert ("ÌÅÆÄÓ");
		skip_lemmas.insert ("ÌÅÑÒÎ");		skip_lemmas.insert ("ÌÎÆÍÎ");		skip_lemmas.insert ("ÍÎÂÛÉ");		skip_lemmas.insert ("ÍÎÌÅĞ");
		skip_lemmas.insert ("ÍÎĞÌÀ");		skip_lemmas.insert ("ÎÁĞÀÇ");		skip_lemmas.insert ("ÎÁÙÈÉ");		skip_lemmas.insert ("ÎÊĞÓÃ");
		skip_lemmas.insert ("ÎĞÃÀÍ");		skip_lemmas.insert ("ÎÒÇÛÂ");		skip_lemmas.insert ("ÏÅĞÅÄ");		skip_lemmas.insert ("ÏËÀÒÀ");
		skip_lemmas.insert ("ÏÎÑËÅ");		skip_lemmas.insert ("ÏÎÑÎË");		skip_lemmas.insert ("ÏĞÀÂÎ");		skip_lemmas.insert ("ÏĞÈÅÌ");
		skip_lemmas.insert ("ÏÓÍÊÒ");		skip_lemmas.insert ("ÏÓÒÅÌ");		skip_lemmas.insert ("ĞÀÉÎÍ");		skip_lemmas.insert ("ĞÀÌÊÀ");
		skip_lemmas.insert ("ĞÀÍÅÅ");		skip_lemmas.insert ("ĞÓÁËÜ");		skip_lemmas.insert ("ÑÂßÇÜ");		skip_lemmas.insert ("ÑÌÛÑË");
		skip_lemmas.insert ("ÑÏÎĞÀ");		skip_lemmas.insert ("ÑÒÀÒÜ");		skip_lemmas.insert ("ÑÓÄÍÎ");		skip_lemmas.insert ("ÑÓÄÜß");
		skip_lemmas.insert ("ÑÓÌÌÀ");		skip_lemmas.insert ("ÑÔÅĞÀ");		skip_lemmas.insert ("Ñ×ÅÒÛ");		skip_lemmas.insert ("ÒÀÊÆÅ");
		skip_lemmas.insert ("ÒÀÊÎÉ");		skip_lemmas.insert ("ÒÅÊÑÒ");		skip_lemmas.insert ("ÔÎĞÌÀ");		skip_lemmas.insert ("×ÀÑÒÜ");
		skip_lemmas.insert ("×ÅĞÅÇ");		skip_lemmas.insert ("×ÈÑËÎ");		skip_lemmas.insert ("ßÂÈÒÜ");		skip_lemmas.insert ("ÀÂÃÓÑÒ");
		skip_lemmas.insert ("ÀÏĞÅËÜ");		skip_lemmas.insert ("ÂÌÅÑÒÅ");		skip_lemmas.insert ("ÂÎÏĞÎÑ");		skip_lemmas.insert ("ÂÏĞÀÂÅ");
		skip_lemmas.insert ("ÂÛÄÀÒÜ");		skip_lemmas.insert ("ÂÛÑØÈÉ");		skip_lemmas.insert ("ÃËÀÂÛÉ");		skip_lemmas.insert ("ÄÀÍÍÛÅ");
		skip_lemmas.insert ("ÄÀÍÍÛÉ");		skip_lemmas.insert ("ÄÎËÃÈÉ");		skip_lemmas.insert ("ÄÎËÆÅÍ");		skip_lemmas.insert ("ÄÎËÆÍÎ");
		skip_lemmas.insert ("ÄÎËÆÍÛ");		skip_lemmas.insert ("ÄĞÓÃÎÉ");		skip_lemmas.insert ("ÆÀËÎÁÀ");		skip_lemmas.insert ("ÇÀÙÈÒÀ");
		skip_lemmas.insert ("ÈÌÅÍÍÎ");		skip_lemmas.insert ("ÊÀÆÄÛÉ");		skip_lemmas.insert ("ÊÎÄÅÊÑ");		skip_lemmas.insert ("ÌÍÅÍÈÅ");
		skip_lemmas.insert ("ÍÎßÁĞÜ");		skip_lemmas.insert ("ÎÁÚÅÊÒ");		skip_lemmas.insert ("ÎÄÍÀÊÎ");		skip_lemmas.insert ("ÎÊĞÓÃÀ");
		skip_lemmas.insert ("ÎÒÌÅÍÀ");		skip_lemmas.insert ("ÎÖÅÍÊÀ");		skip_lemmas.insert ("ÏÅĞÂÛÉ");		skip_lemmas.insert ("ÏÅĞÅÒÜ");
		skip_lemmas.insert ("ÏÈÑÜÌÎ");		skip_lemmas.insert ("ÏËÅÍÓÌ");		skip_lemmas.insert ("ÏÎÄÀÒÜ");		skip_lemmas.insert ("ÏÎÄÀ×À");
		skip_lemmas.insert ("ÏÎËÍÛÉ");		skip_lemmas.insert ("ÏÎËÜÇÀ");		skip_lemmas.insert ("ÏĞÀÂÛÉ");		skip_lemmas.insert ("ÏĞÈÄÒÈ");
		skip_lemmas.insert ("ÏĞÈÉÒÈ");		skip_lemmas.insert ("ÏĞÈÊÀÇ");		skip_lemmas.insert ("ÏĞÎÒÈÂ");		skip_lemmas.insert ("ĞÎÑÑÈß");
		skip_lemmas.insert ("ÑÅÂÅĞÎ");		skip_lemmas.insert ("ÑËÓÆÁÀ");		skip_lemmas.insert ("ÑÎÑÒÀÂ");		skip_lemmas.insert ("ÑÏÎĞÛÉ");
		skip_lemmas.insert ("ÑÑÛËÊÀ");		skip_lemmas.insert ("ÑÒÀÒÜß");		skip_lemmas.insert ("ÒÎËÜÊÎ");		skip_lemmas.insert ("ÒĞÅÒÜß");
		skip_lemmas.insert ("×ÀÑÒÜŞ");		skip_lemmas.insert ("ßÂËßÒÜ");		skip_lemmas.insert ("ßÍÂÀĞÜ");		skip_lemmas.insert ("ÀÂÃÓÑÒÀ");
		skip_lemmas.insert ("ÂÛÍÅÑÒÈ");		skip_lemmas.insert ("ÂÛÑÎÊÈÉ");		skip_lemmas.insert ("ÄÅÊÀÁĞÜ");		skip_lemmas.insert ("ÄÎËÆÍÛÉ");
		skip_lemmas.insert ("ÇÀßÂÈÒÜ");		skip_lemmas.insert ("ÈÇÓ×ÈÒÜ");		skip_lemmas.insert ("ÈÍÒÅĞÅÑ");		skip_lemmas.insert ("ÈÑÊÎÂÎÉ");
		skip_lemmas.insert ("ÊÎÒÎĞÛÉ");		skip_lemmas.insert ("ÍÀÇÂÀÒÜ");		skip_lemmas.insert ("ÍÀËÈ×ÈÅ");		skip_lemmas.insert ("ÎÁËÀÑÒÜ");
		skip_lemmas.insert ("ÎÁßÇÀÒÜ");		skip_lemmas.insert ("ÎÊÒßÁĞÜ");		skip_lemmas.insert ("ÎÒÊĞÛÒÜ");		skip_lemmas.insert ("ÎÖÅÍÈÒÜ");
		skip_lemmas.insert ("ÏÀÑÏÎĞÒ");		skip_lemmas.insert ("ÏÎÇÈÖÈß");		skip_lemmas.insert ("ÏÎĞßÄÎÊ");		skip_lemmas.insert ("ÏÎİÒÎÌÓ");
		skip_lemmas.insert ("ÏĞÀÂÈËÎ");		skip_lemmas.insert ("ÏĞÀÂÈÒÜ");		skip_lemmas.insert ("ÏĞÀÊÒÈÊ");		skip_lemmas.insert ("ÏĞÅÄÌÅÒ");
		skip_lemmas.insert ("ÏĞÈÍßÒÜ");		skip_lemmas.insert ("ÏĞÈ×ÈÍÀ");		skip_lemmas.insert ("ÏĞÎÑÈÒÜ");		skip_lemmas.insert ("ÏĞÎÖÅÑÑ");
		skip_lemmas.insert ("ĞÅØÅÍÈÅ");		skip_lemmas.insert ("ÑÂßÇÀÒÜ");		skip_lemmas.insert ("ÑÄÅËÀÒÜ");		skip_lemmas.insert ("ÑÏÎĞÍÛÉ");
		skip_lemmas.insert ("ÑÏĞÀÂÊÀ");		skip_lemmas.insert ("ÑÑÛËÀÒÜ");		skip_lemmas.insert ("ÑÒÎĞÎÍÀ");		skip_lemmas.insert ("ÑÓÁÚÅÊÒ");
		skip_lemmas.insert ("Ñ×ÈÒÀÒÜ");		skip_lemmas.insert ("ÒÅ×ÅÍÈÅ");		skip_lemmas.insert ("ÓÊÀÇÀÒÜ");		skip_lemmas.insert ("Ó×ÀÑÒÈÅ");
		skip_lemmas.insert ("ÔÅÂĞÀËÜ");		skip_lemmas.insert ("×ÀÑÒÈÒÜ");		skip_lemmas.insert ("ÂÍÈÌÀÍÈÅ");		skip_lemmas.insert ("ÂÑÒÓÏÀÒÜ");
		skip_lemmas.insert ("ÄÅÉÑÒÂÈÅ");		skip_lemmas.insert ("ÄÈĞÅÊÒÎĞ");		skip_lemmas.insert ("ÄÎÊÀÇÀÒÜ");		skip_lemmas.insert ("ÄÎÊÓÌÅÍÒ");
		skip_lemmas.insert ("ÇÀÊÎÍÍÛÉ");		skip_lemmas.insert ("ÇÀßÂËßÒÜ");		skip_lemmas.insert ("ÇÍÀ×ÅÍÈÅ");		skip_lemmas.insert ("ÈÇËÎÆÈÒÜ");
		skip_lemmas.insert ("ÈÇÌÅÍÈÒÜ");		skip_lemmas.insert ("ÈÑÕÎÄÈÒÜ");		skip_lemmas.insert ("ÊËŞ×ÅÂÎÉ");		skip_lemmas.insert ("ÊÎÌÏÀÍÈß");
		skip_lemmas.insert ("ÌÀÒÅĞÈÀË");		skip_lemmas.insert ("ÍÀĞÓØÀÒÜ");		skip_lemmas.insert ("ÍÀÕÎÄÈÒÜ");		skip_lemmas.insert ("ÎÁĞÀÒÈÒÜ");
		skip_lemmas.insert ("ÎÁÙÅÑÒÂÎ");		skip_lemmas.insert ("ÎÁÚßÂÈÒÜ");		skip_lemmas.insert ("ÎÊÀÇÀÍÈÅ");		skip_lemmas.insert ("ÎÑÍÎÂÀÒÜ");
		skip_lemmas.insert ("ÎÑÍÎÂÍÎÉ");		skip_lemmas.insert ("ÎÑÍÎÂÍÛÉ");		skip_lemmas.insert ("ÎÑÒÀÂÈÒÜ");		skip_lemmas.insert ("ÎÒÂÅÒ×ÈÊ");
		skip_lemmas.insert ("ÎÒÊÀÇÀÒÜ");		skip_lemmas.insert ("ÎÒÊĞÛÒÛÉ");		skip_lemmas.insert ("ÎÒÌÅÍÈÒÜ");		skip_lemmas.insert ("ÏÎÄÀÒÅËÜ");
		skip_lemmas.insert ("ÏÎËÀÃÀÒÜ");		skip_lemmas.insert ("ÏÎËÓ×ÈÒÜ");		skip_lemmas.insert ("ÏĞÀÂÎÂÎÉ");		skip_lemmas.insert ("ÏĞÀÊÒÈÊÀ");
		skip_lemmas.insert ("ÏĞÈÂÅÑÒÈ");		skip_lemmas.insert ("ÏĞÈÍßÒÛÉ");		skip_lemmas.insert ("ÏĞÎÂÅÑÒÈ");		skip_lemmas.insert ("ÑÅÍÒßÁĞÜ");
		skip_lemmas.insert ("ÑÎÃËÀÑÍÎ");		skip_lemmas.insert ("ÑĞÅÄÑÒÂÀ");		skip_lemmas.insert ("ÑÓÄÅÁÍÛÉ");		skip_lemmas.insert ("ÑÓÙÅÑÒÂÎ");
		skip_lemmas.insert ("ÓÊÀÇÀÍÈÅ");		skip_lemmas.insert ("ÓÒÎ×ÍÈÒÜ");		skip_lemmas.insert ("ÕÀĞÀÊÒÅĞ");		skip_lemmas.insert ("ÂÎÇÌÎÆÍÛÉ");
		skip_lemmas.insert ("ÂÎÇĞÀÆÀÒÜ");		skip_lemmas.insert ("ÂÛÍÅÑÅÍÈÅ");		skip_lemmas.insert ("ÂÛÑËÓØÀÒÜ");		skip_lemmas.insert ("ÄÎÏÓÑÊÀÒÜ");
		skip_lemmas.insert ("ÄÎÏÓÑÒÈÒÜ");		skip_lemmas.insert ("ÇÀÑÅÄÀÍÈÅ");		skip_lemmas.insert ("ÇÀÑËÓØÀÒÜ");		skip_lemmas.insert ("ÇÀßÂÈÒÅËÜ");
		skip_lemmas.insert ("ÇÀßÂËÅÍÈÅ");		skip_lemmas.insert ("ÈÇÂÅÑÒÈÒÜ");		skip_lemmas.insert ("ÈÍÑÒÀÍÖÈß");		skip_lemmas.insert ("ÈÑÏÎËÍßÒÜ");
		skip_lemmas.insert ("ÍÀÄËÅÆÀÒÜ");		skip_lemmas.insert ("ÍÀÏĞÀÂÈÒÜ");		skip_lemmas.insert ("ÍÀĞÓØÅÍÈÅ");		skip_lemmas.insert ("ÍÀÑÒÎßÙÅÅ");
		skip_lemmas.insert ("ÍÀÑÒÎßÙÈÉ");		skip_lemmas.insert ("ÍÅÊÎÒÎĞÛÉ");		skip_lemmas.insert ("ÎÁßÇÀÍÍÛÉ");		skip_lemmas.insert ("ÎÁßÇÛÂÀÒÜ");
		skip_lemmas.insert ("ÎÑÍÎÂÀÍÈÅ");		skip_lemmas.insert ("ÎÑÒÀËÜÍÎÉ");		skip_lemmas.insert ("ÎÒÄÅËÜÍÛÉ");		skip_lemmas.insert ("ÎÒÊËÎÍÈÒÜ");
		skip_lemmas.insert ("ÎÒÊËÎÍßÒÜ");		skip_lemmas.insert ("ÎÒÍÎØÅÍÈÅ");		skip_lemmas.insert ("ÏÎÂÒÎĞÍÛÉ");		skip_lemmas.insert ("ÏÎÄËÅÆÀÒÜ");
		skip_lemmas.insert ("ÏÎÄÏÈÑÀÒÜ");		skip_lemmas.insert ("ÏÎÇÂÎËßÒÜ");		skip_lemmas.insert ("ÏÎËÎÆÅÍÈÅ");		skip_lemmas.insert ("ÏÎËÓ×ÅÍÈÅ");
		skip_lemmas.insert ("ÏÎÑÊÎËÜÊÓ");		skip_lemmas.insert ("ÏÎÑËÅÄÍÈÉ");		skip_lemmas.insert ("ÏÎÑËÓÆÈÒÜ");		skip_lemmas.insert ("ÏÎÑÒÀÂÈÒÜ");
		skip_lemmas.insert ("ÏÎÑÒÓÏÈÒÜ");		skip_lemmas.insert ("ÏĞÈÇÍÀÍÈÅ");		skip_lemmas.insert ("ÏĞÈÌÅÍÈÒÜ");		skip_lemmas.insert ("ÏĞÈÌÅÍßÒÜ");
		skip_lemmas.insert ("ÏĞÈÕÎÄÈÒÜ");		skip_lemmas.insert ("ÏĞÎÂÅĞÈÒÜ");		skip_lemmas.insert ("ÏĞÎÂÅĞßÒÜ");		skip_lemmas.insert ("ÏĞÎÄÓÊÖÈß");
		skip_lemmas.insert ("ÏĞÎÑĞÎ×ÊÀ");		skip_lemmas.insert ("ĞÅÇÓËÜÒÀÒ");		skip_lemmas.insert ("ÑÂßÇÀÍÍÛÉ");		skip_lemmas.insert ("ÑÅÊĞÅÒÀĞÜ");
		skip_lemmas.insert ("ÑËÅÄÎÂÀÒÜ");		skip_lemmas.insert ("ÑËÅÄÓŞÙÈÉ");		skip_lemmas.insert ("ÑÎÂÅĞØÈÒÜ");		skip_lemmas.insert ("ÑÎÃËÀÑÈÒÜ");
		skip_lemmas.insert ("ÑÎÃËÀÑÍÛÉ");		skip_lemmas.insert ("ÑÎÄÅĞÆÀÒÜ");		skip_lemmas.insert ("ÑÎÑÒÀÂÈÒÜ");		skip_lemmas.insert ("ÑÎÑÒÎßÍÈÅ");
		skip_lemmas.insert ("ÒĞÅÁÎÂÀÒÜ");		skip_lemmas.insert ("ÓÊÀÇÀÍÍÛÉ");		skip_lemmas.insert ("ÓÊÀÇÛÂÀÒÜ");		skip_lemmas.insert ("ÓÒÂÅĞÄÈÒÜ");
		skip_lemmas.insert ("ÔÅÄÅĞÀÖÈß");		skip_lemmas.insert ("×ÀÑÒÈ×ÍÛÉ");		skip_lemmas.insert ("×ÀÑÒÍÎÑÒÜ");		skip_lemmas.insert ("ÂÎÇÍÈÊÍÓÒÜ");
		skip_lemmas.insert ("ÂÎÇĞÀÆÅÍÈÅ");		skip_lemmas.insert ("ÃÎÑÏÎØËÈÍÀ");		skip_lemmas.insert ("ÇÀÊÎÍÍÎÑÒÜ");		skip_lemmas.insert ("ÈÇÃÎÒÎÂÈÒÜ");
		skip_lemmas.insert ("ÊÎËÈ×ÅÑÒÂÎ");		skip_lemmas.insert ("ÊÎÍÊĞÅÒÍÛÉ");		skip_lemmas.insert ("ÍÀÄËÅÆÀÙÈÉ");		skip_lemmas.insert ("ÍÀÇÍÀ×ÅÍÈÅ");
		skip_lemmas.insert ("ÍÅÇÀÊÎÍÍÛÉ");		skip_lemmas.insert ("ÍÅÎÁÕÎÄÈÌÎ");		skip_lemmas.insert ("ÎÁÅÑÏÅ×ÈÒÜ");		skip_lemmas.insert ("ÎÁÆÀËÎÂÀÒÜ");
		skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÒÜ");		skip_lemmas.insert ("ÎÁÚßÑÍÅÍÈÅ");		skip_lemmas.insert ("ÎÏĞÅÄÅËÈÒÜ");		skip_lemmas.insert ("ÎÏĞÅÄÅËßÒÜ");
		skip_lemmas.insert ("ÎÑÏÀĞÈÂÀÒÜ");		skip_lemmas.insert ("ÏÎÄÄÅĞÆÀÒÜ");		skip_lemmas.insert ("ÏÎÄËÅÆÀÙÅÅ");		skip_lemmas.insert ("ÏÎÄÏÈÑÀÍÈÅ");
		skip_lemmas.insert ("ÏĞÀÂÈËÜÍÛÉ");		skip_lemmas.insert ("ÏĞÅÊĞÀÒÈÒÜ");		skip_lemmas.insert ("ÏĞÈÇÍÀÂÀÒÜ");		skip_lemmas.insert ("ÏĞÈËÎÆÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÎÈÇÂÅÑÒÈ");		skip_lemmas.insert ("ĞÎÑÑÈÉÑÊÈÉ");		skip_lemmas.insert ("ÑÎÁËŞÄÅÍÈÅ");		skip_lemmas.insert ("ÑÎÃËÀØÅÍÈÅ");
		skip_lemmas.insert ("ÑÎÄÅĞÆÀÍÈÅ");		skip_lemmas.insert ("ÑÎÑÒÀÂËßÒÜ");		skip_lemmas.insert ("ÒĞÅÁÎÂÀÍÈÅ");		skip_lemmas.insert ("ÓÑÒÀÍÎÂÈÒÜ");
		skip_lemmas.insert ("ÀĞÁÈÒĞÀÆÍÛÉ");		skip_lemmas.insert ("ÁÅÇÓÑËÎÂÍÛÉ");		skip_lemmas.insert ("ÂÎÇÌÎÆÍÎÑÒÜ");		skip_lemmas.insert ("ÃĞÀÆÄÀÍÑÊÈÉ");
		skip_lemmas.insert ("ÄÅÉÑÒÂÎÂÀÒÜ");		skip_lemmas.insert ("ÄÅÉÑÒÂÓŞÙÈÉ");		skip_lemmas.insert ("ÄÎËÆÍÎÑÒÍÎÉ");		skip_lemmas.insert ("ÈÑÑËÅÄÎÂÀÒÜ");
		skip_lemmas.insert ("ÍÅÎÁÕÎÄÈÌÛÉ");		skip_lemmas.insert ("ÍÎĞÌÀÒÈÂÍÛÉ");		skip_lemmas.insert ("ÎÁÅÑÏÅ×ÅÍÈÅ");		skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÍÈÅ");
		skip_lemmas.insert ("ÎÏĞÅÄÅËÅÍÈÅ");		skip_lemmas.insert ("ÎÏĞÎÂÅĞÃÀÒÜ");		skip_lemmas.insert ("ÎĞÃÀÍÈÇÀÖÈß");		skip_lemmas.insert ("ÎÑÓÙÅÑÒÂÈÒÜ");
		skip_lemmas.insert ("ÏÎÄÒÂÅĞÄÈÒÜ");		skip_lemmas.insert ("ÏÎÑËÅÄÑÒÂÈÅ");		skip_lemmas.insert ("ÏÎÑÒÀÍÎÂÈÒÜ");		skip_lemmas.insert ("ÏĞÀÂÎÌÅĞÍÛÉ");
		skip_lemmas.insert ("ÏĞÅÄÑÒÀÂÈÒÜ");		skip_lemmas.insert ("ÏĞÈÂËÅ×ÅÍÈÅ");		skip_lemmas.insert ("ÏĞÎÈÇÂÎÄÈÒÜ");		skip_lemmas.insert ("ĞÀÑÏÎËÎÆÈÒÜ");
		skip_lemmas.insert ("ĞÀÑÑÌÎÒĞÅÒÜ");		skip_lemmas.insert ("ÑÎÃËÀÑÎÂÀÒÜ");		skip_lemmas.insert ("ÒÅÕÍÈ×ÅÑÊÈÉ");		skip_lemmas.insert ("ÓÂÅÄÎÌËÅÍÈÅ");
		skip_lemmas.insert ("ÓÑÌÀÒĞÈÂÀÒÜ");		skip_lemmas.insert ("ÓÒÂÅĞÆÄÅÍÈÅ");		skip_lemmas.insert ("Ó×ÀÑÒÂÎÂÀÒÜ");		skip_lemmas.insert ("Ó×ÀÑÒÂÓŞÙÈÉ");
		skip_lemmas.insert ("ÔÅÄÅĞÀËÜÍÛÉ");		skip_lemmas.insert ("ÕÎÄÀÒÀÉÑÒÂÎ");		skip_lemmas.insert ("ÖÅÍÒĞÀËÜÍÛÉ");		skip_lemmas.insert ("ŞĞÈÄÈ×ÅÑÊÈÉ");
		skip_lemmas.insert ("ÄÂÓÕÌÅÑß×ÍÛÉ");		skip_lemmas.insert ("ÄÅßÒÅËÜÍÎÑÒÜ");		skip_lemmas.insert ("ÈÇÃÎÒÎÂËÅÍÈÅ");		skip_lemmas.insert ("ÈÑÏÎËÜÇÎÂÀÒÜ");
		skip_lemmas.insert ("ÈÑÑËÅÄÎÂÀÍÈÅ");		skip_lemmas.insert ("ÊÀÑÑÀÖÈÎÍÍÛÉ");		skip_lemmas.insert ("ÌÀÒÅĞÈÀËÜÍÛÉ");		skip_lemmas.insert ("ÌÎÒÈÂÈĞÎÂÀÒÜ");
		skip_lemmas.insert ("ÍÀÏĞÀÂËÅÍÍÛÉ");		skip_lemmas.insert ("ÍÅÍÀÄËÅÆÀÙÈÉ");		skip_lemmas.insert ("ÍÅÏĞÀÂÈËÜÍÛÉ");		skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÍÍÛÉ");
		skip_lemmas.insert ("ÎÏĞÅÄÅËÅÍÍÛÉ");		skip_lemmas.insert ("ÎÑÓÙÅÑÒÂËßÒÜ");		skip_lemmas.insert ("ÎÒÍÎÑÈÒÅËÜÍÎ");		skip_lemmas.insert ("ÏĞÀÂÈËÜÍÎÑÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÎÑÒÀÂÈÒÜ");		skip_lemmas.insert ("ÏĞÅÄÑÒÀÂËßÒÜ");		skip_lemmas.insert ("ÏĞÈÍÀÄËÅÆÀÒÜ");		skip_lemmas.insert ("ÏĞÎÈÇÂÎÄÑÒÂÎ");
		skip_lemmas.insert ("ĞÀÑÑÌÎÒĞÅÍÈÅ");		skip_lemmas.insert ("ĞÅÇÎËŞÒÈÂÍÛÉ");		skip_lemmas.insert ("ÑÎÂÎÊÓÏÍÎÑÒÜ");		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÈÅ");
		skip_lemmas.insert ("ÓÑÒÀÍÎÂËÅÍÈÅ");		skip_lemmas.insert ("ÀÄÌÈÍÈÑÒĞÀÖÈß");		skip_lemmas.insert ("ÀÏÅËËßÖÈÎÍÍÛÉ");		skip_lemmas.insert ("ÂÛØÅÓÊÀÇÀÍÍÛÉ");
		skip_lemmas.insert ("ÈÌÓÙÅÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÌÓÍÈÖÈÏÀËÜÍÛÉ");		skip_lemmas.insert ("ÍÅÂÎÇÌÎÆÍÎÑÒÜ");		skip_lemmas.insert ("ÍÅÏĞÀÂÎÌÅĞÍÛÉ");
		skip_lemmas.insert ("ÎÑÓÙÅÑÒÂËÅÍÈÅ");		skip_lemmas.insert ("ÎÒÍÎÑÈÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÏÎÄÒÂÅĞÆÄÅÍÈÅ");		skip_lemmas.insert ("ÏÎÑÒÀÍÎÂËÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÀÂÈÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ÏĞÅÄÑÒÀÂËÅÍÈÅ");		skip_lemmas.insert ("ÏĞÅÄÓÑÌÎÒĞÅÒÜ");		skip_lemmas.insert ("ÏĞÎÒÈÂÎĞÅ×ÈÒÜ");
		skip_lemmas.insert ("ĞÀÑÏÎËÎÆÅÍÍÛÉ");		skip_lemmas.insert ("ĞÀÑÑÌÀÒĞÈÂÀÒÜ");		skip_lemmas.insert ("ÑËÅÄÎÂÀÒÅËÜÍÎ");		skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞÈÒÜ");
		skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞßÒÜ");		skip_lemmas.insert ("ÓÑÒÀÍÀÂËÈÂÀÒÜ");		skip_lemmas.insert ("ÄÎÏÎËÍÈÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÇÀÈÍÒÅĞÅÑÎÂÀÒÜ");
		skip_lemmas.insert ("ÍÅÑÎÎÒÂÅÒÑÒÂÈÅ");		skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÍÍÎÑÒÜ");		skip_lemmas.insert ("ÎÁÑÒÎßÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ÏĞÀÂÎÍÀĞÓØÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÀÂÎÎÒÍÎØÅÍÈÅ");		skip_lemmas.insert ("ÏĞÅÄÎÑÒÀÂËÅÍÈÅ");		skip_lemmas.insert ("ÏĞÎÖÅÑÑÓÀËÜÍÛÉ");		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÅÍÍÎ");
		skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞÅÍÈÅ");		skip_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÅÍÍÀß");		skip_lemmas.insert ("ÃÎÑÓÄÀĞÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÎÒÂÅÒÑÒÂÅÍÍÎÑÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÏĞÈÍÈÌÀÒÅËÜ");		skip_lemmas.insert ("ÏĞÅÄÓÑÌÀÒĞÈÂÀÒÜ");		skip_lemmas.insert ("ĞÀÇÁÈĞÀÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ĞÅÃÈÑÒĞÀÖÈÎÍÍÛÉ");
		skip_lemmas.insert ("ĞÓÊÎÂÎÄÑÒÂÎÂÀÒÜ");		skip_lemmas.insert ("ÑÀÌÎÑÒÎßÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÎÂÀÒÜ");
		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÓŞÙÈÉ");		skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞÅÍÍÛÉ");		skip_lemmas.insert ("ÀÄÌÈÍÈÑÒĞÀÒÈÂÍÛÉ");		skip_lemmas.insert ("ÇÀÈÍÒÅĞÅÑÎÂÀÍÍÛÉ");
		skip_lemmas.insert ("ÇÀÊÎÍÎÄÀÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ÇÀĞÅÃÈÑÒĞÈĞÎÂÀÒÜ");		skip_lemmas.insert ("ÍÅÏÎÑĞÅÄÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÑÂÈÄÅÒÅËÜÑÒÂÎÂÀÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÑÅÄÀÒÅËÜÑÒÂÎÂÀÒÜ");		skip_lemmas.insert ("ÏĞÅÄÑÅÄÀÒÅËÜÑÒÂÓŞÙÈÉ");
	} if (run_mode == 2) {
		skip_lemmas.insert ("Ì");		skip_lemmas.insert ("Í");
		skip_lemmas.insert ("Ğ");		skip_lemmas.insert ("Ò");
		skip_lemmas.insert ("Õ");		skip_lemmas.insert ("ß");
		skip_lemmas.insert ("ÃÎ");		skip_lemmas.insert ("ÊÀ");
		skip_lemmas.insert ("ÑÒ");		skip_lemmas.insert ("ÓÆ");
		skip_lemmas.insert ("ÂÍÅ");		skip_lemmas.insert ("ÃÄÅ");
		skip_lemmas.insert ("ĞßÄ");		skip_lemmas.insert ("ÓÆÅ");
		skip_lemmas.insert ("ÔÍÑ");		skip_lemmas.insert ("×ÀÑ");
		skip_lemmas.insert ("ÂĞÅÄ");		skip_lemmas.insert ("ÃĞÓÇ");
		skip_lemmas.insert ("ÄÎËß");		skip_lemmas.insert ("ÄÎÌÀ");
		skip_lemmas.insert ("ÈÔÍÑ");		skip_lemmas.insert ("ÊÎÀÏ");
		skip_lemmas.insert ("ÏËÀÍ");		skip_lemmas.insert ("ÏßÒÜ");
		skip_lemmas.insert ("ÑÀÉÒ");		skip_lemmas.insert ("ÑÅÁÅ");
		skip_lemmas.insert ("ÑÅÒÜ");		skip_lemmas.insert ("ÒÅ×Ü");
		skip_lemmas.insert ("ÒĞÓÄ");		skip_lemmas.insert ("ÕÎÒß");
		skip_lemmas.insert ("×ÀÑÛ");		skip_lemmas.insert ("ßÂÊÀ");
		skip_lemmas.insert ("ÀÃÅÍÒ");		skip_lemmas.insert ("ÂÍÎÂÜ");
		skip_lemmas.insert ("ÂÎËÃÎ");		skip_lemmas.insert ("ÂÑÅÃÎ");
		skip_lemmas.insert ("ÆÈËÎÉ");		skip_lemmas.insert ("ÇÅÌËß");
		skip_lemmas.insert ("ÌÅÍÅÅ");		skip_lemmas.insert ("ÌÎÆÍÎ");
		skip_lemmas.insert ("ÎÒÂÅÒ");		skip_lemmas.insert ("ÎÒ×ÅÒ");
		skip_lemmas.insert ("ĞÛÍÎÊ");		skip_lemmas.insert ("ÑÄÀ×À");
		skip_lemmas.insert ("ÑÅĞÈß");		skip_lemmas.insert ("ÒÀĞÈÔ");
		skip_lemmas.insert ("ÒÎÃÄÀ");		skip_lemmas.insert ("ÓÇÊÈÉ");
		skip_lemmas.insert ("ÓÙÅĞÁ");		skip_lemmas.insert ("ÀÍÀËÈÇ");
		skip_lemmas.insert ("ÂÂÅÑÒÈ");		skip_lemmas.insert ("ÂÅĞÍÛÉ");
		skip_lemmas.insert ("ÂËÈßÒÜ");		skip_lemmas.insert ("ÂÒÎĞÎÅ");
		skip_lemmas.insert ("ÂÛÄÀ×À");		skip_lemmas.insert ("ÂÛÏÓÑÊ");
		skip_lemmas.insert ("ÄÀÂÀÒÜ");		skip_lemmas.insert ("ÄÎÊËÀÄ");
		skip_lemmas.insert ("ÄÎËÈÒÜ");		skip_lemmas.insert ("ÄÎĞÎÃÀ");
		skip_lemmas.insert ("ÇÀÌÅÍÀ");		skip_lemmas.insert ("ÇÀÏÈÑÜ");
		skip_lemmas.insert ("ÈÑÒÅ×Ü");		skip_lemmas.insert ("ËÈ×ÍÛÉ");
		skip_lemmas.insert ("ËÈØÈÒÜ");		skip_lemmas.insert ("ÍÀÄÇÎĞ");
		skip_lemmas.insert ("ÍÀ×ÀËÎ");		skip_lemmas.insert ("ÍÀ×ÀÒÜ");
		skip_lemmas.insert ("ÍÎÑÈÒÜ");		skip_lemmas.insert ("ÏÎÄĞßÄ");
		skip_lemmas.insert ("ÏĞÎÅÊÒ");		skip_lemmas.insert ("ÏĞßÌÎÉ");
		skip_lemmas.insert ("ĞÀÇÄÅË");		skip_lemmas.insert ("ĞÅÌÎÍÒ");
		skip_lemmas.insert ("ĞÅÑÓĞÑ");		skip_lemmas.insert ("ĞÅØÈÒÜ");
		skip_lemmas.insert ("ÑÂÅĞÊÀ");		skip_lemmas.insert ("ÑÒÀÒÓÑ");
		skip_lemmas.insert ("ÒÅĞÅÒÜ");		skip_lemmas.insert ("ÒÛÑß×À");
		skip_lemmas.insert ("ÕÎÒÅÒÜ");		skip_lemmas.insert ("ÖÅËÈÒÜ");
		skip_lemmas.insert ("ÀÄÂÎÊÀÒ");		skip_lemmas.insert ("ÁÀÍÊĞÎÒ");
		skip_lemmas.insert ("ÂÊËŞ×Àß");		skip_lemmas.insert ("ÂÍÎÑÈÒÜ");
		skip_lemmas.insert ("ÂßÒÑÊÈÉ");		skip_lemmas.insert ("ÃĞÀÍÈÖÀ");
		skip_lemmas.insert ("ÄÅÂßÒÛÉ");		skip_lemmas.insert ("ÄÅËÎÂÎÉ");
		skip_lemmas.insert ("ÄÎĞÎÃÎÉ");		skip_lemmas.insert ("ÇÍÀ×ÈÒÜ");
		skip_lemmas.insert ("ÊÀÏÈÒÀË");		skip_lemmas.insert ("ÌÀÃÀÇÈÍ");
		skip_lemmas.insert ("ÍÈÊÀÊÎÉ");		skip_lemmas.insert ("ÎÁÚÅÑÒÜ");
		skip_lemmas.insert ("ÎÁÛ×ÍÛÉ");		skip_lemmas.insert ("ÎÒÌÅÒÊÀ");
		skip_lemmas.insert ("Î×ÅĞÅÄÜ");		skip_lemmas.insert ("ÏÀÑÏÎĞÒ");
		skip_lemmas.insert ("ÏÅĞÅĞÛÂ");		skip_lemmas.insert ("ÏÅĞÅÕÎÄ");
		skip_lemmas.insert ("ÏÎÄÏÈÑÜ");		skip_lemmas.insert ("ÏÎÍßÒÈÅ");
		skip_lemmas.insert ("ÏĞÀÊÒÈÊ");		skip_lemmas.insert ("ÏĞÈÅÌÊÀ");
		skip_lemmas.insert ("ÏĞÈÍÖÈÏ");		skip_lemmas.insert ("ÏĞÈÑÒÀÂ");
		skip_lemmas.insert ("ĞÀÁÎ×ÈÉ");		skip_lemmas.insert ("ĞÀÇÍÈÖÀ");
		skip_lemmas.insert ("ĞÅÑÓĞÑÛ");		skip_lemmas.insert ("ÑÂÎÁÎÄÀ");
		skip_lemmas.insert ("ÑËÎÆÈÒÜ");		skip_lemmas.insert ("ÑÎÇÄÀÒÜ");
		skip_lemmas.insert ("ÑÏÎĞÎÒÜ");		skip_lemmas.insert ("ÑÒĞÀÕÎÂ");
		skip_lemmas.insert ("ÒÀÌÎÆÍß");		skip_lemmas.insert ("ÒÅÊÓÙÈÉ");
		skip_lemmas.insert ("ÓĞÎÂÅÍÜ");		skip_lemmas.insert ("Ó×ÅÒÍÛÉ");
		skip_lemmas.insert ("ÔÈÍÀÍÑÛ");		skip_lemmas.insert ("ÔÓÍÊÖÈß");
		skip_lemmas.insert ("İÍÅĞÃÈß");		skip_lemmas.insert ("ÀĞÅÍÄÍÛÉ");
		skip_lemmas.insert ("ÂÇÀÈÌÍÛÉ");		skip_lemmas.insert ("ÂÈÍÎÂÍÛÉ");
		skip_lemmas.insert ("ÂËÀÄÅËÅÖ");		skip_lemmas.insert ("ÂËÀÄÅÍÈÅ");
		skip_lemmas.insert ("ÃĞÓÇÎÂÎÉ");		skip_lemmas.insert ("ÃĞÓÇÎÂÛÉ");
		skip_lemmas.insert ("ÄÂÈÆÅÍÈÅ");		skip_lemmas.insert ("ÇÀÂÈÑÅÒÜ");
		skip_lemmas.insert ("ÇÀÍÈÌÀÒÜ");		skip_lemmas.insert ("ÈÇËÈØÍÈÉ");
		skip_lemmas.insert ("ÈÍÒÅĞÍÅÒ");		skip_lemmas.insert ("ÈÑÒÎ×ÍÈÊ");
		skip_lemmas.insert ("ÊÀÑÑÎÂÛÉ");		skip_lemmas.insert ("ÊËŞ×ÅÂÎÉ");
		skip_lemmas.insert ("ÊÎÌÏËÅÊÑ");		skip_lemmas.insert ("ÌÅÑß×ÍÛÉ");
		skip_lemmas.insert ("ÍÀ×ÈÍÀÒÜ");		skip_lemmas.insert ("ÍÅÂÅĞÍÛÉ");
		skip_lemmas.insert ("ÎÁËÀÃÀÒÜ");		skip_lemmas.insert ("ÎÁËÀÄÀÒÜ");
		skip_lemmas.insert ("ÎÁĞÀÒÍÛÉ");		skip_lemmas.insert ("ÎÑÒÀÒÜÑß");
		skip_lemmas.insert ("ÎÒ×ÅÒÍÛÉ");		skip_lemmas.insert ("ÏÅĞÅĞÛÒÜ");
		skip_lemmas.insert ("ÏÎÃÀÑÈÒÜ");		skip_lemmas.insert ("ÏÎÄÀÂÀÒÜ");
		skip_lemmas.insert ("ÏÎËÓ×ÀÒÜ");		skip_lemmas.insert ("ÏÎÌÎÙÍÈÊ");
		skip_lemmas.insert ("ÏÎÍÈÌÀÒÜ");		skip_lemmas.insert ("ÏÎ×ÒÎÂÛÉ");
		skip_lemmas.insert ("ÏÎßÑÍÈÒÜ");		skip_lemmas.insert ("ÏĞÀÊÒÈÊÀ");
		skip_lemmas.insert ("ÑÎÇÄÀÍÈÅ");		skip_lemmas.insert ("ÑÎÎÁÙÈÒÜ");
		skip_lemmas.insert ("ÒÎÂÀĞÍÛÉ");		skip_lemmas.insert ("ÒÎĞÃÎÂËß");
		skip_lemmas.insert ("ÒĞÓÄÎÂÎÉ");		skip_lemmas.insert ("ÓÑÒÀÂÍÎÉ");
		skip_lemmas.insert ("ÓÑÒÀÂÍÛÉ");		skip_lemmas.insert ("ÓÒĞÀÒÈÒÜ");
		skip_lemmas.insert ("ÕĞÀÍÅÍÈÅ");		skip_lemmas.insert ("ØÒĞÀÔÍÎÉ");
		skip_lemmas.insert ("ÀÃÅÍÒÑÒÂÎ");		skip_lemmas.insert ("ÀĞÅÍÄÀÒÎĞ");
		skip_lemmas.insert ("ÁŞÄÆÅÒÍÛÉ");		skip_lemmas.insert ("ÂÎÇÁÓÄÈÒÜ");
		skip_lemmas.insert ("ÂÛÏËÀÒÈÒÜ");		skip_lemmas.insert ("ÂÛÏÎËÍßÒÜ");
		skip_lemmas.insert ("ÂÛÑÒÓÏÀÒÜ");		skip_lemmas.insert ("ÂÛßÑÍÅÍÈÅ");
		skip_lemmas.insert ("ÇÀÊËŞ×ÀÒÜ");		skip_lemmas.insert ("ÇÀÊĞÅÏÈÒÜ");
		skip_lemmas.insert ("ÈÇÂÅÑÒÍÛÉ");		skip_lemmas.insert ("ÈÇÂÅÙÅÍÈÅ");
		skip_lemmas.insert ("ÈÑÊËŞ×ÀÒÜ");		skip_lemmas.insert ("ÈÑÊËŞ×ÈÒÜ");
		skip_lemmas.insert ("ÊÀÒÅÃÎĞÈß");		skip_lemmas.insert ("ÊÂÈÒÀÍÖÈß");
		skip_lemmas.insert ("ÊĞÅÄÈÒÍÛÉ");		skip_lemmas.insert ("ÍÀÄËÅÆÀÙÅ");
		skip_lemmas.insert ("ÍÀÊÀÇÀÍÈÅ");		skip_lemmas.insert ("ÍÀ×ÀËÜÍÈÊ");
		skip_lemmas.insert ("ÍÅÓÑÒÎÉÊÀ");		skip_lemmas.insert ("ÍÈ×ÒÎÆÍÛÉ");
		skip_lemmas.insert ("ÎÊÀÇÛÂÀÒÜ");		skip_lemmas.insert ("ÎÒÍÅÑÅÍÈÅ");
		skip_lemmas.insert ("ÎÖÅÍÈÂÀÒÜ");		skip_lemmas.insert ("ÏÅĞÅÂÎÇÊÀ");
		skip_lemmas.insert ("ÏÎÄĞßÄ×ÈÊ");		skip_lemmas.insert ("ÏÎßÑÍÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÅÒÅÍÇÈß");		skip_lemmas.insert ("ÏĞÈÂÎÄÈÒÜ");
		skip_lemmas.insert ("ÏĞÈËÎÆÈÒÜ");		skip_lemmas.insert ("ÏĞÎÈÇÎÉÒÈ");
		skip_lemmas.insert ("ÏÓÁËÈ×ÍÛÉ");		skip_lemmas.insert ("ĞÀÇËÈ×ÍÛÉ");
		skip_lemmas.insert ("ĞÀÇĞÅØÀÒÜ");		skip_lemmas.insert ("ÑÅÊĞÅÒÀĞÜ");
		skip_lemmas.insert ("ÑÎÂÅĞØÀÒÜ");		skip_lemmas.insert ("ÑÎÃËÀØÀÒÜ");
		skip_lemmas.insert ("ÑÎÇÄÀÂÀÒÜ");		skip_lemmas.insert ("ÑÎÎÁÙÅÍÈÅ");
		skip_lemmas.insert ("ÒĞÀÍÑÏÎĞÒ");		skip_lemmas.insert ("ÓÂÅËÈ×ÈÒÜ");
		skip_lemmas.insert ("ÓÒÎ×ÍÅÍÈÅ");		skip_lemmas.insert ("ÕÎÇßÉÑÒÂÎ");
		skip_lemmas.insert ("ÀĞÅÍÄÎÂÀÒÜ");		skip_lemmas.insert ("ÁÀÍÊÎÂÑÊÈÉ");
		skip_lemmas.insert ("ÂÍÓÒĞÅÍÍÈÉ");		skip_lemmas.insert ("ÄÀËÜÍÅÉØÈÉ");
		skip_lemmas.insert ("ÄÎÃÎÂÎĞÍÛÉ");		skip_lemmas.insert ("ÈÍÑÒĞÓÊÖÈß");
		skip_lemmas.insert ("ÊÎÍÊÓĞÑÍÛÉ");		skip_lemmas.insert ("ÊÎÍÒĞÀÃÅÍÒ");
		skip_lemmas.insert ("ËÈÊÂÈÄÀÖÈß");		skip_lemmas.insert ("ÍÅÂÎÇÌÎÆÍÎ");
		skip_lemmas.insert ("ÎÁÓÑËÎÂÈÒÜ");		skip_lemmas.insert ("ÎÏËÀ×ÈÂÀÒÜ");
		skip_lemmas.insert ("ÎÑÂÎÁÎÄÈÒÜ");		skip_lemmas.insert ("ÏÅÍÑÈÎÍÍÛÉ");
		skip_lemmas.insert ("ÏÎÄÃÎÒÎÂÊÀ");		skip_lemmas.insert ("ÏÎÄÏÈÑÀÍÈÅ");
		skip_lemmas.insert ("ÏÎËÜÇÎÂÀÒÜ");		skip_lemmas.insert ("ÏÎÑÒÎßÍÍÛÉ");
		skip_lemmas.insert ("ÏĞÅÊĞÀÙÀÒÜ");		skip_lemmas.insert ("ÏĞÈÂËÅÊÀÒÜ");
		skip_lemmas.insert ("ÏĞÈ×ÈÍÅÍÈÅ");		skip_lemmas.insert ("ÏĞÎÏÓÑÒÈÒÜ");
		skip_lemmas.insert ("ĞÀÇÌÅÙÅÍÈÅ");		skip_lemmas.insert ("ÑÎÂÌÅÑÒÍÛÉ");
		skip_lemmas.insert ("ÑÎÎĞÓÆÅÍÈÅ");		skip_lemmas.insert ("ÑÏÅÖÈÀËÈÑÒ");
		skip_lemmas.insert ("ÓÂÅËÈ×ÅÍÈÅ");		skip_lemmas.insert ("ÓÑÒĞÀÍÅÍÈÅ");
		skip_lemmas.insert ("ÓÒÂÅĞÆÄÀÒÜ");		skip_lemmas.insert ("Ó×ĞÅÄÈÒÅËÜ");
		skip_lemmas.insert ("İÊÑÏÅĞÒÈÇÀ");		skip_lemmas.insert ("ÁÅÇÓÑËÎÂÍÛÉ");
		skip_lemmas.insert ("ÂÎÇÁÓÆÄÅÍÈÅ");		skip_lemmas.insert ("ÃÎÑÓÄÀĞÑÒÂÎ");
		skip_lemmas.insert ("ÄÅÏÀĞÒÀÌÅÍÒ");		skip_lemmas.insert ("ÄÎÑÒÎÂÅĞÍÛÉ");
		skip_lemmas.insert ("ÅÆÅÌÅÑß×ÍÛÉ");		skip_lemmas.insert ("ÈÍÎÑÒĞÀÍÍÛÉ");
		skip_lemmas.insert ("ÊÀÄÀÑÒĞÎÂÛÉ");		skip_lemmas.insert ("ÊÀËÅÍÄÀĞÍÛÉ");
		skip_lemmas.insert ("ÊÎÌÏÅÍÑÀÖÈß");		skip_lemmas.insert ("ÊÎÍÑÒÈÒÓÖÈß");
		skip_lemmas.insert ("ÌÅĞÎÏĞÈßÒÈÅ");		skip_lemmas.insert ("ÌÈÍÈÌÀËÜÍÛÉ");
		skip_lemmas.insert ("ÍÀÑÒÓÏËÅÍÈÅ");		skip_lemmas.insert ("ÍÅÂÎÇÌÎÆÍÛÉ");
		skip_lemmas.insert ("ÎÃĞÀÍÈ×ÅÍÈÅ");		skip_lemmas.insert ("ÎÑÂÎÁÎÆÄÀÒÜ");
		skip_lemmas.insert ("ÎÑÎÁÅÍÍÎÑÒÜ");		skip_lemmas.insert ("ÎÑÏÀĞÈÂÀÍÈÅ");
		skip_lemmas.insert ("ÏÎÒĞÅÁÈÒÅËÜ");		skip_lemmas.insert ("ÏĞÅÄËÎÆÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÅÏßÒÑÒÂÈÅ");		skip_lemmas.insert ("ÏĞÈÎÁĞÅÒÀÒÜ");
		skip_lemmas.insert ("ĞÀÇÚßÑÍÅÍÈÅ");		skip_lemmas.insert ("ĞÀÑÒÎĞÆÅÍÈÅ");
		skip_lemmas.insert ("ÑÎÁÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÒĞÈÍÀÄÖÀÒÛÉ");
		skip_lemmas.insert ("ÓÏĞÀÂËßŞÙÈÉ");		skip_lemmas.insert ("ÀĞÅÍÄÎÄÀÒÅËÜ");
		skip_lemmas.insert ("ÂÎÇÁÓÆÄÅÍÍÛÉ");		skip_lemmas.insert ("ÂÏÎÑËÅÄÑÒÂÈÈ");
		skip_lemmas.insert ("ÄÂÓÕÌÅÑß×ÍÛÉ");		skip_lemmas.insert ("ÄÎÊÓÌÅÍÒÀÖÈß");
		skip_lemmas.insert ("ÇÍÀ×ÈÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÈÇÃÎÒÎÂËÅÍÈÅ");
		skip_lemmas.insert ("ÊÎÌÌÓÍÀËÜÍÛÉ");		skip_lemmas.insert ("ÍÀÈÌÅÍÎÂÀÍÈÅ");
		skip_lemmas.insert ("ÍÅÇÀÊÎÍÍÎÑÒÜ");		skip_lemmas.insert ("ÍÅÏĞÈÌÅÍÅÍÈÅ");
		skip_lemmas.insert ("ÍÅÑÎÁËŞÄÅÍÈÅ");		skip_lemmas.insert ("ÎÁÅÑÏÅ×ÈÂÀÒÜ");
		skip_lemmas.insert ("ÎÁÎĞÓÄÎÂÀÍÈÅ");		skip_lemmas.insert ("ÎÁÑËÓÆÈÂÀÍÈÅ");
		skip_lemmas.insert ("ÎÁÙÅÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÏĞÅÄÏÎËÀÃÀÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÑÅÄÀÒÅËÜ");		skip_lemmas.insert ("ĞÅÃÈÎÍÀËÜÍÛÉ");
		skip_lemmas.insert ("ÑÂÅĞÄËÎÂÑÊÈÉ");		skip_lemmas.insert ("ÑÎÃËÀÑÎÂÀÍÈÅ");
		skip_lemmas.insert ("ÑÒĞÎÈÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÑÓÙÅÑÒÂÎÂÀÒÜ");
		skip_lemmas.insert ("ÓÂÅÄÎÌËÅÍÍÛÉ");		skip_lemmas.insert ("ÄÎÑÒÎÂÅĞÍÎÑÒÜ");
		skip_lemmas.insert ("ÎÄÍÎÑÒÎĞÎÍÍÈÉ");		skip_lemmas.insert ("ÎÊÎÍ×ÀÒÅËÜÍÛÉ");
		skip_lemmas.insert ("ÏÅĞÅ×ÈÑËÅÍÍÛÉ");		skip_lemmas.insert ("ÏÎÄĞÀÇÄÅËÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÀÂÎÏĞÅÅÌÍÈÊ");		skip_lemmas.insert ("ÏĞÈÌÅÍÈÒÅËÜÍÎ");
		skip_lemmas.insert ("ĞÀÑÏĞÅÄÅËÅÍÈÅ");		skip_lemmas.insert ("ĞÅÃÓËÈĞÎÂÀÍÈÅ");
		skip_lemmas.insert ("ÑÎÃËÀÑÎÂÀÍÍÛÉ");		skip_lemmas.insert ("ÓÄÎÑÒÎÂÅĞÅÍÈÅ");
		skip_lemmas.insert ("Ó×ĞÅÄÈÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÄÅÉÑÒÂÈÒÅËÜÍÛÉ");
		skip_lemmas.insert ("ÈÍÔÎĞÌÀÖÈÎÍÍÛÉ");		skip_lemmas.insert ("ÈÑÊËŞ×ÈÒÅËÜÍÛÉ");
		skip_lemmas.insert ("ÏÅĞÂÎÍÀ×ÀËÜÍÛÉ");		skip_lemmas.insert ("ÏĞÅÏßÒÑÒÂÎÂÀÒÜ");
		skip_lemmas.insert ("ÏĞÈÍÓÄÈÒÅËÜÍÛÉ");		skip_lemmas.insert ("ĞÀÑÏĞÎÑÒĞÀÍßÒÜ");
		skip_lemmas.insert ("ÔÈÍÀÍÑÈĞÎÂÀÍÈÅ");		skip_lemmas.insert ("ÆÅËÅÇÍÎÄÎĞÎÆÍÛÉ");
		skip_lemmas.insert ("ÇÀÊÎÍÎÄÀÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÊÂÀËÈÔÈÖÈĞÎÂÀÒÜ");
		skip_lemmas.insert ("ÍÅÎÑÍÎÂÀÒÅËÜÍÛÉ");		skip_lemmas.insert ("ÏĞÅÄÂÀĞÈÒÅËÜÍÛÉ");
		skip_lemmas.insert ("ÏĞÈÎÑÒÀÍÎÂËÅÍÈÅ");		skip_lemmas.insert ("ĞÅÃÈÑÒĞÀÖÈÎÍÍÛÉ");
		skip_lemmas.insert ("ÇÀĞÅÃÈÑÒĞÈĞÎÂÀÍÍÛÉ");

		skip_lemmas.insert ("À");	skip_lemmas.insert ("Â");	skip_lemmas.insert ("Ã");	skip_lemmas.insert ("Ä");
		skip_lemmas.insert ("Å");	skip_lemmas.insert ("È");	skip_lemmas.insert ("Ê");	skip_lemmas.insert ("Î");
		skip_lemmas.insert ("Ñ");	skip_lemmas.insert ("Ó");	skip_lemmas.insert ("ÂÎ");	skip_lemmas.insert ("ÄÎ");
		skip_lemmas.insert ("ÅÅ");	skip_lemmas.insert ("ÆÅ");	skip_lemmas.insert ("ÇÀ");	skip_lemmas.insert ("ÈÇ");
		skip_lemmas.insert ("ÈÕ");	skip_lemmas.insert ("ÊÂ");	skip_lemmas.insert ("ËÈ");	skip_lemmas.insert ("ÍÀ");
		skip_lemmas.insert ("ÍÅ");	skip_lemmas.insert ("ÍÎ");	skip_lemmas.insert ("ÎÁ");	skip_lemmas.insert ("ÎÍ");
		skip_lemmas.insert ("ÎÒ");	skip_lemmas.insert ("ÏÎ");	skip_lemmas.insert ("ĞÔ");	skip_lemmas.insert ("ÑÎ");
		skip_lemmas.insert ("ÒÎ");	skip_lemmas.insert ("ÓË");	skip_lemmas.insert ("ÀÊÒ");	skip_lemmas.insert ("ÁÀÇ");
		skip_lemmas.insert ("ÁÅÇ");	skip_lemmas.insert ("ÂÈÄ");	skip_lemmas.insert ("ÂÑÅ");	skip_lemmas.insert ("ÃÎÄ");
		skip_lemmas.insert ("ÄÂÀ");	skip_lemmas.insert ("ÄËß");	skip_lemmas.insert ("ÅÃÎ");	skip_lemmas.insert ("ÇÀÎ");
		skip_lemmas.insert ("ÈËÈ");	skip_lemmas.insert ("ÈÑÊ");	skip_lemmas.insert ("ÊÀÊ");	skip_lemmas.insert ("ÊÎÏ");
		skip_lemmas.insert ("ÍÄÑ");	skip_lemmas.insert ("ÎÀÎ");	skip_lemmas.insert ("ÎÍÀ");	skip_lemmas.insert ("ÎÍÈ");
		skip_lemmas.insert ("ÎÍÎ");	skip_lemmas.insert ("ÎÎÎ");	skip_lemmas.insert ("ÏÎÄ");	skip_lemmas.insert ("ÏĞÈ");
		skip_lemmas.insert ("ĞÓÁ");	skip_lemmas.insert ("ÑÀÌ");	skip_lemmas.insert ("ÑÓÄ");	skip_lemmas.insert ("ÒÀÊ");
		skip_lemmas.insert ("ÒÅÌ");	skip_lemmas.insert ("ÒÎÌ");	skip_lemmas.insert ("ÒÎÒ");	skip_lemmas.insert ("ÒĞÈ");
		skip_lemmas.insert ("ÕÎÄ");	skip_lemmas.insert ("×ÅÌ");	skip_lemmas.insert ("×ÒÎ");	skip_lemmas.insert ("İÒÎ");
		skip_lemmas.insert ("ÁÀÇÀ");	skip_lemmas.insert ("ÁÀÍÊ");	skip_lemmas.insert ("ÁÛËÎ");	skip_lemmas.insert ("ÁÛËÜ");
		skip_lemmas.insert ("ÁÛÒÜ");	skip_lemmas.insert ("ÂÅÑÜ");	skip_lemmas.insert ("ÂÈÍÀ");	skip_lemmas.insert ("ÂÛØÅ");
		skip_lemmas.insert ("ÄÀÍÀ");	skip_lemmas.insert ("ÄÀÒÀ");	skip_lemmas.insert ("ÄÀÒÜ");	skip_lemmas.insert ("ÄÅËÎ");
		skip_lemmas.insert ("ÄÅÍÜ");	skip_lemmas.insert ("ÄÅÒÜ");	skip_lemmas.insert ("ÄÎËÃ");	skip_lemmas.insert ("ÅÑËÈ");
		skip_lemmas.insert ("ÅÑÒÜ");	skip_lemmas.insert ("ÈÍÎÉ");	skip_lemmas.insert ("ÊÎÏÀ");	skip_lemmas.insert ("ËÈÁÎ");
		skip_lemmas.insert ("ËÈÑÒ");	skip_lemmas.insert ("ËÈÖÎ");	skip_lemmas.insert ("ËÈØÜ");	skip_lemmas.insert ("ÌÅĞÀ");
		skip_lemmas.insert ("ÌÎ×Ü");	skip_lemmas.insert ("ÎÄÈÍ");	skip_lemmas.insert ("ÏËÀÒ");	skip_lemmas.insert ("ÏÓÒÜ");
		skip_lemmas.insert ("ÑÂÎÉ");	skip_lemmas.insert ("ÑÈËÀ");	skip_lemmas.insert ("ÑÈËÎ");	skip_lemmas.insert ("ÑÏÎĞ");
		skip_lemmas.insert ("ÑĞÎÊ");	skip_lemmas.insert ("Ñ×ÅÒ");	skip_lemmas.insert ("ÒÅÌÀ");	skip_lemmas.insert ("ÒÎÃÎ");
		skip_lemmas.insert ("ÒÜÌÀ");	skip_lemmas.insert ("Ó×ÅÒ");	skip_lemmas.insert ("ÔÀÊÒ");	skip_lemmas.insert ("ÔÎÍÄ");
		skip_lemmas.insert ("ÕÎÄß");	skip_lemmas.insert ("ÖÅËÜ");	skip_lemmas.insert ("ÖÅÍÀ");	skip_lemmas.insert ("İÒÎÒ");
		skip_lemmas.insert ("ÀÁÇÀÖ");	skip_lemmas.insert ("ÀÄĞÅÑ");	skip_lemmas.insert ("ÁÀÍÊÀ");	skip_lemmas.insert ("ÁÎËÅÅ");
		skip_lemmas.insert ("ÂÈÄÍÎ");	skip_lemmas.insert ("ÂËÅ×Ü");	skip_lemmas.insert ("ÂĞÅÌß");	skip_lemmas.insert ("ÂÛÂÎÄ");
		skip_lemmas.insert ("ÂÛ×ÅÒ");	skip_lemmas.insert ("ÃËÀÂÀ");	skip_lemmas.insert ("ÄÀËÅÅ");	skip_lemmas.insert ("ÄÎÂÎÄ");
		skip_lemmas.insert ("ÇÀÊÎÍ");	skip_lemmas.insert ("ÇÀ×ÅÒ");	skip_lemmas.insert ("ÈÌÅÒÜ");	skip_lemmas.insert ("ÈÑÒÅÖ");
		skip_lemmas.insert ("ÊÀÊÎÉ");	skip_lemmas.insert ("ÊÎÃÄÀ");	skip_lemmas.insert ("ÊÎÏÈß");	skip_lemmas.insert ("ÊĞÎÌÅ");
		skip_lemmas.insert ("ÊÓÏËß");	skip_lemmas.insert ("ËŞÁÎÉ");	skip_lemmas.insert ("ÌÅÆÄÓ");	skip_lemmas.insert ("ÌÅÑÒÎ");
		skip_lemmas.insert ("ÌÅÑßÖ");	skip_lemmas.insert ("ÍÎÂÎÅ");	skip_lemmas.insert ("ÍÎÂÛÉ");	skip_lemmas.insert ("ÍÎĞÌÀ");
		skip_lemmas.insert ("ÎÁĞÀÇ");	skip_lemmas.insert ("ÎÁÙÈÉ");	skip_lemmas.insert ("ÎÊĞÓÃ");	skip_lemmas.insert ("ÎĞÃÀÍ");
		skip_lemmas.insert ("ÎÒÊÀÇ");	skip_lemmas.insert ("ÏÅĞÅÄ");	skip_lemmas.insert ("ÏËÀÒÀ");	skip_lemmas.insert ("ÏÎËÍÎ");
		skip_lemmas.insert ("ÏÎÑËÅ");	skip_lemmas.insert ("ÏÎÑÎË");	skip_lemmas.insert ("ÏĞÀÂÎ");	skip_lemmas.insert ("ÏĞÈÅÌ");
		skip_lemmas.insert ("ÏÓÍÊÒ");	skip_lemmas.insert ("ÏÓÒÅÌ");	skip_lemmas.insert ("ĞÀÉÎÍ");	skip_lemmas.insert ("ĞÀÌÊÀ");
		skip_lemmas.insert ("ĞÀÍÅÅ");	skip_lemmas.insert ("ĞÅÆÈÌ");	skip_lemmas.insert ("ĞÓÁËÜ");	skip_lemmas.insert ("ÑÂßÇÜ");
		skip_lemmas.insert ("ÑÌÛÑË");	skip_lemmas.insert ("ÑÏÎĞÀ");	skip_lemmas.insert ("ÑÒÀÒÜ");	skip_lemmas.insert ("ÑÓÄÍÎ");
		skip_lemmas.insert ("ÑÓÌÌÀ");	skip_lemmas.insert ("Ñ×ÅÒÛ");	skip_lemmas.insert ("ÒÀÊÆÅ");	skip_lemmas.insert ("ÒÀÊÎÉ");
		skip_lemmas.insert ("ÔÎĞÌÀ");	skip_lemmas.insert ("×ÀÑÒÜ");	skip_lemmas.insert ("×ÅĞÅÇ");	skip_lemmas.insert ("×ÈÑËÎ");
		skip_lemmas.insert ("ßÂÈÒÜ");	skip_lemmas.insert ("ÀĞÅÍÄÀ");	skip_lemmas.insert ("ÂÈÄÍÛÉ");	skip_lemmas.insert ("ÂÌÅÑÒÅ");
		skip_lemmas.insert ("ÂÍÅÑÒÈ");	skip_lemmas.insert ("ÂÎÏĞÎÑ");	skip_lemmas.insert ("ÂÏĞÀÂÅ");	skip_lemmas.insert ("ÂÒÎĞÎÉ");
		skip_lemmas.insert ("ÂÛÄÀÒÜ");	skip_lemmas.insert ("ÂÛÑØÈÉ");	skip_lemmas.insert ("ÄÀÍÍÛÅ");	skip_lemmas.insert ("ÄÀÍÍÛÉ");
		skip_lemmas.insert ("ÄÎËÃÈÉ");	skip_lemmas.insert ("ÄÎËÆÅÍ");	skip_lemmas.insert ("ÄÎËÆÍÎ");	skip_lemmas.insert ("ÄÎËÆÍÛ");
		skip_lemmas.insert ("ÄĞÓÃÎÉ");	skip_lemmas.insert ("ÅÄÈÍÛÉ");	skip_lemmas.insert ("ÆÀËÎÁÀ");	skip_lemmas.insert ("ÇÀÙÈÒÀ");
		skip_lemmas.insert ("ÇÄÀÍÈÅ");	skip_lemmas.insert ("ÈÌÅÍÍÎ");	skip_lemmas.insert ("ÊÀÆÄÛÉ");	skip_lemmas.insert ("ÊÎÄÅÊÑ");
		skip_lemmas.insert ("ÌÍÅÍÈÅ");	skip_lemmas.insert ("ÌÎÌÅÍÒ");	skip_lemmas.insert ("ÎÁÚÅÊÒ");	skip_lemmas.insert ("ÎÄÍÀÊÎ");
		skip_lemmas.insert ("ÎÊĞÓÃÀ");	skip_lemmas.insert ("ÎÑÍÎÂÀ");	skip_lemmas.insert ("ÎÒÌÅÍÀ");	skip_lemmas.insert ("ÎÖÅÍÊÀ");
		skip_lemmas.insert ("ÏÅĞÂÛÉ");	skip_lemmas.insert ("ÏÅĞÅÒÜ");	skip_lemmas.insert ("ÏÅĞÈÎÄ");	skip_lemmas.insert ("ÏÈÑÜÌÎ");
		skip_lemmas.insert ("ÏËÅÍÓÌ");	skip_lemmas.insert ("ÏÎÄÀÒÜ");	skip_lemmas.insert ("ÏÎÄÀ×À");	skip_lemmas.insert ("ÏÎËÍÛÉ");
		skip_lemmas.insert ("ÏÎËÜÇÀ");	skip_lemmas.insert ("ÏĞÀÂÛÉ");	skip_lemmas.insert ("ÏĞÅÄÅË");	skip_lemmas.insert ("ÏĞÈÄÒÈ");
		skip_lemmas.insert ("ÏĞÈÉÒÈ");	skip_lemmas.insert ("ÏĞÈÊÀÇ");	skip_lemmas.insert ("ĞÀÇÌÅĞ");	skip_lemmas.insert ("ĞÅÅÑÒĞ");
		skip_lemmas.insert ("ĞÎÑÑÈß");	skip_lemmas.insert ("ÑÄÅËÊÀ");	skip_lemmas.insert ("ÑËÓÆÁÀ");	skip_lemmas.insert ("ÑËÓ×ÀÉ");
		skip_lemmas.insert ("ÑÎÑÒÀÂ");	skip_lemmas.insert ("ÑÏÎĞÛÉ");	skip_lemmas.insert ("ÑÑÛËÊÀ");	skip_lemmas.insert ("ÑÒÀÂÊÀ");
		skip_lemmas.insert ("ÑÒÀÂÎÊ");	skip_lemmas.insert ("ÑÒÀÒÜß");	skip_lemmas.insert ("ÒÎËÜÊÎ");	skip_lemmas.insert ("ÒĞÅÒÜÅ");
		skip_lemmas.insert ("ÓÁÛÒÎÊ");	skip_lemmas.insert ("Ó×ÅÑÒÜ");	skip_lemmas.insert ("×ÀÑÒÜŞ");	skip_lemmas.insert ("ßÂËßÒÜ");
		skip_lemmas.insert ("ßÍÂÀĞÜ");	skip_lemmas.insert ("ÂÅÄÅÍÈÅ");	skip_lemmas.insert ("ÂÎÇÂĞÀÒ");	skip_lemmas.insert ("ÂÕÎÄÈÒÜ");
		skip_lemmas.insert ("ÂÛÍÅÑÒÈ");	skip_lemmas.insert ("ÂÛĞÓ×ÊÀ");	skip_lemmas.insert ("ÂÛÑÎÊÈÉ");	skip_lemmas.insert ("ÂÛßÂÈÒÜ");
		skip_lemmas.insert ("ÄÅÊÀÁĞÜ");	skip_lemmas.insert ("ÄÎËÆÍÈÊ");	skip_lemmas.insert ("ÄÎËÆÍÛÉ");	skip_lemmas.insert ("ÇÀÒĞÀÒÀ");
		skip_lemmas.insert ("ÇÀßÂÈÒÜ");	skip_lemmas.insert ("ÈÍÒÅĞÅÑ");	skip_lemmas.insert ("ÈÑÊÎÂÎÉ");	skip_lemmas.insert ("ÊÂÀĞÒÀË");
		skip_lemmas.insert ("ÊÎÌÈÒÅÒ");	skip_lemmas.insert ("ÊÎÏÅÉÊÀ");	skip_lemmas.insert ("ÊÎÒÎĞÛÉ");	skip_lemmas.insert ("ÌÅÑÒÍÛÉ");
		skip_lemmas.insert ("ÍÀÇÂÀÒÜ");	skip_lemmas.insert ("ÍÀËÈ×ÈÅ");	skip_lemmas.insert ("ÎÁËÀÑÒÜ");	skip_lemmas.insert ("ÎÁßÇÀÒÜ");
		skip_lemmas.insert ("ÎÒÊĞÛÒÜ");	skip_lemmas.insert ("ÎÖÅÍÈÒÜ");	skip_lemmas.insert ("ÏËÎÙÀÄÜ");	skip_lemmas.insert ("ÏÎÇÄÍÅÅ");
		skip_lemmas.insert ("ÏÎÇÄÍÈÉ");	skip_lemmas.insert ("ÏÎĞßÄÎÊ");	skip_lemmas.insert ("ÏÎØËÈÍÀ");	skip_lemmas.insert ("ÏÎİÒÎÌÓ");
		skip_lemmas.insert ("ÏĞÀÂÈËÎ");	skip_lemmas.insert ("ÏĞÀÂÈÒÜ");	skip_lemmas.insert ("ÏĞÅÄÌÅÒ");	skip_lemmas.insert ("ÏĞÈÁÛËÜ");
		skip_lemmas.insert ("ÏĞÈÍßÒÜ");	skip_lemmas.insert ("ÏĞÈ×ÈÍÀ");	skip_lemmas.insert ("ÏĞÎÄÀÆÀ");	skip_lemmas.insert ("ÏĞÎÑÈÒÜ");
		skip_lemmas.insert ("ÏĞÎÖÅÑÑ");	skip_lemmas.insert ("ĞÅØÅÍÈÅ");	skip_lemmas.insert ("ÑÀÍÊÖÈß");	skip_lemmas.insert ("ÑÂßÇÀÒÜ");
		skip_lemmas.insert ("ÑÄÅËÀÒÜ");	skip_lemmas.insert ("ÑÈÑÒÅÌÀ");	skip_lemmas.insert ("ÑËÓÆÈÒÜ");	skip_lemmas.insert ("ÑÎÑËÀÒÜ");
		skip_lemmas.insert ("ÑÏÎĞÍÛÉ");	skip_lemmas.insert ("ÑÑÛËÀÒÜ");	skip_lemmas.insert ("ÑÒÎĞÎÍÀ");	skip_lemmas.insert ("ÑÓÁÚÅÊÒ");
		skip_lemmas.insert ("Ñ×ÈÒÀÒÜ");	skip_lemmas.insert ("ÒÅ×ÅÍÈÅ");	skip_lemmas.insert ("ÓÊÀÇÀÒÜ");	skip_lemmas.insert ("ÓÑËÎÂÈÅ");
		skip_lemmas.insert ("Ó×ÀÑÒÈÅ");	skip_lemmas.insert ("Ó×ÀÑÒÎÊ");	skip_lemmas.insert ("ÔÀÊÒÓĞÀ");	skip_lemmas.insert ("×ÀÑÒÈÒÜ");
		skip_lemmas.insert ("İÊÑÏÎĞÒ");		skip_lemmas.insert ("ÂÊËŞ×ÀÒÜ");	skip_lemmas.insert ("ÂÊËŞ×ÈÒÜ");	skip_lemmas.insert ("ÂÍÅÑÅÍÈÅ");
		skip_lemmas.insert ("ÂÍÈÌÀÍÈÅ");	skip_lemmas.insert ("ÂÑÒÓÏÈÒÜ");	skip_lemmas.insert ("ÂÛÅÇÄÍÎÉ");	skip_lemmas.insert ("ÄÅÉÑÒÂÈÅ");
		skip_lemmas.insert ("ÄÎÁÀÂÈÒÜ");	skip_lemmas.insert ("ÄÎÊÀÇÀÒÜ");	skip_lemmas.insert ("ÄÎÊÓÌÅÍÒ");	skip_lemmas.insert ("ÇÀÊÎÍÍÛÉ");
		skip_lemmas.insert ("ÇÍÀ×ÅÍÈÅ");	skip_lemmas.insert ("ÈÇËÎÆÈÒÜ");	skip_lemmas.insert ("ÈÑÕÎÄÈÒÜ");	skip_lemmas.insert ("ÊÀÑÀÒÜÑß");
		skip_lemmas.insert ("ÊÀ×ÅÑÒÂÎ");	skip_lemmas.insert ("ÊÎËËÅÃÈß");	skip_lemmas.insert ("ÊÎÍÒĞÀÊÒ");	skip_lemmas.insert ("ÊÎÍÒĞÎËÜ");
		skip_lemmas.insert ("ÊĞÅÄÈÒÎĞ");	skip_lemmas.insert ("ÌÀÒÅĞÈÀË");	skip_lemmas.insert ("ÍÀĞÓØÀÒÜ");	skip_lemmas.insert ("ÍÀĞÓØÈÒÜ");
		skip_lemmas.insert ("ÍÀÕÎÄÈÒÜ");	skip_lemmas.insert ("ÍÅÄÎÈÌÊÀ");	skip_lemmas.insert ("ÍÅÏÎËÍÛÉ");	skip_lemmas.insert ("ÍÅÓÏËÀÒÀ");
		skip_lemmas.insert ("ÎÁĞÀÒÈÒÜ");	skip_lemmas.insert ("ÎÁÙÅÑÒÂÎ");	skip_lemmas.insert ("ÎÊÀÇÀÍÈÅ");	skip_lemmas.insert ("ÎÏÅĞÀÖÈß");
		skip_lemmas.insert ("ÎÏËÀÒÈÒÜ");	skip_lemmas.insert ("ÎÑÍÎÂÀÒÜ");	skip_lemmas.insert ("ÎÑÍÎÂÍÎÉ");	skip_lemmas.insert ("ÎÑÍÎÂÍÛÉ");
		skip_lemmas.insert ("ÎÑÒÀÂÈÒÜ");	skip_lemmas.insert ("ÎÒÂÅÒ×ÈÊ");	skip_lemmas.insert ("ÎÒÊÀÇÀÒÜ");	skip_lemmas.insert ("ÎÒÊĞÛÒÛÉ");
		skip_lemmas.insert ("ÎÒÌÅÍÈÒÜ");	skip_lemmas.insert ("ÎÒĞÀÇÈÒÜ");	skip_lemmas.insert ("ÎÒÍÎÑÈÒÜ");	skip_lemmas.insert ("ÎÔÎĞÌÈÒÜ");
		skip_lemmas.insert ("ÏÅĞÅÄÀÒÜ");	skip_lemmas.insert ("ÏÅĞÅÄÀ×À");	skip_lemmas.insert ("ÏÅĞÅ×ÅÍÜ");	skip_lemmas.insert ("ÏÎÄÏÓÍÊÒ");
		skip_lemmas.insert ("ÏÎËÀÃÀÒÜ");	skip_lemmas.insert ("ÏÎËÓ×ÈÒÜ");	skip_lemmas.insert ("ÏÎÑÒÀÂÊÀ");	skip_lemmas.insert ("ÏĞÀÂÎÂÎÉ");
		skip_lemmas.insert ("ÏĞÈÂÅÑÒÈ");	skip_lemmas.insert ("ÏĞÈÂËÅ×Ü");	skip_lemmas.insert ("ÏĞÈÇÍÀÒÜ");	skip_lemmas.insert ("ÏĞÈÍßÒÈÅ");
		skip_lemmas.insert ("ÏĞÈÍßÒÛÉ");	skip_lemmas.insert ("ÏĞÎÂÅÑÒÈ");	skip_lemmas.insert ("ÏĞÎÄÀÂÅÖ");	skip_lemmas.insert ("ÏĞÎÒÎÊÎË");
		skip_lemmas.insert ("ÑÂÅÄÅÍÈÅ");	skip_lemmas.insert ("ÑÎÃËÀÑÍÎ");	skip_lemmas.insert ("ÑÎÑÒÎßÒÜ");	skip_lemmas.insert ("ÑĞÅÄÑÒÂÀ");
		skip_lemmas.insert ("ÑĞÅÄÑÒÂÎ");	skip_lemmas.insert ("ÑÓÄÅÁÍÛÉ");	skip_lemmas.insert ("ÑÓÙÅÑÒÂÎ");	skip_lemmas.insert ("ÓÊÀÇÀÍÈÅ");
		skip_lemmas.insert ("Ó×ÀÑÒÍÈÊ");	skip_lemmas.insert ("ÕÀĞÀÊÒÅĞ");	skip_lemmas.insert ("ÂÎÇËÎÆÈÒÜ");	skip_lemmas.insert ("ÂÎÇÌÎÆÍÛÉ");
		skip_lemmas.insert ("ÂĞÅÌÅÍÈÒÜ");	skip_lemmas.insert ("ÂÛÍÅÑÅÍÈÅ");	skip_lemmas.insert ("ÂÛÏÎËÍÈÒÜ");	skip_lemmas.insert ("ÂÛÑÒÀÂÈÒÜ");
		skip_lemmas.insert ("ÃĞÀÆÄÀÍÈÍ");	skip_lemmas.insert ("ÄÎÏÓÑÒÈÒÜ");	skip_lemmas.insert ("ÇÀÊËŞ×ÈÒÜ");	skip_lemmas.insert ("ÇÀÑÅÄÀÍÈÅ");
		skip_lemmas.insert ("ÇÀßÂËÅÍÈÅ");	skip_lemmas.insert ("ÇÀßÂÈÒÅËÜ");	skip_lemmas.insert ("ÇÅÌÅËÜÍÛÉ");	skip_lemmas.insert ("ÈÇÌÅÍÅÍÈÅ");
		skip_lemmas.insert ("ÈÍÑÒÀÍÖÈß");	skip_lemmas.insert ("ÈÑÏÎËÍÈÒÜ");	skip_lemmas.insert ("ÈÑÒÅ×ÅÍÈÅ");	skip_lemmas.insert ("ÈÑ×ÈÑËÈÒÜ");
		skip_lemmas.insert ("ÍÀÏĞÀÂÈÒÜ");	skip_lemmas.insert ("ÍÀĞÓØÅÍÈÅ");	skip_lemmas.insert ("ÍÀÑÒÎßÙÅÅ");	skip_lemmas.insert ("ÍÀÑÒÎßÙÈÉ");
		skip_lemmas.insert ("ÍÀ×ÈÑËÈÒÜ");	skip_lemmas.insert ("ÍÅÊÎÒÎĞÛÉ");	skip_lemmas.insert ("ÎÁĞÀÙÅÍÈÅ");	skip_lemmas.insert ("ÎÁßÇÀÍÍÛÉ");
		skip_lemmas.insert ("ÎÑÍÎÂÀÍÈÅ");	skip_lemmas.insert ("ÎÒÄÅËÜÍÛÉ");	skip_lemmas.insert ("ÎÒÊËÎÍÈÒÜ");	skip_lemmas.insert ("ÎÒÊËÎÍßÒÜ");
		skip_lemmas.insert ("ÎÒÍÎØÅÍÈÅ");	skip_lemmas.insert ("ÎØÈÁÎ×ÍÛÉ");	skip_lemmas.insert ("ÏËÀÒÅÆÍÛÉ");	skip_lemmas.insert ("ÏÎÄËÅÆÀÒÜ");
		skip_lemmas.insert ("ÏÎÄÏÈÑÀÒÜ");	skip_lemmas.insert ("ÏÎËÍÎÑÒÜŞ");	skip_lemmas.insert ("ÏÎËÎÆÅÍÈÅ");	skip_lemmas.insert ("ÏÎËÓ×ÅÍÈÅ");
		skip_lemmas.insert ("ÏÎÌÅÙÅÍÈÅ");	skip_lemmas.insert ("ÏÎĞÓ×ÅÍÈÅ");	skip_lemmas.insert ("ÏÎÑÊÎËÜÊÓ");	skip_lemmas.insert ("ÏÎÑËÅÄÍÈÉ");
		skip_lemmas.insert ("ÏÎÑËÓÆÈÒÜ");	skip_lemmas.insert ("ÏÎÑÒÀÂÈÒÜ");	skip_lemmas.insert ("ÏÎÑÒÀÂÙÈÊ");	skip_lemmas.insert ("ÏÎÑÒÓÏÈÒÜ");
		skip_lemmas.insert ("ÏĞÈÇÍÀÍÈÅ");	skip_lemmas.insert ("ÏĞÈÌÅÍÈÒÜ");	skip_lemmas.insert ("ÏĞÈÌÅÍßÒÜ");	skip_lemmas.insert ("ÏĞÈÍÈÌÀÒÜ");
		skip_lemmas.insert ("ÏĞÎÂÅĞÈÒÜ");	skip_lemmas.insert ("ÏĞÎÂÅĞßÒÜ");	skip_lemmas.insert ("ÏĞÎÄÓÊÖÈß");	skip_lemmas.insert ("ĞÀÑ×ÅÒÍÛÉ");
		skip_lemmas.insert ("ĞÅÇÓËÜÒÀÒ");	skip_lemmas.insert ("ÑÂßÇÀÍÍÛÉ");	skip_lemmas.insert ("ÑËÅÄÎÂÀÒÜ");	skip_lemmas.insert ("ÑËÅÄÓŞÙÈÉ");
		skip_lemmas.insert ("ÑÎÂÅĞØÈÒÜ");	skip_lemmas.insert ("ÑÎÃËÀÑÈÒÜ");	skip_lemmas.insert ("ÑÎÃËÀÑÍÛÉ");	skip_lemmas.insert ("ÑÎÄÅĞÆÀÒÜ");
		skip_lemmas.insert ("ÑÎÑÒÀÂÈÒÜ");	skip_lemmas.insert ("ÑÎÑÒÎßÍÈÅ");	skip_lemmas.insert ("ÒĞÅÁÎÂÀÒÜ");	skip_lemmas.insert ("ÓÊÀÇÀÍÍÛÉ");
		skip_lemmas.insert ("ÓÊÀÇÛÂÀÒÜ");	skip_lemmas.insert ("ÓÌÅÍÜØÈÒÜ");	skip_lemmas.insert ("ÓÒÂÅĞÄÈÒÜ");	skip_lemmas.insert ("Ó×ÈÒÛÂÀÒÜ");
		skip_lemmas.insert ("ÔÅÄÅĞÀÖÈß");	skip_lemmas.insert ("×ÀÑÒÈ×ÍÛÉ");	skip_lemmas.insert ("×ÀÑÒÍÎÑÒÜ");	skip_lemmas.insert ("ÂÎÇÂĞÀÒÈÒÜ");
		skip_lemmas.insert ("ÂÎÇÌÅÙÅÍÈÅ");	skip_lemmas.insert ("ÂÎÇÍÈÊÍÓÒÜ");	skip_lemmas.insert ("ÂÎÇĞÀÆÅÍÈÅ");	skip_lemmas.insert ("ÂÛÏÎËÍÅÍÈÅ");
		skip_lemmas.insert ("ÄÅÊËÀĞÀÖÈß");	skip_lemmas.insert ("ÇÀÊËŞ×ÅÍÈÅ");	skip_lemmas.insert ("ÇÀÊÎÍÍÎÑÒÜ");	skip_lemmas.insert ("ÈÍÔÎĞÌÀÖÈß");
		skip_lemmas.insert ("ÈÑÊËŞ×ÅÍÈÅ");	skip_lemmas.insert ("ÈÑÏÎËÍÅÍÈÅ");	skip_lemmas.insert ("ÈÑ×ÈÑËÅÍÈÅ");	skip_lemmas.insert ("ÊÎËÈ×ÅÑÒÂÎ");
		skip_lemmas.insert ("ÊÎÍÊĞÅÒÍÛÉ");	skip_lemmas.insert ("ÍÀÄËÅÆÀÙÈÉ");	skip_lemmas.insert ("ÍÀ×ÈÑËÅÍÈÅ");	skip_lemmas.insert ("ÍÀÇÍÀ×ÅÍÈÅ");
		skip_lemmas.insert ("ÍÅÇÀÊÎÍÍÛÉ");	skip_lemmas.insert ("ÍÅÎÁÕÎÄÈÌÎ");	skip_lemmas.insert ("ÎÁÆÀËÎÂÀÒÜ");	skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÒÜ");
		skip_lemmas.insert ("ÎÃĞÀÍÈ×ÈÒÜ");	skip_lemmas.insert ("ÎÏĞÅÄÅËÈÒÜ");	skip_lemmas.insert ("ÎÏĞÅÄÅËßÒÜ");	skip_lemmas.insert ("ÎÑÏÀĞÈÂÀÒÜ");
		skip_lemmas.insert ("ÎÒÊÀÇÛÂÀÒÜ");	skip_lemmas.insert ("ÎÒÑÓÒÑÒÂÈÅ");	skip_lemmas.insert ("ÎÔÎĞÌËÅÍÈÅ");	skip_lemmas.insert ("ÏÅĞÅÎÖÅÍÊÀ");
		skip_lemmas.insert ("ÏËÀÒÅËÜÙÈÊ");	skip_lemmas.insert ("ÏÎÄËÅÆÀÙÅÅ");	skip_lemmas.insert ("ÏÎÊÓÏÀÒÅËÜ");	skip_lemmas.insert ("ÏÎËÍÎÌÎ×ÈÅ");
		skip_lemmas.insert ("ÏĞÀÂÈËÜÍÛÉ");	skip_lemmas.insert ("ÏĞÅÄËÎÆÈÒÜ");	skip_lemmas.insert ("ÏĞÅÄÚßÂÈÒÜ");	skip_lemmas.insert ("ÏĞÈÇÍÀÂÀÒÜ");
		skip_lemmas.insert ("ÏĞÈÇÍÀÍÍÛÉ");	skip_lemmas.insert ("ÏĞÈËÎÆÅÍÈÅ");	skip_lemmas.insert ("ÏĞÈÌÅÍÅÍÈÅ");	skip_lemmas.insert ("ÏĞÈÎÁĞÅÑÒÈ");
		skip_lemmas.insert ("ÏĞÎÂÅÄÅÍÈÅ");	skip_lemmas.insert ("ÏĞÎÈÇÂÅÑÒÈ");	skip_lemmas.insert ("ĞÀÇĞÅØÅÍÈÅ");	skip_lemmas.insert ("ĞÅÀËÈÇÀÖÈß");
		skip_lemmas.insert ("ĞÅÑÏÓÁËÈÊÀ");	skip_lemmas.insert ("ĞÎÑÑÈÉÑÊÈÉ");	skip_lemmas.insert ("ÑÎÁËŞÄÅÍÈÅ");	skip_lemmas.insert ("ÑÎÂÅĞØÅÍÈÅ");
		skip_lemmas.insert ("ÑÎÃËÀØÅÍÈÅ");	skip_lemmas.insert ("ÑÎÄÅĞÆÀÍÈÅ");	skip_lemmas.insert ("ÑÎÑÒÀÂËßÒÜ");	skip_lemmas.insert ("ÑÎÖÈÀËÜÍÛÉ");
		skip_lemmas.insert ("ÒÀÌÎÆÅÍÍÛÉ");	skip_lemmas.insert ("ÒÅĞĞÈÒÎĞÈß");	skip_lemmas.insert ("ÒĞÅÁÎÂÀÍÈÅ");	skip_lemmas.insert ("ÓÏËÀ×ÈÂÀÒÜ");
		skip_lemmas.insert ("ÓÑÒÀÍÎÂÈÒÜ");	skip_lemmas.insert ("Ó×ĞÅÆÄÅÍÈÅ");	skip_lemmas.insert ("ÔÈÇÈ×ÅÑÊÈÉ");	skip_lemmas.insert ("ÔÈÍÀÍÑÎÂÛÉ");
		skip_lemmas.insert ("ÀĞÁÈÒĞÀÆÍÛÉ");	skip_lemmas.insert ("ÂÎÇÌÎÆÍÎÑÒÜ");	skip_lemmas.insert ("ÂÑÅÑÒÎĞÎÍÍÅ");	skip_lemmas.insert ("ÃĞÀÆÄÀÍÑÊÈÉ");
		skip_lemmas.insert ("ÄÅÉÑÒÂÎÂÀÒÜ");	skip_lemmas.insert ("ÄÅÉÑÒÂÓŞÙÈÉ");	skip_lemmas.insert ("ÄÎËÆÍÎÑÒÍÎÉ");	skip_lemmas.insert ("ÄÎÑÒÀÒÎ×ÍÛÉ");
		skip_lemmas.insert ("ÇÀÊËŞ×ÅÍÍÀß");	skip_lemmas.insert ("ÇÀÊËŞ×ÅÍÍÛÉ");	skip_lemmas.insert ("ÈÑÑËÅÄÎÂÀÒÜ");	skip_lemmas.insert ("ÊÀÌÅĞÀËÜÍÛÉ");
		skip_lemmas.insert ("ÍÀÏĞÀÂËÅÍÈÅ");	skip_lemmas.insert ("ÍÅÎÁÕÎÄÈÌÛÉ");	skip_lemmas.insert ("ÍÎĞÌÀÒÈÂÍÛÉ");	skip_lemmas.insert ("ÎÁÅÑÏÅ×ÅÍÈÅ");
		skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÍÈÅ");	skip_lemmas.insert ("ÎÁĞÀÇÎÂÀÍÈÅ");	skip_lemmas.insert ("ÎÁßÇÀÍÍÎÑÒÜ");	skip_lemmas.insert ("ÎÏĞÅÄÅËÅÍÈÅ");
		skip_lemmas.insert ("ÎĞÃÀÍÈÇÀÖÈß");	skip_lemmas.insert ("ÎÑÓÙÅÑÒÂÈÒÜ");	skip_lemmas.insert ("ÏÅĞÅ×ÈÑËÈÒÜ");	skip_lemmas.insert ("ÏÎÄÒÂÅĞÄÈÒÜ");
		skip_lemmas.insert ("ÏÎËÜÇÎÂÀÍÈÅ");	skip_lemmas.insert ("ÏÎÑËÅÄÑÒÂÈÅ");	skip_lemmas.insert ("ÏÎÑÒÓÏËÅÍÈÅ");	skip_lemmas.insert ("ÏĞÀÂÎÌÅĞÍÛÉ");
		skip_lemmas.insert ("ÏĞÅÄÑÒÀÂÈÒÜ");	skip_lemmas.insert ("ÏĞÅÊĞÀÙÅÍÈÅ");	skip_lemmas.insert ("ÏĞÈÂËÅ×ÅÍÈÅ");	skip_lemmas.insert ("ÏĞÎÈÇÂÎÄÈÒÜ");
		skip_lemmas.insert ("ĞÀÑÏÎËÎÆÈÒÜ");	skip_lemmas.insert ("ĞÀÑÑÌÎÒĞÅÒÜ");	skip_lemmas.insert ("ĞÅÀËÈÇÎÂÀÒÜ");	skip_lemmas.insert ("ĞÅÃÈÑÒĞÀÖÈß");
		skip_lemmas.insert ("ÑÎÁÑÒÂÅÍÍÈÊ");	skip_lemmas.insert ("ÒÅÕÍÈ×ÅÑÊÈÉ");	skip_lemmas.insert ("ÓÑÌÀÒĞÈÂÀÒÜ");	skip_lemmas.insert ("ÓÒÂÅĞÆÄÅÍÈÅ");
		skip_lemmas.insert ("Ó×ÀÑÒÂÎÂÀÒÜ");	skip_lemmas.insert ("Ó×ÀÑÒÂÓŞÙÈÉ");	skip_lemmas.insert ("ÔÀÊÒÈ×ÅÑÊÈÉ");	skip_lemmas.insert ("ÔÅÄÅĞÀËÜÍÛÉ");
		skip_lemmas.insert ("ÕÎÄÀÒÀÉÑÒÂÎ");		skip_lemmas.insert ("ŞĞÈÄÈ×ÅÑÊÈÉ");		skip_lemmas.insert ("ÄÅßÒÅËÜÍÎÑÒÜ");	skip_lemmas.insert ("ÄÎÁĞÎÂÎËÜÍÛÉ");
		skip_lemmas.insert ("ÄÎÍÀ×ÈÑËÅÍÈÅ");	skip_lemmas.insert ("ÈÑÏÎËÜÇÎÂÀÒÜ");	skip_lemmas.insert ("ÈÑÑËÅÄÎÂÀÍÈÅ");	skip_lemmas.insert ("ÊÀÑÑÀÖÈÎÍÍÛÉ");
		skip_lemmas.insert ("ÌÀÒÅĞÈÀËÜÍÛÉ");	skip_lemmas.insert ("ÍÀÏĞÀÂËÅÍÍÛÉ");	skip_lemmas.insert ("ÍÅÈÑÏÎËÍÅÍÈÅ");	skip_lemmas.insert ("ÍÅÍÀÄËÅÆÀÙÈÉ");
		skip_lemmas.insert ("ÍÅÏĞÀÂÈËÜÍÛÉ");	skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÍÍÛÉ");	skip_lemmas.insert ("ÎÁßÇÀÒÅËÜÍÛÉ");	skip_lemmas.insert ("ÎÃĞÀÍÈ×ÅÍÍÛÉ");
		skip_lemmas.insert ("ÎÏĞÅÄÅËÅÍÍÛÉ");	skip_lemmas.insert ("ÎÑÓÙÅÑÒÂËßÒÜ");	skip_lemmas.insert ("ÏÅĞÅ×ÈÑËÅÍÈÅ");	skip_lemmas.insert ("ÏÎÄÒÂÅĞÆÄÀÒÜ");
		skip_lemmas.insert ("ÏĞÀÂÈËÜÍÎÑÒÜ");	skip_lemmas.insert ("ÏĞÅÄÎÑÒÀÂÈÒÜ");	skip_lemmas.insert ("ÏĞÅÄÑÒÀÂËßÒÜ");	skip_lemmas.insert ("ÏĞÅÄÚßÂËÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÈÍÀÄËÅÆÀÒÜ");	skip_lemmas.insert ("ÏĞÈÎÁĞÅÒÅÍÈÅ");	skip_lemmas.insert ("ÏĞÎÈÇÂÎÄÑÒÂÎ");	skip_lemmas.insert ("ĞÀÑÏÎĞßÆÅÍÈÅ");
		skip_lemmas.insert ("ĞÀÑÑÌÎÒĞÅÍÈÅ");	skip_lemmas.insert ("ĞÅÃÓËÈĞÎÂÀÒÜ");	skip_lemmas.insert ("ĞÓÊÎÂÎÄÈÒÅËÜ");	skip_lemmas.insert ("ÑÎÂÎÊÓÏÍÎÑÒÜ");
		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÈÅ");	skip_lemmas.insert ("ÑÓÙÅÑÒÂÅÍÍÛÉ");	skip_lemmas.insert ("ÒĞÀÍÑÏÎĞÒÍÛÉ");	skip_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÈÒÜ");
		skip_lemmas.insert ("ÓÑÒÀÍÎÂËÅÍÈÅ");	skip_lemmas.insert ("ÀÄÌÈÍÈÑÒĞÀÖÈß");	skip_lemmas.insert ("ÀÏÅËËßÖÈÎÍÍÛÉ");	skip_lemmas.insert ("ÁÓÕÃÀËÒÅĞÑÊÈÉ");
		skip_lemmas.insert ("ÂÛØÅÓÊÀÇÀÍÍÛÉ");	skip_lemmas.insert ("ÈÑÏÎËÜÇÎÂÀÍÈÅ");	skip_lemmas.insert ("ÌÓÍÈÖÈÏÀËÜÍÛÉ");	skip_lemmas.insert ("ÍÅÎÁÕÎÄÈÌÎÑÒÜ");
		skip_lemmas.insert ("ÍÅÏĞÀÂÎÌÅĞÍÛÉ");	skip_lemmas.insert ("ÎÁßÇÀÒÅËÜÑÒÂÎ");	skip_lemmas.insert ("ÎÑÓÙÅÑÒÂËÅÍÈÅ");	skip_lemmas.insert ("ÎÒÑÓÒÑÒÂÎÂÀÒÜ");
		skip_lemmas.insert ("ÏÎÄÒÂÅĞÆÄÅÍÈÅ");	skip_lemmas.insert ("ÏÎÑÒÀÍÎÂËÅÍÈÅ");	skip_lemmas.insert ("ÏĞÀÂÈÒÅËÜÑÒÂÎ");	skip_lemmas.insert ("ÏĞÀÂÎÌÅĞÍÎÑÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÎÑÒÀÂËßÒÜ");	skip_lemmas.insert ("ÏĞÅÄÑÒÀÂÈÒÅËÜ");	skip_lemmas.insert ("ÏĞÅÄÑÒÀÂËÅÍÈÅ");	skip_lemmas.insert ("ÏĞÅÄÓÑÌÎÒĞÅÒÜ");
		skip_lemmas.insert ("ÏĞÎÒÈÂÎĞÅ×ÈÒÜ");	skip_lemmas.insert ("ĞÀÑÏÎËÎÆÅÍÍÛÉ");	skip_lemmas.insert ("ĞÀÑÑÌÀÒĞÈÂÀÒÜ");	skip_lemmas.insert ("ÑËÅÄÎÂÀÒÅËÜÍÎ");
		skip_lemmas.insert ("ÑÎÁÑÒÂÅÍÍÎÑÒÜ");	skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞÈÒÜ");	skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞßÒÜ");	skip_lemmas.insert ("ÓÑÒÀÍÀÂËÈÂÀÒÜ");
		skip_lemmas.insert ("ÕÎÇßÉÑÒÂÅÍÍÛÉ");	skip_lemmas.insert ("İÊÎÍÎÌÈ×ÅÑÊÈÉ");	skip_lemmas.insert ("ÄÎÊÀÇÀÒÅËÜÑÒÂÎ");	skip_lemmas.insert ("ÄÎÊÓÌÅÍÒÀËÜÍÛÉ");
		skip_lemmas.insert ("ÄÎÏÎËÍÈÒÅËÜÍÛÉ");	skip_lemmas.insert ("ÈÍÄÈÂÈÄÓÀËÜÍÛÉ");	skip_lemmas.insert ("ÈÑÏÎËÍÈÒÅËÜÍÛÉ");	skip_lemmas.insert ("ÍÅÎÁÎÑÍÎÂÀÍÍÛÉ");
		skip_lemmas.insert ("ÎÁÎÑÍÎÂÀÍÍÎÑÒÜ");	skip_lemmas.insert ("ÎÁÑÒÎßÒÅËÜÑÒÂÎ");	skip_lemmas.insert ("ÏĞÀÂÎÍÀĞÓØÅÍÈÅ");	skip_lemmas.insert ("ÏĞÀÂÎÎÒÍÎØÅÍÈÅ");
		skip_lemmas.insert ("ÏĞÅÄÎÑÒÀÂËÅÍÈÅ");	skip_lemmas.insert ("ÏĞÎÖÅÑÑÓÀËÜÍÛÉ");	skip_lemmas.insert ("ÑÀÌÎÓÏĞÀÂËÅÍÈÅ");	skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÅÍÍÎ");
		skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞÅÍÈÅ");	skip_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÅÍÍÛÉ");	skip_lemmas.insert ("ÃÎÑÓÄÀĞÑÒÂÅÍÍÛÉ");	skip_lemmas.insert ("ÍÀËÎÃÎÎÁËÎÆÅÍÈÅ");
		skip_lemmas.insert ("ÍÅÑÂÎÅÂĞÅÌÅÍÍÛÉ");	skip_lemmas.insert ("ÍÅÑÎÑÒÎßÒÅËÜÍÛÉ");	skip_lemmas.insert ("ÎÒÂÅÒÑÒÂÅÍÍÎÑÒÜ");	skip_lemmas.insert ("ÏĞÅÄÏĞÈÍÈÌÀÒÅËÜ");
		skip_lemmas.insert ("ÏĞÅÄÓÑÌÀÒĞÈÂÀÒÜ");	skip_lemmas.insert ("ĞÓÊÎÂÎÄÑÒÂÎÂÀÒÜ");	skip_lemmas.insert ("ÑÀÌÎÑÒÎßÒÅËÜÍÛÉ");	skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÅÍÍÛÉ");
		skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÎÂÀÒÜ");	skip_lemmas.insert ("ÑÎÎÒÂÅÒÑÒÂÓŞÙÈÉ");	skip_lemmas.insert ("ÀÄÌÈÍÈÑÒĞÀÒÈÂÍÛÉ");			skip_lemmas.insert ("ÇÀÊÎÍÎÄÀÒÅËÜÑÒÂÎ");
		skip_lemmas.insert ("ÇÀĞÅÃÈÑÒĞÈĞÎÂÀÒÜ");	skip_lemmas.insert ("ÍÅÄÅÉÑÒÂÈÒÅËÜÍÛÉ");	skip_lemmas.insert ("ÍÅÏÎÑĞÅÄÑÒÂÅÍÍÛÉ");	skip_lemmas.insert ("ÑÂÈÄÅÒÅËÜÑÒÂÎÂÀÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÏĞÈÍÈÌÀÒÅËÜÑÊÈÉ");	skip_lemmas.insert ("ÒĞÅÒÈÉ");				skip_lemmas.insert ("ÄÎÌ");					skip_lemmas.insert ("ÈŞËÜ");
		skip_lemmas.insert ("ÌÀĞÒ");				skip_lemmas.insert ("ÄÎËÆÍÀ");				skip_lemmas.insert ("ÎÊÒßÁĞÜ");				skip_lemmas.insert ("ÍÀÊËÀÄÍÀß");
		skip_lemmas.insert ("ÍÀÊËÀÄÍÎÉ");			skip_lemmas.insert ("ÍÀÊËÀÄÍÛÉ");			skip_lemmas.insert ("ÏÎÃÀØÅÍÈÅ");			skip_lemmas.insert ("ĞÀÇĞÅØÈÒÜ");
		skip_lemmas.insert ("ÎÑÒÀÂËÅÍÈÅ");			skip_lemmas.insert ("ÏÈÑÜÌÅÍÍÛÉ");			skip_lemmas.insert ("ÁÅÇÄÅÉÑÒÂÈÅ");			skip_lemmas.insert ("ÂÎÇÍÈÊÍÎÂÅÍÈÅ");

		skip_lemmas.insert ("Á");		skip_lemmas.insert ("ÁÛ");		skip_lemmas.insert ("ÃÊ");		skip_lemmas.insert ("ÊÃ");
		skip_lemmas.insert ("ÍÈ");		skip_lemmas.insert ("ÍÊ");		skip_lemmas.insert ("ÑÌ");		skip_lemmas.insert ("ÔÇ");
		skip_lemmas.insert ("ÈÌß");		skip_lemmas.insert ("ËÅÒ");		skip_lemmas.insert ("ÌÀÉ");		skip_lemmas.insert ("ÌÍÑ");
		skip_lemmas.insert ("ÍÅÒ");		skip_lemmas.insert ("ÎÁÀ");		skip_lemmas.insert ("ÂÈÍÎ");		skip_lemmas.insert ("ÈÌÍÑ");
		skip_lemmas.insert ("ÈÒÎÃ");		skip_lemmas.insert ("ÈŞÍÜ");		skip_lemmas.insert ("ÊĞÀÉ");		skip_lemmas.insert ("ËÅÒÀ");
		skip_lemmas.insert ("ÑÅÁß");		skip_lemmas.insert ("ÒÎÌÀ");		skip_lemmas.insert ("×ÅÃÎ");		skip_lemmas.insert ("ÂÂÈÄÓ");
		skip_lemmas.insert ("ÂÅÑÒÈ");		skip_lemmas.insert ("ÂÇÍÎÑ");		skip_lemmas.insert ("ÇÀÂÎÄ");		skip_lemmas.insert ("ÌÀĞÒÀ");
		skip_lemmas.insert ("ÌÀßÒÜ");		skip_lemmas.insert ("ÌÎÒÈÂ");		skip_lemmas.insert ("ÍÀÉÒÈ");		skip_lemmas.insert ("ÍÅÌÎÉ");
		skip_lemmas.insert ("ÍÅÑÒÈ");		skip_lemmas.insert ("ÍÎÌÅĞ");		skip_lemmas.insert ("ÎÒÄÅË");		skip_lemmas.insert ("ÎÒÇÛÂ");
		skip_lemmas.insert ("ĞÑÔÑĞ");		skip_lemmas.insert ("ÑÀÌÛÉ");		skip_lemmas.insert ("ÑÀÍÊÒ");		skip_lemmas.insert ("ÑÎÁÎÉ");
		skip_lemmas.insert ("ÑÎÂÅÒ");		skip_lemmas.insert ("ÑÓÄÜß");		skip_lemmas.insert ("ÑÔÅĞÀ");		skip_lemmas.insert ("ÒÅÊÑÒ");
		skip_lemmas.insert ("ÓÑÒÀÂ");		skip_lemmas.insert ("ÔÈĞÌÀ");		skip_lemmas.insert ("ÖÅËÛÉ");		skip_lemmas.insert ("ÖÅÍÒĞ");
		skip_lemmas.insert ("×ÓÆÀß");		skip_lemmas.insert ("×ÓÆÎÉ");		skip_lemmas.insert ("ÀÂÃÓÑÒ");		skip_lemmas.insert ("ÀÏĞÅËÜ");
		skip_lemmas.insert ("ÁÀËÀÍÑ");		skip_lemmas.insert ("ÂËÀÑÒÜ");		skip_lemmas.insert ("ÃËÀÂÛÉ");		skip_lemmas.insert ("ËÜÃÎÒÀ");
		skip_lemmas.insert ("ÌÅĞÅÒÜ");		skip_lemmas.insert ("ÍÅËÜÇß");		skip_lemmas.insert ("ÍÎßÁĞÜ");		skip_lemmas.insert ("ÎÁÎĞÎÒ");
		skip_lemmas.insert ("ÏÅĞÂÎÅ");		skip_lemmas.insert ("ÏĞÎÒÈÂ");		skip_lemmas.insert ("ĞÀÂÍÛÉ");		skip_lemmas.insert ("ÑÅÂÅĞÎ");
		skip_lemmas.insert ("ÑÏÎÑÎÁ");		skip_lemmas.insert ("ÒĞÅÒÜß");		skip_lemmas.insert ("ÔÈËÈÀË");		skip_lemmas.insert ("ÀÂÃÓÑÒÀ");
		skip_lemmas.insert ("ÂÛÏÈÑÊÀ");		skip_lemmas.insert ("ÂÛÏËÀÒÀ");		skip_lemmas.insert ("ÃËÀÂÍÎÅ");		skip_lemmas.insert ("ÃËÀÂÍÛÉ");
		skip_lemmas.insert ("ÇÀÊĞÛÒÜ");		skip_lemmas.insert ("ÇÀÏÀÄÍÎ");		skip_lemmas.insert ("ÈÇÓ×ÈÒÜ");		skip_lemmas.insert ("ÍÅÆÈËÎÉ");
		skip_lemmas.insert ("ÎÊÀÇÀÒÜ");		skip_lemmas.insert ("ÎÒÍÅÑÒÈ");		skip_lemmas.insert ("ÏÎÂËÅ×Ü");		skip_lemmas.insert ("ÏÎÇÈÖÈß");
		skip_lemmas.insert ("ÏÎÍÅÑÒÈ");		skip_lemmas.insert ("ÏĞÈÁÛÒÜ");		skip_lemmas.insert ("ÏĞÈÇÍÀÊ");		skip_lemmas.insert ("ÏĞÎÏÓÑÊ");
		skip_lemmas.insert ("ÑÏĞÀÂÊÀ");		skip_lemmas.insert ("ÑÒÀÂÈÒÜ");		skip_lemmas.insert ("ÔÅÂĞÀËÜ");		skip_lemmas.insert ("ÂÂÅÄÅÍÈÅ");
		skip_lemmas.insert ("ÂÎÑÒÎ×ÍÎ");		skip_lemmas.insert ("ÂÑÒÓÏÀÒÜ");		skip_lemmas.insert ("ÂÛĞÀÇÈÒÜ");		skip_lemmas.insert ("ÂÛÒÅÊÀÒÜ");
		skip_lemmas.insert ("ÂÛßÑÍÈÒÜ");		skip_lemmas.insert ("ÄÀÂÍÎÑÒÜ");		skip_lemmas.insert ("ÄÈĞÅÊÒÎĞ");		skip_lemmas.insert ("ÇÀÊÀÇ×ÈÊ");
		skip_lemmas.insert ("ÇÀÊĞÛÒÛÉ");		skip_lemmas.insert ("ÇÀÏÀÄÍÛÉ");		skip_lemmas.insert ("ÇÀßÂËßÒÜ");		skip_lemmas.insert ("ÈÇÌÅÍÈÒÜ");
		skip_lemmas.insert ("ÊÎÌÈÑÑÈß");		skip_lemmas.insert ("ÊÎÌÏÀÍÈß");		skip_lemmas.insert ("ÎÁĞÀÙÀÒÜ");		skip_lemmas.insert ("ÎÁÑÓÄÈÒÜ");
		skip_lemmas.insert ("ÎÁÚßÂÈÒÜ");		skip_lemmas.insert ("ÎÁßÇÀÍÈÅ");		skip_lemmas.insert ("ÎÏÅ×ÀÒÊÀ");		skip_lemmas.insert ("ÎÑÏÎĞÈÒÜ");
		skip_lemmas.insert ("ÎÒÂÅ×ÀÒÜ");		skip_lemmas.insert ("ÎÒÌÅÒÈÒÜ");		skip_lemmas.insert ("ÏÎÄÀÒÅËÜ");		skip_lemmas.insert ("ÏĞÈÑËÀÒÜ");
		skip_lemmas.insert ("ÏĞÎÊÓĞÎĞ");		skip_lemmas.insert ("ĞÀÁÎÒÍÈÊ");		skip_lemmas.insert ("ĞÀÉÎÍÍÛÉ");		skip_lemmas.insert ("ĞÅÀËÜÍÛÉ");
		skip_lemmas.insert ("ĞÅÄÀÊÖÈß");		skip_lemmas.insert ("ÑÅÍÒßÁĞÜ");		skip_lemmas.insert ("ÑËÓØÀÍÈÅ");		skip_lemmas.insert ("ÑÎÁËŞÑÒÈ");
		skip_lemmas.insert ("ÑÎÁĞÀÍÈÅ");		skip_lemmas.insert ("ÑÎÃËÀÑÈÅ");		skip_lemmas.insert ("ÒÎĞÃÎÂÛÉ");		skip_lemmas.insert ("ÓÒÎ×ÍÈÒÜ");
		skip_lemmas.insert ("ÂÅĞÕÎÂÍÛÉ");		skip_lemmas.insert ("ÂÊËŞ×ÅÍÈÅ");		skip_lemmas.insert ("ÂÎÇËÀÃÀÒÜ");		skip_lemmas.insert ("ÂÎÇÍÈÊÀÒÜ");
		skip_lemmas.insert ("ÂÎÇĞÀÆÀÒÜ");		skip_lemmas.insert ("ÂĞÅÌÅÍÍÎÉ");		skip_lemmas.insert ("ÂĞÅÌÅÍÍÛÉ");		skip_lemmas.insert ("ÂÑÒĞÅ×ÍÛÉ");
		skip_lemmas.insert ("ÂÛÑËÓØÀÒÜ");		skip_lemmas.insert ("ÃÎĞÎÄÑÊÎÉ");		skip_lemmas.insert ("ÄÎÏÓÑÊÀÒÜ");		skip_lemmas.insert ("ÇÀÍÈÆÅÍÈÅ");
		skip_lemmas.insert ("ÇÀÑËÓØÀÒÜ");		skip_lemmas.insert ("ÈÇÂÅÑÒÈÒÜ");		skip_lemmas.insert ("ÈÑÏÎËÍßÒÜ");		skip_lemmas.insert ("ÈÑ×ÈÑËßÒÜ");
		skip_lemmas.insert ("ÍÀÄËÅÆÀÒÜ");		skip_lemmas.insert ("ÍÀÇÍÀ×ÈÒÜ");		skip_lemmas.insert ("ÍÀËÎÆÅÍÈÅ");		skip_lemmas.insert ("ÍÀÑÅËÅÍÈÅ");
		skip_lemmas.insert ("ÎÁËÀÑÒÍÎÉ");		skip_lemmas.insert ("ÎÁßÇÛÂÀÒÜ");		skip_lemmas.insert ("ÎÊÎÍ×ÀÍÈÅ");		skip_lemmas.insert ("ÎÑÒÀËÜÍÎÉ");
		skip_lemmas.insert ("ÎÒÄÅËÅÍÈÅ");		skip_lemmas.insert ("ÏÅĞÂÈ×ÍÛÉ");		skip_lemmas.insert ("ÏÅÒÅĞÁÓĞÃ");		skip_lemmas.insert ("ÏÎÂÒÎĞÍÛÉ");
		skip_lemmas.insert ("ÏÎÇÂÎËßÒÜ");		skip_lemmas.insert ("ÏÎÑ×ÈÒÀÒÜ");		skip_lemmas.insert ("ÏĞÅÂÛØÀÒÜ");		skip_lemmas.insert ("ÏĞÅÇÈÄÈÓÌ");
		skip_lemmas.insert ("ÏĞÈÕÎÄÈÒÜ");		skip_lemmas.insert ("ÏĞÈ×ÈÍÈÒÜ");		skip_lemmas.insert ("ÏĞÎÂÎÄÈÒÜ");		skip_lemmas.insert ("ÏĞÎÑĞÎ×ÊÀ");
		skip_lemmas.insert ("ÏĞÎÖÅÄÓĞÀ");		skip_lemmas.insert ("ÑÈÁÈĞÑÊÈÉ");		skip_lemmas.insert ("ÑÒĞÀÕÎÂÎÉ");		skip_lemmas.insert ("ÓÂÅÄÎÌÈÒÜ");
		skip_lemmas.insert ("ÓÍÈÒÀĞÍÛÉ");		skip_lemmas.insert ("ÓÏĞÀÂËßÒÜ");		skip_lemmas.insert ("ÓĞÀËÜÑÊÈÉ");		skip_lemmas.insert ("ÓÑÒĞÀÍÈÒÜ");
		skip_lemmas.insert ("ÂÇÛÑÊÈÂÀÒÜ");		skip_lemmas.insert ("ÂÎÇÌÅÑÒÈÒÜ");		skip_lemmas.insert ("ÂÑËÅÄÑÒÂÈÅ");		skip_lemmas.insert ("ÂÑÒÓÏËÅÍÈÅ");
		skip_lemmas.insert ("ÃÎÑÏÎØËÈÍÀ");		skip_lemmas.insert ("ÄÎÏÎËÍÅÍÈÅ");		skip_lemmas.insert ("ÈÇÂËÅ×ÅÍÈÅ");		skip_lemmas.insert ("ÈÇÃÎÒÎÂÈÒÜ");
		skip_lemmas.insert ("ÊÀÂÊÀÇÑÊÈÉ");		skip_lemmas.insert ("ÍÀÏĞÀÂËßÒÜ");		skip_lemmas.insert ("ÍÀÕÎÆÄÅÍÈÅ");		skip_lemmas.insert ("ÍÅÄÂÈÆÈÌÛÉ");
		skip_lemmas.insert ("ÎÁÅÑÏÅ×ÈÒÜ");		skip_lemmas.insert ("ÎÁĞÀÇÎÂÀÒÜ");		skip_lemmas.insert ("ÎÁÚßÑÍÅÍÈÅ");		skip_lemmas.insert ("ÎÒÊËÎÍÅÍÈÅ");
		skip_lemmas.insert ("ÎÒ×ÅÒÍÎÑÒÜ");		skip_lemmas.insert ("ÏÅĞÅÄÀÂÀÒÜ");		skip_lemmas.insert ("ÏÎÂÎËÆÑÊÈÉ");		skip_lemmas.insert ("ÏÎÄÄÅĞÆÀÒÜ");
		skip_lemmas.insert ("ÏĞÅÄÛÄÓÙÈÉ");		skip_lemmas.insert ("ÏĞÅÊĞÀÒÈÒÜ");		skip_lemmas.insert ("ĞÀÇÚßÑÍÈÒÜ");		skip_lemmas.insert ("ÒÎËÊÎÂÀÍÈÅ");
		skip_lemmas.insert ("ÓÌÅÍÜØÅÍÈÅ");		skip_lemmas.insert ("ÀÍÀËÎÃÈ×ÍÛÉ");		skip_lemmas.insert ("ÁÀÍÊĞÎÒÑÒÂÎ");		skip_lemmas.insert ("ÃÅÍÅĞÀËÜÍÛÉ");
		skip_lemmas.insert ("ÄÎÊÀÇÛÂÀÍÈÅ");		skip_lemmas.insert ("ÄÎÍÀ×ÈÑËÈÒÜ");		skip_lemmas.insert ("ÇÀÂÈÑÈÌÎÑÒÜ");		skip_lemmas.insert ("ÇÀÌÅÑÒÈÒÅËÜ");
		skip_lemmas.insert ("ÈÑÏÎËÍÈÒÅËÜ");		skip_lemmas.insert ("ÊÎÌÏÅÒÅÍÖÈß");		skip_lemmas.insert ("ÌÅÆĞÀÉÎÍÍÛÉ");		skip_lemmas.insert ("ÍÅÇÀÂÈÑÈÌÛÉ");
		skip_lemmas.insert ("ÎÁÆÀËÎÂÀÍÈÅ");		skip_lemmas.insert ("ÎÁÚÅÊÒÈÂÍÛÉ");		skip_lemmas.insert ("ÎÏĞÎÂÅĞÃÀÒÜ");		skip_lemmas.insert ("ÏÎÑËÅÄÓŞÙÈÉ");
		skip_lemmas.insert ("ÏÎÑÒÀÍÎÂÈÒÜ");		skip_lemmas.insert ("ÏĞÅÄÚßÂËßÒÜ");		skip_lemmas.insert ("ÑÎÂÅĞØÅÍÍÛÉ");		skip_lemmas.insert ("ÑÎÃËÀÑÎÂÀÒÜ");
		skip_lemmas.insert ("ÑÎÑÒÀÂËÅÍÈÅ");		skip_lemmas.insert ("ÑÏÅÖÈÀËÜÍÛÉ");		skip_lemmas.insert ("ÑÒĞÀÕÎÂÀÍÈÅ");		skip_lemmas.insert ("ÓÂÅÄÎÌËÅÍÈÅ");
		skip_lemmas.insert ("ÖÅÍÒĞÀËÜÍÛÉ");		skip_lemmas.insert ("ÂÑÅÑÒÎĞÎÍÍÈÉ");		skip_lemmas.insert ("ÊÎÌÌÅĞ×ÅÑÊÈÉ");		skip_lemmas.insert ("ÌÎÒÈÂÈĞÎÂÀÒÜ");
		skip_lemmas.insert ("ÍÅÄÂÈÆÈÌÎÑÒÜ");		skip_lemmas.insert ("ÎÑÂÎÁÎÆÄÅÍÈÅ");		skip_lemmas.insert ("ÎÒÍÎÑÈÒÅËÜÍÎ");		skip_lemmas.insert ("ĞÅÇÎËŞÒÈÂÍÛÉ");
		skip_lemmas.insert ("İÊÑÏËÓÀÒÀÖÈß");		skip_lemmas.insert ("ÂÛØÅÍÀÇÂÀÍÍÛÉ");		skip_lemmas.insert ("ÈÌÓÙÅÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ËÅÍÈÍÃĞÀÄÑÊÈÉ");
		skip_lemmas.insert ("ÍÅÂÎÇÌÎÆÍÎÑÒÜ");		skip_lemmas.insert ("ÍÅÍÎĞÌÀÒÈÂÍÛÉ");		skip_lemmas.insert ("ÎÄÍÎÂĞÅÌÅÍÍÛÉ");		skip_lemmas.insert ("ÎÒÍÎÑÈÒÅËÜÍÛÉ");
		skip_lemmas.insert ("ÑÂÈÄÅÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ÑÂÎÅÂĞÅÌÅÍÍÛÉ");		skip_lemmas.insert ("ÑÒĞÎÈÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ÂÎÑÑÒÀÍÎÂËÅÍÈÅ");
		skip_lemmas.insert ("ÂÛØÅÈÇËÎÆÅÍÍÛÉ");		skip_lemmas.insert ("ÇÀÈÍÒÅĞÅÑÎÂÀÒÜ");		skip_lemmas.insert ("ÌÎÒÈÂÈĞÎÂÀÍÍÛÉ");		skip_lemmas.insert ("ÍÅÄÎÊÀÇÀÍÍÎÑÒÜ");
		skip_lemmas.insert ("ÍÅÑÎÎÒÂÅÒÑÒÂÈÅ");		skip_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÅÍÍÀß");		skip_lemmas.insert ("ÄÀËÜÍÅÂÎÑÒÎ×ÍÛÉ");		skip_lemmas.insert ("ÊÎÍÑÒÈÒÓÖÈÎÍÍÛÉ");
		skip_lemmas.insert ("ÍÅÏĞÅÄÑÒÀÂËÅÍÈÅ");		skip_lemmas.insert ("ĞÀÇÁÈĞÀÒÅËÜÑÒÂÎ");		skip_lemmas.insert ("ÒÅĞĞÈÒÎĞÈÀËÜÍÛÉ");		skip_lemmas.insert ("ÓÄÎÂËÅÒÂÎĞÅÍÍÛÉ");
		skip_lemmas.insert ("ÇÀÈÍÒÅĞÅÑÎÂÀÍÍÛÉ");		skip_lemmas.insert ("ÍÅÎÁÎÑÍÎÂÀÍÍÎÑÒÜ");		skip_lemmas.insert ("ÏĞÎÈÇÂÎÄÑÒÂÅÍÍÛÉ");		skip_lemmas.insert ("ÍÅÑÎÑÒÎßÒÅËÜÍÎÑÒÜ");
		skip_lemmas.insert ("ÍÅÄÅÉÑÒÂÈÒÅËÜÍÎÑÒÜ");		skip_lemmas.insert ("ÏĞÅÄÑÅÄÀÒÅËÜÑÒÂÎÂÀÒÜ");		skip_lemmas.insert ("ÏĞÅÄÑÅÄÀÒÅËÜÑÒÂÓŞÙÈÉ");
	}
#endif

	std::set<std::string> remain_lemmas;

#ifndef	_DEBUG
	//Ñïèñîê îò 23 àâãóñòà 2011ã.
	remain_lemmas.insert ("ÀÃÅÍÒ");
	remain_lemmas.insert ("ÀÄĞÅÑ");
	remain_lemmas.insert ("ÀÊÖÈÎÍÅĞÍÛÉ");
	remain_lemmas.insert ("ÀĞÅÍÄÀ");
	remain_lemmas.insert ("ÀĞÅÍÄÀÒÎĞ");
	remain_lemmas.insert ("ÀĞÅÍÄÍÛÉ");
	remain_lemmas.insert ("ÀĞÅÍÄÎÂÀÒÜ");
	remain_lemmas.insert ("ÀĞÅÍÄÎÄÀÒÅËÜ");
	remain_lemmas.insert ("ÁÀËÀÍÑ");
	remain_lemmas.insert ("ÁÀÍÊ");
	remain_lemmas.insert ("ÁÀÍÊÎÂÑÊÈÉ");
	remain_lemmas.insert ("ÁÀÍÊĞÎÒ");
	remain_lemmas.insert ("ÁÀÍÊĞÎÒÑÒÂÎ");
	remain_lemmas.insert ("ÁÅÇÄÅÉÑÒÂÈÅ");
	remain_lemmas.insert ("ÁŞÄÆÅÒ");
	remain_lemmas.insert ("ÁŞÄÆÅÒÍÛÉ");
	remain_lemmas.insert ("ÂÅÄÅÍÈÅ");
	remain_lemmas.insert ("ÂÇÀÈÌÍÛÉ");
	remain_lemmas.insert ("ÂÇÍÎÑ");
	remain_lemmas.insert ("ÂÇÛÑÊÀÍÈÅ");
	remain_lemmas.insert ("ÂÇÛÑÊÀÒÜ");
	remain_lemmas.insert ("ÂÈÍÀ");
	remain_lemmas.insert ("ÂÈÍÎ");
	remain_lemmas.insert ("ÂÈÍÎÂÍÛÉ");
	remain_lemmas.insert ("ÂÊËŞ×ÀÒÜ");
	remain_lemmas.insert ("ÂËÀÄÅËÅÖ");
	remain_lemmas.insert ("ÂËÀÄÅÍÈÅ");
	remain_lemmas.insert ("ÂÎÇÂĞÀÒ");
	remain_lemmas.insert ("ÂÎÇÂĞÀÒÈÒÜ");
	remain_lemmas.insert ("ÂÎÇÌÅÙÅÍÈÅ");
	remain_lemmas.insert ("ÂÎÇÍÈÊÍÎÂÅÍÈÅ");
	remain_lemmas.insert ("ÂÎÑÑÒÀÍÎÂËÅÍÈÅ");
	remain_lemmas.insert ("ÂĞÅÄ");
	remain_lemmas.insert ("ÂĞÅÌÅÍÍÛÉ");
	remain_lemmas.insert ("ÂÑÒĞÅ×ÍÛÉ");
	remain_lemmas.insert ("ÂÑÒÓÏÈÒÜ");
	remain_lemmas.insert ("ÂÑÒÓÏËÅÍÈÅ");
	remain_lemmas.insert ("ÂÛÄÀÒÜ");
	remain_lemmas.insert ("ÂÛÄÀ×À");
	remain_lemmas.insert ("ÂÛÅÇÄÍÎÉ");
	remain_lemmas.insert ("ÂÛÏËÀÒÈÒÜ");
	remain_lemmas.insert ("ÂÛÏÎËÍÅÍÈÅ");
	remain_lemmas.insert ("ÂÛÏÎËÍßÒÜ");
	remain_lemmas.insert ("ÂÛÏÓÑÊ");
	remain_lemmas.insert ("ÂÛĞÓ×ÊÀ");
	remain_lemmas.insert ("ÂÛÑÒÀÂÈÒÜ");
	remain_lemmas.insert ("ÂÛ×ÅÒ");
	remain_lemmas.insert ("ÃÅÍÅĞÀËÜÍÛÉ");
	remain_lemmas.insert ("ÃÎÑÏÎØËÈÍÀ");
	remain_lemmas.insert ("ÃÎÑÓÄÀĞÑÒÂÎ");
	remain_lemmas.insert ("ÃĞÀÆÄÀÍÈÍ");
	remain_lemmas.insert ("ÃĞÀÍÈÖÀ");
	remain_lemmas.insert ("ÃĞÓÇ");
	remain_lemmas.insert ("ÃĞÓÇÎÂÎÉ");
	remain_lemmas.insert ("ÄÀÂÍÎÑÒÜ");
	remain_lemmas.insert ("ÄÂÈÆÅÍÈÅ");
	remain_lemmas.insert ("ÄÅÊËÀĞÀÖÈß");
	remain_lemmas.insert ("ÄÅËÎÂÎÉ");
	remain_lemmas.insert ("ÄÅÍÅÆÍÛÉ");
	remain_lemmas.insert ("ÄÈĞÅÊÒÎĞ");
	remain_lemmas.insert ("ÄÎÁĞÎÂÎËÜÍÛÉ");
	remain_lemmas.insert ("ÄÎÂÅĞÅÍÍÎÑÒÜ");
	remain_lemmas.insert ("ÄÎÃÎÂÎĞ");
	remain_lemmas.insert ("ÄÎÃÎÂÎĞÍÛÉ");
	remain_lemmas.insert ("ÄÎÊÀÇÀÒÅËÜÑÒÂÎ");
	remain_lemmas.insert ("ÄÎÊÀÇÛÂÀÍÈÅ");
	remain_lemmas.insert ("ÄÎÊÓÌÅÍÒÀÖÈß");
	remain_lemmas.insert ("ÄÎËÃ");
	remain_lemmas.insert ("ÄÎËÆÍÈÊ");
	remain_lemmas.insert ("ÄÎËÆÍÎÑÒÍÎÉ");
	remain_lemmas.insert ("ÄÎÍÀ×ÈÑËÅÍÈÅ");
	remain_lemmas.insert ("ÄÎĞÎÃÀ");
	remain_lemmas.insert ("ÄÎÑÒÎÂÅĞÍÎÑÒÜ");
	remain_lemmas.insert ("ÄÎÑÒÎÂÅĞÍÛÉ");
	remain_lemmas.insert ("ÄÎÕÎÄ");
	remain_lemmas.insert ("ÅÄÈÍÛÉ");
	remain_lemmas.insert ("ÅÆÅÌÅÑß×ÍÛÉ");
	remain_lemmas.insert ("ÆÅËÅÇÍÎÄÎĞÎÆÍÛÉ");
	remain_lemmas.insert ("ÆÈËÎÉ");
	remain_lemmas.insert ("ÇÀÂÈÑÅÒÜ");
	remain_lemmas.insert ("ÇÀÄÎËÆÅÍÍÎÑÒÜ");
	remain_lemmas.insert ("ÇÀÈÍÒÅĞÅÑÎÂÀÍÍÛÉ");
	remain_lemmas.insert ("ÇÀÈÍÒÅĞÅÑÎÂÀÒÜ");
	remain_lemmas.insert ("ÇÀÊÀÇ×ÈÊ");
	remain_lemmas.insert ("ÇÀÊËŞ×ÀÒÜ");
	remain_lemmas.insert ("ÇÀÊËŞ×ÅÍÈÅ");
	remain_lemmas.insert ("ÇÀÊËŞ×ÅÍÍÀß");
	remain_lemmas.insert ("ÇÀÊËŞ×ÅÍÍÛÉ");
	remain_lemmas.insert ("ÇÀÊĞÅÏÈÒÜ");
	remain_lemmas.insert ("ÇÀÌÅÍÀ");
	remain_lemmas.insert ("ÇÀÍÈÆÅÍÈÅ");
	remain_lemmas.insert ("ÇÀÍÈÌÀÒÜ");
	remain_lemmas.insert ("ÇÀÏÈÑÜ");
	remain_lemmas.insert ("ÇÀĞÅÃÈÑÒĞÈĞÎÂÀÍÍÛÉ");
	remain_lemmas.insert ("ÇÀĞÅÃÈÑÒĞÈĞÎÂÀÒÜ");
	remain_lemmas.insert ("ÇÀÒĞÀÒÀ");
	remain_lemmas.insert ("ÇÀ×ÅÒ");
	remain_lemmas.insert ("ÇÄÀÍÈÅ");
	remain_lemmas.insert ("ÇÅÌÅËÜÍÛÉ");
	remain_lemmas.insert ("ÇÅÌËß");
	remain_lemmas.insert ("ÇÍÀ×ÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÈÇÃÎÒÎÂÈÒÜ");
	remain_lemmas.insert ("ÈÇÃÎÒÎÂËÅÍÈÅ");
	remain_lemmas.insert ("ÈÇËÈØÍÈÉ");
	remain_lemmas.insert ("ÈÇÌÅÍÅÍÈÅ");
	remain_lemmas.insert ("ÈÌÓÙÅÑÒÂÅÍÍÛÉ");
	remain_lemmas.insert ("ÈÌÓÙÅÑÒÂÎ");
	remain_lemmas.insert ("ÈÌß");
	remain_lemmas.insert ("ÈÍÄÈÂÈÄÓÀËÜÍÛÉ");
	remain_lemmas.insert ("ÈÍÎÑÒĞÀÍÍÛÉ");
	remain_lemmas.insert ("ÈÍÑÏÅÊÖÈß");
	remain_lemmas.insert ("ÈÍÑÒĞÓÊÖÈß");
	remain_lemmas.insert ("ÈÍÒÅĞÅÑ");
	remain_lemmas.insert ("ÈÍÒÅĞÍÅÒ");
	remain_lemmas.insert ("ÈÍÔÎĞÌÀÖÈß");
	remain_lemmas.insert ("ÈÑÊËŞ×ÅÍÈÅ");
	remain_lemmas.insert ("ÈÑÊËŞ×ÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÈÑÏÎËÍÅÍÈÅ");
	remain_lemmas.insert ("ÈÑÏÎËÍÈÒÅËÜ");
	remain_lemmas.insert ("ÈÑÏÎËÍÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÈÑÏÎËÍÈÒÜ");
	remain_lemmas.insert ("ÈÑÏÎËÜÇÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÈÑÒÅ×ÅÍÈÅ");
	remain_lemmas.insert ("ÈÑÒÎ×ÍÈÊ");
	remain_lemmas.insert ("ÈÑ×ÈÑËÈÒÜ");
	remain_lemmas.insert ("ÊÀÄÀÑÒĞÎÂÛÉ");
	remain_lemmas.insert ("ÊÀËÅÍÄÀĞÍÛÉ");
	remain_lemmas.insert ("ÊÀÌÅĞÀËÜÍÛÉ");
	remain_lemmas.insert ("ÊÀÏÈÒÀË");
	remain_lemmas.insert ("ÊÀÑÑÎÂÛÉ");
	remain_lemmas.insert ("ÊÀÒÅÃÎĞÈß");
	remain_lemmas.insert ("ÊÀ×ÅÑÒÂÎ");
	remain_lemmas.insert ("ÊÂÀĞÒÀË");
	remain_lemmas.insert ("ÊÂÈÒÀÍÖÈß");
	remain_lemmas.insert ("ÊËŞ×ÅÂÎÉ");
	remain_lemmas.insert ("ÊÎÀÏ");
	remain_lemmas.insert ("ÊÎÌÌÓÍÀËÜÍÛÉ");
	remain_lemmas.insert ("ÊÎÌÏÅÍÑÀÖÈß");
	remain_lemmas.insert ("ÊÎÌÏËÅÊÑ");
	remain_lemmas.insert ("ÊÎÍÊÓĞÑÍÛÉ");
	remain_lemmas.insert ("ÊÎÍÑÒÈÒÓÖÈÎÍÍÛÉ");
	remain_lemmas.insert ("ÊÎÍÑÒÈÒÓÖÈß");
	remain_lemmas.insert ("ÊÎÍÒĞÀÃÅÍÒ");
	remain_lemmas.insert ("ÊÎÍÒĞÎËÜ");
	remain_lemmas.insert ("ÊĞÅÄÈÒÍÛÉ");
	remain_lemmas.insert ("ÊĞÅÄÈÒÎĞ");
	remain_lemmas.insert ("ÊÓÏËß");
	remain_lemmas.insert ("ËÈÊÂÈÄÀÖÈß");
	remain_lemmas.insert ("ËÈ×ÍÛÉ");
	remain_lemmas.insert ("ËÜÃÎÒÀ");
	remain_lemmas.insert ("ÌÀÒÅĞÈÀËÜÍÛÉ");
	remain_lemmas.insert ("ÌÅĞÎÏĞÈßÒÈÅ");
	remain_lemmas.insert ("ÌÅÑÒÍÛÉ");
	remain_lemmas.insert ("ÌÅÑßÖ");
	remain_lemmas.insert ("ÌÅÑß×ÍÛÉ");
	remain_lemmas.insert ("ÌÈÍÈÌÀËÜÍÛÉ");
	remain_lemmas.insert ("ÌÈÍÈÑÒÅĞÑÒÂÎ");
	remain_lemmas.insert ("ÌÎÌÅÍÒ");
	remain_lemmas.insert ("ÌÎÒÈÂ");
	remain_lemmas.insert ("ÌÓÍÈÖÈÏÀËÜÍÛÉ");
	remain_lemmas.insert ("ÍÀÄÇÎĞ");
	remain_lemmas.insert ("ÍÀÈÌÅÍÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÍÀÊÀÇÀÍÈÅ");
	remain_lemmas.insert ("ÍÀÊËÀÄÍÀß");
	remain_lemmas.insert ("ÍÀÊËÀÄÍÎÉ");
	remain_lemmas.insert ("ÍÀÊËÀÄÍÛÉ");
	remain_lemmas.insert ("ÍÀËÎÃ");
	remain_lemmas.insert ("ÍÀËÎÃÎÂÛÉ");
	remain_lemmas.insert ("ÍÀËÎÃÎÎÁËÎÆÅÍÈÅ");
	remain_lemmas.insert ("ÍÀËÎÃÎÏËÀÒÅËÜÙÈÊ");
	remain_lemmas.insert ("ÍÀÏĞÀÂËÅÍÍÛÉ");
	remain_lemmas.insert ("ÍÀĞÓØÅÍÈÅ");
	remain_lemmas.insert ("ÍÀĞÓØÈÒÜ");
	remain_lemmas.insert ("ÍÀÑÅËÅÍÈÅ");
	remain_lemmas.insert ("ÍÀÑÒÓÏËÅÍÈÅ");
	remain_lemmas.insert ("ÍÄÑ");
	remain_lemmas.insert ("ÍÅÂÅĞÍÛÉ");
	remain_lemmas.insert ("ÍÅÂÎÇÌÎÆÍÎÑÒÜ");
	remain_lemmas.insert ("ÍÅÄÂÈÆÈÌÎÑÒÜ");
	remain_lemmas.insert ("ÍÅÄÂÈÆÈÌÛÉ");
	remain_lemmas.insert ("ÍÅÄÅÉÑÒÂÈÒÅËÜÍÎÑÒÜ");
	remain_lemmas.insert ("ÍÅÄÅÉÑÒÂÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÍÅÄÎÈÌÊÀ");
	remain_lemmas.insert ("ÍÅÆÈËÎÉ");
	remain_lemmas.insert ("ÍÅÇÀÊÎÍÍÛÉ");
	remain_lemmas.insert ("ÍÅÈÑÏÎËÍÅÍÈÅ");
	remain_lemmas.insert ("ÍÅÍÀÄËÅÆÀÙÈÉ");
	remain_lemmas.insert ("ÍÅÎÁÎÑÍÎÂÀÍÍÛÉ");
	remain_lemmas.insert ("ÍÅÎÁÕÎÄÈÌÎÑÒÜ");
	remain_lemmas.insert ("ÍÅÎÑÍÎÂÀÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÍÅÏÎËÍÛÉ");
	remain_lemmas.insert ("ÍÅÏÎÑĞÅÄÑÒÂÅÍÍÛÉ");
	remain_lemmas.insert ("ÍÅÏĞÀÂÎÌÅĞÍÛÉ");
	remain_lemmas.insert ("ÍÅÏĞÈÌÅÍÅÍÈÅ");
	remain_lemmas.insert ("ÍÅÑÎÁËŞÄÅÍÈÅ");
	remain_lemmas.insert ("ÍÅÑÎÎÒÂÅÒÑÒÂÈÅ");
	remain_lemmas.insert ("ÍÅÑÎÑÒÎßÒÅËÜÍÎÑÒÜ");
	remain_lemmas.insert ("ÍÅÑÎÑÒÎßÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÍÅÓÏËÀÒÀ");
	remain_lemmas.insert ("ÍÅÓÑÒÎÉÊÀ");
	remain_lemmas.insert ("ÍÈ×ÒÎÆÍÛÉ");
	remain_lemmas.insert ("ÍÊ");
	remain_lemmas.insert ("ÎÁËÀÃÀÒÜ");
	remain_lemmas.insert ("ÎÁËÀÄÀÒÜ");
	remain_lemmas.insert ("ÎÁÎĞÎÒ");
	remain_lemmas.insert ("ÎÁÎĞÓÄÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÎÁĞÀÇ");
	remain_lemmas.insert ("ÎÁĞÀÙÅÍÈÅ");
	remain_lemmas.insert ("ÎÁÑËÓÆÈÂÀÍÈÅ");
	remain_lemmas.insert ("ÎÁÙÅÑÒÂÅÍÍÛÉ");
	remain_lemmas.insert ("ÎÁÚÅÊÒ");
	remain_lemmas.insert ("ÎÁÚÅÌ");
	remain_lemmas.insert ("ÎÁÛ×ÍÛÉ");
	remain_lemmas.insert ("ÎÁßÇÀÍÍÎÑÒÜ");
	remain_lemmas.insert ("ÎÁßÇÀÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÎÁßÇÀÒÅËÜÑÒÂÎ");
	remain_lemmas.insert ("ÎÃĞÀÍÈ×ÅÍÈÅ");
	remain_lemmas.insert ("ÎÃĞÀÍÈ×ÅÍÍÛÉ");
	remain_lemmas.insert ("ÎÃĞÀÍÈ×ÈÒÜ");
	remain_lemmas.insert ("ÎÄÍÎÑÒÎĞÎÍÍÈÉ");
	remain_lemmas.insert ("ÎÊÀÇÀÍÈÅ");
	remain_lemmas.insert ("ÎÊÀÇÛÂÀÒÜ");
	remain_lemmas.insert ("ÎÏÅ×ÀÒÊÀ");
	remain_lemmas.insert ("ÎÏËÀÒÀ");
	remain_lemmas.insert ("ÎÏËÀÒÈÒÜ");
	remain_lemmas.insert ("ÎÏËÀ×ÈÂÀÒÜ");
	remain_lemmas.insert ("ÎÏĞÅÄÅËÈÒÜ");
	remain_lemmas.insert ("ÎÑÂÎÁÎÄÈÒÜ");
	remain_lemmas.insert ("ÎÑÂÎÁÎÆÄÀÒÜ");
	remain_lemmas.insert ("ÎÑÍÎÂÍÎÉ");
	remain_lemmas.insert ("ÎÒÇÛÂ");
	remain_lemmas.insert ("ÎÒÊÀÇ");
	remain_lemmas.insert ("ÎÒÌÅÒÊÀ");
	remain_lemmas.insert ("ÎÒÑÓÒÑÒÂÈÅ");
	remain_lemmas.insert ("ÎÒÑÓÒÑÒÂÎÂÀÒÜ");
	remain_lemmas.insert ("ÎÒ×ÅÒÍÎÑÒÜ");
	remain_lemmas.insert ("ÎÒ×ÅÒÍÛÉ");
	remain_lemmas.insert ("ÎÔÎĞÌÈÒÜ");
	remain_lemmas.insert ("ÎÖÅÍÊÀ");
	remain_lemmas.insert ("Î×ÅĞÅÄÜ");
	remain_lemmas.insert ("ÎØÈÁÎ×ÍÛÉ");
	remain_lemmas.insert ("ÏÀÑÏÎĞÒ");
	remain_lemmas.insert ("ÏÅÍÈ");
	remain_lemmas.insert ("ÏÅÍÑÈÎÍÍÛÉ");
	remain_lemmas.insert ("ÏÅÍß");
	remain_lemmas.insert ("ÏÅĞÂÈ×ÍÛÉ");
	remain_lemmas.insert ("ÏÅĞÂÎÅ");
	remain_lemmas.insert ("ÏÅĞÂÎÍÀ×ÀËÜÍÛÉ");
	remain_lemmas.insert ("ÏÅĞÅÂÎÇÊÀ");
	remain_lemmas.insert ("ÏÅĞÅÄÀÒÜ");
	remain_lemmas.insert ("ÏÅĞÅÄÀ×À");
	remain_lemmas.insert ("ÏÅĞÅÎÖÅÍÊÀ");
	remain_lemmas.insert ("ÏÅĞÅÕÎÄ");
	remain_lemmas.insert ("ÏÅĞÅ×ÈÑËÈÒÜ");
	remain_lemmas.insert ("ÏÅĞÈÎÄ");
	remain_lemmas.insert ("ÏÈÑÜÌÅÍÍÛÉ");
	remain_lemmas.insert ("ÏËÀÍ");
	remain_lemmas.insert ("ÏËÀÒÀ");
	remain_lemmas.insert ("ÏËÀÒÅÆ");
	remain_lemmas.insert ("ÏËÀÒÅÆÍÛÉ");
	remain_lemmas.insert ("ÏËÀÒÅËÜÙÈÊ");
	remain_lemmas.insert ("ÏËÎÙÀÄÜ");
	remain_lemmas.insert ("ÏÎÃÀÑÈÒÜ");
	remain_lemmas.insert ("ÏÎÃÀØÅÍÈÅ");
	remain_lemmas.insert ("ÏÎÄÀ×À");
	remain_lemmas.insert ("ÏÎÄÃÎÒÎÂÊÀ");
	remain_lemmas.insert ("ÏÎÄÏÈÑÀÍÈÅ");
	remain_lemmas.insert ("ÏÎÄÏÈÑÀÒÜ");
	remain_lemmas.insert ("ÏÎÄÏÈÑÜ");
	remain_lemmas.insert ("ÏÎÄĞÀÇÄÅËÅÍÈÅ");
	remain_lemmas.insert ("ÏÎÄĞßÄ");
	remain_lemmas.insert ("ÏÎÄĞßÄ×ÈÊ");
	remain_lemmas.insert ("ÏÎÄÒÂÅĞÄÈÒÜ");
	remain_lemmas.insert ("ÏÎÄÒÂÅĞÆÄÀÒÜ");
	remain_lemmas.insert ("ÏÎÄÒÂÅĞÆÄÅÍÈÅ");
	remain_lemmas.insert ("ÏÎÇÈÖÈß");
	remain_lemmas.insert ("ÏÎÊÓÏÀÒÅËÜ");
	remain_lemmas.insert ("ÏÎËÍÎÌÎ×ÈÅ");
	remain_lemmas.insert ("ÏÎËÍÎÑÒÜŞ");
	remain_lemmas.insert ("ÏÎËÍÛÉ");
	remain_lemmas.insert ("ÏÎËÜÇÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÏÎÌÅÙÅÍÈÅ");
	remain_lemmas.insert ("ÏÎĞÓ×ÅÍÈÅ");
	remain_lemmas.insert ("ÏÎĞßÄÎÊ");
	remain_lemmas.insert ("ÏÎÑÒÀÂÈÒÜ");
	remain_lemmas.insert ("ÏÎÑÒÀÂÊÀ");
	remain_lemmas.insert ("ÏÎÑÒÀÂÙÈÊ");
	remain_lemmas.insert ("ÏÎÑÒÎßÍÍÛÉ");
	remain_lemmas.insert ("ÏÎÒĞÅÁÈÒÅËÜ");
	remain_lemmas.insert ("ÏÎ×ÒÎÂÛÉ");
	remain_lemmas.insert ("ÏÎØËÈÍÀ");
	remain_lemmas.insert ("ÏĞÀÂÈÒÅËÜÑÒÂÎ");
	remain_lemmas.insert ("ÏĞÀÂÈÒÜ");
	remain_lemmas.insert ("ÏĞÀÂÎÏĞÅÅÌÍÈÊ");
	remain_lemmas.insert ("ÏĞÅÄÅË");
	remain_lemmas.insert ("ÏĞÅÄÏĞÈÍÈÌÀÒÅËÜ");
	remain_lemmas.insert ("ÏĞÅÄÏĞÈÍÈÌÀÒÅËÜÑÊÈÉ");
	remain_lemmas.insert ("ÏĞÅÄÑÒÀÂÈÒÅËÜ");
	remain_lemmas.insert ("ÏĞÅÄÓÑÌÎÒĞÅÒÜ");
	remain_lemmas.insert ("ÏĞÅÄÚßÂÈÒÜ");
	remain_lemmas.insert ("ÏĞÅÄÚßÂËÅÍÈÅ");
	remain_lemmas.insert ("ÏĞÅÊĞÀÙÅÍÈÅ");
	remain_lemmas.insert ("ÏĞÅÏßÒÑÒÂÈÅ");
	remain_lemmas.insert ("ÏĞÅÏßÒÑÒÂÎÂÀÒÜ");
	remain_lemmas.insert ("ÏĞÅÒÅÍÇÈß");
	remain_lemmas.insert ("ÏĞÈÁÛËÜ");
	remain_lemmas.insert ("ÏĞÈÂËÅ×Ü");
	remain_lemmas.insert ("ÏĞÈÅÌ");
	remain_lemmas.insert ("ÏĞÈÅÌÊÀ");
	remain_lemmas.insert ("ÏĞÈÇÍÀÍÈÅ");
	remain_lemmas.insert ("ÏĞÈÇÍÀÍÍÛÉ");
	remain_lemmas.insert ("ÏĞÈÇÍÀÒÜ");
	remain_lemmas.insert ("ÏĞÈÍÀÄËÅÆÀÒÜ");
	remain_lemmas.insert ("ÏĞÈÍÓÄÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÏĞÈÍÖÈÏ");
	remain_lemmas.insert ("ÏĞÈÎÁĞÅÒÅÍÈÅ");
	remain_lemmas.insert ("ÏĞÈÎÑÒÀÍÎÂËÅÍÈÅ");
	remain_lemmas.insert ("ÏĞÈ×ÈÍÀ");
	remain_lemmas.insert ("ÏĞÈ×ÈÍÅÍÈÅ");
	remain_lemmas.insert ("ÏĞÎÂÅÄÅÍÈÅ");
	remain_lemmas.insert ("ÏĞÎÂÅĞÊÀ");
	remain_lemmas.insert ("ÏĞÎÄÀÂÅÖ");
	remain_lemmas.insert ("ÏĞÎÄÀÆÀ");
	remain_lemmas.insert ("ÏĞÎÄÓÊÖÈß");
	remain_lemmas.insert ("ÏĞÎÅÊÒ");
	remain_lemmas.insert ("ÏĞÎÈÇÂÎÄÑÒÂÎ");
	remain_lemmas.insert ("ÏĞÎÏÓÑÊ");
	remain_lemmas.insert ("ÏĞÎÏÓÑÒÈÒÜ");
	remain_lemmas.insert ("ÏĞÎÑĞÎ×ÊÀ");
	remain_lemmas.insert ("ÏĞÎÒÎÊÎË");
	remain_lemmas.insert ("ÏĞÎÖÅÄÓĞÀ");
	remain_lemmas.insert ("ÏĞÎÖÅÍÒ");
	remain_lemmas.insert ("ÏĞÎÖÅÑÑ");
	remain_lemmas.insert ("ÏÓÁËÈ×ÍÛÉ");
	remain_lemmas.insert ("ĞÀÁÎÒÀ");
	remain_lemmas.insert ("ĞÀÁÎÒÍÈÊ");
	remain_lemmas.insert ("ĞÀÁÎ×ÈÉ");
	remain_lemmas.insert ("ĞÀÇÁÈĞÀÒÅËÜÑÒÂÎ");
	remain_lemmas.insert ("ĞÀÇÌÅĞ");
	remain_lemmas.insert ("ĞÀÇÌÅÙÅÍÈÅ");
	remain_lemmas.insert ("ĞÀÇÍÈÖÀ");
	remain_lemmas.insert ("ĞÀÇĞÅØÅÍÈÅ");
	remain_lemmas.insert ("ĞÀÌÊÀ");
	remain_lemmas.insert ("ĞÀÑÏĞÅÄÅËÅÍÈÅ");
	remain_lemmas.insert ("ĞÀÑÒÎĞÆÅÍÈÅ");
	remain_lemmas.insert ("ĞÀÑÕÎÄ");
	remain_lemmas.insert ("ĞÀÑ×ÅÒ");
	remain_lemmas.insert ("ĞÀÑ×ÅÒÍÛÉ");
	remain_lemmas.insert ("ĞÅÀËÈÇÀÖÈß");
	remain_lemmas.insert ("ĞÅÀËÈÇÎÂÀÒÜ");
	remain_lemmas.insert ("ĞÅÀËÜÍÛÉ");
	remain_lemmas.insert ("ĞÅÃÈÑÒĞÀÖÈÎÍÍÛÉ");
	remain_lemmas.insert ("ĞÅÃÈÑÒĞÀÖÈß");
	remain_lemmas.insert ("ĞÅÃÓËÈĞÎÂÀÍÈÅ");
	remain_lemmas.insert ("ĞÅÅÑÒĞ");
	remain_lemmas.insert ("ĞÅÆÈÌ");
	remain_lemmas.insert ("ĞÅÇÓËÜÒÀÒ");
	remain_lemmas.insert ("ĞÅÌÎÍÒ");
	remain_lemmas.insert ("ĞÓÊÎÂÎÄÈÒÅËÜ");
	remain_lemmas.insert ("ÑÀÌÎÓÏĞÀÂËÅÍÈÅ");
	remain_lemmas.insert ("ÑÀÍÊÖÈß");
	remain_lemmas.insert ("ÑÁÎĞ");
	remain_lemmas.insert ("ÑÁÎĞÛ");
	remain_lemmas.insert ("ÑÂÅĞÊÀ");
	remain_lemmas.insert ("ÑÂÈÄÅÒÅËÜÑÒÂÎ");
	remain_lemmas.insert ("ÑÂÎÁÎÄÀ");
	remain_lemmas.insert ("ÑÄÀ×À");
	remain_lemmas.insert ("ÑÄÅËÊÀ");
	remain_lemmas.insert ("ÑËÓ×ÀÉ");
	remain_lemmas.insert ("ÑÎÁĞÀÍÈÅ");
	remain_lemmas.insert ("ÑÎÁÑÒÂÅÍÍÈÊ");
	remain_lemmas.insert ("ÑÎÁÑÒÂÅÍÍÎÑÒÜ");
	remain_lemmas.insert ("ÑÎÁÑÒÂÅÍÍÛÉ");
	remain_lemmas.insert ("ÑÎÂÅĞØÅÍÈÅ");
	remain_lemmas.insert ("ÑÎÂÌÅÑÒÍÛÉ");
	remain_lemmas.insert ("ÑÎÃËÀÑÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÑÎÃËÀØÅÍÈÅ");
	remain_lemmas.insert ("ÑÎÄÅĞÆÀÍÈÅ");
	remain_lemmas.insert ("ÑÎÄÅĞÆÀÒÜ");
	remain_lemmas.insert ("ÑÎÎĞÓÆÅÍÈÅ");
	remain_lemmas.insert ("ÑÎÖÈÀËÜÍÛÉ");
	remain_lemmas.insert ("ÑÏÅÖÈÀËÈÑÒ");
	remain_lemmas.insert ("ÑÏĞÀÂÊÀ");
	remain_lemmas.insert ("ÑĞÅÄÑÒÂÀ");
	remain_lemmas.insert ("ÑĞÅÄÑÒÂÎ");
	remain_lemmas.insert ("ÑĞÎÊ");
	remain_lemmas.insert ("ÑÒÀÂÊÀ");
	remain_lemmas.insert ("ÑÒÀÒÓÑ");
	remain_lemmas.insert ("ÑÒÎÈÌÎÑÒÜ");
	remain_lemmas.insert ("ÑÒĞÀÕÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÑÒĞÀÕÎÂÎÉ");
	remain_lemmas.insert ("ÑÒĞÎÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("ÑÒĞÎÈÒÅËÜÑÒÂÎ");
	remain_lemmas.insert ("ÑÓÙÅÑÒÂÅÍÍÛÉ");
	remain_lemmas.insert ("ÑÔÅĞÀ");
	remain_lemmas.insert ("Ñ×ÅÒ");
	remain_lemmas.insert ("ÒÀÌÎÆÅÍÍÛÉ");
	remain_lemmas.insert ("ÒÀÌÎÆÍß");
	remain_lemmas.insert ("ÒÀĞÈÔ");
	remain_lemmas.insert ("ÒÅĞĞÈÒÎĞÈß");
	remain_lemmas.insert ("ÒÅÕÍÈ×ÅÑÊÈÉ");
	remain_lemmas.insert ("ÒÎÂÀĞ");
	remain_lemmas.insert ("ÒÎÂÀĞÍÛÉ");
	remain_lemmas.insert ("ÒÎĞÃÎÂËß");
	remain_lemmas.insert ("ÒĞÀÍÑÏÎĞÒ");
	remain_lemmas.insert ("ÒĞÀÍÑÏÎĞÒÍÛÉ");
	remain_lemmas.insert ("ÒĞÅÒÈÉ");
	remain_lemmas.insert ("ÒĞÅÒÜÅ");
	remain_lemmas.insert ("ÒĞÅÒÜß");
	remain_lemmas.insert ("ÒĞÓÄ");
	remain_lemmas.insert ("ÒĞÓÄÎÂÎÉ");
	remain_lemmas.insert ("ÓÁÛÒÎÊ");
	remain_lemmas.insert ("ÓÂÅËÈ×ÅÍÈÅ");
	remain_lemmas.insert ("ÓÄÎÑÒÎÂÅĞÅÍÈÅ");
	remain_lemmas.insert ("ÓÊÀÇÀÍÈÅ");
	remain_lemmas.insert ("ÓÌÅÍÜØÅÍÈÅ");
	remain_lemmas.insert ("ÓÌÅÍÜØÈÒÜ");
	remain_lemmas.insert ("ÓÍÈÒÀĞÍÛÉ");
	remain_lemmas.insert ("ÓÏËÀÒÀ");
	remain_lemmas.insert ("ÓÏËÀÒÈÒÜ");
	remain_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÅÍÍÀß");
	remain_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÅÍÍÛÉ");
	remain_lemmas.insert ("ÓÏÎËÍÎÌÎ×ÈÒÜ");
	remain_lemmas.insert ("ÓÏĞÀÂËßŞÙÈÉ");
	remain_lemmas.insert ("ÓÑËÎÂÈÅ");
	remain_lemmas.insert ("ÓÑËÓÃÀ");
	remain_lemmas.insert ("ÓÑÒÀÂ");
	remain_lemmas.insert ("ÓÑÒÀÂÍÎÉ");
	remain_lemmas.insert ("ÓÑÒÀÂÍÛÉ");
	remain_lemmas.insert ("Ó×ÀÑÒÍÈÊ");
	remain_lemmas.insert ("Ó×ÀÑÒÎÊ");
	remain_lemmas.insert ("Ó×ÅÑÒÜ");
	remain_lemmas.insert ("Ó×ÅÒ");
	remain_lemmas.insert ("Ó×ÅÒÍÛÉ");
	remain_lemmas.insert ("Ó×ÈÒÛÂÀÒÜ");
	remain_lemmas.insert ("Ó×ĞÅÄÈÒÅËÜ");
	remain_lemmas.insert ("Ó×ĞÅÄÈÒÅËÜÍÛÉ");
	remain_lemmas.insert ("Ó×ĞÅÆÄÅÍÈÅ");
	remain_lemmas.insert ("ÓÙÅĞÁ");
	remain_lemmas.insert ("ÔÀÊÒ");
	remain_lemmas.insert ("ÔÀÊÒÈ×ÅÑÊÈÉ");
	remain_lemmas.insert ("ÔÀÊÒÓĞÀ");
	remain_lemmas.insert ("ÔÈÇÈ×ÅÑÊÈÉ");
	remain_lemmas.insert ("ÔÈÍÀÍÑÈĞÎÂÀÍÈÅ");
	remain_lemmas.insert ("ÔÈÍÀÍÑÎÂÛÉ");
	remain_lemmas.insert ("ÔÈÍÀÍÑÛ");
	remain_lemmas.insert ("ÕÎÄÀÒÀÉÑÒÂÎ");
	remain_lemmas.insert ("ÕÎÇßÉÑÒÂÅÍÍÛÉ");
	remain_lemmas.insert ("ÕÎÇßÉÑÒÂÎ");
	remain_lemmas.insert ("ÕĞÀÍÅÍÈÅ");
	remain_lemmas.insert ("ÖÅÍÀ");
	remain_lemmas.insert ("×ÀÑ");
	remain_lemmas.insert ("×ÓÆÀß");
	remain_lemmas.insert ("×ÓÆÎÉ");
	remain_lemmas.insert ("ØÒĞÀÔ");
	remain_lemmas.insert ("ØÒĞÀÔÍÎÉ");
	remain_lemmas.insert ("İÊÎÍÎÌÈ×ÅÑÊÈÉ");
	remain_lemmas.insert ("İÊÑÏÅĞÒÈÇÀ");
	remain_lemmas.insert ("İÊÑÏËÓÀÒÀÖÈß");
	remain_lemmas.insert ("İÊÑÏÎĞÒ");
	remain_lemmas.insert ("İÍÅĞÃÈß");
	remain_lemmas.insert ("ßÂÊÀ");
#endif

	for (std::set<std::string>::const_iterator it = remain_lemmas.begin (); it != remain_lemmas.end (); it++)
		skip_lemmas.erase (*it);

	if (!two_bases && argc == 7) {
		long year = atol (argv [6]);
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long doc_id_i = (*alldocs)[i];
			DocInfo docinfo;
			aBase->FindDocInfo (doc_id_i, docinfo);
			if (docinfo.FirstDate.da_year == year)
				year_docs.insert (doc_id_i);
		}
		printf ("year %ld docs: %ld\n", year, year_docs.size ());
	}

	bool b_calc = (two_bases && new_docs->ItemCount) || !two_bases;
	int i;
	if (b_calc) {
		for (BTIterator btit (index); !btit.End (); ++btit) {
			const char* key = (const char*)btit.Key ();
			if (key[0] & 0x80)
				break;
			if (skip_lemmas.find (key+1) != skip_lemmas.end ())
				continue;
			Stream *str0 = index->Open (key), *str1 = index->OpenN (key, 1), *str2 = index->OpenN (key, 2);
			char *qqq = strdup (key+1);
			Recoding (cd_win, cd_dos, qqq);
			printf ("%s\r", qqq); fflush (stdout);
			free (qqq);
			if (str0) {
				lemmas.push_back (key+1);

				DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
				DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

				DBCore::Ref_ ref = {0,0,0};
				DBCore::ExtrPair extr;

				long docs = 0;

				while (str_reader->get_next (ref, 0)) {
					long id = ref.doc_id, from, to;
					if (alldocs->IndexOf (&id) == -1 || all_docs->IndexOf (&id) == -1)
						continue;

					bool b_part_document = part_documents.find (id) != part_documents.end ();
					if (b_part_document) {
						from = part_documents_from.find (id)->second;
						to = part_documents_to.find (id)->second; 
					}

					DBCore::ULongVector positions;
					pos_reader->get (positions, ref, extr);
					long count_in_doc = 0;
					for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
						long pos = *pos_it;
						if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK)
							continue;
						if ((pos & ContextSearch::POS_INVISIBLE) == ContextSearch::POS_INVISIBLE)
							continue;
						pos &= ContextSearch::POS_TEXT;
						if (b_part_document && (pos < from || pos >= to))
							continue;
						count_in_doc++;
					}
					docs++;
					std::map<long, lemmacounts_packed>::iterator it = doc_lemmas_counts_packed->find (id);
					if (it == doc_lemmas_counts_packed->end ())
						it = doc_lemmas_counts_packed->insert (std::map<long,lemmacounts_packed>::value_type (id, lemmacounts_packed ())).first;
					u_int64_t put = ((u_int64_t)lemma << 32) + count_in_doc;
					it->second.push_back (put);
				}

				if (docs)
					lemma_in_docs.insert (std::map<long,long>::value_type (lemma, docs));

				index->Close (str2);
				index->Close (str1);
				index->Close (str0);
				
				lemma++;
			}
		}
		printf ("\n");

		for (std::map<long,long>::const_iterator lemma_in_docs_it = lemma_in_docs.begin (); lemma_in_docs_it != lemma_in_docs.end (); lemma_in_docs_it++) {
			if (lemma_in_docs_it->second > 40000) {
				long lemma = lemma_in_docs_it->first;
				std::string lemma_str = lemmas.at (lemma);
				if (remain_lemmas.find (lemma_str) == remain_lemmas.end ()) {
					lemmas_to_skip.insert (lemma);
					printf ("èñêëş÷àåì %s\n", lemma_str.c_str ());
					fflush (stdout);
				}
			}
		}

		for (std::map<long, lemmacounts_packed>::const_iterator doc_lemmas_counts_it = doc_lemmas_counts_packed->begin (); doc_lemmas_counts_it != doc_lemmas_counts_packed->end (); doc_lemmas_counts_it++) {
			long doc_id = doc_lemmas_counts_it->first;
			std::map<long,long>::iterator doc_words_it = doc_words.insert (std::map<long,long>::value_type (doc_id, 0)).first;
			lemmacounts_packed::const_iterator it = doc_lemmas_counts_it->second.begin ();
			if (it != doc_lemmas_counts_it->second.end ()) for (it++; it != doc_lemmas_counts_it->second.end (); it++)
				doc_words_it->second++;
		}

		C = alldocs->ItemCount;
		double log_C_plus_1 = log (C+1.0);
		for (std::map<long,long>::const_iterator doc_words_it = doc_words.begin (); doc_words_it != doc_words.end (); doc_words_it++) {
			long doc_id = doc_words_it->first, plus_w = doc_words_it->second;
			W += plus_w;
		}
		W /= C;
		printf ("W = %ld\n", W);
		W = 380; //Äîáğîâ

		for (std::map<long,long>::const_iterator lemmas_in_docs_it = lemma_in_docs.begin (); lemmas_in_docs_it != lemma_in_docs.end (); lemmas_in_docs_it++ ) {
			long lemma = lemmas_in_docs_it->first;
			if (lemmas_to_skip.find (lemma) == lemmas_to_skip.end ()) {
				long Cw = lemmas_in_docs_it->second;
				//double idf = log((C+0.5)/Cw)/log_C_plus_1;
				double idf = 1 - 0.16 * log ((double)Cw); //Äîáğîâ
				lemma_idf.insert (std::map<long,double>::value_type (lemma, idf));
			}
		}
		printf ("idf calculated\n");

		IndexLoader loader (aBase);

		std::map<u_int64_t, long> refs;
		for (i = 0; i < C; i++) {
			long id = (*alldocs)[i];

			long gdi;
			INDEX_DATA (RespRef) doc_i_refs = loader.load <RespRef> (id, IDD_REFS, gdi, true);
			if (doc_i_refs.ptr ()) {
				RespRef* refs_ptr = doc_i_refs.ptr ();
				for (int ref = 0; ref < gdi; ref++, refs_ptr++ ) {
					u_int64_t aref = (((u_int64_t)refs_ptr->DocId) << 32) + refs_ptr->Sub;
					std::map<u_int64_t,long>::iterator it = refs.find (aref);
					if (it==refs.end ())
						refs.insert (std::map<u_int64_t,long>::value_type (aref, 1));
					else
						it->second++;					
				}
			}
		}

		for (i = 0; i < C; i++) {
			long id = (*alldocs)[i];
			if (doc_words.find (id) == doc_words.end ())
				continue;
			long Wi = doc_words.find (id)->second;
			std::map<long, lemmacounts_packed>::const_iterator doc_i = doc_lemmas_counts_packed->find (id);
			double sum = 0.0;
			for (lemmacounts_packed::const_iterator lemmas_in_i = doc_i->second.begin (); lemmas_in_i != doc_i->second.end (); lemmas_in_i++) {
				u_int64_t at_it = *lemmas_in_i;
				long lemma = (long) (at_it >> 32);
				if (lemmas_to_skip.find (lemma) == lemmas_to_skip.end ()) {
					long Nwi = (long)(at_it & 0xffffffff);
					double tf = Nwi / (Nwi + 0.5 + 1.5 * (Wi / W));
					double idf = lemma_idf.find (lemma)->second;
					double tfidf = 0.4+0.6*tf*idf;
					sum += tfidf*tfidf;
				}
			}
			tfidf.insert (std::map<long,double>::value_type (id,sqrt (sum)));

			//ïğî÷èòàòü ññûëêè
			long refs_in_i = 0, gdi;
			INDEX_DATA (RespRef) doc_i_refs = loader.load <RespRef> (id, IDD_REFS, gdi, true);
			std::deque<long> doc_resps_in;
			std::deque<u_int64_t> refs_resps_in;
			if (doc_i_refs.ptr ()) {
				RespRef* refs_ptr = doc_i_refs.ptr ();
				for (int ref = 0; ref < gdi; ref++, refs_ptr++ ) {
					long ref_doc = refs_ptr->DocId;
					if (ref_doc == 12127526 || ref_doc == 3961642 || ref_doc == 10100950)
						continue;
					long ref_sub = refs_ptr->Sub;
					if ( !ref_sub && (ref_doc == 10164072 || ref_doc == 10900200))
						continue;
					u_int64_t aref = (((u_int64_t)ref_doc) << 32) + ref_sub;
					if (refs.find (aref)->second < 10000) {
						refs_in_i++;
						refs_resps_in.push_back (aref);
						doc_resps_in.push_back (ref_doc);
					}
				}
			}

			if (refs_in_i) {
				std::sort (doc_resps_in.begin (), doc_resps_in.end ());
				std::sort (refs_resps_in.begin (), refs_resps_in.end ());
				gd.insert (std::map<long,long>::value_type (id,gdi));
				map_docs_resps->insert (std::map< long,std::deque<long> >::value_type (id, doc_resps_in));
				map_refs_resps->insert (std::map< long,std::deque<u_int64_t> >::value_type (id, refs_resps_in));
			}
		}
		printf ("tfidf calculated\n");
		
	} else {
		printf ("No new docs, skip reading data from indexes\n");
	}

#ifndef	WIN64
	delete aBase;
#endif
	aBase = 0;

	if (two_bases) {
		int threads_count = 1;
		if (argv [4]) {
			threads_count = atol (argv [4]);
			if (threads_count > MAX_THREADS)
				threads_count = MAX_THREADS;
		}

		bool multy_part_work = false;
		long total_parts = 1, from_part = 0, dones = 0;
		if (argc > 6) {
			multy_part_work = true;
			total_parts = atol (argv [5]);
			from_part = atol (argv [6]);
		} else {
			multy_part_work = true;
			total_parts = threads_count;
		}
		long step = new_docs->ItemCount / total_parts, pos = 0, thread_id = 0, from = from_part * step, to = from + threads_count * step;
		if (from_part + threads_count == total_parts) {
			to = new_docs->ItemCount;
			step += total_parts;
		}

		//ñíà÷àëà ïîñ÷èòàåì äëÿ íîâûõ äîêóìåíòîâ
		//long step = new_docs->ItemCount / threads_count, pos = 0, thread_id;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].from = from;
			thread_data [thread_id].to   = to;
			thread_data [thread_id].done = 0;
		}
		for (thread_id = 0, i = from; i < to; i++, pos++) if (pos == step) {
			thread_data [thread_id].to = i;
			thread_data [++thread_id].from = i;
			pos = 0;
		}

		if (b_calc) {
			printf ("Calculate samedocs for new docs\n");
			long ok_threads = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++) {
				ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
				inst->spawn ((ACE_THR_FUNC)calculate_samedocs_new_78, &thread_id, THR_DETACHED);
				ok_threads++;
				ACE_OS::sleep (1);
			}
			for (;;) {
				long id = get_new_doc (false);
				if (id) {
					printf ("threads checked, %ld%%\n", (new_doc_it * 100) / new_docs->ItemCount);
					ACE_OS::sleep (10);
				} else {
					int dones = 0;
					for (thread_id = 0; thread_id < threads_count; thread_id++)
						if (thread_data [thread_id].done)
							dones++;
					if (dones == ok_threads)
						break;
					else
						ACE_OS::sleep (10);
				}
			}
			printf ("\ndelete threads"); fflush (stdout);
		}

		//òåïåğü äëÿ ñòàğûõ
		step = old_docs->ItemCount / total_parts, pos = 0, from = from_part * step, to = from + threads_count * step;
		if (from_part + threads_count == total_parts) {
			to = old_docs->ItemCount;
			step += total_parts;
		}
		//step = old_docs->ItemCount / threads_count, pos = 0;

		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data_2 [thread_id].from = from;
			thread_data_2 [thread_id].to   = to;
			thread_data_2 [thread_id].done = 0;
		}
		for (thread_id = 0, i = from; i < to; i++, pos++) if (pos == step) {
			thread_data_2 [thread_id].to = i;
			thread_data_2 [++thread_id].from = i;
			pos = 0;
		}

		printf ("\nWriting samedocs. Please wait...\n");
		char part_file_name [32], str_to_write [32];
		if (multy_part_work)
			sprintf (part_file_name, "samedocs_%s_part%ld.next_week", argv [1], from_part);
		else
			sprintf (part_file_name, "samedocs_%s.next_week", argv [1]);
		FILE *part_file = mpcxc_fopen (part_file_name, "w" );

		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			for (std::map<long, std::deque<DocRele> >::const_iterator it = thread_data [thread_id].samedocs_map.begin (); it != thread_data [thread_id].samedocs_map.end (); it++) {
				long doc_id_i = it->first, to_put_size = sizeof (DocRele) * it->second.size ();
				if (alldocs->IndexOf (&doc_id_i) == -1 || all_docs->IndexOf (&doc_id_i) == -1)
					continue;
				sprintf (str_to_write, "%ld: ", doc_id_i);
				fputs (str_to_write, part_file);
				bool b_writed = false;
				std::deque<DocRele>::const_iterator same_docs_iter;
				for (same_docs_iter = it->second.begin (); same_docs_iter != it->second.end (); same_docs_iter++) {
					long doc_id_iter = same_docs_iter->DocId;
					if (alldocs->IndexOf (&doc_id_iter) == -1 || all_docs->IndexOf (&doc_id_iter) == -1)
						continue;
					b_writed = true;
					sprintf (str_to_write, "%ld.%ld ", doc_id_iter, same_docs_iter->Rele);
					fputs (str_to_write, part_file);
				}
				if (!b_writed) {
					sprintf (str_to_write, "%ld.%ld ", it->second.begin ()->DocId, it->second.begin ()->Rele);
					fputs (str_to_write, part_file);
				}
				sprintf (str_to_write, "\n");
				fputs (str_to_write, part_file);
			}
		}

		fclose (part_file);
	} else {
		int threads_count = 1;
		if (argv [3]) {
			threads_count = atol (argv [3]);
			if (threads_count > MAX_THREADS)
				threads_count = MAX_THREADS;
		}

		bool multy_part_work = false;
		long total_parts = 1, from_part = 0;
		if (argc > 5) {
			multy_part_work = true;
			total_parts = atol (argv [4]);
			from_part = atol (argv [5]);
		}

		long step = alldocs->ItemCount / total_parts, pos = 0, thread_id = 0, from = from_part * step, to = from + threads_count * step;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].from = from;
			thread_data [thread_id].to   = to;
			thread_data [thread_id].done = 0;
		}
		for (thread_id = 0, i = from; i < to; i++, pos++)
			if (pos == step) {
				thread_data [thread_id].to = i;
				thread_data [++thread_id].from = i;
				pos = 0;
			}
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
			inst->spawn ((ACE_THR_FUNC)calculate_samedocs, &thread_id, THR_DETACHED);
			ACE_OS::sleep (1);
		}
		int dones; do {
			dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				dones += thread_data [thread_id].done;
			ACE_OS::sleep (5);
		} while (dones < threads_count);
		printf ("\nWriting samedocs. Please wait...\n");
		if (aBase)
			delete aBase;
		FILE *part_file;
		char str_to_write [32];
		if (multy_part_work) {
			char part_file_name [32];
			sprintf (part_file_name, "samedocs_%s_%ld.part", argv [1], from_part);
			part_file = mpcxc_fopen (part_file_name, "w" );
			aBase = 0;
		} else {
			aBase = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		}
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			for (std::map<long, std::deque<DocRele> >::const_iterator it = thread_data [thread_id].samedocs_map.begin (); it != thread_data [thread_id].samedocs_map.end (); it++) {
				long doc_id_i = it->first;
				if (multy_part_work) {
					sprintf (str_to_write, "%ld: ", doc_id_i);
					fputs (str_to_write, part_file);
					for (std::deque<DocRele>::const_iterator same_docs_iter = it->second.begin (); same_docs_iter != it->second.end (); same_docs_iter++) {
						sprintf (str_to_write, "%ld.%ld ", same_docs_iter->DocId, same_docs_iter->Rele);
						fputs (str_to_write, part_file);
					}
					sprintf (str_to_write, "\n");
					fputs (str_to_write, part_file);
				} else {
					long to_put_size = sizeof (DocRele) * it->second.size ();
					DocRele *to_put = (DocRele*) malloc (to_put_size), *to_put_ptr = to_put;
					printf ("same docs for %ld: ", doc_id_i);
					for (std::deque<DocRele>::const_iterator same_docs_iter = it->second.begin (); same_docs_iter != it->second.end (); same_docs_iter++, to_put_ptr++) {
						to_put_ptr->DocId = same_docs_iter->DocId;
						to_put_ptr->Rele  = same_docs_iter->Rele;
						printf ("%ld ",same_docs_iter->DocId);
					}
					printf ("\n"); fflush (stdout);
					aBase->ReplaceAttr (doc_id_i, IDD_SAMEDOCS, to_put, to_put_size);
					free (to_put);
				}
			}
		}
		if (multy_part_work)
			fclose (part_file);
	}

#ifndef	WIN64
	if (old_base)
		delete old_base;
	if (aBase)
		delete aBase;
#endif

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
