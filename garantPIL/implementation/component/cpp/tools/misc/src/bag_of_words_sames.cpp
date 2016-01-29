#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

#include <boost/thread.hpp>

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

#define	MAX_THREADS	6
struct thread_data_struct {
	volatile int done;
	std::deque<std::string> result;
};
thread_data_struct thread_data [MAX_THREADS];

std::map<long,std::set<long> >::const_iterator compare_doc_it;
ACE_Recursive_Thread_Mutex compare_it_mutex;

std::map<long,std::set<long> > map_doc_blocks, map1_doc_blocks, map2_doc_blocks; //какие документы и блоки будет обсчитывать
std::map<u_int64_t, std::deque<std::pair<std::string,long> > > map_docblock_lemmacount;
std::map<u_int64_t, long> map_docblock_size;

long	user_same_value, block_size;
bool	b_debug = false;

long	get_doc_to_compare ()
{
	RWRITE_GUARD (compare_it_mutex) {
		if (compare_doc_it == map1_doc_blocks.end ())
			return 0;
		long result = compare_doc_it->first;
		compare_doc_it++;
		return result;
	}
}

void	calculate_sames (long& thread_id)
{
	char small_str [128];
	thread_data_struct* thread_data_ptr = & (thread_data [thread_id]);
	for (;;) {
		long doc1 = get_doc_to_compare ();
		if (0 == doc1)
			break;

		std::map<long,std::set<long> >::const_iterator it1 = map1_doc_blocks.find (doc1);
		for (std::set<long>::const_iterator block_it1 = it1->second.begin (); block_it1 != it1->second.end (); block_it1++) {
			long block1 = *block_it1;
			u_int64_t ref1 = (((u_int64_t)doc1) << 32) + block1;

			std::map<u_int64_t,long>::const_iterator wordsin1it = map_docblock_size.find (ref1);
			if (wordsin1it == map_docblock_size.end () || wordsin1it->second < block_size)
				continue;

			std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::const_iterator first_it = map_docblock_lemmacount.find (ref1);
			if (first_it == map_docblock_lemmacount.end ())
				continue;

			for (std::map<long,std::set<long> >::const_iterator it2 = map2_doc_blocks.begin (); it2 != map2_doc_blocks.end (); it2++) {
				long doc2 = it2->first;
				for (std::set<long>::const_iterator block_it2 = it2->second.begin (); block_it2 != it2->second.end (); block_it2++) {
					long block2 = *block_it2;
					
					if (doc1 == doc2 && block1 == block2)
						continue;
					u_int64_t ref2 = (((u_int64_t)doc2) << 32) + block2;

					std::map<u_int64_t,long>::const_iterator wordsin2it = map_docblock_size.find (ref2);
					if (wordsin2it == map_docblock_size.end () || wordsin2it->second < block_size)
						continue;

					std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::const_iterator second_it = map_docblock_lemmacount.find (ref2);
					if (second_it == map_docblock_lemmacount.end ())
						continue;

					u_int64_t first_second = 0, squares_first = 0, squares_second = 0;

					std::deque<std::pair<std::string,long> >::const_iterator first_lemma_it = first_it->second.begin ();
					std::deque<std::pair<std::string,long> >::const_iterator second_lemma_it = second_it->second.begin ();
					std::vector<std::string> strings_to_add;
					while (first_lemma_it != first_it->second.end () && second_lemma_it != second_it->second.end ()) {
						if (first_lemma_it->first == second_lemma_it->first) {
							if (b_debug) {
								std::string string_to_add ("same ");
								string_to_add += first_lemma_it->first.c_str () + 1;
								sprintf (small_str, ", in 1: %ld, in 2: %ld", first_lemma_it->second, second_lemma_it->second);
								string_to_add += small_str;
								strings_to_add.push_back (string_to_add);								
							}
							first_second += (u_int64_t)first_lemma_it->second * (u_int64_t)second_lemma_it->second;
							squares_first += (u_int64_t)first_lemma_it->second * (u_int64_t)first_lemma_it->second;
							squares_second += (u_int64_t)second_lemma_it->second * (u_int64_t)second_lemma_it->second;
							first_lemma_it++, second_lemma_it++;
						} else if (first_lemma_it->first < second_lemma_it->first) {
							if (b_debug) {
								std::string string_to_add ("in 1 ");
								string_to_add += first_lemma_it->first.c_str () + 1;
								sprintf (small_str, ", %ld", first_lemma_it->second);
								string_to_add += small_str;
								strings_to_add.push_back (string_to_add);								
							}
							squares_first += (u_int64_t)first_lemma_it->second * (u_int64_t)first_lemma_it->second;
							first_lemma_it++;
						} else {
							if (b_debug) {
								std::string string_to_add ("in 2 ");
								string_to_add += second_lemma_it->first.c_str () + 1;
								sprintf (small_str, ", %ld", second_lemma_it->second);
								string_to_add += small_str;
								strings_to_add.push_back (string_to_add);								
							}
							squares_second += (u_int64_t)second_lemma_it->second * (u_int64_t)second_lemma_it->second;
							second_lemma_it++;
						}
					}
					while (first_lemma_it != first_it->second.end ()) {
						if (b_debug) {
							std::string string_to_add ("in 1 ");
							string_to_add += first_lemma_it->first.c_str () + 1;
							sprintf (small_str, ", %ld", first_lemma_it->second);
							string_to_add += small_str;
							strings_to_add.push_back (string_to_add);								
						}
						squares_first += (u_int64_t)first_lemma_it->second * (u_int64_t)first_lemma_it->second;
						first_lemma_it++;
					}
					while (second_lemma_it != second_it->second.end ()) {
						squares_second += (u_int64_t)second_lemma_it->second * (u_int64_t)second_lemma_it->second;
						if (b_debug) {
							std::string string_to_add ("in 2 ");
							string_to_add += second_lemma_it->first.c_str () + 1;
							sprintf (small_str, ", %ld", second_lemma_it->second);
							string_to_add += small_str;
							strings_to_add.push_back (string_to_add);								
						}
						second_lemma_it++;
					}
					long double squares = (long double)squares_first * (long double)squares_second;
					long double sqrt_squares = sqrt (squares);
					long same_value = (long)(((long double)first_second / sqrt_squares) * 1000);
					if (same_value >= user_same_value) {
						/*
						if (b_debug) {
							char qqq [128];
							sprintf (qqq, "first_second: %lld, squares_first = %lld, squares_second = %lld \n", first_second, squares_first, squares_second);
							strings_to_add.push_back (qqq);
						}
						*/
						char str [128];
						sprintf (str, "%ld.%ld;%ld.%ld;%ld", doc1,block1, doc2,block2, same_value);
						thread_data_ptr->result.push_back (str);
						if (b_debug) {
							for (std::vector<std::string>::const_iterator add_it = strings_to_add.begin (); add_it != strings_to_add.end (); add_it++)
								thread_data_ptr->result.push_back (add_it->c_str ());
							thread_data_ptr->result.push_back ("\n");
						}
					}
				}
			}
		}
	}
	thread_data_ptr->done = 1;
}

int main_logic ( int argc, char *argv[] )
{
	SetUnhandledExceptionFilter (UEF);

	if (argc >= 8 && !stricmp (argv [7], "debug"))
		b_debug = true;

	Base *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();

	std::map<std::string,long> map_lemma_count;
	std::map<long,std::vector<std::string> > map_count_lemmas;

	FILE *in1_file = fopen (argv [2], "rt");
	if (in1_file) {
		while (!feof (in1_file)) {
			char str [256];
			fgets (str, sizeof (str), in1_file);
			Ref ref = {atol (str),0};
			char *dot = strchr (str, '.');
			if (dot) ref.Sub = atol (++dot);

			if (map1_doc_blocks.find (ref.DocId) == map1_doc_blocks.end ()) {
				std::set<long> blocks;
				blocks.insert (ref.Sub);
				map1_doc_blocks.insert (std::map<long,std::set<long> >::value_type (ref.DocId, blocks));
			} else {
				map1_doc_blocks.find (ref.DocId)->second.insert (ref.Sub);
			}

			u_int64_t ref64 = (((u_int64_t) ref.DocId) << 32) + ref.Sub;
		}
		fclose (in1_file);
	}
	map_doc_blocks = map1_doc_blocks;

	FILE *in2_file = fopen (argv [3], "rt");
	if (in1_file) {
		while (!feof (in2_file)) {
			char str [256];
			fgets (str, sizeof (str), in2_file);
			Ref ref = {atol (str),0};
			char *dot = strchr (str, '.');
			if (dot) ref.Sub = atol (++dot);

			if (map2_doc_blocks.find (ref.DocId) == map2_doc_blocks.end ()) {
				std::set<long> blocks;
				blocks.insert (ref.Sub);
				map2_doc_blocks.insert (std::map<long,std::set<long> >::value_type (ref.DocId, blocks));
			} else {
				map2_doc_blocks.find (ref.DocId)->second.insert (ref.Sub);
			}

			u_int64_t ref64 = (((u_int64_t) ref.DocId) << 32) + ref.Sub;
		}
		fclose (in2_file);
	}
	for (std::map<long,std::set<long> >::const_iterator map2_it = map2_doc_blocks.begin (); map2_it != map2_doc_blocks.end (); map2_it++) {
		std::map<long,std::set<long> >::iterator map_it = map_doc_blocks.find (map2_it->first);
		if (map_it == map_doc_blocks.end ())
			map_doc_blocks.insert (std::map<long,std::set<long> >::value_type (map2_it->first, map2_it->second));
		else
			map_it->second.insert (map2_it->second.begin (), map2_it->second.end ());
	}

	std::set<std::string> stop_lemms;
	if (argv [6]) {
		FILE *stop_file = fopen (argv [6], "rt");
		if (stop_file) {
			while (!feof (stop_file)) {
				char str [256];
				fgets (str, sizeof (str), stop_file);
				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;
				stop_lemms.insert (str);
			}
			fclose (stop_file);
		}
	}

	user_same_value = atol (argv [4]), block_size = atol (argv [5]);

	std::map<long, std::deque<long> > map_doc_skippositions;
	std::map<long, std::map<long, std::pair<long,long> > > map_doc_map_block_firstlastword;
	for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_blocks.begin (); map_it != map_doc_blocks.end (); map_it++) {
		long doc = map_it->first;

		for (std::set<long>::const_iterator block_it = map_it->second.begin (); block_it != map_it->second.end (); block_it++) {
			u_int64_t ref64 = (((u_int64_t)doc) << 32) + *block_it;
			map_docblock_size.insert (std::map<u_int64_t,long>::value_type (ref64, 0));
		}

		std::map<long, std::pair<long,long> > map_block_firstlastpara;

		long structs_count, i = 0, best_sub = 0;
		DocStruct *structs = (DocStruct*) base->LoadAttr (doc, IDD_DOCSTRUCT, structs_count), *ptr = structs;
		for (i = 0; i < structs_count / sizeof (DocStruct); i++, ptr++) {
			short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
			long block = ptr->m_para_list_id;
			if ((evd_type == SUBDESCEX_BLOCK || evd_type == SUBDESCEX_DOCUMENT )&& map_it->second.find (block) != map_it->second.end ()) {
				std::pair<long,long> paras ((long)ptr->m_start_para, (long)ptr->m_end_para + 1);
				map_block_firstlastpara.insert (std::map<long, std::pair<long,long> >::value_type (block, paras));
			}
		}
		gk_free (structs);

		std::map<long, std::pair<long,long> > map_block_firstlastword;
		Stream *str = base->FindIndex ("SWords")->Open (&doc);
		if (str) {
			long len = str->Length ();
			char *data = new char [len];
			str->Read (data, len);
			base->FindIndex ("SWords")->Close (str);

			for (std::map<long, std::pair<long,long> >::const_iterator it = map_block_firstlastpara.begin (); it != map_block_firstlastpara.end (); it++) {
				long block = it->first, from_para = it->second.first, to_para = it->second.second;

				char *from_word_ptr = data + 3 * from_para, *to_word_ptr = data + 3 * to_para;
				
				long from_word = 0; memcpy (&from_word, from_word_ptr, 3);
				if (0 != from_para)
					from_word++;
				
					long to_word = 0;
				if (to_para == len / 3) {
					to_word = ContextSearch::POS_TEXT;
				} else {
					memcpy (&to_word, to_word_ptr, 3);
				}

				map_block_firstlastword.insert (std::map<long, std::pair<long,long> >::value_type (block, std::pair<long,long> (from_word, to_word)));
			}

			std::deque<long> zero;
			map_doc_skippositions.insert (std::map<long, std::deque<long> >::value_type (doc, zero));

			Document *document = base->GetDoc (doc);
			std::map<long, std::deque<long> >::iterator skip_it = map_doc_skippositions.find (doc);
			for (int apara = 0; apara < document->Stat.ParaCount; apara++) {
				bool b_iscomment = document->EVDFlags (document->GetPara (apara)) & (ENDT_COMMENTS | ENDT_VERSION_COMMENTS);
				if (b_iscomment) {
					char *from_word_ptr = data + 3 * apara, *to_word_ptr = data + 3 * (apara+1);
					
					long from_word = 0; memcpy (&from_word, from_word_ptr, 3);
					if (0 != apara)
						from_word++;
					
					long to_word = 0;
					if (apara >= len / 3) {
						to_word = ContextSearch::POS_TEXT;
					} else {
						memcpy (&to_word, to_word_ptr, 3);
					}
					for (long word = from_word; word <= to_word; word++)
						skip_it->second.push_back (word);
				}
			}
			delete document;

			delete []data;
		}

		map_doc_map_block_firstlastword.insert (std::map<long, std::map<long, std::pair<long,long> > >::value_type (doc, map_block_firstlastword));
	}

	Index* index = base->FindIndex ("NWCntxt");
	for (BTIterator btit (index); !btit.End (); ++btit) {
		const char* key = (const char*)btit.Key ();
		if (stop_lemms.find (key + 1) != stop_lemms.end ())
			continue;

		Stream *str0 = index->Open (key), *str1 = index->OpenN (key, 1), *str2 = index->OpenN (key, 2);
		if (str0) {
			DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
			DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

			DBCore::Ref_ ref = {0,0,0};
			DBCore::ExtrPair extr;

			long count = 0;
			while (str_reader->get_next (ref, 0)) {
				long id = ref.doc_id, count_in_doc = 0;
				if (map_doc_blocks.find (id) == map_doc_blocks.end ())
					continue;

				std::set<long> blocks;
				std::map<long, std::pair<long,long> > map_block_words;
				std::map<long,long> map_block_count;
				std::map<long, std::deque<long> >::iterator skip_it = map_doc_skippositions.find (id);

				if (map_doc_blocks.find (id) != map_doc_blocks.end ()) {
					blocks = map_doc_blocks.find (id)->second; //блоки в документе, которые интересуют
					map_block_words = map_doc_map_block_firstlastword.find (id)->second; //блоки и позиции слов для них
					for (std::set<long>::const_iterator block_it = blocks.begin (); block_it != blocks.end (); block_it++)
						map_block_count.insert (std::map<long,long>::value_type (*block_it, 0));
				}

				DBCore::ULongVector positions;
				pos_reader->get (positions, ref, extr);
				for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
					long pos = *pos_it;
					if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK)
						continue;
					if ((pos & ContextSearch::POS_INVISIBLE) == ContextSearch::POS_INVISIBLE)
						continue;
					pos &= ContextSearch::POS_TEXT;

					if (skip_it != map_doc_skippositions.end () && std::binary_search (skip_it->second.begin (), skip_it->second.end (), pos))
						continue;

					count_in_doc++;
					count++;

					//если позиция попала в блок, то для этого блока надо увеличить count
					for (std::set<long>::const_iterator block_it = blocks.begin (); block_it != blocks.end (); block_it++) {
						long block = *block_it;
						std::pair<long,long> fromto = map_block_words.find (block)->second;
						if (pos >= fromto.first && pos <= fromto.second)
							map_block_count.find (block)->second++;
					}
				}
				if (count_in_doc && map_doc_blocks.find (id) != map_doc_blocks.end ()) {
					for (std::set<long>::const_iterator block_it = blocks.begin (); block_it != blocks.end (); block_it++) {
						long block = *block_it, count_in_block = map_block_count.find (block)->second;
						if (0 == count_in_block)
							continue;

						u_int64_t ref64 = (((u_int64_t)id) << 32) + block;
						map_docblock_size.find (ref64)->second += count_in_block;

						std::pair<std::string,long> lemmacount (key, count_in_block);
						std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::iterator res_it = map_docblock_lemmacount.find (ref64);
						if (res_it == map_docblock_lemmacount.end ()) {
							std::deque<std::pair<std::string,long> > first;
							first.push_back (lemmacount);
							map_docblock_lemmacount.insert (std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::value_type (ref64, first));
						} else {
							res_it->second.push_back (lemmacount);
						}
					}
				}
			}
			if (count) {
				map_lemma_count.insert (std::map<std::string,long>::value_type (key, count));
				std::map<long,std::vector<std::string> >::iterator map_it = map_count_lemmas.find (count);
				if (map_it == map_count_lemmas.end ()) {
					std::vector<std::string> lemmas;
					lemmas.push_back (key);
					map_count_lemmas.insert (std::map<long,std::vector<std::string> >::value_type (count, lemmas));
				} else {
					map_it->second.push_back (key);
				}
			}

			index->Close (str2);
			index->Close (str1);
			index->Close (str0);
		}
	}

	compare_doc_it = map1_doc_blocks.begin ();
	long thread_id;
	for (thread_id = 0; thread_id < MAX_THREADS; thread_id++) {
		thread_data [thread_id].done = 0;
		boost::thread thread (calculate_sames, thread_id);
		thread.detach ();
		ACE_OS::sleep (1);
	}
	for (;;) {
		ACE_OS::sleep (5);
		int dones = 0;
		for (long thread_id = 0; thread_id < MAX_THREADS; thread_id++)
			if (thread_data [thread_id].done)
				dones++;
		if (dones == MAX_THREADS)
			break;
	}
	for (thread_id = 0; thread_id < MAX_THREADS; thread_id++)
		for (std::deque<std::string>::const_iterator it = thread_data [thread_id].result.begin (); it != thread_data [thread_id].result.end (); it++)
			printf ("%s\n", it->c_str ());

#ifndef	_WIN64
	delete base;
#endif
	return 0;
}
