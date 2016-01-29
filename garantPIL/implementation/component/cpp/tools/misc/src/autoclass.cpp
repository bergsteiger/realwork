#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "SearchB.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

#include <utility>
#include <math.h>
#include "shared/ContextSearch/Common/Constants.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/BaseCache.h"

ToolsBase* aBase = 0;

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	return main_logic (argc, argv);
}

void	decrypt (char* ptr)
{
	const	char	*to   = "абвгдеЄжзийклмнопрстуфхцчшщьыъэю€abcdefghijklmnopqrstuvwxyzјЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„Ўў№џЏЁёяABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-[]";
	const	char	*from = "abcdefghijklmnopqrstuvwxyzабвгдеЄжзийклмнопрсту0123456789-[]фхцчшщьыъэю€јЅ¬√ƒ≈®ABCDEFGHIJKLMNOPQRSTUVWXYZ∆«»… ЋћЌќѕ–—“”‘’÷„Ўў№џЏЁёя";
	while (*ptr) {
		const char*	at = strchr (from, *ptr);
		if (at) {
			int offset = at - from;
			*ptr = *(to + offset);
		}
		ptr++;
	}
}

struct Tree
{
	Tree *parent, *next, *child;
	bool b_class; //установлен класс
	long id, pid;
	long from, to;
};

struct	SubDesc2
{
	long	block;
	long	from, to;
};

Tree*	Root;

std::map<long,std::set<long> > map_doc_blocks_with_autoclass; //мапа: какие блоки документа были найдены Searchем
std::map<u_int64_t, std::set<std::string> > map_ref_autoclasses; //мапа: какие классы были проставлены поиском на Refы
std::map<std::string, RefCollection*> result; //мапа: автокласс, какие документа.блоки были найдены поиском
std::set<long> exclusive_docs; //список документов, найденных по {class}. »м обычные [class] не ставить
std::set<long> autoclassed_docs; //на какие документы были проставлены какие-либо автоклассы
std::map<long,Tree*> map_doc_tree; ///мапа: документ и его "дерев€нна€" структура
//std::map<long,std::set<long> > map_doc_blocks_with_prefix; //мапа: документ и его блоки, на которых стоит префикс
std::map<long, SubDesc2*> doc_blocks_map; //мапа-кэш: документ и его пре-дерев€нна€ структура
std::map<long, long> doc_blocks_count; //мапа: документ и сколько у него блоков

/*
std::map<long,std::set<long> >map_doc_blocks_with_autoclass, , processed_map_doc_blocks_with_prefix;
std::map<long,std::set<long> >::const_iterator	blocks_with_prefixes;
*/

void	GetBlocksWithClasses (Tree *root, std::set<long> &blocks)
{
	if (root->b_class)
		blocks.insert (root->id);

	Tree* r = root->child;
	if (r)
		GetBlocksWithClasses (r, blocks);
	r = root->next;
	if (r)
		GetBlocksWithClasses (r, blocks);
}

void	ClearClasses (Tree *root)
{
	/*
	if (blocks_with_prefixes == map_doc_blocks_with_prefix.end () || blocks_with_prefixes->second.find (root->id) == blocks_with_prefixes->second.end ())
		root->b_class = false;
	*/
	root->b_class = false;
	Tree *r = root->child;
	if (r)
		ClearClasses (r);
	r = root->next;
	if (r)
		ClearClasses (r);
}

void	AbsoluteClearClasses (Tree *root)
{
	root->b_class = false;
	Tree *r = root->child;
	if (r)
		AbsoluteClearClasses (r);
	r = root->next;
	if (r)
		AbsoluteClearClasses (r);
}

bool	SetClassForBlock (Tree *root, long aid)
{
	if (root->id == aid) {
		root->b_class = true;
		return true;
	}
	Tree* r = root->child;
	if (r) {
		if (SetClassForBlock (r, aid))
			return true;
	}
	r = root->next;
	if (r) {
		if (SetClassForBlock (r, aid))
			return true;
	}
	return false;
}

void	ClearClassesForChild (Tree *root)
{
	if (root->b_class) {
		Tree* r = root->child;
		if (r)
			AbsoluteClearClasses (r);
	}
	Tree* r = root->child;
	if (r)
		ClearClassesForChild (r);
	r = root->next;
	if (r)
		ClearClassesForChild (r);
}

void	SetClassForParent (Tree *root)
{
	long blocks_wclass = 0, count = 0;
	Tree *r = root->child;
	while (r) {
		count++;
		SetClassForParent (r);
		if (r->b_class)
			blocks_wclass++;
		r = r->next;
	}
	if (blocks_wclass * 2 > count) {
		//у всех детей убрать class, подн€ть наверх
		r = root->child;
		if (r) AbsoluteClearClasses (r);
		/*
		while (r) {
			r->b_class = false;
			r = r->next;
		}
		*/
		root->b_class = true;
	}

}

Tree*	Locate (Tree *root, long from, long to)
{
	if (from >= root->from && to <= root->to) {
		//попали в родител€, ищем среди детей
		Tree* r = root->child;
		while (r) {
			if (from >= r->from && to <= r->to) {
				Tree* q = Locate (r, from, to);
				return q;
			}
			r = r->next;
		}
	} else {
		//ищем среди следующих
		Tree* r = root->next;
		while (r) {
			if (from >= r->from && to <= r->to) {
				Tree* q = Locate (r, from, to);
				return q;
			}
			r = r->next;
		}
	}
	return root;
}

int	InsertItem (int id, long from, long to)
{
	Tree *r = Locate (Root, from, to);

	if (r == 0)
		return 1;

	Tree *q = (Tree*) malloc (sizeof (Tree));
	q -> b_class = false;
	q -> child = 0;
	q -> next = 0;
	q -> id  = id;
	q -> from = from;
	q -> to = to;
	q -> parent = r;
	q -> pid = r -> id;

	if (!r -> child)
		r -> child = q;
	else {
		Tree *qq = r->child;
		while (qq->next)
			qq = qq->next;
		qq->next = q;
	}
	return 0;
}

int sortSubDesc2( const void *a, const void *b )
{
	SubDesc2* s1 = (SubDesc2*) a;
	SubDesc2* s2 = (SubDesc2*) b;
	int s;
	s = s1->from - s2->from;
	if ( s != 0 ) return s;
	s = ( s2->to - s2->from ) - ( s1->to - s1->from );
	if ( s != 0 ) return s;
	s = s2->to - s1->to;
	if ( s != 0 ) return s;
	return s2->block - s1->block;
	//сначала блоки, начинающиес€ выше.
	//среди начинающихс€ на одном параграфе - сначала бќльшие, потом м≈ньшие (вложенные)
}


/*
SubDesc2* Construct (SubDescEx* subs, long SubCount, long& blockscount)
{
	SubDesc2*	blocks = 0;
	blockscount = 0;
	SubDescEx* subptr = subs;

	long i;
	for (i = 0; i < SubCount; i++, subptr++) {
		if (subptr->Flags == SUBDESCEX_BLOCKEND) {
			if (!blocks)
				blocks = (SubDesc2*) malloc (sizeof (SubDesc2));
			else
				blocks = (SubDesc2*) realloc (blocks, (blockscount+1) * sizeof (SubDesc2));
			blocks [blockscount].block = subptr->Sub;
			blocks [blockscount].to = subptr->Para;
			blockscount++;
		}
	}

	//получен список блоков, наличествующих в документе
	for (i = 0; i < blockscount; i++) {
		long aBlock = blocks[i].block;
		subptr = subs;
		for (long j = 0; j < SubCount; j++, subptr++) {
			if (subptr->Flags == SUBDESCEX_BLOCK && blocks[ i ].block == subptr->Sub) {
				blocks[ i ].from = subptr->Para;
				break;
			}
		}
	}

	qsort (blocks, blockscount, sizeof (SubDesc2), sortSubDesc2);
	//дл€ каждого блока теперь есть начало и конец, в параграфах
	return blocks;
}
*/

SubDesc2* Construct (DocStruct* subs, long structs_count, long& blockscount)
{
	SubDesc2*	blocks = 0;
	blockscount = 0;
	DocStruct* structs_ptr = subs;

	for (int i = 0; i < structs_count; i++, structs_ptr++) {
		short evd_type = (short) ((structs_ptr->m_para_list_type >> 24) & 0xFF);
		if (evd_type == SUBDESCEX_BLOCK) {
			long block = structs_ptr->m_para_list_id;

			blocks = (SubDesc2*) realloc (blocks, (blockscount+1) * sizeof (SubDesc2));
			blocks [blockscount].block = block;
			blocks [blockscount].from = structs_ptr->m_start_para;
			blocks [blockscount].to = structs_ptr->m_end_para + 1;
			blockscount++;
		}
	}

	qsort( blocks, blockscount, sizeof( SubDesc2 ), sortSubDesc2 );

	return blocks;
}

template <typename T>
class IndexDataLoader {
public:
	IndexDataLoader (const bool is_array = true) : m_is_array (is_array) {
	}

	T* load (ToolsBase* base, const long doc_id, const int tag, long& count) {
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

bool	local_compare_hstr (char* index_str, const char* user_str)
{
	char shrinked_str [2048];
	char* toput = shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return !strcmp (shrinked_str, user_str);
}

IndexReq*	build_hindex_req (const char* index_name, std::vector<std::string> &strs, int search_op = SO_AND | SO_KEYS_AND)
{
	IndexReq* req = 0;
	if (strs.size ()) {
		char full_key [2048];

		HIndex* index = (HIndex*)aBase->FindIndex (index_name);
		req = (IndexReq*) malloc (sizeof (IndexReq) + strs.size () * index->KeyLength);
		req->ItemCount = 0;
		req->ItemSize  = index->KeyLength;
		req->SearchOp  = search_op;
		strcpy (req->Name, index_name);
		char* toput = (char*)(req+1);
		for (BTIterator btit (index); !btit.End () && req->ItemCount != strs.size (); ++btit) {
			index->FullName (btit.Key (), full_key);
			for (std::vector<std::string>::const_iterator it = strs.begin (); it != strs.end (); it++) {
				if (local_compare_hstr (full_key, it->c_str ())) {
					memcpy (toput, btit.Key (), req->ItemSize);
					req->ItemCount++;
					toput += req->ItemSize;
					break;
				}
			}
		}
	}
	return req;
}

IndexReq*	build_index_req (const char* index_name, std::vector<std::string> &strs)
{
	IndexReq* req = 0;
	if (strs.size ()) {
		Index* index = aBase->FindIndex (index_name);
		req = (IndexReq*) malloc (sizeof (IndexReq) + strs.size () * index->KeyLength);
		req->ItemCount = 0;
		req->ItemSize  = index->KeyLength;
		req->SearchOp  = SO_AND | SO_KEYS_AND;
		strcpy (req->Name, index_name);
		char* toput = (char*)(req+1);
		for (std::vector<std::string>::const_iterator it = strs.begin (); it != strs.end (); it++) {
			for (BTIterator btit (index); !btit.End (); ++btit) {
				char* aKey = (char*) btit.Key();
				if (!strcmp (aKey, it->c_str ())) {
					memcpy (toput, aKey, req->ItemSize);
					req->ItemCount++;
					toput += req->ItemSize;
				}
			}
		}
	}
	return req;
}

IndexReq*	build_ctx_req (std::vector<std::string> &strs, unsigned long ctx_mask)
{
	IndexReq* req = 0;
	if (strs.size ()) {
		long size = 0;
		std::vector<std::string>::const_iterator it;
		for (it = strs.begin (); it != strs.end (); ++it)
			size += it->size () + 1;

		req = (IndexReq*) malloc (sizeof (IndexReq) + size);
		req->ItemCount = strs.size ();
		req->ItemSize  = 0;
		req->SearchOp = SO_AND | SO_KEYS_AND | ctx_mask;
		strcpy (req->Name, "Morpho");
		char* toput = (char*)(req+1);
		for (it = strs.begin (); it != strs.end (); ++it) {
			strcpy (toput, it->c_str ());
			toput += it->size () + 1;
		}
	}
	return req;
}

extern	void	merge_part_with_requestpart (RefwReleCollection&, RefwReleCollection&);

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	bool b_decrypt = true;

	Core::AutoInit init;
	aBase = new ToolsBase (argv [1]);
	DocCollection* all_docs = aBase->AllDocs ();

	char str_to_write [2048];
	char name [512];
	FILE *rulesFile = fopen (argv [2], "rt"), *results_file = fopen (argv [3] && strcmp (argv [3], "-nodecrypt") ? argv [3] : "autoclass.result", "wt");
	if ((argv [3] && !strcmp (argv [3], "-nodecrypt")) || (argv [4] && !strcmp (argv [4], "-nodecrypt")))
		b_decrypt = false;

	if (!results_file)
		exit (-1);

	std::vector<std::string> headers, texts, not_texts, classes, types, not_types, prefixes, not_prefixes, norms, sources, not_sources, territories;
	std::string str_class;

	long	phase = 0, request_iter = 0;
	bool	b_exclusive_class = false;

	Morpho::Def::ICache* cache = BaseCache::instance ()->get_morpho_cache_ptr ();
	cache->load (aBase->abstract_base (), true);

	SearchAdapterLib::Adapter::ISearcher_var searcher = SearchAdapter::instance ()->get (
		aBase->abstract_base (), cache, "NWCntxt.str"
	);

	while (!feof (rulesFile)) {
		char str [256];
		if ( !fgets (str, sizeof (str), rulesFile)) {
			if (phase == 3)
				goto do_search;
			break;
		}

		int length = strlen (str);
		if (length && (str [length-1] == 10 || str [length-1] == 13))
			str [--length] = 0;

		if (b_decrypt)
			decrypt (str);

		if (feof (rulesFile) && phase == 3) {
			if (str_class.size ())
				str_class += " ";
			str_class += str;
			length = 0;
		}
		
		if (!length) {
do_search:
			if (str_class.size ()) {
				classes.push_back (str_class);
				str_class = "";
			}
			if (phase == 3 || phase == 31) {
				IndexReq *ctx_reqs [2], *other_reqs [10];

				IndexReq *norms_req = build_index_req ("Category", norms);
				IndexReq *sources_req = build_hindex_req ("Adopted", sources);
				if (!sources_req && not_sources.size ()) sources_req = build_hindex_req ("Adopted", not_sources, SO_MINUS);
				IndexReq *types_req = build_hindex_req ("Type", types);
				if (!types_req && not_types.size ()) types_req = build_hindex_req ("Type", not_types, SO_MINUS);
				IndexReq *prefixes_req = build_hindex_req ("Kind", prefixes);
				if (!prefixes_req && not_prefixes.size ()) prefixes_req = build_hindex_req ("Kind", not_prefixes, SO_MINUS);
				IndexReq *territories_req = build_hindex_req ("Territory", territories);

				IndexReq *headers_req = build_ctx_req (headers, SV_MTITLES);
				IndexReq *texts_req = build_ctx_req (texts, SV_MBODIES);

				long other_req_count = 0;
				if (norms_req)
					other_reqs [other_req_count++] = norms_req;
				if (sources_req)
					other_reqs [other_req_count++] = sources_req;
				if (prefixes_req)
					other_reqs [other_req_count++] = prefixes_req;
				if (types_req)
					other_reqs [other_req_count++] = types_req;
				if (territories_req)
					other_reqs [other_req_count++] = territories_req;

				long ctx_req_count = 0;
				if (headers_req)
					ctx_reqs [ctx_req_count++] = headers_req;
				if (texts_req)
					ctx_reqs [ctx_req_count++] = texts_req;

#ifdef	_DEBUG
				printf ("request: %ld, %s+%s", ++request_iter, headers_req ? (char*)(headers_req+1) : "\"\"", texts_req ? (char*)(texts_req+1) : "\"\""); fflush (stdout);
#endif

				bool valid_request = true;
				{
					std::vector<std::string>::const_iterator it;
					for (it = headers.begin (); it != headers.end () && valid_request; it++) {
						Core::Aptr <GCL::StrSet> res = aBase->get_incorrect_words (it->c_str ());
						if (res.is_nil () == false && res->size ())
							valid_request = false;
					}
					for (it = texts.begin (); it != texts.end () && valid_request; it++) {
						Core::Aptr <GCL::StrSet> res = aBase->get_incorrect_words (it->c_str ());
						if (res.is_nil () == false && res->size ())
							valid_request = false;
					}
				}

				SortedCollection* ctx_list = valid_request ? aBase->Search (ctx_req_count, ctx_reqs, 0, SO_AND, 0, 0, 0, false, false)->list : 0;
				SortedCollection* other_list = other_req_count ? aBase->Search (other_req_count, other_reqs, 0, SO_AND, 0, 0, 0, false, false)->list : 0;
				SortedCollection* not_ctx_list = new RefwReleCollection ();

				if (not_texts.size ()) {
					std::vector<std::string>::const_iterator not_it;
					for (not_it = not_texts.begin (); not_it != not_texts.end (); not_it++) {
						std::vector<std::string> local_texts;
						
						Core::Aptr <GCL::StrSet> res = aBase->get_incorrect_words (not_it->c_str ());
						if (res.is_nil () == false && res->size ())
							valid_request = false;

						local_texts.push_back (*not_it);
						IndexReq *not_texts_req = build_ctx_req (local_texts, SV_MBODIES);
						IndexReq *not_ctx_reqs [1] = {not_texts_req};
						SortedCollection* not_list = valid_request ? aBase->Search (1, not_ctx_reqs, 0,SO_AND)->list : 0;
						if (not_list) {
							if (not_list->ItemCount)
								merge_part_with_requestpart (*(RefwReleCollection*)not_ctx_list, *(RefwReleCollection*)not_list);
							delete not_list;
						}
					}
					std::set<long> not_docs;
					int i;
					for (i = 0; i < not_ctx_list->ItemCount; i++)
						not_docs.insert (((RefwRele*)not_ctx_list->GetItem (i))->DocId);
					RefwReleCollection* new_ctx_list = new RefwReleCollection ();
					for (i = 0; i < ctx_list->ItemCount; i++) {
						RefwRele* ati = (RefwRele*) ctx_list->GetItem (i);
						if (not_docs.find (ati->DocId) == not_docs.end ())
							new_ctx_list->Collection::Add (ati);
					}
					delete ctx_list;
					ctx_list = new_ctx_list;
				}

				Collection* foundlist = new RefwReleSubCollection ();

				if (valid_request) {
					if (ctx_list && ctx_list->ItemCount) {
						if (other_list) {
							if (other_list->Tag () == OT_DOCCOLLECTION) {
								long pos1 = 0, pos2 = 0;
								while (pos1 < ctx_list->ItemCount && pos2 < other_list->ItemCount) {
									RefwRele* at1 = (RefwRele*) ctx_list->GetItem (pos1);
									long at2 = (*(DocCollection*)other_list)[pos2];
									if (at1->DocId == at2) {
										RefwRele add = { at1->DocId, at1->Word & ContextSearch::POS_TEXT, at1->Rele };
										while ( pos2 < other_list->ItemCount ) {
											at2 = (*(DocCollection*)other_list)[pos2];
											if (at2 != at1->DocId)
												break;
											foundlist->Collection::Add( &add );
											pos2++;
										}
										pos1++;
									} else {
										if (at1->DocId < at2)
											pos1++;
										else
											pos2++;									
									}
								}
							} else {
								long pos1 = 0, pos2 = 0;
								while (pos1 < ctx_list->ItemCount && pos2 < other_list->ItemCount) {
									RefwRele* at1 = (RefwRele*) ctx_list->GetItem (pos1);
									Ref* at2 = (Ref*)other_list->GetItem (pos2);
									if (at1->DocId == at2->DocId) {
										RefwRele add = { at1->DocId, at1->Word & ContextSearch::POS_TEXT, at1->Rele };
										while ( pos2 < other_list->ItemCount ) {
											at2 = (Ref*)other_list->GetItem (pos2);
											if (at2->DocId != at1->DocId )
												break;
											foundlist->Collection::Add( &add );
											pos2++;
										}
										pos1++;
									} else {
										if (at1->DocId < at2->DocId)
											pos1++;
										else
											pos2++;
									}
								}
							}
						} else {
							foundlist->Move (*ctx_list);
						}
					}
				} else if (other_list) {
					if (!ctx_req_count) {
						if (other_list->Tag () == OT_DOCCOLLECTION) {
							for (int i = 0; i < other_list->ItemCount; i++) {
								RefwRele to_add = {*(long*)other_list->GetItem (i), 501, 0};
								foundlist->Collection::Add (&to_add);
							}
						} else {
							for (int i = 0; i < other_list->ItemCount; i++) {
								RefwRele to_add = {((Ref*)(other_list->GetItem (i)))->DocId, 501, 0};
								foundlist->Collection::Add (&to_add);
							}
						}
					}
				}

				RefCollection* realresult = new RefCollection ();
				for (int i = 0; i < foundlist->ItemCount; i++) {
					RefwRele* ati = (RefwRele*)foundlist->GetItem (i);
					long doc_id = ati->DocId;
					std::vector<long> paras;
					if (texts.size ()) {
						GCL::StrVector words;
						words.push_back (*texts.begin ());
						printf ("%s\n", words.at (0).c_str ());

						SearchAdapterLib::Adapter::IPositions_var res = searcher->get_positions (words, doc_id);
						if (res.is_nil () == false && res->data ().size ()) {
							Core::Aptr <WordsParas> hld = aBase->get_paras_and_words (doc_id, res->data ());
							for (std::vector <long>::const_iterator it = hld->paras.begin (); it != hld->paras.end (); it++)
								paras.push_back (*it);
						}
					} else {
						paras.push_back (aBase->find_paras_with_word (doc_id, ati->Word));
					}

					std::map<long,SubDesc2*>::const_iterator doc_blocks = doc_blocks_map.find (ati->DocId);
					if (doc_blocks == doc_blocks_map.end ()) {
						/*
						long sub_count, blocks_count;
						Core::Aptr <SubDescEx, DataDestructor> sd (IndexDataLoader <SubDescEx> ().load (aBase, doc_id, IDD_SUBS_EX, sub_count));
						SubDesc2* blocks = Construct (sd.ptr (), sub_count, blocks_count);
						*/
						long structs_count, blocks_count;
						Core::Aptr <DocStruct, DataDestructor> sd (IndexDataLoader <DocStruct> ().load (aBase, doc_id, IDD_DOCSTRUCT, structs_count));
						SubDesc2* blocks = Construct (sd.ptr (), structs_count, blocks_count);

						doc_blocks_map.insert (std::map<long,SubDesc2*>::value_type (doc_id,blocks));
						doc_blocks = doc_blocks_map.find (doc_id);
						doc_blocks_count.insert (std::map<long, long>::value_type (doc_id, blocks_count));
					}

					long blocks_count = doc_blocks_count.find (doc_id)->second;
					for (std::vector<long>::const_iterator para_it = paras.begin (); para_it != paras.end (); para_it++) {
						long para = *para_it, block = 0;					
						if (blocks_count) {
							SubDesc2* blocks = doc_blocks->second;
							for (int j = blocks_count - 1; j >= 0; j--) {
								//просматриваем блоки с конца документа вверх. Ќаходим первый, начинающийс€ над параграфом
								if (blocks[j].from <= para && blocks[j].to > para) {
									block = blocks[j].block;
									break;
								}
							}
						}

						if (!b_exclusive_class && exclusive_docs.find (ati->DocId) != exclusive_docs.end ())
							continue;

						Ref toadd = {ati->DocId, block};
						realresult->Insert (&toadd);
						if (b_exclusive_class)
							exclusive_docs.insert (ati->DocId);
						autoclassed_docs.insert (ati->DocId);

						std::map<long,std::set<long> >::iterator map_it = map_doc_blocks_with_autoclass.find (doc_id);
						if (map_it == map_doc_blocks_with_autoclass.end ()) {
							std::set<long> to_insert;
							to_insert.insert (toadd.Sub);
							map_doc_blocks_with_autoclass.insert (std::map<long,std::set<long> >::value_type (toadd.DocId, to_insert));
						} else {
							map_it->second.insert (toadd.Sub);
						}

						u_int64_t ref64 = (((u_int64_t)toadd.DocId) << 32) + (u_int64_t) toadd.Sub;
						std::map<u_int64_t,std::set<std::string> >::iterator map_iit = map_ref_autoclasses.find (ref64);
						if (map_iit == map_ref_autoclasses.end ()) {
							std::set<std::string> str_set;
							str_set.insert (*classes.begin ());
							map_ref_autoclasses.insert (std::map<u_int64_t,std::set<std::string> >::value_type (ref64, str_set));
						} else {
							map_iit->second.insert (*classes.begin ());
						}
					}
				}
				delete foundlist;

#ifdef	_DEBUG
				printf (", found: %ld\n", realresult->ItemCount);
#endif
				if (realresult->ItemCount) {
					for (std::vector<std::string>::const_iterator it = classes.begin (); it != classes.end (); ++it) {
						std::map<std::string, RefCollection*>::iterator atres = result.find (*it);
						if (atres == result.end ())
							result.insert(std::map<std::string, RefCollection*>::value_type (*it, realresult));
						else
							atres->second->Merge (*realresult);
					}
				}

				if (territories_req)
					free (territories_req);
				if (norms_req)
					free (norms_req);
				if (sources_req)
					free (sources_req);
				if (types_req) free
					(types_req);
				if (prefixes_req)
					free (prefixes_req);
				if (headers_req)
					free (headers_req);
				if (texts_req)
					free (texts_req);

				headers.clear ();
				texts.clear ();
				not_texts.clear ();
				classes.clear ();
				types.clear ();
				not_types.clear ();
				prefixes.clear ();
				not_prefixes.clear ();
				norms.clear ();
				sources.clear ();
				not_sources.clear ();
				territories.clear ();
				phase = 0;
				b_exclusive_class = false;
			}
			continue;
		}
		if (!stricmp (str, "[HEADER]") || !stricmp (str, "[TITLE]"))
			phase = 1;
		else
		if (!stricmp (str, "[TEXT]"))
			phase = 2;
		else
		if (!stricmp (str, "[-TEXT]"))
			phase = 22;
		else
		if (!stricmp (str, "[CLASS]"))
			phase = 3;
		else
		if (!stricmp (str, "{CLASS}"))
			phase = 31;
		else
		if (!stricmp (str, "[TYPE]"))
			phase = 4;
		else
		if (!stricmp (str, "[-TYPE]"))
			phase = 44;
		else
		if (!stricmp (str, "[KIND]"))
			phase = 5;
		else
		if (!stricmp (str, "[-KIND]"))
			phase = 55;
		else
		if (!stricmp (str, "[SOURCE]"))
			phase = 6;
		else
		if (!stricmp (str, "[-SOURCE]"))
			phase = 66;
		else
		if (!stricmp (str, "[NORM]"))
			phase = 7;
		else
		if (!stricmp (str, "[TERRITORY]"))
			phase = 8;
		else {
			switch (phase) {
				case 1:
					headers.push_back (str);
					break;
				case 2:
					texts.push_back (str);
					break;
				case 22:
					not_texts.push_back (str);
					break;
				case 31:
					b_exclusive_class = true;
				case 3:
					if (str_class.size ())
						str_class += " ";
					str_class += str;
					break;
				case 4:
					types.push_back (str);
					break;
				case 44:
					not_types.push_back (str);
					break;
				case 5:
					prefixes.push_back (str);
					break;
				case 55:
					not_prefixes.push_back (str);
					break;
				case 6:
					sources.push_back (str);
					break;
				case 66:
					not_sources.push_back (str);
					break;
				case 7:
					norms.push_back (str);
					break;
				case 8:
					territories.push_back (str);
					break;
			}
		}
	}

#ifdef	_DEBUG
	{
		for (std::map<long,std::set<long> >::const_iterator it = map_doc_blocks_with_autoclass.begin (); it != map_doc_blocks_with_autoclass.end (); it++) {
			long doc_id = it->first;
			printf ("%ld:", doc_id);
			for (std::set<long>::const_iterator iit = it->second.begin (); iit != it->second.end (); iit++)
				printf (" %ld", *iit);
			printf ("\n");
		}
	}
#endif

	{
		for (int i = 0; i < all_docs->ItemCount; i++) {
			long doc_id = (*all_docs) [i];
			std::map<long,SubDesc2*>::const_iterator doc_blocks = doc_blocks_map.find (doc_id);
			if (doc_blocks == doc_blocks_map.end ()) {
				/*
				long sub_count, blocks_count;
				Core::Aptr <SubDescEx, DataDestructor> sd (IndexDataLoader <SubDescEx> ().load (aBase, doc_id, IDD_SUBS_EX, sub_count));
				SubDesc2* blocks = Construct (sd.ptr (), sub_count, blocks_count);
				*/
				long structs_count, blocks_count;
				Core::Aptr <DocStruct, DataDestructor> sd (IndexDataLoader <DocStruct> ().load (aBase, doc_id, IDD_DOCSTRUCT, structs_count));
				SubDesc2* blocks = Construct (sd.ptr (), structs_count, blocks_count);

				doc_blocks_map.insert (std::map<long,SubDesc2*>::value_type (doc_id,blocks));
				doc_blocks = doc_blocks_map.find (doc_id);
				doc_blocks_count.insert (std::map<long, long>::value_type (doc_id, blocks_count));
			}
		}
	}

	//Ўаг: вычисл€ем блоки, на которых стоит PREFIX
	printf ("calculate blocks\n"); fflush (stdout);
	std::map<long,SubDesc2*>::const_iterator doc_blocks_map_iter;
	for (doc_blocks_map_iter = doc_blocks_map.begin (); doc_blocks_map_iter != doc_blocks_map.end (); doc_blocks_map_iter++) {
		long doc_id = doc_blocks_map_iter->first;
		DocInfo docinfo;
		aBase->FindDocInfo (doc_id, docinfo);

		SubDesc2* blocks = doc_blocks_map_iter->second;
		Root = (Tree*) malloc (sizeof (Tree));
		memset (Root, 0, sizeof (Tree));
		Root->to = docinfo.ParaCount;

		long blocks_count = doc_blocks_count.find (doc_id)->second;
		for (int i = 0; i < blocks_count; i++)
			InsertItem (blocks [i].block, blocks [i].from, blocks [i].to);
		map_doc_tree.insert (std::map<long,Tree*>::value_type (doc_id, Root));

		/*
		std::set<long> blocks_with_prefix;
		long length; char *prefix_blocks = (char*) aBase->LoadAttr (doc_id, IDD_DOCKIND, length), *prefix = prefix_blocks;
		if (length) while (prefix - prefix_blocks < length) {
			long block; sscanf (prefix, "%d:", &block);
			blocks_with_prefix.insert (block);
			prefix += strlen (prefix) + 1;
		}
		gk_free (prefix_blocks);
		map_doc_blocks_with_prefix.insert (std::map<long,std::set<long> >::value_type (doc_id, blocks_with_prefix));
		*/
	}

	printf ("calculate classes\n"); fflush (stdout);
	for (std::map<std::string, RefCollection*>::iterator it = result.begin (); it != result.end (); ++it) {
		RefCollection *refs = it->second, newrefs;
		if (!refs || !refs->ItemCount)
			continue;
		const char* request = it->first.c_str ();
		//printf ("%s ", it->first.c_str ()); fflush (stdout);
		for (int i = 0; i < refs->ItemCount; ) {			
			Ref ref_i = (*refs)[i];
			long doc_id = ref_i.DocId;
			std::set<long> subs;
			subs.insert (ref_i.Sub);
			for (i++; i < refs->ItemCount; i++) {
				Ref ref_i = (*refs)[i];
				if (ref_i.DocId == doc_id)
					subs.insert (ref_i.Sub);
				else {
					break;
				}
			}
			//итого, в subs - все блоки документа doc_id, найденные по классу

			Root = map_doc_tree.find (doc_id)->second; //дерево документа
			AbsoluteClearClasses (Root); //надо очистить (от прошлых проходов) признаки, что у блоков есть класс

			//выставл€ем признак, что у блоков есть класс.
			std::set<long>::const_iterator it;
			for (it = subs.begin (); it != subs.end (); it++) {
				long sub = *it;
				SetClassForBlock (Root, sub);
			}

			//шаг. ” вложенных блоков надо вычистить класс, если он стоит на внешнем блоке
			std::set<long> was_blocks_with_classes;
			GetBlocksWithClasses (Root, was_blocks_with_classes);
			ClearClassesForChild (Root);
			//но - внимание - надо оставить его у тех блоков, у которых есть !PREFIX. ѕоэтому дл€ них выставл€ем обратно
			/*
			std::map<long, std::set<long> >::const_iterator map_doc_blocks_with_prefix_iter = map_doc_blocks_with_prefix.find (doc_id);
			if (map_doc_blocks_with_prefix_iter != map_doc_blocks_with_prefix.end ()) {
				std::set<long> blocks_with_prefix = map_doc_blocks_with_prefix_iter->second; //блоки документа с префиксами
				for (it = blocks_with_prefix.begin (); it != blocks_with_prefix.end (); it++) {
					long sub = *it;
					if (was_blocks_with_classes.find (sub) != was_blocks_with_classes.end ())
						SetClassForBlock (Root, sub);
				}
			}
			*/

			//шаг. ≈сли у 50% вложенных блоков класс, то его надо перенести наверх
			SetClassForParent (Root);
			/*
			if (map_doc_blocks_with_prefix_iter != map_doc_blocks_with_prefix.end ()) {
				std::set<long> blocks_with_prefix = map_doc_blocks_with_prefix_iter->second; //блоки документа с префиксами
				for (it = blocks_with_prefix.begin (); it != blocks_with_prefix.end (); it++) {
					long sub = *it;
					if (was_blocks_with_classes.find (sub) != was_blocks_with_classes.end ())
						SetClassForBlock (Root, sub);
				}
			}
			*/

			std::set<long> blocks_with_classes;
			GetBlocksWithClasses (Root, blocks_with_classes); //получили список блоков после переносов вверх-вниз

			for (it = blocks_with_classes.begin (); it != blocks_with_classes.end (); it++) {
				Ref to_insert = {doc_id, *it};
				newrefs.Insert (&to_insert);
			}
		}
		refs->FreeAll ();
		refs->Move (newrefs);
	}

	//Ўаг: блокам с префиксами, которым не выставлен ј , надо прописать ќбщие¬опросы’озƒе€тельности
	/*
	{
	std::set<u_int64_t> classified; //здесь будут все док.блок, на которых стоит автокласс
	for (std::map<std::string, RefCollection*>::const_iterator i = result.begin (); i != result.end (); i++) {
		RefCollection* refs = i->second;
		for (int j = 0; j < refs->ItemCount; j++) {
			Ref at_j = (*refs) [j];
			u_int64_t value = (((u_int64_t)at_j.DocId) << 32) + at_j.Sub;
			classified.insert (value);
		}
	}

	RefCollection *put_in = new RefCollection;
	std::map<long, std::set<long> >::const_iterator it = map_doc_blocks_with_prefix.begin ();
	for (; it != map_doc_blocks_with_prefix.end (); it++) {
		long doc_id = it->first;
		std::set<long> blocks = it->second;
		for (std::set<long>::const_iterator blocks_it = blocks.begin (); blocks_it != blocks.end (); blocks_it++) {
			long block = *blocks_it;
			u_int64_t value = (((u_int64_t)doc_id) << 32) + block;
			if (classified.find (value) == classified.end ()) {
				//если на нем нет никакого ј , то к нему приписать ќбщие¬опросы’озƒе€тельности
				Ref to_put = {doc_id, block};
				put_in->Insert (&to_put);
				autoclassed_docs.insert (doc_id);
			}
		}
	}
	result.insert (std::map<std::string, RefCollection*>::value_type ("ќбщие вопросы хоз€йственной и предпринимательской де€тельности\\ќбщие вопросы хоз€йственной де€тельности", put_in));
	}
	*/

	/*
	printf ("calculate classes\n"); fflush (stdout);
	for (std::map<std::string, RefCollection*>::iterator it = result.begin (); it != result.end (); ++it) {
		RefCollection* refs = it->second;
		if (!refs || !refs->ItemCount)
			continue;
		const char* request = it->first.c_str ();
		printf ("%s ", it->first.c_str ()); fflush (stdout);
		Ref ref_i = (*refs)[0];
		long doc_id = ref_i.DocId;
		bool b_stop = false;
		for (int i = 0; i < refs->ItemCount; ) {			
			std::set<long> subs;
			subs.insert (ref_i.Sub);
			i++;
			for (; i < refs->ItemCount; i++) {
				ref_i = (*refs)[i];
				if (ref_i.DocId == doc_id)
					subs.insert (ref_i.Sub);
				else
					break;
			}
			if (i == refs->ItemCount)
				b_stop = true;

			//обработать текущий документ и его сабы
			Root = map_doc_tree.find (doc_id)->second;
			blocks_with_prefixes = map_doc_blocks_with_prefix.end ();
			ClearClasses (Root); //очистили признаки, что у блоков есть класс

			//выставл€ем признак, что у блоков есть класс.
			for (std::set<long>::const_iterator it = subs.begin (); it != subs.end (); it++) {
				long sub = *it;
				SetClass (Root, sub);
			}

			//шаг1. ” вложенных блоков надо вычистить класс, если он стоит на внешнем блоке
			blocks_with_prefixes = map_doc_blocks_with_prefix.find (doc_id);
			SetClassStep1 (Root);

			//шаг2. ≈сли у 50% вложенных блоков класс, то его надо перенести наверх
			SetClassStep2 (Root);

			std::set<long> blocks_with_classes;
			GetBlocksWithClasses (Root, blocks_with_classes);

			//итого, имеем:
			//  1. в blocks_with_classes - список блоков, на котором данный класс
			//  2. в subs - блоки, на которые изначально хотели ставить классы
			
			//надо: блоки с префиксом, если на них не сто€т никакие автоклассы, поставить текущий класс
			//в map_doc_blocks_with_prefix - мапа doc->блоки с префиксом
			std::map<long,std::set<long> >::const_iterator map_it = map_doc_blocks_with_prefix.find (doc_id);
			if (map_it != map_doc_blocks_with_prefix.end ()) {
				std::map<long,std::set<long> >::const_iterator map_it2 = map_doc_blocks_with_autoclass.find (doc_id); //документы, на блоках которых есть автокласс (по поиску)
				for (std::set<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
					long sub = *it; //блок, на котором стоит префикс
					std::map<long, std::set<long> >::iterator was_processed = processed_map_doc_blocks_with_prefix.find (doc_id);
					//processed_map_doc_blocks_with_prefix - это те блоки, которым уже присвоили автокласс

					//проверить - если на блоке есть автокласс (по поиску), то ставить не надо
					//if ((map_it2 != map_doc_blocks_with_autoclass.end ()) && (map_it2->second.find (sub) != map_it2->second.end ()))
					//	continue;

					//проверить - если раньше этому блоку уже поставили чей-то автокласс, то не ставить
					//if ((was_processed != processed_map_doc_blocks_with_prefix.end ()) && (was_processed->second.find (sub) != was_processed->second.end ()))
					//	continue;

					if (map_it2->second.find (sub) == map_it2->second.end () && was_processed == processed_map_doc_blocks_with_prefix.end () || ((was_processed != processed_map_doc_blocks_with_prefix.end ()) && (was_processed->second.find (sub) == was_processed->second.end ()))) { // раньше только из шапки классы ставили, теперь - любые
						blocks_with_classes.insert (sub);
						if (was_processed == processed_map_doc_blocks_with_prefix.end ()) {
							std::set<long> processed_subs;
							processed_subs.insert (sub);
							processed_map_doc_blocks_with_prefix.insert (std::map<long, std::set<long> >::value_type (doc_id, processed_subs));
						} else {
							was_processed->second.insert (sub);
						}
					}
				}
			}

			//в коллекцию добавить те из blocks_with_classes, которых нет в subs
			std::set<long>::const_iterator it;
			for (it = blocks_with_classes.begin (); it != blocks_with_classes.end (); it++) {
				long sub = *it;
				if (subs.find (sub) == subs.end ()) {
					Ref to_add = {doc_id, sub};
					refs->Insert (&to_add);
#ifdef	_DEBUG
					printf ("+");
#endif
				}
#ifdef	_DEBUG
				printf ("%ld.%ld ", doc_id, sub);
#endif
			}

			//те, которые есть в subs, но нет в blocks_with_classes, удалить из коллекции
			for (it = subs.begin (); it != subs.end (); it++) {
				long sub = *it;
				if (blocks_with_classes.find (sub) == blocks_with_classes.end ()) {
					Ref to_delete = {doc_id, sub};
					long pos = refs->IndexOf (&to_delete);
					if (pos != -1) {
						refs->atDelete (pos);
#ifdef	_DEBUG
						printf ("-");
#endif
					}
				}
#ifdef	_DEBUG
				printf ("%ld.%ld ", doc_id, sub);
#endif
			}

			if (b_stop)
				break;

			i = refs->IndexOf (&ref_i);
			doc_id = ref_i.DocId; //переходим к следующему документу

			printf ("\n");
		}
		printf ("\n");
	}

#ifdef	_DEBUG
	{
		for (std::map<long,std::set<long> >::const_iterator it = map_doc_blocks_with_autoclass.begin (); it != map_doc_blocks_with_autoclass.end (); it++) {
			long doc_id = it->first;
			printf ("%ld:", doc_id);
			for (std::set<long>::const_iterator iit = it->second.begin (); iit != it->second.end (); iit++)
				printf (" %ld", *iit);
			printf ("\n");
		}
	}
#endif

	//std::map<long,std::set<long> > map_doc_blocks_with_autoclass
	std::map<long,std::set<long> > result_doc_blocks_with_autoclass;
	std::map<std::string, RefCollection*>::const_iterator it;
	for (it = result.begin (); it != result.end (); ++it) {
		RefCollection* refs = it->second;
		if (!refs || !refs->ItemCount)
			continue;
		for (int i = 0; i < refs->ItemCount; i++) {
			Ref ati = (*refs)[i];
			std::map<long,std::set<long> >::iterator map_it = result_doc_blocks_with_autoclass.find (ati.DocId);
			if (map_it == result_doc_blocks_with_autoclass.end ()) {
				std::set<long> blocks;
				blocks.insert (ati.Sub);
				result_doc_blocks_with_autoclass.insert (std::map<long,std::set<long> >::value_type (ati.DocId, blocks));
			} else {
				map_it->second.insert (ati.Sub);
			}
		}
	}
	//итого, в result_doc_blocks_with_autoclass блоки, на которые € пропишу автокласс
	//среди них могли потер€тьс€ те, которые были найдены изначально, а потом с них подн€ли класс "наверх"
	std::map<long,std::set<long> >::const_iterator iit;
	for (iit = map_doc_blocks_with_autoclass.begin (); iit != map_doc_blocks_with_autoclass.end (); iit++) {
		long doc_id = iit->first;
		std::map<long,std::set<long> >::const_iterator org_it = result_doc_blocks_with_autoclass.find (doc_id);
		std::map<long,std::set<long> >::const_iterator with_prefix_it = map_doc_blocks_with_prefix.find (doc_id);
		for (std::set<long>::const_iterator it = iit->second.begin (); it != iit->second.end (); it++) {
			long sub = *it;
			if (with_prefix_it->second.find (sub) != with_prefix_it->second.end () && org_it->second.find (sub) == org_it->second.end ()) {
				//надо добавить этот 
				u_int64_t ref64 = ((u_int64_t)doc_id) << 32 + (u_int64_t)sub;
				std::string autoclass = map_ref_autoclass.find (ref64)->second;
				Ref ref = {doc_id, sub};
				result.find (autoclass)->second->Insert (&ref);
			}
		}
	}

	for (iit = map_doc_blocks_with_prefix.begin (); iit != map_doc_blocks_with_prefix.end (); iit++) {
		long doc_id = iit->first;
		std::map<long,std::set<long> >::const_iterator org_it = result_doc_blocks_with_autoclass.find (doc_id);
		for (std::set<long>::const_iterator it = iit->second.begin (); it != iit->second.end (); it++) {
			long sub = *it;
			if (org_it != result_doc_blocks_with_autoclass.end () && (org_it->second.find (sub) == org_it->second.end ())) {
				//если его нет в резалте, то надо поставить ему любой класс из поставленных на этот документ
				std::map<long,std::set<long> >::const_iterator with_prefix_it = map_doc_blocks_with_prefix.find (doc_id);
				for (std::set<long>::const_iterator it2 = with_prefix_it->second.begin (); it2 != with_prefix_it->second.end (); it2++) {
					if (*it2 != sub) {
						u_int64_t ref64 = ((u_int64_t)doc_id) << 32 + (u_int64_t)*it2;
						if (map_ref_autoclass.find (ref64) != map_ref_autoclass.end ()) {
							std::string autoclass = map_ref_autoclass.find (ref64)->second;
							Ref ref = {doc_id, sub};
							result.find (autoclass)->second->Insert (&ref);
							break;
						}
					}
				}
			}
		}
	}	
	*/

	printf ("writing results\n"); fflush (stdout);
	for (std::map<std::string, RefCollection*>::iterator it = result.begin (); it != result.end (); ++it) {
		RefCollection* refs = it->second;
		if (!refs || !refs->ItemCount)
			continue;
		sprintf (str_to_write, "[%s]\n", it->first.c_str ());
		fputs (str_to_write, results_file);
		for (int i = 0; i < refs->ItemCount; i++) {
			Ref ati = (*refs)[i];
			sprintf (str_to_write, "%ld.%ld ", ati.DocId-ID_BORDER, ati.Sub);
			fputs (str_to_write, results_file);
		}
		fputs("\n\n", results_file);
		fflush (results_file);
	}
	fclose (results_file);

	//вывести список тех, на которые не поставлен никакой автокласс
	printf ("Not autoclassified\n"); fflush (stdout);
	for (int i = 0; i < all_docs->ItemCount; i++) {
		long doc_id = (*all_docs) [i];
		if (autoclassed_docs.find (doc_id) == autoclassed_docs.end ())
			printf ("%ld ", doc_id - ID_BORDER);
	}

	ACE_OS::sleep (1);
	delete aBase;
	exit (EXIT_SUCCESS);
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
