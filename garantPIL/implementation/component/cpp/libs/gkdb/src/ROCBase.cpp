#include "shared/Core/fix/mpcxc.h"

#include "ROCBase.h"
#include "BaseCache.h"

static StreamFileFats *pAllFats= 0;
static Core::Mutex g_mutex_cacheFats;

extern "C" int my_def_ace_seek(int, void *, int, int, int);

CacheFats::~CacheFats () {
	delete m_pAllFats;
}

extern void gkdb_read_Fat(PagedFile *, StreamFile *);

class StreamFileRO : public StreamFile
{
protected:
	virtual int Get_SF_FAT_OD(void *, int)
	{
		return 0;
	}
public:
	StreamFileRO(PagedFile *pFile, int bLoadFat) : StreamFile(pFile, bLoadFat)
	{
	}
	virtual void LoadFat       (PagedFile *otherLine= 0)
	{
		AllocSysBuf();

		if ( !file -> GetAttr ( "FatSize", &fatPages, sizeof ( short ) ) )
			fatPages = 1;

		GUARD (g_mutex_cacheFats);
		G_Point	fnd= pAllFats->seek(gcl_FullFileName(file->FileName));
		if(fnd){
			Fat = pAllFats->contents(fnd).pFAT;
			if(file->IsPacked()){
				free(file->pageOffs);
				file->pageOffs= (unsigned int*)(pAllFats->contents(fnd).pPackOffs);
			}
			file->free_postFileNames();
		}else if(otherLine){ // Теперь FAT грузим только из файла data.0ey //
			if(file->IsPacked()){
				Fat = (int gk_huge *)realloc(Fat,((size_t)((*(unsigned short*)&fatPages) & 0xffff)) * file->PageSize + (file->m_PackArraySize + sizeof(ACE_UINT64)));
				pAllFats->get(gcl_FullFileName(file->FileName)).pPackOffs= (Fat+(((long)fatPages*file->PageSize)/sizeof(int)));
				memcpy(Fat+((((size_t)((*(unsigned short*)&fatPages) & 0xffff)) * file->PageSize)/sizeof(int)), file->pageOffs, file->m_PackArraySize);
				free(file->pageOffs);
				file->pageOffs= (unsigned int*)(pAllFats->get(gcl_FullFileName(file->FileName)).pPackOffs);
			}else{
				Fat = (int gk_huge *)realloc(Fat,((size_t)((*(unsigned short*)&fatPages) & 0xffff)) * file->PageSize);
			}
			gkdb_read_Fat(otherLine, this);
			pAllFats->get(gcl_FullFileName(file->FileName)).pFAT= Fat;
			IndexMoveNames();
		}
		if(pFirst && pFirst->file->m_readed.cur_Seek != my_def_ace_seek){
			void *pTmpBuff= alloca(pFirst->file->PageSize);
			if(!pFirst->file->PagedFile::GetPage(1, pTmpBuff))
				NdtClone::Error();
		}else if(file->m_readed.cur_Seek != my_def_ace_seek){
			file->skip_c_rtl_handle();
		}
	}
	void moveNames(PagedFile *pIn, LPPL_BASE_FILE_LIST *ppLst){
		(*ppLst)->pFileName= strdup(pIn->FileName);
		(*ppLst)->pNext= malloc(sizeof(PL_BASE_FILE_LIST));
		LPPL_BASE_FILE_LIST *ppNxt= (LPPL_BASE_FILE_LIST *)&((*ppLst)->pNext);
		char **ppN= pIn->m_postFileNames;
		do{
			(*ppNxt)->pNext= 0;
			pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt= ppNxt;
		}while(*ppN && ((*ppNxt)-> pFileName= *ppN) && !(*ppN++= 0) && ((*ppNxt)->pNext= malloc(sizeof(PL_BASE_FILE_LIST))) && (ppNxt= ((LPPL_BASE_FILE_LIST *)&((*ppNxt)->pNext))));
	}
	LPPL_BASE_FILE_LIST *m_LastAdd;
	void IndexMoveNames()
	{
		pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt= m_LastAdd;
		moveNames(pFirst->file, m_LastAdd);
		moveNames(file, pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt);
	}
};

StreamFile *BaseRO_Ex::make_StreamsPool(PagedFile *pFile, int bLoadFat){
	return new StreamFileRO(strFile, 0);
}

Core::Var <CacheFats> BaseRO_Ex::s_shared_cacheFats;
extern "C" void pl_OpenBase (LPPF_PARAM pKey, LPPF_PARAM pStr, char** keyTag, char** strTag, char** ndtTag);

void BaseRO_Ex::openAllInKey()
{
		FindIndex("Adopted");
		FindIndex("PhGroup");
		FindIndex("PhEffect");
		FindIndex("Mkb");
		FindIndex("Chapter");
		FindIndex("Territory");
		FindIndex("ServiceInfo");
		FindIndex("Atc");
		FindIndex("RegStatus");
		FindIndex("LekForm");
		FindIndex("PhFirm");
		FindIndex("PhCountry");
		FindIndex("Type");
		FindIndex("RegDate");
		FindIndex("AnnulDate");
		FindIndex("Active");
		FindIndex("Date");
		FindIndex("Status");
		FindIndex("Status_ex");
		FindIndex("KeyWord");
		FindIndex("RCode");
		FindIndex("Respondent");
		FindIndex("Correspondent");
		FindIndex("RDate");
		FindIndex("VIncluded");
		FindIndex("VChanged");
		FindIndex("VAbolished");
		FindIndex("Class");
		FindIndex("DocKind");
		FindIndex("Kind");
		FindIndex("SortDate");
		FindIndex("VAnonced");
		FindIndex("VLControl");
		FindIndex("Category");
		FindIndex("TradeName");
		FindIndex("IntName");
		FindIndex("PublishedIn");
		FindIndex("Segment");
		FindIndex("Blob");
		FindIndex("Control");
		FindIndex("Class6");
		FindIndex("NewCorr");
		FindIndex("Attribs");
		FindIndex("AnnoUser");
		FindIndex("AnnoOrganization");
		FindIndex("AnnoTax");
		FindIndex("AnnoInterest");
		FindIndex("AnnoKind");
		FindIndex("AnnoDate");
		FindIndex("KindCorr");
}

void BaseRO_Ex::FindAttrsIndexWithFAT(Index *pAx, const long PreLastPage)
{
	FindIndexWithFAT(pAx, m_AttrsName, PreLastPage);
	if(!docInd) {
		delete textFile;
		textFile= 0;
		throw std::exception ();
	}else{
		char newI0[]= "CalIn.str", newI1[]= "CalAb.str", newI2[]= "CalCh.str", buffT;
		if((pOtherNextIndex-1)->pKey->GetAttr(m_TagName,&buffT,1)){
			YBase::FindIndexOther(m_TagName,this->pOtherNextIndex-1);
		}else{
			// когда индекс TagName станет обязательным для хедового формата базы, то раскоментарить return
			// return false;
		}
		YBase::FindIndexOther(newI0,this->pOtherNextIndex-1);
		YBase::FindIndexOther(newI1,this->pOtherNextIndex-1);
		YBase::FindIndexOther(newI2,this->pOtherNextIndex-1);
	}
	subNames= (RefIndex*)FindIndex ( m_SubNamesName );
}

void BaseRO_Ex::makeCacheThreads()
{
	if(!curr_mode && !m_makeCacheThreads){
		int make_mode= 0;
		if(m_mmode < 0){
			if (!s_shared_cacheFats) {
				// если КЕШ пустой - заполняем его
				s_shared_cacheFats = new CacheFats;
				pAllFats= s_shared_cacheFats->m_pAllFats;
				make_mode= 1;
			}else{
				// иначе просто увеличиваем счетчик ссылок
				s_shared_cacheFats.addref();
				if(!((pAllFats= s_shared_cacheFats->m_pAllFats)->seek(gcl_FullFileName(strFile->FileName))))
				{
					make_mode= 1;
				}
			}
		}else{
			make_mode= m_mmode;
		}
		Index *pAx;
		if(!(pAx= FindIndex ( m_AuxName ))) {
			delete textFile;
			textFile= 0;
			throw std::exception ();
		}
		if(!pAx->streams->Fat || !(pAx->streams->Fat[1] & FAT_CHAIN)){
			// ручная прогрузка всего FAT-а, прогружженного частично по-требованию //
			G_Point fnd= pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName));
			if(fnd){
				pAx->streams->Fat = pAllFats->contents(fnd).pFAT;
				if(pAx->streams->file->IsPacked()){
					free(pAx->streams->file->pageOffs);
					pAx->streams->file->pageOffs= (unsigned int*)(pAllFats->contents(fnd).pPackOffs);
				}
			}else
				correct_Old_Aux_FAT(pAx, &make_mode);
		}
		long PreLastPage= get_ID_FATS_IN_AUX(pAx,make_mode);
		FindAttrsIndexWithFAT(pAx, PreLastPage);
		if(docInd->file->IsPacked()){
			if(make_mode){
				s_shared_cacheFats->pPackOffs2= docInd->file->pageOffs;
			}else{
				free(docInd->file->pageOffs);
				docInd->file->pageOffs= (pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName)))).pPackOffs2;
			}
		}
		Index *fnd= 0;
		if(is_morpho_exist()){
			fnd= FindIndexWithFAT(pAx, "Context.str", PreLastPage);
			if(fnd->file->IsPacked()){
				if(make_mode){
					s_shared_cacheFats->pPackOffs3= fnd->file->pageOffs;
				}else{
					free(fnd->file->pageOffs);
					fnd->file->pageOffs= (pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName)))).pPackOffs3;
				}
			}
			actualMorpho(	&fnd, PreLastPage, make_mode, pAx );
			openAllInKey();
		}else{
			throw std::exception ();
		}
		currentBlockSize = ADD_BLOCK_SIZE;
		if(make_mode){
			LPPL_BASE_FILE_LIST pFreePreAlloc= (LPPL_BASE_FILE_LIST)(s_shared_cacheFats->m_pList), pNxtAlloc= (LPPL_BASE_FILE_LIST)(pFreePreAlloc->pNext);
			do{
				if(pNxtAlloc->pNext == 0) pFreePreAlloc->pNext= 0;
				pFreePreAlloc= pNxtAlloc;
			}while((pNxtAlloc= (LPPL_BASE_FILE_LIST)(pNxtAlloc->pNext)));
			free(pFreePreAlloc);
			G_Point fnd= pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName));
			if(fnd){
				PagedFileBuffsNew *pAuxNode= &(pAllFats->contents(fnd));
				pAuxNode->pPackOffs0= s_shared_cacheFats->pPackOffs0;
				pAuxNode->pPackOffs1= s_shared_cacheFats->pPackOffs1;
				pAuxNode->pPackOffs2= s_shared_cacheFats->pPackOffs2;
				pAuxNode->pPackOffs3= s_shared_cacheFats->pPackOffs3;
				pAuxNode->pPackOffs4= s_shared_cacheFats->pPackOffs4;
				pAuxNode->pPackOffs5= s_shared_cacheFats->pPackOffs5;
				s_shared_cacheFats->pPackOffs0=s_shared_cacheFats->pPackOffs1=s_shared_cacheFats->pPackOffs2=s_shared_cacheFats->pPackOffs3
					=s_shared_cacheFats->pPackOffs4=s_shared_cacheFats->pPackOffs5= 0;
				pAuxNode->m_pList= s_shared_cacheFats->m_pList;s_shared_cacheFats->m_pList= 0;
			}else{
				throw std::exception ();
			}
		}
		{
			m_not_dynamic_load_index= true;
		}
		m_makeCacheThreads= true;
	}
}

#include "ncpf.h"
extern "C" void impModifyName(char *);

BaseRO_Ex::BaseRO_Ex (const char* name, int m, const std::vector<std::string> &indxs)
						: m_mmode(-1), simple_TextFile(0), m_makeCacheThreads(false), SearchBase (name, m)
{
	if (m & ~0x20000000) {
		throw std::exception ();
	}
	if (!m) {
		textFile->skip_c_rtl_handle();
		return;
	}
	// m == 0x20000000
	char buf [1024];
	int lnNm= strlen(name);
	memcpy(buf,name,lnNm+1);
	GUARD (g_mutex_cacheFats);
	m_mmode= 0;
	bool make_mode= false;
	if (!s_shared_cacheFats) {
		m_mmode= 1;
	}else{
		// иначе просто увеличиваем счетчик ссылок
		s_shared_cacheFats.addref();
		{
			ForceExt (buf, GB_STR_EXT);
			pAllFats= s_shared_cacheFats->m_pAllFats;
			m_mmode = pAllFats->seek (gcl_FullFileName (buf)) ? 0 : 1;
			make_mode= indxs.size() < 1;
			if(!m_mmode && !make_mode){
				buf[lnNm]= 0;
				int make_mask= 0, make_key_count= 0;
				for (std::vector<std::string>::const_iterator name_it = indxs.begin (); name_it != indxs.end (); name_it++){
					if(*name_it == std::string("Aux")){
						make_mask |= 0x01;
					}else if(	*name_it == std::string("Attrs")){
						if(indxs.size() == 1){
							(simple_TextFile= textFile= new NCPagedFile (ForceExt (buf, GB_NDT_EXT), 0, 128))->m_readed.currentDisk= 0;
							keyFile= textFile;
							keyFile->free_postFileNames();
							simple_TextFile->skip_c_rtl_handle();
							if(!(docInd= (AttrIndex	*)FindIndex(m_AttrsName))) {
								delete textFile;
								textFile= 0;
								throw std::exception ();
							}
							docInd->file->free_postFileNames();
							m_not_dynamic_load_index= true;
							hack_add_ref();
							return;
						}
						make_mask |= 0x02;
					}else if(	*name_it == std::string("Tag")
								|| *name_it == std::string("CalIn")
								|| *name_it == std::string("SubName")
								|| *name_it == std::string("CalAb")
								|| *name_it == std::string("CalCh")
							){
						make_mask |= 0x04;
					}else
						make_key_count++;
				}
				if(make_key_count > 0){
					(textFile  = new NCPagedFile (ForceExt (buf, GB_NDT_EXT), 0, 128))->m_readed.currentDisk= 0;
					reConnectKeyAndStr (name, 0);
					pl_OpenBase(	&keyFile->m_readed, &strFile->m_readed,
									&keyFile->m_pCryptoTag, &strFile->m_pCryptoTag,
									&textFile->m_pCryptoTag);
					textFile->free_postFileNames();
					textFile->skip_c_rtl_handle();
					FindIndexWithFAT(0, m_NumberName, 0);
					openAllInKey();
				}else{
					(keyFile= new PagedFile (ForceExt (buf, "0ey"), 0))->m_readed.currentDisk= 0;
					(simple_TextFile= textFile= keyFile)->skip_c_rtl_handle();
				}
				if(make_mask & 0x2 || make_mask & 0x4){
					/*if(!(make_mask & 0x02)){
						char *ppRet_1ey_IndexName= (char*)m_SubNamesName;
					}*/
					FindAttrsIndexWithFAT();
				}
				if(make_mask & 0x1){
					FindIndex(m_AuxName);
				}
				hack_add_ref();
				m_not_dynamic_load_index= true;
				if(make_key_count < 1){
					keyFile= 0;
				}
			}
		}
	}
	if(m_mmode || make_mode){
		(textFile= new NCPagedFile (ForceExt (buf, GB_NDT_EXT), 0, 128))->m_readed.currentDisk= 0;
		if(textFile){
			if(textFile->IsOk()){
				reConnectKeyAndStr (name, 0);
				if(IsOk()){
					// если КЕШ пустой - заполняем его
					if(!s_shared_cacheFats){
						s_shared_cacheFats = new CacheFats;
						pAllFats= s_shared_cacheFats->m_pAllFats;
					}
					pl_OpenBase(	&keyFile->m_readed, &strFile->m_readed,
									&keyFile->m_pCryptoTag, &strFile->m_pCryptoTag,
									&textFile->m_pCryptoTag);
					textFile->skip_c_rtl_handle();
					makeCacheThreads();
				}
			}else{
				delete textFile; 
				textFile= 0;
			}
		}
	}
}

void BaseRO_Ex::hack_add_ref()
{
	*((char*)(strrchr(indTable[0]->streams->file->FileName, '.')+1))= '9';
	(pAllFats->contents(pAllFats->seek(gcl_FullFileName(indTable[0]->streams->file->FileName)))).m_cntCln++;
	if(simple_TextFile){
		keyFile= 0;
	}
}

void correct_Old_FAT(Index *pAx) {
	pAx->streams->AllocFAT();
	pAx->streams->LoadFatEx (-1, true);
	pAx->streams->m_deletedFat= 0;
	if(pAx->streams->file->IsPacked()){
		pAx->streams->Fat = (int gk_huge *)realloc(	pAx->streams->Fat
													,  ((size_t)((*(unsigned short*)&pAx->streams->fatPages) & 0xffff))*pAx->streams->file->PageSize
															+ pAx->streams->file->m_PackArraySize + sizeof(ACE_UINT64)	) ;
		memcpy(	pAllFats->get(gcl_FullFileName(pAx->streams->file->FileName)).pPackOffs
								= pAx->streams->Fat+((((size_t)((*(unsigned short*)&pAx->streams->fatPages) & 0xffff))*pAx->streams->file->PageSize)/sizeof(int))
				, pAx->streams->file->pageOffs, pAx->streams->file->m_PackArraySize);
		free(pAx->streams->file->pageOffs);
		pAx->streams->file->pageOffs= (unsigned int*)(pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).pPackOffs);
	}else if(!pAx->streams->Fat){
		pAx->streams->Fat = (int gk_huge *)malloc(((size_t)((*(unsigned short*)&pAx->streams->fatPages) & 0xffff))*pAx->streams->file->PageSize);
	}
	assert( pAx->streams->Fat );
	pAllFats->get(gcl_FullFileName(pAx->streams->file->FileName)).pFAT= pAx->streams->Fat;
}

void BaseRO_Ex::getNumberIndex(Index *pAx, int make_mode, long PreLastPage)
{
	if(pAx->file->IsPacked()){
		if(make_mode){
			s_shared_cacheFats->pPackOffs0= pAx->file->pageOffs;
		}else{
			free(pAx->file->pageOffs);
			pAx->file->pageOffs= (pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName)))).pPackOffs0;

		}
	}
	if(make_mode){
		s_shared_cacheFats->m_pList= (LPPL_BASE_FILE_LIST)malloc(sizeof(PL_BASE_FILE_LIST));
		((StreamFileRO*)(pAx->streams))->moveNames(textFile, &(s_shared_cacheFats->m_pList));
		((StreamFileRO*)(pAx->streams))->moveNames(pAx->file, pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt);
		((StreamFileRO*)(pAx->streams))->moveNames(pAx->streams->file, pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt);
		((StreamFileRO*)(pAx->streams))->m_LastAdd= pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt;
	}else{
		textFile->free_postFileNames();
		pAx->file->free_postFileNames();
	}
	Index *fnd;
	if(!(fnd= FindIndexWithFAT(pAx, m_NumberName, PreLastPage))) {
		delete textFile;
		textFile= 0;
	}else if(fnd->file->IsPacked()){
			if(make_mode){
				s_shared_cacheFats->pPackOffs1= fnd->file->pageOffs;
			}else{
				free(fnd->file->pageOffs);
				fnd->file->pageOffs= (pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName)))).pPackOffs1;
			}
	}
}

long BaseRO_Ex::get_ID_FATS_IN_AUX(Index *pAx, int make_mode)
{
	long PreLP= 0;
	if(make_mode){
		void *tB= alloca(pAx->file->PageSize);
		if(pAx->file->GetAttr(ID_FATS_IN_AUX, &PreLP, 4)
			&& PreLP){
				pAx->file->GetPage((pAx->file->LastPage=pAx->file->cpn=PreLP),tB);
		}
		getNumberIndex(pAx,make_mode,PreLP);
	}else{
		getNumberIndex(pAx,make_mode,PreLP);
		{
			PagedFileBuffsNew *pAuxNode= &(pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName))));
			pAuxNode->m_cntCln++;
		}
	}
	return PreLP;
}

void BaseRO_Ex::correct_Old_Aux_FAT(Index *pAx, int *)
{
	correct_Old_FAT(pAx);
}

void CachedBaseRO_without6tr4tr::correct_Old_Aux_FAT(Index *pAx, int *p_make_mode)
{
	correct_Old_FAT(pAx);
	if(p_make_mode[0] == 0)
		p_make_mode[0]= 1;
}

CachedBaseRO_without6tr4tr::CachedBaseRO_without6tr4tr(const char* name):BaseRO_Ex(name,ACE_OS_O_RDONLY)
{
}

Index* CachedBaseRO_without6tr4tr::FindIndex (const char *name){
	if(!strcmp("NFContxt.str", name)||!strcmp("NWCntxt.str", name)||m_SWordsName==name){
		return indTable[0];
	}
	return BaseRO_Ex::FindIndex(name);
}
void CachedBaseRO_without6tr4tr::actualMorpho(Index **pOutPtrIndex, long PreLastPage, int make_mode, Index *)
{
	*pOutPtrIndex= 0;
}

long CachedBaseRO_without6tr4tr::get_ID_FATS_IN_AUX(Index *pAx, int make_mode)
{
	getNumberIndex(pAx, make_mode, 0);
	return 0;
}

void BaseRO_Ex::actualMorpho(Index **pOutPtrIndex, long PreLastPage, int make_mode, Index *pAx)
{
	(*pOutPtrIndex)= FindIndexWithFAT(pAx, m_SWordsName, PreLastPage);
	if((*pOutPtrIndex)->file->IsPacked()){
		if(make_mode){
			s_shared_cacheFats->pPackOffs4= (*pOutPtrIndex)->file->pageOffs;
		}else{
			free((*pOutPtrIndex)->file->pageOffs);
			(*pOutPtrIndex)->file->pageOffs= (pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName)))).pPackOffs4;
		}
	}
	(*pOutPtrIndex)= FindIndexWithFAT(pAx, "NFContxt.str", PreLastPage);
	if((*pOutPtrIndex)->file->IsPacked()){
		if(make_mode){
			s_shared_cacheFats->pPackOffs5= (*pOutPtrIndex)->file->pageOffs;
		}else{
			free((*pOutPtrIndex)->file->pageOffs);
			(*pOutPtrIndex)->file->pageOffs= (pAllFats->contents(pAllFats->seek(gcl_FullFileName(pAx->streams->file->FileName)))).pPackOffs5;
		}
	}
}

Index *BaseRO_Ex::FindIndexWithFAT(Index *pAx, const char *name, const long PreLastPage)
{
	Index *retI= FindIndex(name);
	if(retI)
	{
		if(!retI->streams->Fat){
			((StreamFileRO*)(retI->streams))->m_LastAdd= ((StreamFileRO*)(pAx->streams))->m_LastAdd;
			if(!PreLastPage){
				correct_Old_FAT(retI);
				((StreamFileRO*)(retI->streams))->IndexMoveNames();
			}else{
				retI->streams->LoadFat(pAx->file);
			}
			((StreamFileRO*)(pAx->streams))->m_LastAdd= pAllFats->contents(pAllFats->GetRootG_SimpleSplayNode()).m_ppNxt;
		}else{
			retI->file->free_postFileNames();
		}
	}
	return retI;
}

bool BaseRO_Ex::IsMultiThreadsR(){
	bool ret= false;
	if(!curr_mode){
		if(!m_makeCacheThreads){
			GUARD (g_mutex_cacheFats);
			try{
				makeCacheThreads();
				ret= true;
			} catch (...) {
				throw std::exception ();
			}
		}else{
			ret= true;
		}
	}
	return ret;
}

void *BaseRO_Ex::getDefList(char *, void *)
{
	return pAllFats->contents(pAllFats->seek(gcl_FullFileName(indTable[0]->streams->file->FileName))).m_pList;
}

BaseRO_Ex::~BaseRO_Ex () {
	if (bLoadFatInOpened){
		GUARD (g_mutex_cacheFats);
		if(s_shared_cacheFats.in ()){
			PagedFileBuffsNew *pAuxNode= &(pAllFats->contents(pAllFats->seek(gcl_FullFileName(indTable[0]->streams->file->FileName))));
			if(pAuxNode->m_cntCln == 0){
				G_Point t;
				int dl_cnt= 0;
				gcl_FullFileName fls[6];
				for(t= pAllFats->first(); t; pAllFats->next(t)){
					if(pAllFats->key(t).IsBaseFile(indTable[0]->streams->file->FileName)){
						if(dl_cnt < 6){
							fls[dl_cnt++]= pAllFats->key(t);
						}
						int *pMem= pAllFats->contents(t).pFAT;
						pAllFats->contents(t).pFAT= 0;
						if(pMem)
							gk_free(pMem);
					}
				}
				while(dl_cnt--){
					pAllFats->del(fls[dl_cnt]);
				}
				if(pAuxNode->pPackOffs0)
					free(pAuxNode->pPackOffs0);
				if(pAuxNode->pPackOffs1)
					free(pAuxNode->pPackOffs1);
				if(pAuxNode->pPackOffs2)
					free(pAuxNode->pPackOffs2);
				if(pAuxNode->pPackOffs3)
					free(pAuxNode->pPackOffs3);
				if(pAuxNode->pPackOffs4)
					free(pAuxNode->pPackOffs4);
				if(pAuxNode->pPackOffs5)
					free(pAuxNode->pPackOffs5);
				if(pAuxNode->m_pList){
					int free_sz= 0;
					LPPL_BASE_FILE_LIST pNxt= pAuxNode->m_pList;
					do{
						free_sz++;
						free(pNxt->pFileName);
					}while((pNxt= (LPPL_BASE_FILE_LIST)(pNxt->pNext)));
					LPPL_BASE_FILE_LIST *ppArray= (LPPL_BASE_FILE_LIST *)alloca(free_sz * sizeof(*ppArray)), *ppAdd= ppArray;
					pNxt= pAuxNode->m_pList;
					do{
						*ppAdd++= pNxt;
					}while((pNxt= (LPPL_BASE_FILE_LIST)(pNxt->pNext)));
					while(free_sz--) free(ppArray[free_sz]);
				}
			}else{
				pAuxNode->m_cntCln--;
			}
			s_shared_cacheFats.release ();
		}
	}
	if (keyFile && keyFile->GetFileHandle() > 0){
		if(keyFile->m_readed.cur_Seek == my_def_ace_seek)
			if(!ace_os_close(keyFile->GetFileHandle()))
				keyFile->SetFileHandle(-1);
	}
	if (strFile && strFile->GetFileHandle() > 0){
		if(strFile->m_readed.cur_Seek == my_def_ace_seek)
			if(!ace_os_close(strFile->GetFileHandle()))
				strFile->SetFileHandle(-1);
	}
	if(simple_TextFile){
		char *pNDTSys= textFile->SystemPageBuf;
		textFile= 0;
		delete simple_TextFile;
		free(pNDTSys);
	}else if (textFile && textFile->GetFileHandle() > 0){
		if(textFile->m_readed.cur_Seek == my_def_ace_seek)
			if(!ace_os_close(textFile->GetFileHandle()))
				textFile->SetFileHandle(-1);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

class BasePool_i
	: virtual public DBCore::IBasePool
	, virtual public Core::RefCountObjectBase {
public:
	BasePool_i (size_t size, const std::string& path) {
		m_pool.resize (size);

		BaseCache::instance ();

		for (std::vector <CachedBaseRO*>::iterator it = m_pool.begin (); it != m_pool.end (); ++it) {
			*it = new CachedBaseRO (path.c_str ());
			(*it)->IsOk ();
			(*it)->check_version ();
		}
	}

	virtual ~BasePool_i () {
		for (std::vector <CachedBaseRO*>::iterator it = m_pool.begin (); it != m_pool.end (); ++it) {
			delete (*it);
		}
	}
protected:
	virtual size_t get_size () const {
		return m_pool.size ();
	}

	virtual DBCore::IBase* get (size_t i) {
		return m_pool [i]->abstract_base ();
	}
private:
	std::vector <CachedBaseRO*> m_pool;
};

DBCore::IBasePool* make_base_pool (size_t size, const std::string& path) {
	return new BasePool_i (size, path);
}