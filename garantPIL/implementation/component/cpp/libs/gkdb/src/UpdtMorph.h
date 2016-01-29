#ifndef __UpdtMorph_H
#define __UpdtMorph_H
#include "../../mrglib/src/gdbapi.h"
#include "stdbase.h"
#include "../../gctx/src/u_int64_t.CtxLongSet.SplayMap.h"

class u_intPointerV_tCtxLongSetSplayMap : public u_int64_tCtxLongSetSplayMap
{
public:
  u_intPointerV_tCtxLongSetSplayMap(CtxLongSet& dflt,
								u_int64_tCtxLongSetSplayNode **pp_ForNew= 0)
								: u_int64_tCtxLongSetSplayMap(dflt, pp_ForNew) {}
  int comp_items(void *pFirst, void*pSecond){
	return u_int64_tCMP((*(size_t*)pFirst), (*(size_t*)pSecond));
  }
  void SetItemInNode(void *pOldItem, void *pNewItem){
	*(size_t*)pOldItem= *(size_t*)pNewItem;
  }
};

extern "C" void copyKeysZZZ(void *, void *);
extern "C" fat_rec_type *load_fat(streamfile_st *pfile);
extern "C" void init_streams_cache(streamfile_st *pfile, u_int32_t mode);
extern "C" int __cdecl truncation_NContxt_stream(	struct SET_ST_TAG*,struct tag_index*,
												struct tag_iterator*,struct tag_stream*,
												struct tag_stream*);

class u_intFormOld_tCtxLongSetSplayMap : public u_int64_tCtxLongSetSplayMap
{
public:
  u_intFormOld_tCtxLongSetSplayMap(CtxLongSet& dflt,
								u_int64_tCtxLongSetSplayNode **pp_ForNew= 0)
								: u_int64_tCtxLongSetSplayMap(dflt, pp_ForNew) {}
  int comp_items(void *pFirst, void*pSecond){
	return strncmp((const char*)pFirst, (const char*)pSecond, 31);
  }
  void SetItemInNode(void *pOldItem, void *pNewItem){
	copyKeysZZZ(pOldItem, pNewItem);
  }
};

extern NContxtIndex *pNIndexReRead;
extern char name_temp_flush_handle[1024];
extern stref_st *pref00;

class u_intFrm_tCtxLongSetSplayMap : public u_int64_tCtxLongSetSplayMap
{
public:
  u_intFrm_tCtxLongSetSplayMap(CtxLongSet& dflt,
								u_int64_tCtxLongSetSplayNode **pp_ForNew= 0)
								: u_int64_tCtxLongSetSplayMap(dflt, pp_ForNew) {}
  int comp_items(void *pFirst, void*pSecond){
	return (*(unsigned char*)pFirst <= *(unsigned char*)pSecond)? ((*(unsigned char*)pFirst == *(unsigned char*)pSecond)? 0 : -1) : 1;
  }
  void SetItemInNode(void *pOldItem, void *pNewItem){
	*(unsigned char*)pOldItem= *(unsigned char*)pNewItem;
  }
};

extern void ReParse_Stream(	u_int64_tCtxLongSetSplayMap *pIndxs,
							NContxtIndex *pNIndx, stream_st *pstr, u_intPointerV_tCtxLongSetSplayMap *ptmpA,
							int lookOlForms, long *pNewVal, u_intFrm_tCtxLongSetSplayMap *ptmpF, char **ppN,
							int WithOldNumbers, int CompOk);

extern u_int32_t max_size00;

extern base_st *makeBaseForCopy(Base *base, base_st& thisBase, PagedFile *file, StreamFile * streams,
						 long *m_pNIdList, long Root, char *Name, char* pName, void **pp_UpdThdr,
	char **p_gs_target_name, index_st **p_pin, iter_st **p_spit, stream_st **p_pdstr);

extern int compare_iter_st_long( const void *, const void * );

extern "C" char *GetBasedExtFileName( char *, int );

extern void	f_found_docs_include_header_in_text (YBase *pBase, std::set<long> &docs_include_header_in_text);

class	UpdtContextIndex : public NWContxtIndex
{
public:
	YBase *pFirst;
	int NormalFromPointer;
	UpdtContextIndex(PagedFile*f, const char*n, StreamFile*s,
									unsigned NormlsBuffCount= MAX_NODES_INCACHE, IndexInfo *pinfo= 0 )
					: NWContxtIndex(f, n, s, NormlsBuffCount, pinfo )
	{
		m_pNIdDelList= (long*)malloc(sizeof(*m_pNIdDelList));
		m_pNIdDelList[0]= 0x7ffffffc;
		m_sNIdDelList= 1;
		NormalFromPointer= 1;
		InitFileNameTempFiles();
	}
	virtual void SetFormsData(u_int64_tCtxLongSetSplayMap *ptmpA, char *key_buff, void*pIN, void*pDSTR);
	virtual void getParaWordFromDoc (u_int64_tCtxLongSetSplayMap *p_ctxTextArray, long Id, long LastPara, long LastWordPos, std::map< long,std::set<std::string> >& kinds, IGarDoc *pdoc= 0, bool include_name_in_text = false);
	virtual bool IsReparsingAllTexts(DocIterator *it, IGarDoc *doc= 0, u_int64_tCtxLongSetSplayMap	*pMap= 0);
	virtual NContxtIndex * FindContextIndexForFlash();
	virtual void InitTempFiles();
	virtual void exit(int _Code, char *name= 0){
		::exit(_Code);
	}
protected:
	virtual bool IsReaderFlush(){
		return (itemsDone != 0);
	}
};

class	get_gctx_kinds
{
public:
	get_gctx_kinds () {}
	~get_gctx_kinds () {}
	void	fill_kindsset (YBase *pBase, std::map <long,std::set<std::string> >& gctx_kinds){//GARFB2 templates must not edn with >> but > >
		gctx_kinds.clear ();

		std::set<std::string> names_to_gctx;
		Stream* str = pBase->FindIndex ("Aux")->Open (AUX_KIND_BLOCK);
		if (str) {
			long length = str->Length ();
			char *kinds = new char [length], *ptr = kinds;
			str->Read (kinds, length);
			pBase->FindIndex ("Aux")->Close (str);
			while (ptr - kinds < length) {
				names_to_gctx.insert (ptr);
				ptr += strlen (ptr) + 1;
			}
			delete []kinds;
		}
		gctx_kinds.insert (std::map< long,std::set<std::string> >::value_type (0,names_to_gctx));

		std::set<std::string> kinds_to_gctx;
		str = pBase->FindIndex ("Aux")->Open (AUX_KIND_GCTX);
		if (str) {
			long length = str->Length ();
			char *kinds = new char [length], *ptr = kinds;
			str->Read (kinds, length);
			pBase->FindIndex ("Aux")->Close (str);
			while (ptr - kinds < length) {
				kinds_to_gctx.insert (ptr);
				ptr += strlen (ptr) + 1;
			}
			delete []kinds;
		}
		gctx_kinds.insert (std::map< long,std::set<std::string> >::value_type (1,kinds_to_gctx));
	}
};

class get_docs_include_header_in_text
{
public:
	get_docs_include_header_in_text()
	{
	}
	~get_docs_include_header_in_text()
	{
	}
	void	fill_set(YBase *pBase, std::deque<long> &docs_include_header_in_text){
		long comm_id = 0, letter_id = 0;
		Index* types = pBase->FindIndex ("Type");
		DocCollection letters;
		BTIterator *it;

		for ( it = new BTIterator (types); !it->End (); ++(*it)) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it->Key ();
			if (key->level == 0 && !strcmp (key->text+4, "Комментарии")) {
				comm_id = key->id;
				if (letters.ItemCount)
					break;
			} else if (key->level == 0 && !strcmp (key->text+4, "Письмо")) {
				Stream *str = types->Index::OpenN (key, 0);
				if (str) {
					letters.FastLoadRefs (str);
					types->Close (str);
				}
				if (comm_id)
					break;
			}
		}
		delete it;
		if (comm_id) {
			for (it = new BTIterator (types); !it->End (); ++(*it)) {
				HIndex::HIndexKey* key = (HIndex::HIndexKey*) it->Key ();
				char* keyname = key->text+4;
				if (key->level == 1 && key->parent == comm_id && (!strcmp (keyname, "Статья") || !strcmp (keyname, "Энциклопедия") || !strcmp (keyname, "Книга") || !strcmp (keyname, "Вопрос-ответ") || !strcmp (keyname, "Бератор"))) {
					Stream *str = types->Index::OpenN (key, 0);
					if (str) {
						RefCollection refs;
						refs.Get (str);
						types->Close (str);
						for (int i = 0; i < refs.ItemCount; i++) {
							Ref at_i = refs[i];
							if (at_i.Sub == 0)
								docs_include_header_in_text.push_back (at_i.DocId);
						}
					}
				}
			}
			delete it;
		}

		HIndex* index = (HIndex*) pBase->FindIndex ("Adopted");
		DocCollection adopteds;
		char full_key [2048];
		for (it = new BTIterator (index); !it->End (); ++(*it)) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) it->Key ();
			if (0 == key->level)
				continue;
			else if (1 == key->level) {
				index->FullName (key, full_key);
				if (compare_hstr (full_key, "Федеральные министерства и ведомства\\Минфин России (Министерство финансов РФ)")) {
					Stream* str = index->Index::OpenN (it->Key (), 0);
					if (str) {
						adopteds.Get (str);
						index->Close (str);
					}
					break;
				}
			} else {
				break;
			}
		}
		delete it;
		letters.Intersect (adopteds);
		for (int i = 0; i < letters.ItemCount; i++)
			docs_include_header_in_text.push_back (letters [i]);
		std::sort (docs_include_header_in_text.begin (), docs_include_header_in_text.end ());
		docs_include_header_in_text.erase (std::unique (docs_include_header_in_text.begin (), docs_include_header_in_text.end ()), docs_include_header_in_text.end ());

	}
protected:
	bool	compare_hstr (char* index_str, const char* user_str){
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
			if (token)
				*(token-1) = '\\';
		}
		return !strcmp (shrinked_str, user_str);
	}
};
#endif
