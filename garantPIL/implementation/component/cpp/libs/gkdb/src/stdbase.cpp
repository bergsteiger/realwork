#include "ace/ACE.h"

#include "stdbase.h"
#include "ncpf.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/lexical_cast.hpp"

YBase::YBase (const char* n, int m, int nc) : Base () {
	initMultiIndex (n, m, nc);
}

void MorphoReadOnlyAccessForModifiedBase(YBase *pBase, bool bInitTurboForReadOnly)
{
	CreatedBigStream= 1;
	pBase->curr_mode= ACE_OS_O_RDWR;
	pBase->Base::createIndices();
	{
		LPG_OTHER_INDEX pOtherNextIndexTmp= pBase->pOtherIndex;
		char CalIn[]= "CalIn.str", bufA[1];
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pKey == pBase->subNames->file) {
				if(pOtherNextIndexTmp->pKey->GetAttr(CalIn,bufA, 1)){
					pBase->FindIndexOther(CalIn,pOtherNextIndexTmp)->Create (sizeof (date), sizeof (long)*3, 1);
					pBase->FindIndexOther("CalAb.str",pOtherNextIndexTmp)->Create (sizeof (date), sizeof (long)*3, 1);
					pBase->FindIndexOther("CalCh.str",pOtherNextIndexTmp)->Create (sizeof (date), sizeof (long)*3, 1);
					pBase->FindIndexOther("Tag.str",pOtherNextIndexTmp)->Create (TAG_KEY_SIZE, sizeof (long)*3, 1);
				}
				break;
			}
			pOtherNextIndexTmp++;
		}
	}
	if( !pBase->streamFile->Fat || !pBase->keyFile->IsOk() ) {
		pBase->streamFile->LoadFat();
		pBase->OpenIndices ();
		if(!pBase->IsOkWithoutText() || !(pBase->subNames= pBase->FindIndex(pBase->m_SubNamesName)))
			abort();
		return;
	}
	if(bInitTurboForReadOnly){
		int tmp_curr_mode= pBase->curr_mode;
		pBase->curr_mode= ACE_OS_O_RDONLY;
		pBase->FindIndex("NFContxt.str");
		pBase->FindIndex("NWCntxt.str");
		pBase->FindIndexOther(pBase->m_SWordsName,pBase->pOtherNextIndex-1);
		pBase->curr_mode= tmp_curr_mode;
	}
	pBase->streamFile->StartTransaction();
	if(pBase->pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pBase->pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if( !pOtherNextIndexTmp->pStreamFile || !pOtherNextIndexTmp->pStreamFile->Fat || !pOtherNextIndexTmp->pKey->IsOk() ) {
				abort();
			}
			pOtherNextIndexTmp->pStreamFile->StartTransaction();
			pOtherNextIndexTmp++;
		}
	}
}

StdBigBase::StdBigBase (const char* name, int mode, int ndt_cache) : YBase (name, mode, ndt_cache) {
	MorphoReadOnlyAccessForModifiedBase (this);
}

void EndModifiedBase(YBase *pBase) {
	pBase->streamFile->EndTransaction();
	if(pBase->pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pBase->pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if( !pOtherNextIndexTmp->pStreamFile ) {
				abort();
			}
			pOtherNextIndexTmp->pStreamFile->EndTransaction();
			pOtherNextIndexTmp++;
		}
	}
}

StdBigBase::~StdBigBase () {
	EndModifiedBase (this);
}

int	YBase::IsOkWithoutText () {
#if defined BRDR32 || !defined _GCD_SERVER
	if(streamFile == 0 && (!(streamFile= make_StreamsPool( strFile, bLoadFatInOpened)) || !streamFile->file)){
		if(streamFile)
			delete streamFile;
		streamFile= 0;
		return 0;
	}
	if((docInd == 0 && (docInd= (AttrIndex*)FindIndex("Attrs")) == 0)){
		baseStatus = BS_DOCINDERROR;
		return 0;
	}
#endif
	return Base::IsOkWithoutText();
}

void YBase::OpenIndices () {
	FindIndex ("Aux.str");
}

int	YBase::IsOk () {
	if(!Base::IsOk())
		return 0;

	if(pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if( pOtherNextIndexTmp->pStreamFile && pOtherNextIndexTmp->pStreamFile->Fat && ( !pOtherNextIndexTmp->pKey->IsOk() || !pOtherNextIndexTmp->pStreamFile->IsOk()) ) {
				baseStatus = BS_NOTOK;
				return 0;
			}
			pOtherNextIndexTmp++;
		}
	}else{
		Base::createIndices();
		if( !streamFile->Fat )
			streamFile->LoadFat();
	}
#if	defined(BRDR32)
	if( !(curr_mode & ACE_OS_O_CREAT)) {
		IndexInfo info;
		if( !keyFile->GetAttr( "AnnoDate", &info, sizeof (info)))
			return 0;
	}	
#endif
	return 1;
}

int YBase::IsPacked () {
	int isPack= this->keyFile->IsPacked() | this->strFile->IsPacked() | this->textFile->IsPacked();
	if(this->pOtherIndex){
		LPG_OTHER_INDEX pOtherNextIndexTmp= this->pOtherIndex;
		while(pOtherNextIndexTmp->pKey){
			if(pOtherNextIndexTmp->pStreamFile)
				isPack |= pOtherNextIndexTmp->pStreamFile->file->IsPacked();
			isPack |= pOtherNextIndexTmp->pKey->IsPacked();
			pOtherNextIndexTmp++;
		}
	}
	return isPack;
}

extern "C" {
	int CompStringsZZZ(const void *pFirst, const void* pSecond)
	{
		return strncmp((const char *)pFirst, (const char *)pSecond, MAX_VAL_STR_AS_KEY+1);
	}
	void copyKeysZZZ(void *pOldItem, void *pNewItem)
	{
		int size= 32/sizeof(int),
				*pInp= (int*)pNewItem,
				*pOut= (int*)pOldItem;
		while(size--) *pOut++ = *pInp++;
	}
}

void* __stdcall defGetDocument (long DocID) {
	return 0;
}

extern const char* pTempFileFormat0;
extern const char* pTempFileListFormat0;
extern const char* pTempFileFormat1;
extern const char* pTempFileListFormat1;
extern const char* pTempFileFormat2;
extern const char* pTempFileListFormat2;

#include "dociter.h"

void NContxtIndex::FreeFprmsBuffs () {
	if (pp_ctxTextCacheArray) {
		delete pp_ctxTextCacheArray [0];
		free (pp_ctxTextCacheArray);
		pp_ctxTextCacheArray = 0;
	}
	if (pBufForNormals) {
		free (pBufForNormals);
		pBufForNormals = 0;
	}
	if (pAllPre) {
		delete [] pAllPre;
		pAllPre = 0;
	}
}

NContxtIndex::~NContxtIndex () {
	CopyAsFlush();
	this->FreeFprmsBuffs ();
}

int NContxtIndex::nitems;
int NContxtIndex::lastP;
int NContxtIndex::countNF;

typedef Ref RefStruct;

void NWContxtIndex::FlushAllParaWords()
{
	if(!hFlushAllParaWords){
		char tmpBaseName[256], *fnd= strrchr(file->FileName, '.');
		*fnd= 0;
		sprintf(tmpBaseName, pTempFileListFormat, file->FileName);
		if((hFlushAllParaWords= c_io_open(tmpBaseName, ACE_OS_O_CREAT|ACE_OS_O_WRONLY|ACE_OS_O_BINARY)) != -1){
			hNameFlushAllParaWords= strdup(tmpBaseName);
		}
		*fnd= '.';
	}
	if(hFlushAllParaWords != -1){
		c_io_write(hFlushAllParaWords, &m_ID, sizeof(m_ID));
		c_io_write(hFlushAllParaWords, pPutWordPosCount, (AllParaCount+1) * 3);
	}
}

void NWContxtIndex::WordPosControl(long ID, int ParaN, int *pVal, int textpos_add) {
	if(ParaN == 1) {
		*pVal= ContextSearch::DOC_BEGIN_WORD + textpos_add;
		if(!pAllWordPos){
			 if(m_pNIdList){
				AllDocCount += AllParaCount + 1;
			 }else
				AllDocCount = ContextSearch::POS_TEXT;
			pAllWordPos= new char[10*AllDocCount];
			pPutWordPosCount= pAllWordPos;
			memcpy(pAllWordPos + 3, pVal, 3);
			pPutWordPos = pAllWordPos + 6;
			AllParaCount= ParaN;
			m_ID = ID;
		}else{
			memcpy(pPutWordPosCount, &AllParaCount, 3);
			if(m_pNIdList){
				pPutWordPosCount= pPutWordPos;
				memcpy(pPutWordPos + 3, pVal, 3);
				pPutWordPos += 6;
				AllParaCount= ParaN;
			}else{
				FlushAllParaWords();
				m_ID = ID;
				pPutWordPosCount= pAllWordPos;
				memcpy(pAllWordPos + 3, pVal, 3);
				pPutWordPos = pAllWordPos + 6;
			}
			AllParaCount= ParaN;
		}
	}
	else if(ParaN > 0 && AllParaCount != ParaN){
		AllParaCount= ParaN;
		memcpy(pPutWordPos, pVal, 3);
		pPutWordPos += 3;
	}
}

void NWContxtIndex::DeleteChildsIndex()
{
	if(pPutWordPos){
		pPutWordPos= 0;
		memcpy(pPutWordPosCount, &AllParaCount, 3);
		if(!m_pNIdList)
			FlushAllParaWords();
	}
}

void NContxtIndex::PutOffset(CtxLongSet *sp, long Id, long j, int wordPos)
{
	abort();
}

void NWContxtIndex::PutOffset(CtxLongSet *sp, long Id, long j, int wordPos)
{
	sp->e[sp->lastI++] = Id;
	sp->e[sp->lastI++] = wordPos;
	*(size_t*)(sp->e+sp->lastI)= (size_t)pp_ctxTextCacheArray[cacheI]->root;
	sp->lastI+=2;
}

void NContxtIndex::InitMorpho (long Id) {
	AllocBufForNormals();
	InitFormsCache ();

#ifndef STD_REALLOC
	if (!pBigLongs) {
		pNxtLongs = pBigLongs = (long*) malloc (100 * 1024 * 1024 * sizeof (long));
	}
#endif
}

void NContxtIndex::InitFormsCache(){
	if(pp_ctxTextCacheArray == 0){
		pNxtNew0= 0;
		if(IsAlloc_pAllPre()){
			if(!(pAllPre= new u_int64_tCtxLongSetSplayNode[m_NormlsBuffCount]))
				abort();
			pNxtNew0= pAllPre;
		}
		if (!(pp_ctxTextCacheArray= (u_int64_tCtxLongSetSplayMap**)malloc (sizeof(u_int64_tCtxLongSetSplayMap*))))
			abort();
		if(!(pp_ctxTextCacheArray[0] = new u_int256_tCtxLongSetSplayMap(lsdef, pNxtNew0 ? &pNxtNew0 : 0)))
			abort();
	}
}

void u_int256_tCtxLongSetSplayMap::SetItemInNode(void *pOldItem, void *pNewItem)
{
	copyKeysZZZ(pOldItem, pNewItem);
}

int u_int256_tCtxLongSetSplayMap::comp_items(void *pFirst, void*pSecond)
{
	return CompStringsZZZ(pFirst, pSecond);
}

void u_intPointerN_tCtxLongSetSplayMap::SetItemInNode(void *pOldItem, void *pNewItem)
{
	*(size_t*)pOldItem= *(size_t*)pNewItem;
}

int u_intPointerN_tCtxLongSetSplayMap::comp_items(void *pFirst, void*pSecond)
{
	return CompStringsZZZ((void*)*(size_t*)pFirst, (void*)*(size_t*)pSecond);
}

unsigned NContxtIndex::getParaWord(char *dst, const char **src, unsigned &l, int *f)
{
	char *to = dst;
	unsigned length =l;
	int bWasWord = 0;

	while(length){
		if((
			 *f && IS_CTX_CHAR_NORMLS_62(*(*src))) || (!*f && IS_CTX_CHAR_NORMLS_56(*(*src))) ){
			*to = *(*src)++;
			if(*f){
				QUICK_R_WIN_TOUPPER_WIN(*to);
			}else{
				QUICK_R_DOS_TOUPPER_WIN(*to);
			}
			if (to-dst<128) to++;
			length--;
			bWasWord = 1;
		}else{
			if( bWasWord )
				// end word //
				break;
			if( *(*src) == '\x4' ){
				if( *f ){
					(*src)++; length --;
					*f = 0;
					switch( *(*src) ){
						case REFTYPE_REFLIST:
						case REFTYPE_BLOB:
							{
								unsigned t = *(short*)((*src)+1);
								if( !t ) t = 1;
								t*=sizeof(RefStruct);
								t+= 1 + sizeof(short);
								CORE_DUMP_ON_CHECK((t<=length), 
												"ref outside bounds.");
								length-=t;
								(*src)+=t;
							}
							break;
						case REFTYPE_CLASS:
							while( length && *(*src) ){
								(*src)++;
								length--;
							}
							if( length ){
								(*src)++;
								length--;
							}else{
								fprintf(stderr,"\n\nBadNews!\n\n");
							}
					}
				}else{
					(*src)++;
					length --;
					*f = 1;
				}
			}else{
				(*src)++;
				length --;
			}
		}
	}
	CORE_DUMP_ON_CHECK((l>=length), "outside para.");
	l=length;
	return (unsigned)((to-dst)&0x7fffffff);
}

void NContxtIndex::InitFileNameTempFiles()
{
	if(Name[1] == 'F'){
		pTempFileFormat= (char*)pTempFileFormat1;
		pTempFileListFormat= (char*)pTempFileListFormat1;
	}else if(Name[1] == 'P'){
		pTempFileFormat= (char*)pTempFileFormat2;
		pTempFileListFormat= (char*)pTempFileListFormat2;
	}else{
		pTempFileFormat= (char*)pTempFileFormat0;
		pTempFileListFormat= (char*)pTempFileListFormat0;
	}
}

NContxtIndex::NContxtIndex (
	PagedFile* f, const char* n, StreamFile* s, unsigned NormlsBuffCount, IndexInfo* pinfo
)	
    : Index (f,n,s,pinfo)
	, indxs (0)
	, allocIndxs (0)
	, FlashCount (-1)
	, lastDocFromTemp (-1)
	, m_pNIdList (0)
	, maxItems (698880/2)
	, rootNodeKey (0)
	, hFlushAllParaWords (0)
	, hNameFlushAllParaWords (0)
	, pAllWordPos (0)
	, merge_doc_index_names (0)
	, merge_doc_index_count (0)
	, pNxtNPut (0)
	, cacheI (0)
	, itemsDone (0)
	, pTempFileListName(0)
	, m_pNIdDelList(0), m_sNIdDelList(0), NormsCount(0), log(0)
	, pAllPre(0), pBufForNormals(0), pp_ctxTextCacheArray(0), pTempFileFormat(0), pTempFileListFormat(0)
{
	m_AllPatchedAndNewDocsTextSize= (u_int64_t)1;
#ifndef STD_REALLOC
	pBigLongs= 0;
#endif
#if !defined(STD_REALLOC)
	SkipDocForFlush= 0;
#endif
	bzero(&lsdef,sizeof(lsdef));
	///////////////////////////////////////////////////
#if !defined(STD_REALLOC)
	OS_GetDocument= defGetDocument;
#endif
	///////////////////////////////////////////////////
	m_NormlsBuffCount= NormlsBuffCount;
	InitTempFiles();
}

static const char SkipChars[]= "&?*№'_";

int NContxtIndex::isSkipWordWithChar(char *pWord, const char *pChars)
{
	if(!pChars)
		pChars= (char*)SkipChars;
	while(*pChars){
		if(	*pWord == *pChars
			|| pWord[1] == *pChars
			|| pWord[2] == *pChars
			|| pWord[3] == *pChars
			|| pWord[4] == *pChars
			|| pWord[5] == *pChars
			|| pWord[6] == *pChars
			|| pWord[7] == *pChars) {
			return 1;
		}
		pChars++;
	}
	return 0;
}

CtxLongSet NContxtIndex::lsdef;

void NContxtIndex::CompPre(char *, LPPL_RET_NORMLS spRet, int/*uu*/)
{
	if(spRet->lastI){
		// Одинаковые по написанию нормали - игнорируем
		for(int ii= 0; ii < spRet->lastI; ii++){
			if(!pp_ctxTextCacheArray[0]->comp_items (spRet->e+ii*4, spRet->e+spRet->lastI*4)) {
				pNxtNPut -= 4;
				return;
			}
		}
	}
	spRet->lastI++;
}

void NContxtIndex::GetKeyBuff(long **ppSet, u_int64_tCtxLongSetSplayNode *curr)
{
	(*ppSet)= curr->cont.e;
}

CtxLongSet *NContxtIndex::FromCache(void *pkey, LPPL_RET_NORMLS spRet)
{
	CtxLongSet *ret= &(*pp_ctxTextCacheArray[cacheI])[pkey];
	if(ret->lastElemV == -1)
		ret->capacity= 0;
	if(ret->capacity || ret->lastElemV == -1){
		ret->lastI= ret->capacity;
		ret->capacity= (long)ret->e;
		ret->e= (long*)ret->lastElemV;
		ret->lastElemV= ret->capacity;
		ret->capacity= 0;
	}
	if((spRet->lastI= ret->lastI))
		spRet->e= (u_int64_t *)ret->e;
	return ret;
}

int NContxtIndex::GetNormalesFromString (
	char* buf, LPPL_RET_NORMLS spRet, LemmatizeProc lemmatize, unsigned wordLen
) {
	spRet->wordPos = 0;

	if (!(*(u_int64_t*)(buf + wordLen)= (u_int64_t)0) && (/*wordLen < 5 || wordLen > 6 || */isSkipWordWithChar (buf)))
		return 0;

	while (*buf == '-') {
		wordLen--;
		if (!wordLen)
			return 0;
		buf++;
	}
	char* pNxt;
	CtxLongSet* sp;
	int secondWord = 1;

	while (secondWord--) {
		if (secondWord) {
			secondWord--;
			wordLen= (unsigned)strlen (buf + 128);
			memcpy (buf, buf + 128, wordLen + 1); 
		} else if ((pForm = strchr (buf, '-'))) {
			pForm++;
			wordLen = (unsigned)((pForm - buf - 1) & 0x7fffffff);

			buf [wordLen] = 0;

			if (*pForm && *pForm != '-' && !isSkipWordWithChar (pForm,SkipChars)) {
				// для слов, разделённых одним дефисом
				if ((pForm = strchr (buf + wordLen + 1, '-')))
					*pForm = 0;
				strcpy (buf + 128, buf + wordLen + 1);
				secondWord = 2;
			}
		}

		if (wordLen > MAX_VAL_STR_AS_KEY){
			buf [MAX_VAL_STR_AS_KEY] = 0;
			wordLen = MAX_VAL_STR_AS_KEY;
		} else {
			buf[wordLen]= 0;
		}
		spRet->wordPos++;
		cacheI = 0;
		m_CurrReallocFactor = 4;
		*(buf - 1)= (wordLen + 1);

		if (!(sp = FromCache((void*)(buf - 1), spRet))) {
			return 0;
		}

		if (IsNotForms (&secondWord, sp, buf, spRet)) {
			spRet->lastI = 0;
		} else if (!spRet->lastI) {
			init_buff_Norm ();
			sp->e = (long*)(spRet->e = pNxtNPut);
			pForm = (char*)pNxtNPut + 1;
			if ((sp->lastI = lemmatize (buf, this)) > 0) {
				pNxt = buff_Norm;
				do {
					do {
						*pForm++= *pNxt;
						pNxt++;
					} while (*pNxt);
					*pForm= *pNxt;
					*(char*)pNxtNPut = ((char)((pForm-(char*)pNxtNPut)&0x7f));
					CompPre (pForm, spRet, 0);
					pNxtNPut += 4;
					pForm= (char*)pNxtNPut + 1;
					pNxt++;
				} while (--sp->lastI);

				if (!SetRetNormsCount (sp, spRet)) {
					return 0;
				}

				NormsCount += (unsigned)(spRet->lastI & 0x7fffffff);
			} else  {
				do{
					*pForm= buff_Norm[sp->lastI++];
				}while(*pForm++);
				*(char*)pNxtNPut = ((char)(sp->lastI&0x7f)) | 0x80;
				pNxtNPut += 4;
				spRet->lastI = 1;
				NormsCount++;
				SetRetNormsCount (sp, spRet);
			}
		}
	}

	return 0;
}

void NContxtIndex::InitFlushStat()
{
	nitems= 0;
	lastP = -1;
	countNF =0;
}

void NContxtIndex::nflushIt (u_int64_tCtxLongSetSplayMap *ctxmapNormls, NContxtIndex *pIndex) {
	//InitTempFiles();
	CtxLongSet *sp;

	if ( !ctxmapNormls->length() )
		return;

	//nitems += ctxmapNormls->length();
	u_int64_tCtxLongSetSplayMap *ctxmap = ctxmapNormls;

	//int tmp;
	for( Pix i = ctxmap->first(); i; ctxmap->next(i) ){
		sp = (&ctxmap->contents(i));
		/*tmp = (countNF++ * 100) / nitems;
		if( !m_pNIdList && tmp > lastP ){
			lastP = tmp;
			//printf("Flushing %d keys, %d%% done.\r", nitems, lastP );
			//fflush(stdout);
		}*/
		if( sp->e ){
			if(pIndex->QuickFlush(ctxmapNormls, ctxmap->pkey(i), sp->e, sp->lastI)){
				printf("Can't create stream for key '%x'\n",ctxmap->key(i));
				abort();
			}
			FreeData( sp );
		}
	}
	ctxmap->clear();
}

void NContxtIndex::FreeData( CtxLongSet *sp )
{
	free(sp->e);
	sp->e= 0;
	sp->lastI= 0;
	sp->capacity= 0;
}

void NContxtIndex::DeleteChildsIndex() {
}

IGarDoc *NContxtIndex::addInOtherMap(long Id, DocInfo *local_docInfo, IGarDoc *doc)
{
	if(!doc){
		doc = base->GetGarDoc( Id, local_docInfo );
	}else{
		if (base->bases_ptrs.size () > 1) {
			((Document*)doc)->base = base->base_for_doc (Id);
		}
		doc->SetDocInfo(local_docInfo, Id);
		doc->Load(Id);
	}
	return doc;
}

void NContxtIndex::MakeN_Map(u_int64_tCtxLongSetSplayMap **ppNew
#ifdef PRE_ALLOC_NODES
																, u_int64_tCtxLongSetSplayNode **pp_ForNew
#endif
																											)
{
	*ppNew= new 
  #ifdef QUCK_CNTXT_HASH
				u_int64_tCtxLongSetSplayMap
  #else
	#ifdef STORE_FORM_N
				u_intPointerN_tCtxLongSetSplayMap
	#else
				u_int256_tCtxLongSetSplayMap
	#endif
  #endif
													(lsdef
#ifdef PRE_ALLOC_NODES
															, pp_ForNew
#endif
																		);
}

void NContxtIndex::merge_deleted( DocIterator *it, long *pDeletedDocs)
{
	if(pDeletedDocs){
		long Count= 1;
		for ( ; !it->End (); ++(*it) ) {
			Count++;
		}
		m_pNIdList= (long*)malloc(Count*sizeof(*m_pNIdList));
		it->Rewind();
		for ( Count= 0; !it->End (); ++(*it) ) {
			m_pNIdList[Count++]= it->Id();
		}
		it->Rewind();
		m_pNIdList[Count]= 0x7ffffffc;
		m_pNIdDelList= pDeletedDocs;
	}
}

long NWContxtIndex::ReFormatData( void *pNewKey, long **ppData, long all)
{
	int stepR= 4;
	long *pNxt= (*ppData)+stepR, cnt= 0, pt=0,
			*pOut= ((long*)*ppData) + 1,
				lstDocFromTemp= *(*ppData);
	do{
#if !defined(STD_REALLOC)
		if(SkipDocForFlush && lstDocFromTemp == SkipDocForFlush)
			break;
#endif
		if(lstDocFromTemp > lastDocFromTemp)
			lastDocFromTemp= lstDocFromTemp;
		all -= stepR;
		while(all && *pNxt == lstDocFromTemp){
			*pOut++= ((*(pNxt-3) >> 14) << 15) | (*(pNxt-3) & 0x3fff);
			*pOut++= 0x40000000 | (long)((((u_int64_tCtxLongSetSplayNode *)(*(size_t*)(pNxt-2)))-pAllPre)& 0x7fffffff);
			cnt++;
			pNxt += stepR; all -= stepR;
		}
		*pOut++= 0x80000000 | (((*(pNxt-3) >> 14) << 15) | (*(pNxt-3) & 0x3fff));
		*pOut++= 0x40000000 | (long)((((u_int64_tCtxLongSetSplayNode *)(*(size_t*)(pNxt-2)))-pAllPre)& 0x7fffffff);
		cnt++;
		pt += sizeof(long) + cnt*(sizeof(long)*2);
		cnt= 0;
	}while(all && (lstDocFromTemp= *pOut= *pNxt) && (pNxt += stepR)
			&& (pOut= (long*)((char*)pOut + sizeof(long))));

	return pt;
}

long NContxtIndex::ReFormatData( void *pNewKey, long **ppData, long all)
{
	int stepR= 4;
	long *pNxt= (*ppData)+stepR, cnt= 0, pt=0,
			*pOut= (long*)(((char*)*ppData) + sizeof(long) + 4),
				lstDocFromTemp= *(*ppData);
	do{
#if !defined(STD_REALLOC)
		if(SkipDocForFlush && lstDocFromTemp == SkipDocForFlush)
			break;
#endif
		if(lstDocFromTemp > lastDocFromTemp)
			lastDocFromTemp= lstDocFromTemp;
		all -= stepR;
		while(all && *pNxt == lstDocFromTemp){
			*pOut++= (*(pNxt-3) << 15) | *(pNxt-2);
			*pOut++= *(pNxt-1);
			cnt++;
			pNxt += stepR; all -= stepR;
		}
		*pOut++= (*(pNxt-3) << 15) | *(pNxt-2);
		*pOut++= *(pNxt-1);
		cnt++;
		pt += sizeof(long) + 4 + cnt*(sizeof(long)*2);
		memcpy(((char*)(pOut-cnt*2))-4, &cnt, 4); cnt= 0;
	}while(all && (lstDocFromTemp= *pOut= *pNxt) && (pNxt += stepR)
			&& (pOut= (long*)((char*)pOut + sizeof(long) +4)));

	return pt;
}

int NContxtIndex::QuickFlush( u_int64_tCtxLongSetSplayMap *, void *pNewKey, long *pData, long all)
{
	if(!(all= ReFormatData(pNewKey, &pData, all)))
		return 0;

	if(indxs[FlashCount].max_size_saved_Node < all)
		indxs[FlashCount].max_size_saved_Node= all;

	if(::ACE_OS::write(indxs[FlashCount].file, pData, all ) != all ||
		(countNewKeys == alloc_size
		&& (alloc_size += GROW_BY * (pNxtNPut ? 10 : 1))
				&& (indxs[FlashCount].pInd=
				(LPPL_YYY)realloc(indxs[FlashCount].pInd,sizeof(PL_YYY)*alloc_size))
							== 0))
		return -1;
	(indxs[FlashCount].pInd+countNewKeys)->k= asNorm(pNewKey);
	(indxs[FlashCount].pInd+countNewKeys)->len= all;
	countNewKeys++;
	indxs[FlashCount].file_len += all;
	return 0;
}

int attrcmp(const void *a1, const void *a2) {
	if(((AttrKey *)a1)->AttrTag > ((AttrKey *)a2)->AttrTag) return 1;
	if(((AttrKey *)a1)->AttrTag < ((AttrKey *)a2)->AttrTag) return -1;
	if(((AttrKey *)a1)->DocId > ((AttrKey *)a2)->DocId) return 1;
	if(((AttrKey *)a1)->DocId < ((AttrKey *)a2)->DocId) return -1;
	return 0;
}

int attrcmp_new(const void *a1, const void *a2) {
	if(((AttrKey *)a1)->DocId > ((AttrKey *)a2)->DocId) return 1;
	if(((AttrKey *)a1)->DocId < ((AttrKey *)a2)->DocId) return -1;
	if(((AttrKey *)a1)->AttrTag > ((AttrKey *)a2)->AttrTag) return 1;
	if(((AttrKey *)a1)->AttrTag < ((AttrKey *)a2)->AttrTag) return -1;
	return 0;
}

bool YBase::is_demo_base () {
	bool result = false;
	Stream* str = FindIndex ("Aux")->Open (AUX_DEMO);
	if (str) {
		if (str->Length () == sizeof (int)) {
			int is_demo = 0;
			str->Read (&is_demo, sizeof (is_demo));
			result = is_demo == 1;
		}
		FindIndex ("Aux")->Close (str);
	}
	return result;
}

bool YBase::is_vip_base () {
	bool result = false;

	char c_ndt_vip = 0;
	if (textFile->GetAttr (AUX_VIP, &c_ndt_vip, sizeof (c_ndt_vip))) {
		result = c_ndt_vip;
	} else {
		Stream* str = FindIndex ("Aux")->Open (AUX_VIP);
		if (str) {
			if (str->Length () == sizeof (int)) {
				int is_vip = 0;
				str->Read (&is_vip, sizeof (is_vip));
				result = is_vip == 1;
			}
			FindIndex ("Aux")->Close (str);
		}
	}
	return result;
}

void	YBase::get_percents (std::vector<std::pair <std::string, long> > &gauges)
{
	std::vector<std::string> names;

	Stream* str = FindIndex ("Aux")->Open (AUX_PERC);
	if (str) {
		long length = str->Length ();
		char *data = new char [length], *ptr = data;
		str->Read (data, length);
		FindIndex ("Aux")->Close (str);
		while (ptr - data < length) {
			names.push_back (ptr);
			ptr += strlen (ptr) + 1;
		}
		delete []data;
	}

	std::vector<std::string>::const_iterator names_it = names.begin ();

	char perc [40];
	long sum_perc = 0;
	if (textFile->GetAttr (AUX_PERC, perc, sizeof (perc)) && strlen (perc)) {
		std::vector<std::string> parts;
		boost::split (parts, perc, boost::is_any_of (","));
		for (std::vector<std::string>::const_iterator parts_it = parts.begin (); parts_it != parts.end (); parts_it++) {
			std::pair<std::string, long> pair (names_it != names.end () ? *names_it : "?", boost::lexical_cast <long> (*parts_it));
			sum_perc += pair.second;
			gauges.push_back (pair);
			if (names_it != names.end ())
				names_it++;
		}
	} else {
		for (int i = 0; i < 16; i++) {
			char key [5];
			sprintf (key, "%%%%%%%X", i);
			Stream *str = FindIndex ("Aux")->Open (key);
			if (str) {
				long perc;
				str->Read (&perc, 4);
				FindIndex ("Aux")->Close (str);
				std::pair<std::string, long> pair (names_it != names.end () ? *names_it : "?", perc);
				sum_perc += pair.second;
				gauges.push_back (pair);
				if (names_it != names.end ())
					names_it++;
			}
		}
	}
	if (0 == sum_perc)
		gauges.clear ();
}

void gkdb_read_Fat(PagedFile *pRead, StreamFile *pstrFile)
{
	long count= (long)(0xffff & *((unsigned short*)&(pstrFile->fatPages)));
	char *pOut= (char*)pstrFile->Fat;
	count *= pstrFile->file->PageSize / pRead->PageSize;
	while(count--){
		pRead->cpn++;
		if(!pRead->GetPage(pRead->cpn, pOut))
			break;
		pOut += pRead->PageSize;
	}
	pstrFile->Fat[1] |= FAT_CHAIN;
}

GLBase::GLBase(const char* name) : StdBigBase (name, ACE_OS_O_RDWR) {
	int i= indCount;
	Index *pAx= FindIndex("Aux.str");
	if(i){
		while( i--)
			if ( indTable[i] && indTable[i] == pAx && indTable[0] == (Index*)docInd) {
				int PreLastPage= 0;
				Index *pLastWrite0= FindIndex("SWords.str");
				FindIndexOther("NWCntxt.str", this->pOtherNextIndex-1);
				Index *pLastWrite1= FindIndex("NFContxt.str");
				if(pAx->file->GetAttr(ID_FATS_IN_AUX, &PreLastPage, sizeof(PreLastPage))){
					pAx->file->LastPage=PreLastPage;
					if(!(pOtherIndex->pStreamFile->Fat[1] & FAT_CHAIN)){
						void *tB= alloca(pAx->file->PageSize);
						pAx->file->GetPage(PreLastPage,tB);
						pAx->file->cpn= PreLastPage;
						gkdb_read_Fat(pAx->file, streamFile);
						gkdb_read_Fat(pAx->file, docInd->streams);
						gkdb_read_Fat(pAx->file, FindIndex("Context.str")->streams);
						gkdb_read_Fat(pAx->file, pLastWrite0->streams);
						gkdb_read_Fat(pAx->file, pLastWrite1->streams);
					}
				}else{
					if(!(pOtherIndex->pStreamFile->Fat[1] & FAT_CHAIN)){
						streamFile->LoadFatEx(-1,true);
						LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
						while(pOtherNextIndexTmp->pKey){
							if(pOtherNextIndexTmp->pKey != pAx->file)
								pOtherNextIndexTmp->pStreamFile->LoadFatEx(-1,true);
							pOtherNextIndexTmp++;
						}
					}
				}
				indTable[0]= pAx;
				indTable[i]= docInd;
				break;
			}
	}
}

GLBase::~GLBase () {
	Index *pAx= FindIndex("Aux.str");
	if(pAx == indTable[0]){
		int status = 1;
		long currentPos= c_io_tell(pAx->file->GetFileHandle());
		if(c_io_lseek(pAx->file->GetFileHandle(), (pAx->file->LastPage+1) * pAx->file->PageSize, ACE_OS_SEEK_SET)
			== (pAx->file->LastPage+1) * pAx->file->PageSize){
				long	tow= ((long)(0xffff & *((unsigned short*)&(streamFile->fatPages)))) * streamFile->file->PageSize
						, write = c_io_write(pAx->file->GetFileHandle(), streamFile->Fat, tow)
						, addP= 0;

				if (write == tow){
					addP = write / pAx->file->PageSize;
					status++;
				}else
					status = 0;

				if(status && pOtherIndex){
					LPG_OTHER_INDEX pOtherNextIndexTmp= pOtherIndex;
					while(status && (status < 6) && pOtherNextIndexTmp->pKey){
						if (!pOtherNextIndexTmp->pStreamFile)
							abort ();

						if (pOtherNextIndexTmp->pKey != pAx->file) {
							if (pOtherNextIndexTmp->pStreamFile->Fat){
								tow= ((long)(0xffff & *((unsigned short*)&(pOtherNextIndexTmp->pStreamFile->fatPages)))) * pOtherNextIndexTmp->pStreamFile->file->PageSize;
								write = c_io_write(pAx->file->GetFileHandle(), pOtherNextIndexTmp->pStreamFile->Fat, tow) ;
								if (write ==  tow){
									addP += write / pAx->file->PageSize;
									status++;
								}else
									status= 0;
							} else {
								status= 0;
							}
						}
						pOtherNextIndexTmp++;
					}
				}
				if (status && status == 6) {
					pAx->file->PutAttr(ID_FATS_IN_AUX,&(pAx->file->LastPage),sizeof(pAx->file->LastPage));
					pAx->file->LastPage += addP;
				}
		}
		c_io_lseek(pAx->file->GetFileHandle(),currentPos,ACE_OS_SEEK_SET);
	}
}

extern "C" int pl_ModifyBaseEx(int iKey, int iStr, int iNdt,
								char **ppBuff, char **ppBuff0, char *pKeyUP, int CryptoCount);
#include "../../GPersn/src/PL_Types.h"

YBase::~YBase () {
	FreeIndices ();
	if(pOtherIndex){
		pOtherNextIndex= pOtherIndex;
		while(pOtherNextIndex->pKey){
			if(pOtherNextIndex->pStreamFile){
/*#ifdef BRDR32
				pOtherNextIndex->pStreamFile->file->m_pCryptoTag= 0;
#endif*/
				delete pOtherNextIndex->pStreamFile;
			}
/*#ifdef BRDR32
				pOtherNextIndex->pKey->m_pCryptoTag= 0;
#endif*/
			delete pOtherNextIndex->pKey;
			pOtherNextIndex++;
		}
		free(pOtherIndex);
		pOtherNextIndex= pOtherIndex= 0;
	}
	if (keyFile) {
		int curr_mode= 0, ikeyFile = -1, istrFile = -1, itextFile = -1;
		char *pStrTag, *pKeyTag, *pNDTSys;
		if(keyFile && strFile && textFile){
			if(keyFile->SignatureValid()){
				ikeyFile= keyFile->GetFileHandle();
				istrFile= strFile->GetFileHandle();
				itextFile= textFile->GetFileHandle();
			}
			pKeyTag= keyFile->m_pCryptoTag + sizeof(long);
			pStrTag= strFile->m_pCryptoTag + sizeof(long);
			pNDTSys= textFile->SystemPageBuf;
			if((keyFile->m_mode & ACE_OS_O_RDWR) || (keyFile->m_mode & ACE_OS_O_WRONLY))
				curr_mode= keyFile->m_mode;
		}else{
			pKeyTag= (char*)malloc(sizeof(long)) + sizeof(long);
			pStrTag= (char*)malloc(sizeof(long)) + sizeof(long);
			pNDTSys= (char*)malloc(1);
		}
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
		if(!(strFile->Flags & PF_PUTPAGE) && !(textFile->Flags & PF_PUTPAGE) && !(keyFile->Flags & PF_PUTATTR)){
			curr_mode= ACE_OS_O_RDONLY;
		}
#endif
		if (streamFile) {
			delete streamFile;
		} else if (strFile) {
			delete strFile;
		}
		if (keyFile) {
			delete keyFile;
		}
		if (textFile) {
			delete textFile;
		}
		if (m_docs_block) {
			delete m_docs_block;
		}
		if((curr_mode & ACE_OS_O_RDWR) || (curr_mode & ACE_OS_O_WRONLY)){
			if(pl_ModifyBaseEx(	ikeyFile, istrFile, itextFile,
								&pKeyTag, &pStrTag, pNDTSys, MAX_CRYPTED_BLOCK))
			{
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
				// Модификация FAT-а НЕ требует перешифровки первой страницы //
#else
				printf("\nERROR - Update crypted FAT pages !");
				::abort();
#endif
			}
		}
		free((pKeyTag - sizeof(long)));
		free((pStrTag - sizeof(long)));
		free(pNDTSys);
		if (ikeyFile > 0) c_io_close(ikeyFile);
		if (istrFile > 0) c_io_close(istrFile);
		if (itextFile > 0) c_io_close(itextFile);
	}
	if (utmp) {
		free (utmp);
	}
	keyFile= 0;
}

void YBase::open_saw_bases (int mode)
{
	if (bases_ptrs.size ())
		return ;

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

	std::vector<std::string> bases_list;
	bases_list.push_back ("this");

	str = FindIndex ("Aux")->Open (AUX_BASES_LIST);
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
			else
				saw_base_name [0] = 0;
			strcat (strcat (saw_base_name, basename_it->c_str ()), ".ndt");
			YBase *base = new YBase (saw_base_name, mode);
			base->IsOk ();
			base->check_version ();
			bases_ptrs.push_back (base);
		}
	}
}

void StdBigBase::open_saw_bases (int mode)
{
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

	std::vector<std::string> bases_list;
	bases_list.push_back ("this");

	str = FindIndex ("Aux")->Open (AUX_BASES_LIST);
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
			else
				saw_base_name [0] = 0;
			strcat (strcat (saw_base_name, basename_it->c_str ()), ".ndt");
			YBase *base = new StdBigBase (saw_base_name, mode);
			base->IsOk ();
			base->check_version ();
			bases_ptrs.push_back (base);
		}
	}
}

void	YBase::close_saw_bases ()
{
	if (bases_ptrs.size ()) {
		for (size_t i = 1; i < bases_ptrs.size (); i++)
			delete bases_ptrs [i];
	}
	bases_ptrs.clear ();
}
