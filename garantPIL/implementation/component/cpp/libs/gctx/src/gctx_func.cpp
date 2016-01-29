#include "shared/Core/fix/mpcxc.h" // GARANT_CROSSP for __stdcall
#include        "osdep.h"

#include        "base.h"
#include        "basemask.h"
#include        "collect.h"
#include        "ctxwords.h"
#include        "dociter.h"
#include        "garutils.h"
#include        "garver.h"
#include        "gctxl_ver.h"
#include        "stdbase.h"
#include 	"indices.h"
#include        "u_int64_t.CtxLongSet.SplayMap.h"

//#include        <windows.h> // GARANT_CROSSP
//#include        <getopt.h>
#include        <cstdarg>
#include        <cstdio>
#include        <cstdlib>
//#include        <sys/time.h>
#include        <sys/resource.h> // GARANT_TODO: study for replace
//#include        <unistd.h>

#include 	"ace/OS.h"

#if !defined(STD_REALLOC) || !defined(KEYS_IN_MAP)
YBase *curr_base= 0;
void * __stdcall YBase_GetDocument(long DocID){
	return curr_base->GetDoc(DocID);
}
#endif

void * __stdcall Win32LoadBinLibrary(const char *in_dll_name){
	ACE_SHLIB_HANDLE res = ACE_OS::dlopen(platform_independent_path(in_dll_name).c_str()); // GARANT_PIP
	return (res != ACE_SHLIB_INVALID_HANDLE) ? (void *)(res) : 0;
}
void * __stdcall Win32GetFuncFromBinLibrary(void *handle_lib, const char *name_Ifunc){
	return ACE_OS::dlsym(ACE_SHLIB_HANDLE(handle_lib), name_Ifunc);
}
void __stdcall Win32FreeBinLibrary(void *handle_lib)
{
	ACE_OS::dlclose(ACE_SHLIB_HANDLE(handle_lib));
}

int gctx_nmain (YBase *base, NContxtIndex *pContextIndex, DocIterator* it, std::deque<long> docs_include_header_in_text, std::map< long,std::set<std::string> >& gctx_kinds)
{
	int CurrProc= 0;
	pContextIndex->base= base;
	pContextIndex->SetNormlsBuffCount(MAX_NODES_INCACHE);

 #ifndef Not_USE_LongSetSplayNode
   #ifdef PRE_ALLOC_NODES
	u_int64_tCtxLongSetSplayNode *pAll0
					= new u_int64_tCtxLongSetSplayNode[pContextIndex->GetNormlsBuffCount()],
						*pNxtNew1= pAll0;
   #endif
	u_int64_tCtxLongSetSplayMap *pctxTextArray;
	pContextIndex->MakeN_Map(&pctxTextArray
#ifdef PRE_ALLOC_NODES
											, &pNxtNew1
#endif
														);
#endif

 #if !defined(STD_REALLOC) || !defined(KEYS_IN_MAP)
	pContextIndex->OS_GetDocument= YBase_GetDocument; 
	curr_base= base;
 #endif
	DocInfo	   local_docInfo;

	if(!pContextIndex->m_pNIdList){
	}else{ pContextIndex->OS_LocalSetProgress(0); }
	assert(it);
	IGarDoc *doc= 0;

	pContextIndex->itemsDone = 0;

 #ifdef Not_USE_LongSetSplayNode
	int PosNormlsBuffCount= 27000000;
	int bt_alloc_sz= pContextIndex->GetNormlsBuffCount(), bt_sz= 0;
	LPPL_LINE_NORMLS *ppBTree= (LPPL_LINE_NORMLS *)malloc(sizeof(LPPL_LINE_NORMLS)*bt_alloc_sz);

	LPPL_LINE_NORMLS pBTree= (LPPL_LINE_NORMLS)malloc(sizeof(PL_LINE_NORMLS)*bt_alloc_sz), pCurrVal;

	LPPL_POS_NORMLS pAllVal=  (LPPL_POS_NORMLS)malloc(sizeof(PL_POS_NORMLS)*PosNormlsBuffCount),
					pNextVal= pAllVal;

	for(RetVal= 0; RetVal < bt_alloc_sz; RetVal++){
		ppBTree[RetVal]= pBTree + RetVal;
		ppBTree[RetVal]->pFirst= 0;
		ppBTree[RetVal]->key= 0L;
	}
 #endif
	//static long preSize= 0;
	u_int64_t m_AllPatchedAndNewDocsTextSize= pContextIndex->m_AllPatchedAndNewDocsTextSize;
	if(m_AllPatchedAndNewDocsTextSize < (u_int64_t)1)
		// пусть будет от большого размера
		m_AllPatchedAndNewDocsTextSize= (u_int64_t)0xffffffff;
	pContextIndex->pindPut= pContextIndex;
	pContextIndex->SetCalcNormsFlag(&m_AllPatchedAndNewDocsTextSize);
	long  Id= 0;
	do{
		pContextIndex->in_pipeID(&Id, it, &local_docInfo);
		while(Id){
			doc= pContextIndex->addInOtherMap(Id, &local_docInfo, doc);
			pContextIndex->getParaWordFromDoc( pctxTextArray, Id, 0, 0, gctx_kinds, doc, std::binary_search (docs_include_header_in_text.begin (), docs_include_header_in_text.end (), Id));
			/*pContextIndex->itemsDone += pContextIndex->reallocMem / 64;*/
			//if( pContextIndex->maxItems != -1 ){
				if(pContextIndex->IsFlush()){
					//pContextIndex->pindPut->InitFlushStat();
					pContextIndex->pindPut->nflushIt( pctxTextArray, pContextIndex->pindPut->FindContextIndexForFlash() );
					pContextIndex->itemsDone= 0;
 				}
			//}
			pContextIndex->in_pipeID(&Id, it, &local_docInfo);
		}
	}while(pContextIndex->IsReparsingAllTexts(it, doc, pctxTextArray));
	return 0;
}
