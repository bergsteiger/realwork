#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "stdbase.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

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

int main_logic ( int argc, char *argv[] )
{
	SetUnhandledExceptionFilter (UEF);

	Base *base = new YBase (argv [1], ACE_OS_O_RDONLY);
	base->IsOk ();

	std::map<std::string,long> map_lemma_count;
	std::map<long,std::vector<std::string> > map_count_lemmas;

	std::map<u_int64_t, std::deque<std::pair<std::string,long> > > map_docblock_lemmacount;

	std::map<long,std::set<long> > to_compare, map_doc_blocks; //какие документы и блоки будет обсчитывать

	std::set<long> docs;
	FILE *docs_file = fopen (argv [2], "rt");
	if (docs_file) {
		while (!feof (docs_file)) {
			char str [256];
			fgets (str, sizeof (str), docs_file);
			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			Ref ref = {atol (str),0};
			docs.insert (ref.DocId);
			char *dot = strchr (str, '.');
			if (dot) ref.Sub = atol (++dot);

			if (map_doc_blocks.find (ref.DocId) == map_doc_blocks.end ()) {
				std::set<long> blocks;
				blocks.insert (ref.Sub);
				map_doc_blocks.insert (std::map<long,std::set<long> >::value_type (ref.DocId, blocks));
			} else {
				map_doc_blocks.find (ref.DocId)->second.insert (ref.Sub);
			}

			u_int64_t ref64 = (((u_int64_t) ref.DocId) << 32) + ref.Sub;
		}
		fclose (docs_file);
	}

	long user_same_value = argv [3] ? atol (argv [3]) : 1000;

	to_compare = map_doc_blocks;

	std::map<long, std::vector<long> > map_doc_edis;

	std::map<long, std::set<long> > map_doc_skippositions;

	//теперь добавим блоки из всей цепочки редакций
	for (std::set<long>::const_iterator doc_it = docs.begin (); doc_it != docs.end (); doc_it++) {
		long doc = *doc_it;
		std::set<long> docblocks = map_doc_blocks.find (doc)->second;

		DocInfo docinfo;
		base->FindDocInfo (doc, docinfo);
		long prev = docinfo.prevEdition;
		
		std::vector<long> edis;
		edis.push_back (prev);
		map_doc_edis.insert (std::map<long, std::vector<long> >::value_type (doc, edis));

		while (prev) {
			IndexLoader loader (base);
			long structs_count, i = 0;
			INDEX_DATA (DocStruct) structs = loader.load <DocStruct> (prev, IDD_DOCSTRUCT, structs_count);
			DocStruct *ptr;
			for (ptr = structs.ptr (), i = 0; i < structs_count; i++, ptr++) {
				short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
				long block = ptr->m_para_list_id;
				if (evd_type == SUBDESCEX_BLOCK && docblocks.find (block) != docblocks.end ()) {
					if (map_doc_blocks.find (prev) == map_doc_blocks.end ()) {
						std::set<long> blocks;
						blocks.insert (block);
						map_doc_blocks.insert (std::map<long,std::set<long> >::value_type (prev, blocks));
					} else {
						map_doc_blocks.find (prev)->second.insert (block);
					}
				}
			}

			base->FindDocInfo (prev, docinfo);
			prev = docinfo.prevEdition;
			if (prev) map_doc_edis.find (doc)->second.push_back (prev);
		}

	}

	//еще надо позиции слов в комментариях добавить в исключения (пропускать их)
	for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_blocks.begin (); map_it != map_doc_blocks.end (); map_it++) {
		long doc = map_it->first;

		std::set<long> zero; zero.insert (0);
		map_doc_skippositions.insert (std::map<long, std::set<long> >::value_type (doc, zero));

		long len = 0;
		char *data = 0;
		Stream *str = base->FindIndex ("SWords")->Open (&doc);
		if (str) {
			len = str->Length ();
			data = new char [len];
			str->Read (data, len);
			base->FindIndex ("SWords")->Close (str);
		}
		Document *document = base->GetDoc (doc);
		std::map<long, std::set<long> >::iterator skip_it = map_doc_skippositions.find (doc);
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
					skip_it->second.insert (word);
			}
		}
		if (data) delete [] data;
		delete document;
	}

	std::map<long, std::map<long, std::pair<long,long> > > map_doc_map_block_firstlastword;
	for (std::map<long,std::set<long> >::const_iterator map_it = map_doc_blocks.begin (); map_it != map_doc_blocks.end (); map_it++) {
		long doc = map_it->first;

		std::map<long, std::pair<long,long> > map_block_firstlastpara;

		IndexLoader loader (base);
		long structs_count, i = 0, best_sub = 0;
		INDEX_DATA (DocStruct) structs = loader.load <DocStruct> (doc, IDD_DOCSTRUCT, structs_count);
		DocStruct *ptr;
		for (ptr = structs.ptr (), i = 0; i < structs_count; i++, ptr++) {
			short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
			long block = ptr->m_para_list_id;
			if ((evd_type == SUBDESCEX_BLOCK || evd_type == SUBDESCEX_DOCUMENT )&& map_it->second.find (block) != map_it->second.end ()) {
				std::pair<long,long> paras ((long)ptr->m_start_para, (long)ptr->m_end_para + 1);
				map_block_firstlastpara.insert (std::map<long, std::pair<long,long> >::value_type (block, paras));
			}
		}

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

			delete []data;
		}

		map_doc_map_block_firstlastword.insert (std::map<long, std::map<long, std::pair<long,long> > >::value_type (doc, map_block_firstlastword));
	}

	Index* index = base->FindIndex ("NWCntxt");
	for (BTIterator btit (index); !btit.End (); ++btit) {
		const char* key = (const char*)btit.Key ();
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

				std::map<long, std::set<long> >::iterator skip_it = map_doc_skippositions.find (id);

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

					if (skip_it != map_doc_skippositions.end () && skip_it->second.find (pos) != skip_it->second.end ())
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

	//std::map<u_int64_t, std::deque<std::pair<std::string,long> > > map_docblock_lemmacount
	for (std::map<long,std::set<long> >::const_iterator compare_it = to_compare.begin (); compare_it != to_compare.end (); compare_it++) {
		for (std::set<long>::const_iterator subs_it = compare_it->second.begin (); subs_it != compare_it->second.end (); subs_it++) {
			long doc_to_compare = compare_it->first, sub_to_compare = *subs_it;

			u_int64_t doc_ref = (((u_int64_t)doc_to_compare) << 32) + sub_to_compare;

			if (map_docblock_lemmacount.find (doc_ref) == map_docblock_lemmacount.end ())
				continue;

			printf ("%ld.%ld", doc_to_compare, sub_to_compare);
			std::map<long,std::vector<long> >::const_iterator edis_it = map_doc_edis.find (doc_to_compare);
			if (edis_it == map_doc_edis.end ()) {
				printf (":%ld.%ld\n", doc_to_compare, sub_to_compare);
				;//printf ("новый\n");
			} else {
				long edition = 0;
				for (std::vector<long>::const_iterator edi_it = edis_it->second.begin (); edi_it != edis_it->second.end (); edi_it++) {
					//будем сравнивать блоки документа и редакции
					edition = *edi_it;
					u_int64_t edition_ref = (((u_int64_t)edition) << 32) + sub_to_compare;
					std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::const_iterator edition_it = map_docblock_lemmacount.find (edition_ref);
					if (edition_it == map_docblock_lemmacount.end ()) {
						printf (":%ld.%ld", doc_to_compare, sub_to_compare);
						edition = 0;
						break;
					} else {
						//сравнить похожесть редакций
						std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::const_iterator first_it = map_docblock_lemmacount.find (doc_ref);
						std::map<u_int64_t, std::deque<std::pair<std::string,long> > >::const_iterator second_it = map_docblock_lemmacount.find (edition_ref);

						u_int64_t first_second = 0, squares_first = 0, squares_second = 0;
						
						std::deque<std::pair<std::string,long> >::const_iterator first_lemma_it = first_it->second.begin ();
						std::deque<std::pair<std::string,long> >::const_iterator second_lemma_it = second_it->second.begin ();
						while (first_lemma_it != first_it->second.end () && second_lemma_it != second_it->second.end ()) {
							const char *fl = first_lemma_it->first.c_str (), *sl = second_lemma_it->first.c_str ();
							if (first_lemma_it->first == second_lemma_it->first) {
								first_second += (u_int64_t)first_lemma_it->second * (u_int64_t)second_lemma_it->second;
								squares_first += (u_int64_t)first_lemma_it->second * (u_int64_t)first_lemma_it->second;
								squares_second += (u_int64_t)second_lemma_it->second * (u_int64_t)second_lemma_it->second;
								first_lemma_it++, second_lemma_it++;
							} else if (first_lemma_it->first < second_lemma_it->first) {
								squares_first += (u_int64_t)first_lemma_it->second * (u_int64_t)first_lemma_it->second;
								first_lemma_it++;
							} else {
								squares_second += (u_int64_t)second_lemma_it->second * (u_int64_t)second_lemma_it->second;
								second_lemma_it++;
							}
						}
						while (first_lemma_it != first_it->second.end ()) {
							squares_first += (u_int64_t)first_lemma_it->second * (u_int64_t)first_lemma_it->second;
							first_lemma_it++;
						}
						while (second_lemma_it != second_it->second.end ()) {
							squares_second += (u_int64_t)second_lemma_it->second * (u_int64_t)second_lemma_it->second;
							second_lemma_it++;
						}
						long double squares = (long double)squares_first * (long double)squares_second;
						long double sqrt_squares = sqrt (squares);
						long same_value = (long)(((long double)first_second / sqrt_squares) * 1000);
						if (same_value < user_same_value) {
							DocInfo docinfo;
							base->FindDocInfo (edition, docinfo);
							printf (":%ld.%ld;%ld.%ld", docinfo.nextEdition, sub_to_compare, edition, sub_to_compare);
							doc_to_compare = edition;
							doc_ref = (((u_int64_t)doc_to_compare) << 32) + sub_to_compare;
						}
					}
				}
				if (0 != edition)
					printf (":%ld.%ld", edition, sub_to_compare);
				printf ("\n");
			}
		}
	}


#ifndef	_WIN64
	delete base;
#endif
	return 0;
}
