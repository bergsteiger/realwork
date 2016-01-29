/*
 * $Id: unfull.h,v 1.1 2014/12/05 11:10:24 young Exp $
 *
 */

#ifndef __UNFULL_H
#define __UNFULL_H

#include <cstdio>
#include <cstring>
#include <fcntl.h>
#include <sys/stat.h>

#include <deque>

#include "elems.h"
#include "hendlers.h"
#include "cntxtcol.h"
#include "clcache.h"
#include "stringz.h"
#include "dhreader.h"
#include "StorableSplaySet.h"
#include "SharedData.h"
#include "adds.h"
#include "newdoc.h"
#include "SearchB.h"
#include "UpdtMorph.h"
#include "u_int32_t.caddr_t.SplayMap.h"

#define HEADER_SIZE 8

size_t	DeltaRead (void *buffer, size_t size, size_t count, FILE *stream);
static char const0[]="NFContxt.str", g_OldCntxN[]= "Context.str";

class UpdatedSearchBase : public SearchBase, public get_docs_include_header_in_text, public get_gctx_kinds {
public:
	UpdatedSearchBase(const char * name, int mode= ACE_OS_O_RDWR, 
					int key_cpages=-1, 
					int str_cpages =-1, 
					int ndt_cache = -1,
					FILE *stat_file =0 ): SearchBase(name, mode), get_docs_include_header_in_text(), get_gctx_kinds()
	{
		MorphoReadOnlyAccessForModifiedBase(this, false);
#ifdef DLT_IN_OLD_CONTEXT
	#ifdef POST_DEACTUAL_ALL_FORMS
		if(FindIndexOther(g_OldCntxN)->KeyCount)
			;// Формы из "морфо сбоку"
		else{
			FindIndexOther(const0);
		}
	#endif
#endif
	}
};

class UpdatedBase : public UpdatedSearchBase {
public:
	UpdatedBase(const char * name, int mode= ACE_OS_O_RDWR, int key_cpages=-1, int str_cpages =-1, int ndt_cache = -1, FILE *stat_file =0 );
	virtual Index* FindIndex (const char *name);
	virtual	StreamFile *make_StreamsPool(PagedFile *pFile, int bLoadFat);
	virtual	bool IsMultiThreadsR();
	virtual IGarDoc *GetGarDoc( long id, long aOwnerDoc = 0, DocInfo *local_docInfo= 0 );
	UpdatedBase* find_base_for_doc (long id);
	UpdatedBase* find_base_for_blob (long id);

protected:
	virtual Index *makeMorphoIndex( ::PagedFile * tf, const char * name, StreamFile * s);

public:
	std::map<long,char> map_doc_basechar, map_blob_basechar;
	std::vector<UpdatedBase*> bases_ptrs;
};

class	NewDoc_GU : public NewDoc_GC_GU
{
public:
	NewDoc_GU ( Base * b, long id, const char * title, revision& revDate, int packing )
		: NewDoc_GC_GU( id, b, packing )
	{
		pDoc= 0;
		if(!pInfo){
			pInfo= (DocInfo *)calloc(1, sizeof ( *pInfo ));
			strncpy ( pInfo->Title, title, sizeof(pInfo->Title) );
			pInfo->Title [sizeof(pInfo->Title)-1] = '\0';
			pInfo->Revision = revDate;
		}else
			pInfo->Revision= revDate;
	}
	Document *pDoc;
	virtual ~NewDoc_GU()
	{
		if ( docBufPos > 0 )
			FlushBlock ();

		if(!(usePacking & DS_MOJREG)){
			if(usePacking & PM_NOT_STORE_PARAINFO){
				runsStr->Seek(0);
				if(m_pRunCount)
					*m_pRunCount= runCount;
				runsStr->Write(runs,runCount*sizeof(PageRun));runsStr->Trunc();
				base->CloseAtrrStr(runsStr);
				blocksStr->Seek(0);
				if(m_pBlockCount)
					*m_pBlockCount= blockCount;
				blocksStr->Write(blocks,blockCount*sizeof(BlockRec));blocksStr->Trunc();
				base->CloseAtrrStr(blocksStr);
			}else{
				if(pDoc) {
					pDoc->FreeStructs();
					pDoc->runs= runs;
					if(m_pRunCount)
						*m_pRunCount= runCount;
					pDoc->RunCount= runCount;
					pDoc->blocks= blocks;
					if(m_pBlockCount)
						*m_pBlockCount= blockCount;
					pDoc->BlockCount= blockCount;
				}
				if(runCount)
					base->ReplaceAttr(DocId,IDD_RUNS,runs,runCount*sizeof(PageRun));
				if(blockCount)
					base->ReplaceAttr(DocId,IDD_BLOCKS,blocks,blockCount*sizeof(BlockRec));
				pDoc= 0;
			}
		}
		runCount= 0;
		blockCount= 0;

		docBuf= 0;
		runs= 0;
		blocks= 0;
	}
};

class UnFull
{
public:
	UnFull ( UpdatedBase* oldB, UpdatedBase* newB, FILE* dF1, char * pSkipDir, bool english_face, bool b_load);
	~UnFull();
#ifdef MULTI_INDEX_STREAM_FILE
	std::set<long> s_DelDocs, s_UpdDocs, s_SkpDocs, s_NewDocs;
	u_int64_t m_AllPatchedAndNewDocsTextSize;
#endif
	int Work (bool b_first_delta);

	void Reset ( FILE * pfDF1 );
	int MemFree ();
	inline void SetUseReservedFlag () {
		m_pContext -> m_usUseReserved = 1;
	}
public :
	long m_lDocId;
	UpdatedBase *m_pOldBase, *m_pNewBase, *saved_m_pNewBase;
	DocInfo *m_pOldInfo, *m_pNewInfo;

	std::set<std::string> old_kinds_set, new_kinds_set;

	std::map<long,std::string> old_map_id_str;
	std::set<long> to_delete_keys;
	std::map<std::string,long> map_key_id;
	std::map<std::string,long> new_map_key_id;

	StorableSplaySet<short> m_presentSegments;
protected:
	int IsSkipDocName(long lDocId, int iDoIt);
#ifdef QUICK_NEW_DOC
	// для быстрого чтения текста документа //
	Document *pTmpDoc;
	#if defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
		int ReplaceInfo;
	#endif
#endif
	StorableSplaySet<short> m_oldbases;
	StorableSplaySet<short> m_newbases;
	
	ClassCache* m_pClassCache;
	ClassCache* m_pAdoptedCache;
	StringZ* m_pOldClass;
	StringZ* m_pNewClass;
	ContextCollection* m_pContext;

	revision m_aDocRevision;
	SplayMap<long, SplaySet<short> > m_mapDelDocs;

	struct CorDelta {
		SplaySet<Ref> delCor;
		SplaySet<Ref> addCor;
		SplaySet<CorrRef> delNCor;
		SplaySet<CorrRef> addNCor;
	};
	SplayMap<long, CorDelta> m_mapCorrs;
	SplayMap<SString, SMem> m_mapSavedDocKind;
	
	short* m_pDeltaSegments;
	short m_siDeltaSegmentsCount;
	//BaseInfo* m_pBaseInfoDelta;
	BaseInfoMap m_mapBaseInfo;
	char* m_pAttrMask;
	int m_iLevelCount;
	
	enum DSModify {
		dsmStayNodoc,
		dsmStayDoc,
		dsmChgToNodoc,
		dsmChgToDoc,
		dsmStayEdition,
		dsmChgToEdition
	} m_dsm;

	int m_iFullReIndexDocName, m_iReIndexDocName;
	int m_iDeSync;

protected:
	int PrepareDeltaRestoring ();
	int DocRestore ();
	void RestoreNewDoc ();
	void RestoreChgDoc ();
	int RestoreAttr ();
	void TagAttrRestore ( long lDocId, int iTag, const char *log_str = 0);
	int RestoreRefInd (long lDocId);
	
	int FullDelDoc ();
	int DelIndByAttr ( int iTag, long lDocId );
					
	void CorrectPairIndex ( StringZ*, StringZ*, StringZ*, StringZ*, int );
	void FillClassCache ( StringZ* classz, StringZ* prefixz, int c_or_p, int d_or_a, int tag );
	void CollectBaseInfo ( DocInfo*, DocInfo*, SplaySet<short> );

	int AddStrIndex ( int iTag, const char * pKeyStr, long lDocId );
#ifdef	BLOCKSINHERIT
	int DelStrIndex ( int iTag, const char * pKeyStr, long lDocId, int iDelLevel, StringZ* pKeys = 0, StringZ* pDelKeys = 0 );
#else
	int DelStrIndex ( int iTag, const char * pKeyStr, long lDocId, int iDelLevel, StringZ* pKeys = 0 );
#endif

	void ReadMaskLevels ();
	Index* SelectIndex ( int iTag );	
	int SetBaseRevision ( int n, revision aNewRev );

	int AddStreamDoc ( Index* pInd, const void* vpKey, long lDocId, short tag );
	int DelStreamDoc ( Index* pInd, const void* vpKey, long lDocId, short tag, int keepKey = 0 );
	int AddStreamRef ( Index* pInd, const void* vpKey, Ref aRef, short tag );
	int DelStreamRef ( Index* pInd, const void* vpKey, Ref aRef, short tag, int keepKey = 0, bool aAddRef = false );

	int AddSegmentDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddStatusDoc ( Index* pInd, const void* vpKey, long lDocId );
	int DelSegmentDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelStatusDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );

	int AddAdoptedDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddTerritoryDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddPhGroupDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddPhEffectDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddAtcDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddPublishedInDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddCategoryDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddNumberDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddRCodeDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddAnnoKindDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddAnnoInterestDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddAnnoTaxDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddAnnoOrganizationDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddAnnoUserDoc ( Index* pInd, const void* vpKey, long lDocId );
	int AddClassRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddTypeRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddKWRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddKindRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddClass6Ref ( Index* pInd, const void* vpKey, Ref aRef );
	int AddDocKindRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddActiveRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddMkbRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddChapterRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddRegStatusRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddLekFormRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddPhFirmRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddPhCountryRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddRegDateRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddAnnulDateRef ( Index* pInd, const void* vpKey, Ref aRef );
	int AddStatusExRef ( Index* pInd, const void* vpKey, Ref aRef );

	int DelAdoptedDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelTerritoryDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelPhGroupDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelPhEffectDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelAtcDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelPublishedInDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelCategoryDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelNumberDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelRCodeDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelAnnoKindDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelAnnoInterestDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelAnnoTaxDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelAnnoOrganizationDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelAnnoUserDoc ( Index* pInd, const void* vpKey, long lDocId, int keepKey = 0 );
	int DelClassRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelTypeRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelKWRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelKindRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelClass6Ref ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelDocKindRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelActiveRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelMkbRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelChapterRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelRegStatusRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelLekFormRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelPhFirmRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelPhCountryRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelRegDateRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelAnnulDateRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );
	int DelStatusExRef ( Index* pInd, const void* vpKey, Ref aRef, int keepKey = 0, bool aAddRef = false );

	int add_class_type_dockind_ref (Index*, char*, Ref, std::map<std::string, std::deque<Ref> >*);
	int add_segment_status_doc (Index*, short, long, std::map<short,DocCollection*>*);
	int add_adopted_territory_doc (Index*, char*, long, std::map<std::string, std::deque<long> >*);
	int add_regannuldate_ref (Index*, date, Ref, std::map<long, std::deque<Ref> >*);
	int add_statusex_ref (Index*, long, Ref, std::map<long, std::deque<Ref> >*);
	int add_date_doc (Index*, date, long, std::map<long, std::deque<long> >*);
	int del_segment_status_doc (Index*, short, long, std::map<short,DocCollection*>*);
	int del_adopted_territory_doc (Index*, char*, long, std::map<std::string, std::deque<long> >*);
	int del_class_type_dockind_ref (Index*, char*, Ref, std::map<std::string, std::deque<Ref> >*, bool add_ref);
	int del_regannuldate_ref (Index*, date, Ref, std::map<long, std::deque<Ref> >*, bool add_ref);
	int del_statusex_ref (Index*, long, Ref, std::map<long, std::deque<Ref> >*, bool add_ref);
	int del_date_doc (Index*, date, long, std::map<long,std::deque<long> >*);

	void	add_subname (Ref ref, char* name, int length);
	void	del_subname (Ref ref);

	void	RestoreSyns( char* key );
	void	RestoreCVar ();
	void	RestoreMorphoHashes ();
	void	RestoreReleFLaws ();
	void	RestoreTypingErrors ();
	void	RestoreGoodWords ();
	void	RestoreKindCorr (bool b_first_delta);
	void	RestoreSearchCache ();

	void	flush_class_type_dockind (Index*, std::map<std::string, std::deque<Ref> >*, bool, std::vector<std::string>*);
	void	flush_segment_status (Index*, std::map<short, DocCollection*>*);
	void	flush_adopted_territory (Index*, std::map<std::string, std::deque<long> >*, std::vector<std::string>*);
	void	flush_reganunldate (Index*, std::map<long, std::deque<Ref> >*, std::vector<long>*);
	void	flush_statusex (Index*, std::map<long, std::deque<Ref> >*, std::vector<long>*);
	void	flush_date (Index*, std::map<long, std::deque<long> >*, std::vector<long>*);

public:
	bool	b_english_face;
	void	flush_caches (bool b_delete = true);
	void	delete_deleted_docs ();

	bool	b_newdoc;
	void	**m_pTempDocGlobalBuff;

	void	read_corrs (long);
	void	restore_corrs ();
	void	delete_all ();

	long	pos_of_correspondents;
	FILE*	m_DFile1;

private:
	bool	b_cvarupdated;
	AttrIndex   * docInd;
	AttrIndex   * docInd2;

public:
	NewDoc_GU *make_GU_Doc(const char *, int, std::set<long> *);
	NewDoc_GU* pNewDocN;
	void lastDocFlush();
	std::deque<long> docs_include_header_in_text;
	std::map<long, std::set<std::string> > kinds;

private:
	std::map<long,std::string> addsubnames;

	u_int32_tcaddr_tSplayMap *respCache;
};

struct ParaHeader
{
	char cStyle;    //= ParaStyle ( pPara );
	short sTStart;  // = HeaderSize ( pPara );
	char cLMargin;  // = LeftMargin ( pPara );
	char cRMargin;  // = RightMargin ( pPara );
	char cRedLine;  // = RedLine ( pPara );
};

void UpdateBaseInfo ( BaseInfo& info, DocInfo* olddi, DocInfo* newdi );
char* RestoreParaHeader ( char* pPara, ParaHeader aHeader, char cRestoreMask );


#endif

