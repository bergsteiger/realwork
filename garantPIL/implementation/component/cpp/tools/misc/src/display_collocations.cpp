#include "ace/ACE.h"
#include "shared/Core/fix/mpcxc.h"

#include <sys/types.h>
#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"

#include "SearchB.h"

#include "shared/ContextSearch/Search/Search.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/StreamReader.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}


int main_logic ( int argc, char *argv[] )
{
	if (argc == 1)
		return -1;

	std::vector<std::string> collocations;
	if (argv [2]) {
		FILE *collocations_file = fopen (argv[2], "rt");
		while (!feof (collocations_file )) {
			char str [256];
			if (!fgets (str, sizeof (str), collocations_file ))
				break;

			char *s = strchr (str, '\n');
			if (s) *s = '\0';
			/*
			for (s = str; *s != 0; s++)
				if (*s == ' ')
					*s = '-';
			*/
			collocations.push_back (str);
		}
		fclose (collocations_file);
	} else {
		exit (EXIT_SUCCESS);
	}

	SearchBase *base = new SearchBase (argv [1]);
	base->IsOk ();
	base->check_version ();
	delete base->AllDocs ();
	base->FindIndex ("SubName");

	std::set<long> docs;
	if (argv [3]) {
		FILE *docs_file = fopen (argv [3], "rt");
		while (!feof (docs_file )) {
			char str [256];
			if (!fgets (str, sizeof (str), docs_file ))
				break;

			char *s = strchr (str, '\n');
			if (s) *s = '\0';
			docs.insert (atol (str));
		}
		fclose (docs_file);
	} else {
		DocCollection *_docs = base->AllDocs ();
		for (int i = 0; i < _docs->ItemCount; i++)
			docs.insert ((*_docs)[i]);
	}

	IndexLoader loader (base);
	char sub_name [4096], doc_name [4096];
	for (std::vector<std::string>::const_iterator str_it = collocations.begin (); str_it != collocations.end (); str_it++) {
		std::string request = *str_it;
		//std::map<std::string, std::vector<std::string> > subname_texts;
		for (std::set<long>::const_iterator doc_it = docs.begin (); doc_it != docs.end (); doc_it++) {
			std::map<long,long> block_count;
			long doc_id = *doc_it;
			if (!base->FindDoc (doc_id))
				continue;
			Document* doc = base->GetDoc (doc_id);
			base->FindDocName (doc_id, doc_name);

			ContextSearch::Relevancy::Fragments *fragments = base->get_fragments_from_para (request.c_str (), doc_id, 0);
			if (fragments) {
				long subs_count;
				INDEX_DATA (SubDescEx) subs = loader.load <SubDescEx> (doc_id, IDD_SUBS_EX, subs_count);

				for (ContextSearch::Relevancy::Fragments::const_iterator it = fragments->begin (); it != fragments->end (); it++) {
					ContextSearch::Relevancy::Positions positions = it->data;
					YBase::HiliteParas_vec paras;
					YBase::HiliteWords_vec words;
					base->find_paras_with_words (doc_id, positions, paras, words);
					YBase::HiliteParas_vec::const_iterator para_it;
					YBase::HiliteWords_vec::const_iterator word_it;
					std::string fragment_str;

					if (paras.size ()) {
						for (para_it = paras.begin (), word_it = words.begin (); para_it != paras.end (); para_it++, word_it++) {
							long para_id = *para_it;
							long word_id = *word_it;
							char* para = doc->EVDParaText (doc->GetPara (para_id));
							long begin, end;
							base->hilite_word (para, strlen (para), word_id, CP_OEM, begin, end);
							char *word = new char [end - begin + 1];
							gk_bzero (word, end - begin + 1);
							memcpy (word, para + begin, end - begin);
							Recoding (cd_dos, cd_win, word);
							if (fragment_str.size ())
								fragment_str += " ";
							fragment_str += word;
							delete word;
						}

						long i, best_sub = 0;
						std::set<long> blocks_set;
						std::vector<long> blocks;
						SubDescEx *ptr;
						for (ptr = subs.ptr (), i = 0; i < subs_count && ptr->Para <= *paras.begin (); i++, ptr++) {
							long id = ptr->Sub;
							if (ptr->Flags == SUBDESCEX_BLOCK) {
								blocks_set.insert (id);
								blocks.push_back (id);
							} else if (ptr->Flags == SUBDESCEX_BLOCKEND) {
								std::set<long>::iterator del_it = blocks_set.find (id);
								if (del_it != blocks_set.end ())
									blocks_set.erase (del_it);
							}
						}
						long block = 0;
						for (std::vector<long>::reverse_iterator block_it = blocks.rbegin (); block_it != blocks.rend (); block_it++) {
							long block_id = *block_it;
							if (base->FindSubName (doc_id, block_id, sub_name)) {
								if (strstr (sub_name, "пункт") == sub_name || strstr (sub_name, "Пункт") == sub_name || strstr (sub_name, "подпункт") == sub_name || strstr (sub_name, "Подпункт") == sub_name)
									continue;
								block = block_id;
								break;
							}
						}
						if (!block)
							strcpy (sub_name, doc_name);
						//printf ("%ld.%ld.%s\n", doc_id, block, sub_name);
						if (block_count.find (block) == block_count.end ()) {
							block_count.insert (std::map<long,long>::value_type (block, 1));
						} else {
							block_count.find (block)->second++;
						}
						
						//итого,в blocks_set - блоки, которые начинаются над найденным параграфом. Их блокенды заведомо ниже найденного параграфа
						/*
						base->FindSubName (doc_id, 0, sub_name);
						for (std::vector<long>::reverse_iterator block_it = blocks.rbegin (); block_it != blocks.rend (); block_it++) {
							long id = *block_it;
							if (blocks_set.find (id) != blocks_set.end ()) {
								best_sub = id;
								base->FindSubName (doc_id, best_sub, sub_name);
								if (strstr (sub_name, "пункт") == sub_name || strstr (sub_name, "Пункт") == sub_name || strstr (sub_name, "подпункт") == sub_name || strstr (sub_name, "Подпункт") == sub_name || !sub_name[0])
									continue;
								else
									break;
							} 
						}
						if (!sub_name [0])
							base->FindSubName (doc_id, 0, sub_name);
						sprintf (subname_and_sub, "@%s@%ld.%ld@", sub_name, doc_id, best_sub);
						std::map<std::string, std::vector<std::string> >::iterator map_it = subname_texts.find (subname_and_sub);
						if (map_it == subname_texts.end ()) {
							std::vector<std::string> fragments;
							fragments.push_back (fragment_str);
							subname_texts.insert (std::map<std::string, std::vector<std::string> >::value_type (subname_and_sub, fragments));
						} else {
							map_it->second.push_back (fragment_str);
						}
						*/
					}
				}
			}
			delete doc;

			for (std::map<long,long>::const_iterator it = block_count.begin (); it != block_count.end (); it++) {
				long block = it->first;
				base->FindSubName (doc_id, block, sub_name);
				printf ("%ld.%ld:%s:%s:%d\n", doc_id, it->first, request.c_str (), sub_name, it->second);
			}
		}
		/*
		printf ("%s\n", request.c_str ());
		for (std::map<std::string, std::vector<std::string> >::const_iterator map_it = subname_texts.begin (); map_it != subname_texts.end (); map_it++) {
			printf ("%s", map_it->first.c_str ());
			for (std::vector<std::string>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
				if (it != map_it->second.begin ())
					printf (",");
				printf ("%s", it->c_str ());
			}
			printf ("\n");
		}
		*/
	}

	delete base;
	return 0;
}
