
#include "shared/Core/fix/mpcxc.h"

#include "ROCBase.h"
#include "SearchCache.h"

static StreamFileFats *pAllFats= 0;
static Core::Mutex g_mutex_cacheFats;

extern "C" int my_def_ace_seek(int, void *, int, int, int);

CacheFats::~CacheFats () {
	G_Point t;
	pAllFats= 0;
	for(t= m_pAllFats->first(); t; m_pAllFats->next(t)){
		int *pMem= m_pAllFats->contents(t).pFAT;
		m_pAllFats->contents(t).pFAT= 0;
		if(pMem)
			gk_free(pMem);
	}
	delete m_pAllFats;
	if(cacheAllDocs)
		delete cacheAllDocs;
	if(cacheAllMDocs)
		delete cacheAllMDocs;
	if(cacheAllFDocs)
		delete cacheAllFDocs;
	if(pPackOffs0)
		free(pPackOffs0);
	if(pPackOffs1)
		free(pPackOffs1);
	if(pPackOffs2)
		free(pPackOffs2);
	if(pPackOffs3)
		free(pPackOffs3);
	if(pPackOffs4)
		free(pPackOffs4);
	if(pPackOffs5)
		free(pPackOffs5);
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
		G_Point fnd= pAllFats->seek(gcl_FullFileName(file->FileName));
		if(fnd){
			Fat = pAllFats->contents(fnd).pFAT;
			if(file->IsPacked()){
				free(file->pageOffs);
				file->pageOffs= (unsigned int*)(pAllFats->contents(fnd).pPackOffs);
			}
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
		}
		if(pFirst && pFirst->file->m_readed.cur_Seek != my_def_ace_seek){
			void *pTmpBuff= alloca(pFirst->file->PageSize);
			if(!pFirst->file->PagedFile::GetPage(1, pTmpBuff))
				NdtClone::Error();
		}else if(file->m_readed.cur_Seek != my_def_ace_seek){
			void *pTmpBuff= alloca(file->PageSize);
			if(!file->PagedFile::GetPage(1, pTmpBuff))
				NdtClone::Error();
		}
	}
};

StreamFile *CachedBaseRO::make_StreamsPool(PagedFile *pFile, int bLoadFat){
	return new StreamFileRO(strFile, 0);
}

Core::Var <CacheFats> CachedBaseRO::s_shared_cacheFats;

ACE_Recursive_Thread_Mutex cachedbasero_mutex;
std::map<long,char> CachedBaseRO::map_doc_basechar, CachedBaseRO::map_blob_basechar;

CachedBaseRO::CachedBaseRO (const char* name, int mode) : SearchBase (name, mode) {
	char Pagetest[4096];
	if (keyFile && keyFile->GetFileHandle() > 0){
		if(!keyFile->GetPage(1,Pagetest))
			NdtClone::Error();
	}
	if (strFile && strFile->GetFileHandle() > 0){
		if(!strFile->GetPage(1,Pagetest))
			NdtClone::Error();
	}
	if (textFile && textFile->GetFileHandle() > 0){
		if(!textFile->GetPage(1,Pagetest))
			NdtClone::Error();
	}
}

void gk_huge* CachedBaseRO::LoadAttr (long DocId, int tag, long& size)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_doc_basechar.find (DocId)->second]->Base::LoadAttr (DocId, tag, size);
	} else {
		return Base::LoadAttr (DocId, tag, size);
	}
}

void gk_huge* CachedBaseRO::LoadAttrEx (long DocId, int tag, long& size)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_doc_basechar.find (DocId)->second]->Base::LoadAttrEx (DocId, tag, size);
	} else {
		return Base::LoadAttrEx (DocId, tag, size);
	}
}

int CachedBaseRO::LoadAttr (long DocId, int tag, DBCore::Storable& storable)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_doc_basechar.find (DocId)->second]->Base::LoadAttr (DocId, tag, storable);
	} else {
		return Base::LoadAttr (DocId, tag, storable);
	}
}

Index* CachedBaseRO::FindBlobIndexFor (long id)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_blob_basechar.find (id)->second]->FindIndex ("Blob");
	} else {
		return Base::FindIndex ("Blob");
	}		
}

Document* CachedBaseRO::GetDoc (long doc_id, const DocInfo* p_DocInfo)
{
	return bases_ptrs [map_doc_basechar.find (doc_id)->second]->Base::GetDoc (doc_id, p_DocInfo);
}

Base*	CachedBaseRO::FindBaseForDoc (long doc_id)
{
	if (bases_ptrs.size ())
		return bases_ptrs [map_doc_basechar.find (doc_id)->second];
	else
		return this;
}

/*
int CachedBaseRO::FindDocInfo (long Id, DocInfo &docinfo)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_doc_basechar.find (Id)->second]->Base::FindDocInfo (Id, docinfo);
	} else {
		return Base::FindDocInfo (Id, docinfo);
	}
}
*/

int CachedBaseRO::FindDocAttr (long Id, int Tag, void * buf, int size)
{
	if (bases_ptrs.size ()) {
		std::map<long,char>::const_iterator map_it = map_doc_basechar.find (Id);
		if (map_it != map_doc_basechar.end ())
			return bases_ptrs [map_it->second]->Base::FindDocAttr (Id, Tag, buf, size);
		else
			return 0;
	} else {
		return Base::FindDocAttr (Id, Tag, buf, size);
	}
}

int CachedBaseRO::FindDocName (long Id, char * buf)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_doc_basechar.find (Id)->second]->Base::FindDocName (Id, buf);
	} else {
		return Base::FindDocName (Id, buf);
	}
}

int CachedBaseRO::FindSubName (long Id, long sub, char * buf)
{
	if (bases_ptrs.size ()) {
		return bases_ptrs [map_doc_basechar.find (Id)->second]->Base::FindSubName (Id, sub, buf);
	} else {
		return Base::FindSubName (Id, sub, buf);
	}
}

void CachedBaseRO::open_saw_bases ()
{
	RWRITE_GUARD (cachedbasero_mutex) {
		if (map_doc_basechar.size () == 0) {
			Stream *str = FindIndex ("Aux")->Open (AUX_DOC_BASE);
			if (str) {
				long length = str->Length ();
				char *data = new char [length], *ptr = data;
				str->Read (data, length);
				Base::FindIndex ("Aux")->Close (str);
				while (ptr - data < length) {
					long id;
					memcpy (&id, ptr, sizeof (id));
					ptr += sizeof (id);
					char basechar = *ptr;
					ptr++;
					map_doc_basechar.insert (std::map<long,char>::value_type (id, basechar));
				}
				delete []data;
			}
			str = FindIndex ("Aux")->Open (AUX_BLOB_BASE);
			if (str) {
				long length = str->Length ();
				char *data = new char [length], *ptr = data;
				str->Read (data, length);
				Base::FindIndex ("Aux")->Close (str);
				while (ptr - data < length) {
					long id;
					memcpy (&id, ptr, sizeof (id));
					ptr += sizeof (id);
					char basechar = *ptr;
					ptr++;
					map_blob_basechar.insert (std::map<long,char>::value_type (id, basechar));
				}
				delete []data;
			} else {
				map_doc_basechar.insert (std::map<long,char>::value_type (0, 0));
			}
		}
	}
	Stream *str = FindIndex ("Aux")->Open (AUX_BASES_LIST);
	std::vector<std::string> bases_list;
	bases_list.push_back ("this");
	if (str) {
		long length = str->Length ();
		char *bases = new char [length], *ptr = bases;
		str->Read (bases, length);
		Base::FindIndex ("Aux")->Close (str);
		for (; ptr - bases < length; ptr += strlen (ptr) + 1)
			bases_list.push_back (ptr);
		delete []bases;
	}
	for (std::vector<std::string>::const_iterator basename_it = bases_list.begin (); basename_it != bases_list.end (); basename_it++) {
		if (basename_it == bases_list.begin ()) {
			bases_ptrs.push_back (this);
		} else {
			char saw_base_name [MPCXC_MAX_PATH];
			strcpy (saw_base_name, textFile->FileName);
			if (strrchr (saw_base_name, '\\'))
				*(strrchr (saw_base_name, '\\')+1) = 0;
			strcat (strcat (saw_base_name, basename_it->c_str ()), ".ndt");
			YBase *base = new CachedBaseRO (saw_base_name);
			base->IsOk ();
			base->check_version ();
			bases_ptrs.push_back (base);
		}
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

void CachedBaseRO::getNumberIndex(Index *pAx, int make_mode, long PreLastPage)
{
	if(pAx->file->IsPacked()){
		if(make_mode){
			s_shared_cacheFats->pPackOffs0= pAx->file->pageOffs;
		}else{
			free(pAx->file->pageOffs);
			pAx->file->pageOffs= s_shared_cacheFats->pPackOffs0;
		}
	}
	Index *fnd;
	if(!(fnd= FindIndexWithFAT(make_mode, pAx, "Number", PreLastPage))) {
		delete textFile;
		textFile= 0;
	}else if(fnd->file->IsPacked()){
			if(make_mode){
				s_shared_cacheFats->pPackOffs1= fnd->file->pageOffs;
			}else{
				free(fnd->file->pageOffs);
				fnd->file->pageOffs= s_shared_cacheFats->pPackOffs1;
			}
	}
}

long CachedBaseRO::get_ID_FATS_IN_AUX(Index *pAx, int make_mode)
{
	long PreLP= 0;
	void *tB= alloca(pAx->file->PageSize);
	if(pAx->file->GetAttr(ID_FATS_IN_AUX, &PreLP, 4)
		&& PreLP){
			pAx->file->GetPage((pAx->file->LastPage=pAx->file->cpn=PreLP),tB);
	}
	getNumberIndex(pAx,make_mode,PreLP);
	if(make_mode){
		delete AllDocs();
		delete inpharm_medtopics ();
		delete inpharm_firmtopics ();
		/*{
			// позитивное открытие базы 7.1 \- в версиях 7.10 и выше ОНО нам Нужно ?
			Index* index = FindIndex ("Status_ex");
			if(index && index->Root != -1){
				DocCollection *ret= inpharm_medtopics();
				if(ret)
					delete ret;
				ret= inpharm_firmtopics();
				if(ret)
					delete ret;
			}
		}*/
		s_shared_cacheFats->cacheAllDocs = cacheAllDocs;
		s_shared_cacheFats->cacheAllMDocs = cacheAllMDocs;
		s_shared_cacheFats->cacheAllFDocs = cacheAllFDocs;
	}else{
		cacheAllDocs= s_shared_cacheFats->cacheAllDocs;
		cacheAllMDocs= s_shared_cacheFats->cacheAllMDocs;
		cacheAllFDocs= s_shared_cacheFats->cacheAllFDocs;
	}
	return PreLP;
}

void CachedBaseRO::correct_Old_Aux_FAT(Index *pAx, int *)
{
	correct_Old_FAT(pAx);
}

void CachedBaseRO_without6tr4tr::correct_Old_Aux_FAT(Index *pAx, int *p_make_mode)
{
	correct_Old_FAT(pAx);
	if(p_make_mode[0] == 0)
		p_make_mode[0]= 1;
}

CachedBaseRO_without6tr4tr::CachedBaseRO_without6tr4tr(const char* name):CachedBaseRO(name,ACE_OS_O_RDONLY)
{
}

Index* CachedBaseRO_without6tr4tr::FindIndex (const char *name){
	if(!strcmp("NFContxt.str", name)||!strcmp("NWCntxt.str", name)||m_SWordsName==name){
		return indTable[0];
	}
	return CachedBaseRO::FindIndex(name);
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

void CachedBaseRO::actualMorpho(Index **pOutPtrIndex, long PreLastPage, int make_mode, Index *pAx)
{
	(*pOutPtrIndex)= FindIndexWithFAT(make_mode, pAx, m_SWordsName, PreLastPage);
	if((*pOutPtrIndex)->file->IsPacked()){
		if(make_mode){
			s_shared_cacheFats->pPackOffs4= (*pOutPtrIndex)->file->pageOffs;
		}else{
			free((*pOutPtrIndex)->file->pageOffs);
			(*pOutPtrIndex)->file->pageOffs= s_shared_cacheFats->pPackOffs4;
		}
	}
	(*pOutPtrIndex)= FindIndexWithFAT(make_mode, pAx, "NFContxt.str", PreLastPage);
	if((*pOutPtrIndex)->file->IsPacked()){
		if(make_mode){
			s_shared_cacheFats->pPackOffs5= (*pOutPtrIndex)->file->pageOffs;
		}else{
			free((*pOutPtrIndex)->file->pageOffs);
			(*pOutPtrIndex)->file->pageOffs= s_shared_cacheFats->pPackOffs5;
		}
	}
}

Index *CachedBaseRO::FindIndexWithFAT(int make_mode, Index *pAx, const char *name, const long PreLastPage)
{
	Index *retI= FindIndex(name);
	if(retI)
	{
		if(/*PreLastPage || */!retI->streams->Fat){
			if(!PreLastPage && make_mode)
				correct_Old_FAT(retI);
			else
				retI->streams->LoadFat(PreLastPage ? pAx->file : 0);
		}
	}
	return retI;
}

bool CachedBaseRO::IsMultiThreadsR(){
	if(!curr_mode){
		int make_mode= 0;
		GUARD (g_mutex_cacheFats);
		if (!s_shared_cacheFats) {
			// если КЕШ пустой - заполняем его
			s_shared_cacheFats = new CacheFats;
			pAllFats= s_shared_cacheFats->m_pAllFats;
			make_mode= 1;
		}else{
			// иначе просто увеличиваем счетчик ссылок
			s_shared_cacheFats.addref();
			pAllFats= s_shared_cacheFats->m_pAllFats;
		}
		Index *pAx;
		if(!(pAx= FindIndex ( "Aux.str" ))) {
			delete textFile;
			textFile= 0;
			return false;
		}
		if(!pAx->streams->Fat || !(pAx->streams->Fat[1] & FAT_CHAIN)){
			// ручная прогрузка всего FAT-а, прогружженного частично по-требованию //
			GUARD (g_mutex_cacheFats);
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

		if(!(docInd= (AttrIndex	*)FindIndexWithFAT(make_mode, pAx, "Attrs.str", PreLastPage))) {
			delete textFile;
			textFile= 0;
			return false;
		}
		{
			char newI0[]= "CalIn.str", newI1[]= "CalAb.str", newI2[]= "CalCh.str", buffT;
			if((pOtherNextIndex-1)->pKey->GetAttr(m_CorrNewName,&buffT,1)){
				YBase::FindIndexOther(m_CorrNewName,this->pOtherNextIndex-1);
			}else{
				// когда индекс CorrNew станет обязательным для хедового формата базы, то раскоментарить return
				//return false;
			}
			YBase::FindIndexOther(newI0,this->pOtherNextIndex-1);
			YBase::FindIndexOther(newI1,this->pOtherNextIndex-1);
			YBase::FindIndexOther(newI2,this->pOtherNextIndex-1);
		}
		subNames= (RefIndex*)FindIndex ( m_SubNamesName );
		if(docInd->file->IsPacked()){
			if(make_mode){
				s_shared_cacheFats->pPackOffs2= docInd->file->pageOffs;
			}else{
				free(docInd->file->pageOffs);
				docInd->file->pageOffs= s_shared_cacheFats->pPackOffs2;
			}
		}
		Index *fnd= 0;
		if(is_morpho_exist()){
			fnd= FindIndexWithFAT(make_mode, pAx, "Context.str", PreLastPage);
			if(fnd->file->IsPacked()){
				if(make_mode){
					s_shared_cacheFats->pPackOffs3= fnd->file->pageOffs;
				}else{
					free(fnd->file->pageOffs);
					fnd->file->pageOffs= s_shared_cacheFats->pPackOffs3;
				}
			}
			actualMorpho(	&fnd, PreLastPage, make_mode, pAx );
			////
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
		}else{
			return false;
		}
		currentBlockSize = ADD_BLOCK_SIZE;
		return true;
	}
	throw std::exception ();
	return false;
}

CachedBaseRO::~CachedBaseRO () {
	if (bLoadFatInOpened){
		GUARD (g_mutex_cacheFats);
		if(s_shared_cacheFats.in ()){
			s_shared_cacheFats.release ();
		}
	}
	cacheAllDocs = 0;
	cacheAllMDocs = 0;
	cacheAllFDocs = 0;
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
	if (textFile && textFile->GetFileHandle() > 0){
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
