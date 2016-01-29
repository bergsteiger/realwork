#include "shared/Core/fix/mpcxc.h"

#include "shared/DB/DBCore/DBCore.h"

#include "gardefs.h"
#include "stdbase.h"
#include "SearchB.h"
#include "BaseCache.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "garantPIL/implementation/component/cpp/libs/endt/Defines.h"
#include "shared/Core/sys/AutoInit.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	Core::AutoInit init;
	ToolsBase *base = new ToolsBase (argv [1]);

	long cos_value = 800;

	if (argc == 4 && atol (argv [3]))
		cos_value = atol (argv [3]);
	else
	if (argc == 5 && atol (argv [4]))
		cos_value = atol (argv [4]);

	std::set<long> docs;
	if (argc > 3 && !atol (argv [3])) {
		FILE *docsfile = fopen (argv [3], "rt");
		if (docsfile) {
			while (!feof (docsfile)) {
				char str [128];
				if (!fgets (str, sizeof (str), docsfile))
					break;

				if (!str [0])
					continue;

				if (str [strlen (str) - 1] == 10)
					str [strlen (str) - 1] = 0;

				docs.insert (atol (str));
			}
			fclose (docsfile);
		}
	}

	std::map<long, std::deque<std::pair<long,long> > > map_doc_paras;
	Index* swords = base->FindIndex ("SWords.str");
	{
		for (BTIterator it (swords); !it.End (); ++it) {
			long docid = *(long*) it.Key ();
			if (docs.size () && docs.find (docid) == docs.end ())
				continue;
			std::deque<std::pair<long,long> > values;
			Stream* str = swords->Open (&docid);
			if (str) {
				long len = str->Length (), value = 0, prev = 0;
				char *data = new char [len], *ptr = data;
				str->Read (data, len);
				swords->Close (str);

				memcpy (&prev, ptr, 3); ptr += 3; prev++;
				for (long pos = 3; pos < len; pos += 3, ptr += 3) {
					memcpy (&value, ptr, 3);
					std::pair<long,long> from_to (prev, ++value);
					values.push_back (from_to);
					prev = value;
				}
			}
			map_doc_paras.insert (std::map<long, std::deque<std::pair<long,long> > >::value_type (docid, values));
		}
	}

	Index* index = base->FindIndex ("NWCntxt.str");
	std::map<long,std::map<long, std::deque<long> > > map_doc_map_para_lemmas;

	long lemma = 0;
	std::map<std::string,long> map_lemma_uid;
	char lemma_key [64];
	for (BTIterator btit (index); !btit.End (); ++btit, lemma++) {
		char* key = (char*) btit.Key ();
		int len = (long)(key [0]) & 0x7F;
		strncpy (lemma_key, key, len);
		lemma_key [len] = 0;
		map_lemma_uid.insert (std::map<std::string,long>::value_type (lemma_key, lemma));

		Stream *str0 = index->Open (key), *str1 = index->OpenN (key, 1), *str2 = index->OpenN (key, 2);
		DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
		DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, false, 0);
		DBCore::Ref_ ref = {0,0,0};
		DBCore::ExtrPair extr;
		while (str_reader->get_next (ref)) {
			long id = ref.doc_id;

			DBCore::ULongVector positions;
			pos_reader->get (positions, ref, extr);

			if (docs.size () && docs.find (id) == docs.end ())
				continue;

			long count_in_doc = 0;
			for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
				long pos = *pos_it;
				if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK)
					continue;
				if ((pos & ContextSearch::POS_INVISIBLE) == ContextSearch::POS_INVISIBLE)
					continue;
				pos &= ContextSearch::POS_TEXT;

				std::map<long, std::deque<std::pair<long,long> > >::const_iterator paras_it = map_doc_paras.find (id);
				if (paras_it == map_doc_paras.end ()) {
					printf ("cant find paras for doc %ld\n", id);
					exit (-1);
				}
				long para = 0;
				for (std::deque<std::pair<long,long> >::const_iterator para_it = paras_it->second.begin (); para_it != paras_it->second.end (); para_it++, para++)
					if (pos >= para_it->first && pos < para_it->second)
						break;

				std::map<long,std::map<long, std::deque<long> > >::iterator map_it = map_doc_map_para_lemmas.find (id);
				if (map_it == map_doc_map_para_lemmas.end ()) {
					std::deque<long> lemmas;
					lemmas.push_back (lemma);
					std::map<long,std::deque<long> > map_para_lemmas;
					map_para_lemmas.insert (std::map<long,std::deque<long> >::value_type (para, lemmas));
					map_doc_map_para_lemmas.insert (std::map<long,std::map<long, std::deque<long> > >::value_type (id, map_para_lemmas));
				} else {
					std::map<long,std::deque<long> >::iterator para_it = map_it->second.find (para);
					if (para_it == map_it->second.end ()) {
						std::deque<long> lemmas;
						lemmas.push_back (lemma);
						map_it->second.insert (std::map<long,std::deque<long> >::value_type (para, lemmas));
					} else {
						para_it->second.push_back (lemma);
					}
				}
			}
		}

		index->Close (str2);
		index->Close (str1);
		index->Close (str0);
	}

	Morpho::Def::INormalizer_var normalizer = BaseCache::instance ()->make (base->abstract_base ());

	FILE *infile = fopen (argv [2], "rt");
	if (infile) {
		while (!feof (infile)) {
			char str [65535];
			if (!fgets (str, sizeof (str), infile))
				break;

			if (!str [0])
				continue;

			if (str [strlen (str) - 1] == 10)
				str [strlen (str) - 1] = 0;

			GCL::StrVector words;
			boost::split (words, str, boost::is_any_of (" -.,;!?/"));
			std::vector<std::string> word_lemmas;
			for (GCL::StrVector::const_iterator words_it = words.begin (); words_it != words.end (); words_it++) {
				if (!words_it->size ())
					continue;

				std::string word (*words_it);
				Core::Aptr <GCL::StrSet> res = normalizer->execute (word, true);
				for (GCL::StrSet::const_iterator lemmas_it = res->begin (); lemmas_it != res->end (); lemmas_it++)
					word_lemmas.push_back (*lemmas_it);
			}
 
			std::map<long,long> b_x;
			std::set<long> lemmas;
			
			for (std::vector<std::string>::const_iterator lemmas_it = word_lemmas.begin (); lemmas_it != word_lemmas.end (); lemmas_it++) {
				std::string str_lemma = *lemmas_it;
				std::map<std::string,long>::const_iterator map_lemma_it = map_lemma_uid.find (*lemmas_it);
				long uid = map_lemma_it == map_lemma_uid.end () ? ++lemma : map_lemma_it->second;
				lemmas.insert (uid);

				std::map<long,long>::iterator b_x_iter = b_x.find (uid);
				if (b_x_iter == b_x.end ())
					b_x.insert (std::map<long,long>::value_type (uid, 1));
				else
					b_x_iter->second++;
			}
			long down_b = 0;
			for (std::map<long,long>::const_iterator b_x_iter = b_x.begin (); b_x_iter != b_x.end (); b_x_iter++)
				down_b += b_x_iter->second * b_x_iter->second;

			//а теперь эти b надо сравнить со всеми параграфами, которые есть в базе
			for (std::map<long,std::map<long, std::deque<long> > >::const_iterator doc_it = map_doc_map_para_lemmas.begin (); doc_it != map_doc_map_para_lemmas.end (); doc_it++) {
				long doc = doc_it->first;
				Document *document = base->GetDoc (doc);
				for (std::map<long, std::deque<long> >::const_iterator para_it = doc_it->second.begin (); para_it != doc_it->second.end (); para_it++) {
					long para = para_it->first;

					std::map<long,long> a_x;
					for (std::deque<long>::const_iterator lemma_a_it = para_it->second.begin (); lemma_a_it != para_it->second.end (); lemma_a_it++) {
						long uid = *lemma_a_it;
						std::map<long,long>::iterator a_x_iter = a_x.find (uid);
						if (a_x_iter == a_x.end ())
							a_x.insert (std::map<long,long>::value_type (uid, 1));
						else
							a_x_iter->second++;
					}
					
					long down_a = 0;
					for (std::map<long,long>::const_iterator a_x_iter = a_x.begin (); a_x_iter != a_x.end (); a_x_iter++)
						down_a += a_x_iter->second * a_x_iter->second;

					long up = 0;
					for (std::set<long>::const_iterator lemmas_it = lemmas.begin (); lemmas_it != lemmas.end (); lemmas_it++) {
						std::map<long,long>::const_iterator a_x_iter = a_x.find (*lemmas_it);
						if (a_x_iter != a_x.end ()) {
							std::map<long,long>::const_iterator b_x_iter = b_x.find (*lemmas_it);
							up += a_x_iter->second * b_x_iter->second;
						}
					}

					double _cos = ((double)up / (sqrt ((double)down_a) * sqrt ((double)down_b))) * 1000;
					if (_cos > cos_value)
						printf ("cos: %ld, doc: %ld, para: %ld,\ntext: %s\n str: %s\n\n", (long) _cos, doc, para, document->EVDParaText (document->GetPara (para), false), str);
				}
				delete document;
			}
		}
		fclose (infile);
	}

	delete base;
	
	return 0;
}

