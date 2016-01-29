#include "shared/Core/fix/mpcxc.h"
//
// 	Basic classes for handling multiple data chunks - streams
// Stream is a model of a normal file - you can read (write) data
// to (from) them, position in them, truncate them.
// 	All streams are stored in StreamFiles, which supports packing
// of data - small chunks of data can be stored together in pages
// IndexRec buffer can be provided to support immediate data storing
// within the directory (index) record.
//
// Author: Alex V.Boreskoff
// Last Modification : 30/05/97
//

#include "../../NdtClone/Common/index.h"
#include "shared/Core/fix/PragmaWarningDisable.h"
#include "../../NdtClone/Common/streams.h"

#include <cassert>
#include <cstring>
#include <algorithm>

#ifndef PLAIN_GKDB
	#include "ace/OS.h"
#endif

//extern "C" int ace_os_ltrunc(int fd, long loffset);

extern "C" {
#ifdef __WIN16__
	extern int DefaultWin16MessageForResorceTomFunc(void);
#endif

#ifdef	__BORLANDC__
#include <ctype.h>
#endif
		// in GSSCREEN.LIB //
		extern void clear_video(void);     /*  Clear screen */
		// show message, trunc if lenght more then 50 //
		extern void show_message(const char *);

		extern int DefaultMessageForResorceTomFunc(void);
}

void InFile(::PagedFile *FileDef);
//extern FILE	*presfile;

namespace NdtClone {

#ifndef WRITE_KEYS_PAGE_INBACKUP
static NDTKPage MapDefltStr;
#endif

int CreatedBigStream= 1;

char pFatSizeName[]= "FatSize";

inline	int	Handle4Page ( int Handle )
{
	return BIG_STREAM_HANDLE_TO_PAGE(Handle);
}

inline	int	Handle2Page ( int Handle )
{
	return OLD_STREAM_HANDLE_TO_PAGE(Handle);
}

inline	int	Handle3Page ( int Handle )
{
	return ((unsigned int)Handle) >> 10;
}

inline	short	Handle2Id ( int Handle )
{
	return OLD_STREAM_HANDLE_TO_ID(Handle);
}

inline	short	Handle3Id ( int Handle )
{
	return (short)( Handle & 0x03FF );
}

inline	short	Handle4Id ( int Handle, int Low )
{
	return BIG_STREAM_HANDLE_TO_ID(Handle,Low);
}

void StreamFile :: InitThis( ::PagedFile * strFile, int bLoadFat )
{
	//m_s= m_ms= m_us= 0;
	NextIdPerOldPage= 1;
	iCreateOther= 0;
	pCreateOtherK= 0;
	m_pFreeOnPages= 0;
	Fat= m_deletedFat= 0;
	m_pDelKeys= 0;
#ifdef _DEBUG
	ostreams= 0;
#endif
	rpages=
#ifndef SAVE_ALL_FAT_ON_BUCKUP
			fpages=
#endif
					bpages= 0;
#ifdef MIN_MEM_CONTEXT
	pOtherBackuped= 0;
#endif
	pNameBackupName= 0;
	m_hBackup= /*m_hBackupKeys= */0;
	pFirst= 0;pKfile= 0;
	pFirstStr= 0;
	file   = (NdtClone::PagedFile *)strFile;
	SysBuf = 0;
	Flags  = 0;
	Fat= 0;
	CountAllFlush= 0;
	dfltII= 0;
	m_transaction_counter= 0;
	streamID= 0;
	pCreateOtherK= 0;
	iDeleteFile= GKDB::BT_MAXDEPTH;
	while(iDeleteFile--){
		Stack[iDeleteFile].curKey= 0;
		Stack[iDeleteFile].prevKey= 0;
		Stack[iDeleteFile].buf= 0;
	}
	iDeleteFile= 0;
	m_Fs= 0;
	pOldCreate= 0;
	LastCreatedBlockPage= 0;
	m_PagesCacheKeys= 0;
	m_PagesCacheBlocks= 0;
	m_pCacheBlocksStack= 0;
	m_pCacheKeysStack= 0;
	m_pCacheKeysStackCount= 0;
	m_pCacheBlocksStackCount= 0;
	pWritedPages= 0;
	nSysP= 0;
	m_bLoadFat= 
#if defined(BRDR32) || defined(MIN_MEM_CONTEXT)
					bLoadFat
#else
					bLoadFat ? bLoadFat : 1
#endif
											;
	m_next_actual_FAT_page= 0;
	aSysBuf= 0;m_stepWriteBuff= 0;
}

StreamFile :: StreamFile ( ::PagedFile * strFile, int bLoadFat )
{
	m_notAutoRoll= 0;
	global_check();
	InitThis(strFile, bLoadFat );
}

StreamFile :: StreamFile ( ::PagedFile * strFile )
{
	m_notAutoRoll= 0;
	global_check();
	pNameBackupName= 0;
	InitThis(strFile, 0);
}

void StreamFile :: Delete ()
{
	if(!(Flags & SF_DELETE)) { Flags |= SF_DELETE;
		if(pKfile && file->SystemPageBuf == pKfile->SystemPageBuf){
			pKfile->SystemPageBuf= m_PagedBackupSystemPage;
			pKfile->Flags &= ~PF_MODIFIED;
			file->Flags &= ~PF_MODIFIED;
		}
		if ( Flags & PF_MODIFIED )
			SaveFat ();
		if(m_deletedFat)
			gk_free ( m_deletedFat );
		m_deletedFat= 0;
		Fat= 0;
		if(aSysBuf)
		{ 
			file->FreeBuf(aSysBuf);
		}
		aSysBuf= SysBuf= 0;
#ifndef BRDR32
		file->m_mode |= ACE_OS_O_BINARY; // for free map with reallocpaged
		file->Delete(iDeleteFile);
		if(pKfile)
		{
			pKfile->m_mode |= ACE_OS_O_BINARY; // for free map with reallocpaged
			pKfile->Delete(iDeleteFile);
		}
#endif
		iDeleteFile= 0;
		char *pNameF= GetBackupName(), *Fnd= strrchr(pNameF, '.')+1;
		//delete file;
#ifdef _DEBUG
		if(ostreams)
			delete ostreams;	ostreams= 0;
#endif
		if(rpages)
			delete rpages;
		if(bpages)
			delete bpages;
#ifndef SAVE_ALL_FAT_ON_BUCKUP
		if(fpages)
			delete fpages;
		fpages= 
#endif
			rpages= bpages= 0;
#ifdef WRITE_KEYS_PAGE_INBACKUP
		*Fnd= '#';
		ace_os_unlink(pNameF);
#else
		if(m_hBackup){
			c_io_close(m_hBackup);
			m_hBackup= 0;
		}
#endif
		if(m_PagesCacheKeys){
			CachedPage *pCP;
			for(G_Point t= m_PagesCacheKeys->first(); t ; m_PagesCacheKeys->next(t)){
				pCP= m_PagesCacheKeys->contents(t);
				delete pCP;
			}
			delete m_PagesCacheKeys;
		}
		m_PagesCacheKeys= 0;
		if(m_PagesCacheBlocks){
			CachedPage *pCP;
			for(G_Point t= m_PagesCacheBlocks->first(); t ; m_PagesCacheBlocks->next(t)){
				pCP= m_PagesCacheBlocks->contents(t);
				delete pCP;
			}
			delete m_PagesCacheBlocks;
		}
		m_PagesCacheBlocks= 0;
	}
	/*if(m_hBackupKeys){
		char *pNameF= GetBackupName(), *Fnd= strrchr(pNameF, '.')+1;
		c_io_close(m_hBackupKeys);
		m_hBackupKeys= 0;
		*Fnd= '~';
		c_io_unlink(pNameF);
	}*/
	if(pNameBackupName){
		free(pNameBackupName);
		pNameBackupName= 0;
	}
}

//##ModelId=3BFE7DEB012D
StreamFile :: ~StreamFile ()
{
	if(global_IsBlock())
		return;

	if(pKfile && !(pKfile->m_mode & ~(ACE_OS_O_BINARY | 0x3000 | GKDB::BT_GO_TO_ROOT))){
		Delete();
		if(file->m_mode & ~0x3000){
			;
		}else{
			if(file->m_pCryptoTag && ((file->SystemPageBuf && ((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)
										|| file->SystemPageBuf == 0))
			{
				if(file->PageSize < *(int*)file->m_pCryptoTag){
					;
				}else
					delete file;
			}
		}
	}else if(pFirst){
		int ii= 0, old_tmp= 0;
		if(pFirst->KeyCount < 1){
			old_tmp++;
			ii= iCreateOther;
			while(ii--){
				if(pCreateOtherK[ii]->KeyCount > 0){
					BTStack *SF=  pCreateOtherK[ii]->Stack;
					pCreateOtherK[ii]->Stack= pFirst->Stack;
					pFirst->Stack= SF;
					Index *IF= pCreateOtherK[ii];
					pCreateOtherK[ii]= pFirst;
					pFirst= IF;
					old_tmp= 0;
					break;
				}
			}
		}
		if(old_tmp){
			Flags |= SF_POST_CREATE_AS_TMP;
		}
		ii= iCreateOther;
		while(ii--)
			delete pCreateOtherK[ii];
		delete pFirst;
		Delete();
	}else
		Delete();
	iDeleteFile= GKDB::BT_MAXDEPTH;
	while(iDeleteFile--){
		if(Stack[iDeleteFile].curKey)
			gk_free(Stack[iDeleteFile].curKey);
		Stack[iDeleteFile].curKey= 0;
		if(Stack[iDeleteFile].prevKey)
			gk_free(Stack[iDeleteFile].prevKey);
		Stack[iDeleteFile].prevKey= 0;
	}
	if(pCreateOtherK)
		free(pCreateOtherK);
	if(m_pFreeOnPages){
		G_Point fndOp= m_pFreeOnPages->first();
		while(fndOp){
			mapLongToChar *tmpMap= m_pFreeOnPages->contents(fndOp);
			delete tmpMap;
			 m_pFreeOnPages->next(fndOp);
		}
		delete m_pFreeOnPages;
	}
}

int StreamFile :: InitFirstMaps()
{
	if((
#ifndef SAVE_ALL_FAT_ON_BUCKUP
				!rpages &&
#endif
							!(rpages= new STRPageNMap(dfltII)))
#ifndef SAVE_ALL_FAT_ON_BUCKUP
			||
			(
				!fpages &&
							!(fpages= new STRPageNMap(dfltII)))
#endif
			||
			(
#ifndef SAVE_ALL_FAT_ON_BUCKUP
				!bpages &&
#endif
							!(bpages= new STRPageNMap(dfltII))))
	{
		LOG_E (("abort in StreamFile :: Create Maps"));
		abort();
	}
	return 0;
}

void StreamFile :: InitFirstStr( Stream *pNew )
{
	if(!pFirstStr){
		pFirstStr= pNew;
#ifdef _DEBUG
		if(	!(ostreams= new NDTStreamsFreeMap(dfltII))
				/*|| InitFirstMaps()*/) {
			LOG_E (("abort in StreamFile :: Create "));
			abort();
		}
#endif
	}
}

char* StreamFile :: AllocSysBuf(){
	if(!SysBuf){
		m_stepWriteBuff= 0;
		aSysBuf= SysBuf = (char*)calloc ( 2, file ? file->PageSize : m_bLoadFat);
		if(!m_PagesCacheBlocks){
			m_PagesCacheBlocks= new CachePagesMap(0);
		}
	}
	return SysBuf;
}

void	StreamFile :: Create (PagedFile *pFirstKey)
{
	AllocSysBuf();
	if(file){
		if(pFirstKey && file->SystemPageBuf && pFirstKey->GetFileHandle() == -2  && file->SystemPageBuf[file->AttrOffs] ){
			file->SystemPageBuf[file->AttrOffs]= 0;
			file->LastPage= 0;
		}

		if(!Fat) LoadFat();

		if ( file -> NewPage () != 1 )
			assert ( 0 );

		if(file->m_pCryptoTag){
			lastFatPage= (*(int*)file->m_pCryptoTag)/file->PageSize
											? (*(int*)file->m_pCryptoTag)/file->PageSize
												: 1;
		}else{
			lastFatPage= 1;
		}
		Fat[lastFatPage]  = FAT_CHAIN;
		fatPages = 1;
		Flags   |= PF_MODIFIED;

		if(!(file -> PutAttr ( pFatSizeName, &fatPages, int(sizeof ( short )) )) || !(file->PutAttr(SF_FAT_OD, &lastFatPage, 4)))
		{
			LOG_E (("StreamFile :: Create, file -> PutAttr, [%s]", file->FileName));
			abort();
		}
		InitFirstStr( (Stream*)-1 );
	}
}

void StreamFile :: AllocFAT(::PagedFile *otherLine)
{
	AllocSysBuf();

	if ( !otherLine && ( m_deletedFat == (int*)-1 || !file -> GetAttr ( pFatSizeName, &fatPages, sizeof ( short ) )) ){
		m_deletedFat= Fat = (int*)calloc(file->PageSize, (lastFatPage= ((fatPages= 1)&0x7fff)));
		return;
	}
	m_deletedFat= Fat = (int*)calloc(file->PageSize, (size_t)((*(unsigned short*)&fatPages) & 0xffff));
}

void StreamFile :: LoadFat (::PagedFile *otherLine)
{
	AllocFAT(otherLine);
	LoadFatEx (-1);
}

void StreamFile :: LoadFatEx (int hOtherSaveHandle, bool b_ignoreFOD)
{
	if(Fat[1] & FAT_CHAIN){
		Flags |= SF_LOAD_FAT_ON_DEMAND | SF_POST_REST_FAT;
	}else{
		char* ptr = (char*) Fat;
		int pageCount, page, fatPagesCount= (int)(((unsigned short*)&fatPages)[0] &0xffff);
		if(file->m_pCryptoTag){
			page= (*(int*)file->m_pCryptoTag)/file->PageSize
											? (*(int*)file->m_pCryptoTag)/file->PageSize
												: 1;
	#ifdef MAKE_HDD
			if(page > 1)
				page= 3;
	#endif
		}
	#ifdef BRDR32
		else{
			page= 1;
		}
	#endif
		if(page > 1
			//&& !(file->m_mode & (~0x2000)) // with write mode on old base
			&& hOtherSaveHandle == -1
			&& file->GetPage ( 1, Fat ) && ((Fat[1] & FAT_CHAIN) || (Fat[1] & ~FAT_CHAIN))){
			// совместимость на чтение со старым форматом //
			 page = 1;
		}
		if(!b_ignoreFOD && file -> GetAttr ( SF_FAT_OD, &pageCount, sizeof ( pageCount ))){
			if(page > 1){
				if(!file->GetPage ( page, Fat )){
					LOG_E (("abort in StreamFile :: LoadFat First Page №3"));
					abort();
				}
				Fat[1]= FAT_CHAIN;
			}
			lastFatPage= page;
			Flags |= SF_LOAD_FAT_ON_DEMAND;
			while(pageCount < fatPages){
				lastFatPage= (pageCount * (file->PageSize/sizeof(*Fat))) + 1;
				pageCount++;
			}
		}else if ( (hOtherSaveHandle == -1
					&& (file ->GetPage ( (lastFatPage= page), Fat )))
				||
				(hOtherSaveHandle != -1 &&
					c_io_read(hOtherSaveHandle, ptr, file -> PageSize) == file -> PageSize))
		{
			ptr += file -> PageSize;
			for ( page = Fat[page] & ~FAT_CHAIN, pageCount = 1; 
				page != 0; page = Fat[page] & ~FAT_CHAIN, pageCount++ )
			{
				if ( pageCount < fatPagesCount && ((hOtherSaveHandle == -1 &&
	#ifndef SAVE_ALL_FAT_ON_BUCKUP
																			file ->
	#endif
																					GetPage ( (lastFatPage= page), ptr ))
						||
			(hOtherSaveHandle != -1 && c_io_read(hOtherSaveHandle, ptr, file -> PageSize))))
				{
					ptr += file -> PageSize;
				}else {
					LOG_E (("abort in StreamFile :: LoadFat "));
					abort();
				}
			}
		}
	}
}

//##ModelId=3BFE7DEB01A6
void	StreamFile :: SaveFat (int hOtherSaveHandle)
{
#ifndef SAVE_ALL_FAT_ON_BUCKUP
	if(hOtherSaveHandle != -1 || !(file->IsOk()))
		return;
#endif
	char* ptr = (char*) Fat;
	int page = 0, pos;

	if(hOtherSaveHandle != -1
		&& ((pos= c_io_lseek(hOtherSaveHandle, 0, ACE_OS_SEEK_CUR)) == -1
				|| c_io_write(hOtherSaveHandle, &page, sizeof ( fatPages ))
						!= sizeof ( fatPages )))
	{
		LOG_E (("abort in StreamFile :: SaveFat"));
		abort();
	}

	page = (*(int*)file->m_pCryptoTag)/file->PageSize ? (*(int*)file->m_pCryptoTag)/file->PageSize : 1;
#ifdef MAKE_HDD
	if(page > ((file->PageSize + file->PageSize + file->PageSize) / file->PageSize)){
		page= 3;
	}
#endif
	if(page > 1 && (Fat[1] & FAT_CHAIN) && (Fat[1] & (~FAT_CHAIN)))
		page= 1; // сохранение FAT обновленного старого комплекта

	while(page)
	{
		if(hOtherSaveHandle != -1){
			if(c_io_write(hOtherSaveHandle, ptr, file -> PageSize)
					!= file -> PageSize)
			{
				LOG_E (("abort in StreamFile :: SaveFat"));
				abort();
			}
		}else if(file -> getFHandle() != -2){
			if(!file -> PutPage ( page, ptr )){
				LOG_E (("abort in StreamFile :: SaveFat (write error)"));
				abort();
			}
		}
		ptr += file -> PageSize;
		page = Fat[page] & ~FAT_CHAIN;
	}
	if(hOtherSaveHandle != -2 && ((ptr - (char*) Fat)/file -> PageSize) != fatPages){
		LOG_E (("abort in StreamFile :: SaveFat (error in pages from FAT)"));
		abort();
	}
	if(hOtherSaveHandle == -1)
		file -> PutAttr ( pFatSizeName, &fatPages, int(sizeof ( short )) );
	else if(	c_io_lseek(hOtherSaveHandle, pos, ACE_OS_SEEK_SET) != pos
				||c_io_write(hOtherSaveHandle, &fatPages, sizeof ( fatPages ))
								!= sizeof ( fatPages )
				||c_io_lseek(hOtherSaveHandle, 0, ACE_OS_SEEK_END) == -1
								)
	{
		LOG_E (("abort in StreamFile :: SaveFat"));
		abort();
	}
}

int	StreamFile :: AllocPage (int bigHandle)
{
	int	newPage  = file -> NewPage ();
	int	maxPages = (int)((fatPages&0x7fff) * (int)(file -> PageSize&0x7fff)) / 4;

	if ( newPage < maxPages )
		return newPage;

				// increase Fat size by 1 page
				// allocate new
	int *free_mem= m_deletedFat;

	fatPages++;

	m_deletedFat  = (int *) malloc ( ((size_t)(fatPages&0x7fff) * 4) * (file -> PageSize&0x7fff));
#ifdef _DEBUG
	{
		int tmpMM= ( ((size_t)(fatPages&0x7fff) * 4) * (file -> PageSize&0x7fff))/4;
		while(tmpMM--)
			m_deletedFat[tmpMM]= 0;
	}
#endif
	while(maxPages--)
		m_deletedFat[maxPages]= Fat[maxPages];

	memset(m_deletedFat + newPage, 0, file -> PageSize);

	if(free_mem)
		free(free_mem);

	Fat = m_deletedFat;

	lastFatPage= AddNewPage( lastFatPage, bigHandle );

	return newPage;
}

int compBlockDescID(const void *v1, const void *v2){
	if(((BlockDesc *)v1)->Id < ((BlockDesc *)v2)->Id)
		return -1;
	if(((BlockDesc *)v1)->Id == ((BlockDesc *)v2)->Id)
		return 0;
	return 1;
}

//##ModelId=3BFE7DEB0191
int	StreamFile :: FindSubBlock ( int Page, short id )
{
	if(Page && !m_stepWriteBuff && nSysP != Page){
		GetStrsPageFromCache( Page, (SysBuf= aSysBuf) );nSysP= Page;
	}
	BlockDesc * BlockPtr = 0;

	int Offs;
	if((*(short*)SysBuf) > -1){
		BlockPtr = (BlockDesc *)SysBuf;
		for ( Offs = 0; BlockPtr -> Id != id && BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( SysBuf + Offs ) )
		{
			Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;

			if ( Offs >= file -> PageSize )		// somehow get out of range
				return -1;
		}
		if ( BlockPtr -> Id != id )
			return -1;
	}else{
		if(!(BlockPtr = (BlockDesc *)::bsearch(
												&id
												,SysBuf+sizeof(short)
												, -(*(short*)SysBuf)
												, sizeof(BlockDesc), compBlockDescID)))
			return -1;
		return int(((char*)BlockPtr - SysBuf)&0x7fffffff);
	}
	return Offs;
}

int compWriteID(const void *v1, const void *v2)
{
	if(((LPSF_INFILE)v1)->Page < ((LPSF_INFILE)v2)->Page)
		return -1;
	if(((LPSF_INFILE)v1)->Page == ((LPSF_INFILE)v2)->Page)
		return 0;
	return 1;
}

int StreamFile::GetPageFromCache(int page, CachePagesMap **ppMap, ::PagedFile *FileDef, void *buff, char **ppPagesStack, int *pCount)
{
	if(!(*ppMap)){
		(*ppMap)= new CachePagesMap(0);
	}
	Point Fnd= (*ppMap)->seek(page);
	if(Fnd){
		fc= (NdtClone::NPagedFile *)FileDef;
		(*ppMap)->contents(Fnd)->GetPage(buff, this);
		return 1;
	}
	/*if(FileDef->pParamTAlloc)
	{
		//GUARD (FileDef->m_mtxCheckInWrite);
		LPSF_INFILE bFind= (LPSF_INFILE)::bsearch( &page, *FileDef->ppParamT, *FileDef->pCnt, sizeof(*bFind), compWriteID);
		if(bFind){
			memcpy(buff,bFind->pBff,FileDef->PageSize);
			int Ct= (*FileDef->pCnt) - (bFind-(*FileDef->ppParamT)) - 1;
			while(Ct--){
				*bFind= *(bFind+1);
				bFind++;
			}
			(*FileDef->pCnt)--;
		}else if(!FileDef->GetPage(page, buff)){
			return 0;
		}
	}else */if(!FileDef->GetPage(page, buff)){
		return 0;
	}
	AddPageFromCache(page, (*ppMap), FileDef, buff, ppPagesStack, pCount);
	return 1;
}


//##ModelId=3BFE7DEB0131
int StreamFile :: IsNotBlock(int Size)
{
	if ( Size > (int)(((size_t)(file -> PageSize&0x7fff) - sizeof ( BlockDesc ) - 1 - sizeof ( BlockDesc )- sizeof(short))&0x7fffffff))
		return 1;
	return 0;
}
void StreamFile :: AddFatNext(int page, int Val)
{
	AddFat(page, Val, 0);
}

void StreamFile :: AddFat(int page, int Val, int checkShort)
{
#ifndef SAVE_ALL_FAT_ON_BUCKUP
	char *pOut= (char*)(Fat + page);
	if(checkShort && m_pFreeOnPages){
		G_Point fndOpt= m_pFreeOnPages->seek((short)(0x7fff & *(int*)pOut));
		if(fndOpt){
			mapLongToChar *tmpMap= m_pFreeOnPages->contents(fndOpt);
			G_Point fndPage= tmpMap->seek(page);
			if(fndPage){
				// удаляем страницу 
				if(fndPage == tmpMap->first()){
					delete tmpMap;
					m_pFreeOnPages->del(fndOpt);
				}else
					tmpMap->del(fndPage);
				int newVal= *(int*)pOut+Val;
				if(newVal >= (int)((sizeof(short)+5+sizeof(BlockDesc))&0x7fffffff)){
					// добовляем страницу 
					fndOpt= m_pFreeOnPages->seek((short)newVal);
					if(fndOpt)
						m_pFreeOnPages->contents(fndOpt)->get(page)= 0;
					else{
						tmpMap= new mapLongToChar((char)0);
						tmpMap->get(page)= (char)0;
						m_pFreeOnPages->get((short)newVal) = tmpMap;
					}
				}
			}
		}
	}
	if(!(Flags & SF_IN_FILE_DIRECT)){
		char* ptr = 0;
		if(Flags & SF_LOAD_FAT_ON_DEMAND){
			page= ((page / (file->PageSize / sizeof(*Fat)) ) * (file->PageSize / sizeof(*Fat))) + 1;
			ptr= (char*)(Fat+page-1);
			if(page == 1 && file->PageSize < *(int*)file->m_pCryptoTag){
				page= 3;
			}
			if(!(Fat[page] & FAT_CHAIN) && !file->GetPage(page, ptr)){
				LOG_E (("StreamFile :: AddFat, file->GetPage, [%d,%s]", page, file->FileName));
				abort();
			}
		}else{
		  ptr = (char*)Fat;
		  if((*(int*)file->m_pCryptoTag)/file->PageSize
															// with write mode on old base
															&& !(Fat[1] & ~FAT_CHAIN)
																						)
			  page= (*(int*)file->m_pCryptoTag)/file->PageSize;
		  else
			  page= 1;

		  while(page != 0){
			if((pOut-ptr) < file -> PageSize){
				break;
			}
			ptr += file -> PageSize;
			page = Fat[page] & ~FAT_CHAIN;
		  }
		}
		//PrePutPage(page, ptr);
		if(!m_PagesCacheBlocks){
			m_PagesCacheBlocks= new CachePagesMap(0);
		}
		if(file->curr_last >= page){
			if(!fpages->seek(page)){
				rpages->get(page) = 0;
				PrePutPage(page, ptr, Fat + (fpages->get(page)=  int((((int*)ptr)-Fat)&0x7fffffff)));
			}
		}else{
			  fpages->get(page)= int((((int*)ptr)-Fat)&0x7fffffff);
		}
		*(int*)pOut += Val;
	}else
	  *(int*)pOut += Val;
#else
	Fat[Page] += Val;
#endif
}

int StreamFile :: GetLastCreatedBlockPage()
{
	if(!LastCreatedBlockPage){
		if(file->LastPage > 1){
			int PagesPut= 1;
			while(LastCreatedBlockPage <= file->LastPage){
				if(Flags & SF_LOAD_FAT_ON_DEMAND){
					int calcFatPage= ((LastCreatedBlockPage / (file->PageSize / sizeof(*Fat)) ) * (file->PageSize / sizeof(*Fat))) + 1;
					if(!(Fat[calcFatPage] & FAT_CHAIN) && !file->GetPage(calcFatPage, Fat+calcFatPage-1)){
						LOG_E (("StreamFile :: GetLastCreatedBlockPage, file->GetPage, [%d,%s]", calcFatPage, file->FileName));
						abort();
					}
				}
				if ((Fat[LastCreatedBlockPage]&FAT_CHAIN)==0 && Fat[LastCreatedBlockPage]>=(int)((sizeof(short)+7+sizeof(BlockDesc))&0x7fffffff)){
					if(!m_pFreeOnPages){
						m_pFreeOnPages= new mapShortTo_pmapLongToChar((mapLongToChar*)0);
						mapLongToChar *tmpMap= new mapLongToChar((char)0);
						tmpMap->get(LastCreatedBlockPage)= (char)0;
						m_pFreeOnPages->get((short)Fat[LastCreatedBlockPage]) = tmpMap;
					}else{
						G_Point fnd= m_pFreeOnPages->seek((short)Fat[LastCreatedBlockPage]);
						if(fnd){
							(m_pFreeOnPages->contents(fnd))->get(LastCreatedBlockPage)= (char)0;
						}else{
							mapLongToChar *tmpMap= new mapLongToChar((char)0);
							tmpMap->get(LastCreatedBlockPage)= (char)0;
							m_pFreeOnPages->get((short)Fat[LastCreatedBlockPage]) = tmpMap;
						}
						PagesPut++;
					}
				}
				LastCreatedBlockPage++;
			}
			if(m_pFreeOnPages && (LastCreatedBlockPage= m_pFreeOnPages->length()-1) > -1){
				G_Point fndOpt= m_pFreeOnPages->first();
				while(LastCreatedBlockPage--){
					m_pFreeOnPages->next(fndOpt);
				}
				mapLongToChar *tmpMap= m_pFreeOnPages->contents(fndOpt);
				LastCreatedBlockPage= tmpMap->key(tmpMap->first());
				if(tmpMap->length() == 1){
					delete tmpMap;
					m_pFreeOnPages->del(fndOpt);
				}else{
					tmpMap->del(tmpMap->first());
				}
			}else{
				LastCreatedBlockPage= 1;
			}
		}
	}
	return LastCreatedBlockPage;
}

CachedPage *StreamFile :: forceSysBuf(bool fastAdd, int *p_bigHandle, int *p_Handle)
{
	CachedPage *pFnd= 0;
	if((pFnd= (CachedPage *)m_PagesCacheBlocks->seek(LastCreatedBlockPage))){
		pFnd= m_PagesCacheBlocks->contents(pFnd);
		UpActualLevel(pFnd,m_PagesCacheBlocks);
		if(Flags & SF_IN_FILE_DIRECT || file->curr_last < LastCreatedBlockPage){
			pFnd->m_changed= 1;
			SysBuf= (char*)(pFnd->m_Data);
			//file->Flags |= SF_UPDT_ACTUAL;
		}else{
	#ifndef WRITE_KEYS_PAGE_INBACKUP
		  if(!pWritedPages){
			if(!(pWritedPages= new NDTKPageMap(MapDefltStr))) {
				LOG_E (("abort in Index::New Handle 1"));
				abort();
			}
			pWritedPages->get(LastCreatedBlockPage) = NDTKPage(file, pFnd->m_Data);
		  }else{
			Point Fnd= pWritedPages->seek(LastCreatedBlockPage);
			if(!Fnd)
				pWritedPages->get(LastCreatedBlockPage) = NDTKPage(file, pFnd->m_Data);
			else if(Flags & SF_IN_TRANSCTN && pWritedPages->contents(Fnd).GetData() == SysBuf)
#ifdef _DEBUG
				Flags |= SF_IN_TRANSCTN
#endif
																;
			else
				memcpy(pWritedPages->contents(Fnd).GetData(),pFnd->m_Data, file->PageSize);
		  }
		  pFnd->m_changed= 0;
		  SysBuf= (char*)(pWritedPages->contents(pWritedPages->GetRootG_SimpleSplayNode()).GetData());
	#else
		  PutPage ( Page, pFnd->m_Data );
		  SysBuf= (char*)(pFnd->m_Data);
	#endif
		}
		nSysP= LastCreatedBlockPage;
		if(fastAdd){
#ifdef OLD_SHORT_STR
		if(*(short*)SysBuf == 0){
			memset(SysBuf, 0, file->PageSize);
			*(short*)SysBuf= 1;
			Fat[LastCreatedBlockPage] -= 4;
		}
#else
			if(*(short*)SysBuf > 0){
				// старая страница //
			}else if( (Flags & SF_IN_FILE_DIRECT) || file->curr_last < LastCreatedBlockPage){
				BlockDesc *BlockPtr;
				if(*(short*)SysBuf){
					BlockPtr = ((BlockDesc *) ( SysBuf + sizeof(short))) + (-(*(short*)SysBuf));
					BlockPtr->Id= (BlockPtr-1)->Id + 1;
					BlockPtr->Size= (BlockPtr-1)->Size;
				}else{
					BlockPtr = (BlockDesc *) (SysBuf+sizeof(short));
					Fat[LastCreatedBlockPage] -= sizeof ( short );
					BlockPtr->Id= 1;
					BlockPtr->Size= 0;
				}
				((short*)SysBuf)[0]--;
				Fat[LastCreatedBlockPage] -= sizeof ( BlockDesc );
				*p_Handle= (LastCreatedBlockPage << 5) | int(((BlockPtr->Id >> 11) & 0xffff));
				*p_bigHandle &= ~0x7ff00000;	// erase old low bits in Stream::allocatedSize
				*p_bigHandle |= int((BlockPtr->Id & 0x7ff)) << 20;	// put new low bits in Stream::allocatedSize
				return (CachedPage *)-1;
			}
#endif
		}
	}
	return pFnd;
}

void StreamFileFastAdd :: re_find_bytes_in_pre_pages (int Size)
{
	LastCreatedBlockPage= -1;
	NextIdPerOldPage= 1;
}

BlockDesc* StreamFileFastAdd::getOldBlock()
{
		BlockDesc     *BlockPtr = (BlockDesc *)(SysBuf+(file->PageSize - Fat[LastCreatedBlockPage]));
		NextIdPerOldPage++;
		BlockPtr->Id= NextIdPerOldPage;
		BlockPtr->Size= 0;
		return BlockPtr;
}

BlockDesc* StreamFile::getOldBlock()
{
		BlockDesc     *BlockPtr = (BlockDesc *) SysBuf, d;
		d.Id = 1;
		d.Size = 0;
		for ( int Offs = 0; BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( SysBuf + Offs ) ){
			if ( BlockPtr -> Id == d.Id )
			{
				d.Id ++;
				Offs = 0;
			}
			else
				Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;
		}
		memmove ( BlockPtr, &d, sizeof ( BlockDesc ) );
		return BlockPtr;
}

void StreamFile :: re_find_bytes_in_pre_pages (int Size)
{
			  G_Point fndOpt= 0;
			  if(m_pFreeOnPages && m_pFreeOnPages->length()){
				fndOpt= m_pFreeOnPages->seek((short)(Size+sizeof(short)+sizeof(BlockDesc)));
				if(fndOpt){
					fndOpt= fndOpt;
				}else if(m_pFreeOnPages->GetRootG_SimpleSplayNode()->item > (short)(Size+sizeof(short)+sizeof(BlockDesc))){
					fndOpt= (G_Point)m_pFreeOnPages->GetRootG_SimpleSplayNode();
				}
			  }
			  if(LastCreatedBlockPage > 1
				  && Fat[LastCreatedBlockPage] > (int)((sizeof ( BlockDesc ) + sizeof(short) + sizeof(int)) & 0x7fffffff)){
				if(!m_pFreeOnPages){
					m_pFreeOnPages= new mapShortTo_pmapLongToChar((mapLongToChar*)0);
					mapLongToChar *tmpMap= new mapLongToChar((char)0);
					tmpMap->get(LastCreatedBlockPage)= (char)0;
					m_pFreeOnPages->get((short)Fat[LastCreatedBlockPage]) = tmpMap;
				}else{
					G_Point fnd= m_pFreeOnPages->seek((short)Fat[LastCreatedBlockPage]);
					if(fnd){
						(m_pFreeOnPages->contents(fnd))->get(LastCreatedBlockPage)= (char)0;
					}else{
						mapLongToChar *tmpMap= new mapLongToChar((char)0);
						tmpMap->get(LastCreatedBlockPage)= (char)0;
						m_pFreeOnPages->get((short)Fat[LastCreatedBlockPage]) = tmpMap;
					}
				}
			  }
			  if(!fndOpt)
				  LastCreatedBlockPage= -1;
			  else{
				mapLongToChar *tmpMap= m_pFreeOnPages->contents(fndOpt);
				LastCreatedBlockPage= tmpMap->key(tmpMap->first());
				if(tmpMap->length() == 1){
					delete tmpMap;
					m_pFreeOnPages->del(fndOpt);
				}else{
					tmpMap->del(tmpMap->first());
				}
			  }
}

unsigned short	StreamFile :: NewHandle ( int Size, int *p_bigHandle, void *pNewData, int *p_Handle)
{
	unsigned short Id; LastCreatedBlockPage= GetLastCreatedBlockPage();

	if ( IsNotBlock( Size ) ) {
		// allocate whole page
		short preFatSize= fatPages;
		if(file->LastPage + 1 == LastCreatedBlockPage && Fat[LastCreatedBlockPage] != file->PageSize)
			file->LastPage++;
		int	Page = AllocPage (p_bigHandle ? *p_bigHandle : 0);
		//if(file->PageSize == 8192 && Page == 3)
		//	Page= 3;
		if(preFatSize == fatPages){
			if(Page == file->LastPage){
				Flags |= SF_NEW_HANDLE;
			}
		}else{
			if(Page == file->LastPage - 1){
				Flags |= SF_NEW_HANDLE;
			}
		}
		AsUpdated(Page,(Flags & SF_NEW_HANDLE) ? pNewData : SysBuf);
		AddFatNext(Page, (int)FAT_CHAIN - (int)Fat[Page]); // set hi-bit to 1, next page to 0
		Flags     |= PF_MODIFIED;

		//if(p_bigHandle){
			*p_bigHandle &= ~0x7ff00000;
			*p_Handle= Page << 5;
		//}else
		//	*p_Handle= Page << 12;

		Id= 0;
	}else{
		BlockDesc     * BlockPtr = (BlockDesc *) SysBuf;
	#ifdef _DEBUG
		if((Fat[LastCreatedBlockPage]&FAT_CHAIN))
			BlockPtr= BlockPtr;
	#endif
		CachedPage *pFnd= 0;
		if (Fat[LastCreatedBlockPage]>=(int)((Size+sizeof(short)+sizeof(BlockDesc))&0x7fffffff)){
			if((pFnd= forceSysBuf(true, p_bigHandle, p_Handle))){
				if(pFnd == (CachedPage *)-1){
					return NEW_STREAM_HANDLE_TO_ID( *p_Handle, *p_bigHandle );
				}else
					BlockPtr = (BlockDesc *) SysBuf;
			}
		}else{
			if(file->LastPage + 1 == LastCreatedBlockPage && Fat[LastCreatedBlockPage] != file->PageSize)
				file->LastPage++;
			re_find_bytes_in_pre_pages(Size);
		}

		if ( LastCreatedBlockPage == -1l ) {
			// allocate new page
			LastCreatedBlockPage = AllocPage (p_bigHandle ? *p_bigHandle : 0);
			SysBuf= aSysBuf;
			BlockPtr = (BlockDesc *) SysBuf;
#ifdef OLD_SHORT_STR
			AddFat(LastCreatedBlockPage, (int)file -> PageSize - (int)Fat[LastCreatedBlockPage] - 4);
			memset(BlockPtr, 0, file->PageSize);
			BlockPtr -> Id= 1;
#else
			AddFat(LastCreatedBlockPage, (int)file -> PageSize - (int)Fat[LastCreatedBlockPage]);
			BlockPtr -> Id= 0;
#endif
		}else if(Fat[LastCreatedBlockPage] == file -> PageSize || !pFnd){
			if(!(Flags & SF_IN_FILE_DIRECT)){
				rpages->get(LastCreatedBlockPage)= 0;
				if(file->curr_last < LastCreatedBlockPage){
					/*PrePutPage(LastCreatedBlockPage, SysBuf, SysBuf);*/
					if(nSysP != LastCreatedBlockPage){
						SysBuf= 0;
					}
				}else if(nSysP != LastCreatedBlockPage){
					SysBuf= 0;
				}
			}else if(nSysP && nSysP != LastCreatedBlockPage){
				SysBuf= 0;
			}
			if(!SysBuf){
				if(!forceSysBuf(false)){
					GetStrsPageFromCache( LastCreatedBlockPage, (SysBuf= aSysBuf) );
					if(!forceSysBuf(false)){
						LOG_E (("StreamFile :: NewHandle, forceSysBuf, [%s]", file->FileName));
						abort();
					}
				}
				BlockPtr = (BlockDesc *) SysBuf;
			}
			if(Fat[LastCreatedBlockPage] == file -> PageSize){
				BlockPtr -> Id= 0;
			}else{
				// pFnd->m_changed= 1; ???
				if(*(short*)SysBuf > 0){
					// старая страница //
	#ifdef _DEBUG
					BlockPtr = (BlockDesc *)SysBuf;
	#endif
				}else if(Flags & SF_IN_FILE_DIRECT){
					BlockPtr = ((BlockDesc *) (SysBuf + sizeof(short))) + (-(*(short*)SysBuf));nSysP= LastCreatedBlockPage;
					((short*)SysBuf)[0]--;
					BlockPtr->Id= (BlockPtr-1)->Id + 1;
					BlockPtr->Size= (BlockPtr-1)->Size;
					Fat[LastCreatedBlockPage] -= sizeof ( BlockDesc );
					Size = (int)(BlockPtr->Id & 0x7fff);	// low bits from Id
					*p_bigHandle &= ~0x7f000000;	// erase old low bits in Stream::allocatedSize
					*p_bigHandle |= Size << 24;	// put new low bits in Stream::allocatedSize
					return ( LastCreatedBlockPage << 5 ) | (BlockPtr->Id >> 7);
				}
	#ifdef _DEBUG
				else
					BlockPtr = (BlockDesc *)SysBuf;
	#endif
			}
		}
		if(*(short*)BlockPtr == 0){
			if(Fat[LastCreatedBlockPage]>=(int)(Size+sizeof(short)+sizeof(BlockDesc))){
				*(short*)SysBuf= -1;
				BlockPtr = (BlockDesc *) (SysBuf + sizeof(short));
			}else
				BlockPtr->Id= 1;
			BlockPtr->Id= 1;
			BlockPtr->Size= 0;
			AddFat(LastCreatedBlockPage, -(int)(sizeof ( BlockDesc )+sizeof(short)));
		}else if(*(short*)BlockPtr > 0){
			BlockPtr= getOldBlock();
			AddFat(LastCreatedBlockPage, -(int)sizeof ( BlockDesc ));
		}else{
			BlockPtr = ((BlockDesc *) (SysBuf + sizeof(short))) + (-(*(short*)SysBuf));
			((short*)SysBuf)[0]--;
			AddFat(LastCreatedBlockPage, -(int)sizeof ( BlockDesc ));
			BlockPtr->Id= (BlockPtr-1)->Id + 1;
			if(BlockPtr->Id > (0xffff - 2)){
				m_LastNewId= BlockPtr->Id;
			}
			BlockPtr->Size= (BlockPtr-1)->Size;
		}
		/*if(Flags & SF_IN_FILE_DIRECT || file->curr_last < LastCreatedBlockPage ){
			//if(!m_stepWriteBuff)
			//	PutStrsPageFromCache( LastCreatedBlockPage, SysBuf );
			nSysP= LastCreatedBlockPage;
		}else if(file->curr_last < LastCreatedBlockPage ){
			if(!m_stepWriteBuff)
				PutStrsPageFromCache( LastCreatedBlockPage, SysBuf );
			nSysP= LastCreatedBlockPage;
		}else{
			AsUpdated(LastCreatedBlockPage,SysBuf);
			PrePutPage(LastCreatedBlockPage, SysBuf, SysBuf);
		}*/
		/*if(!p_bigHandle)
			Id= ( LastCreatedBlockPage << 12 ) | (int)(BlockPtr->Id & 0x7fff);
		else */if(*(short*)SysBuf > 0){
			Size = (int)(BlockPtr->Id & 0x7fff);	// low bits from Id
			*p_bigHandle &= ~0x7f000000;	// erase old low bits in Stream::allocatedSize
			*p_bigHandle |= Size << 24;	// put new low bits in Stream::allocatedSize
			*p_Handle= ( LastCreatedBlockPage << 5 ) | (BlockPtr->Id >> 7);
			Id= Handle4Id ( *p_Handle, *p_bigHandle );
		}else{
			*p_Handle= (LastCreatedBlockPage << 5) | int(((BlockPtr->Id >> 11) & 0xffff));
			*p_bigHandle &= ~0x7ff00000;	// erase old low bits in Stream::allocatedSize
			*p_bigHandle |= int((BlockPtr->Id & 0x7ff)) << 20;	// put new low bits in Stream::allocatedSize
			Id= NEW_STREAM_HANDLE_TO_ID( *p_Handle, *p_bigHandle );
		}
		Flags      |= PF_MODIFIED;
		/*if(*(short*)SysBuf > -1){
			Page= (((*p_bigHandle) &  FAT_CHAIN) ? Handle4Page ( *p_Handle ) : Handle2Page ( *p_Handle ));
			return (((*p_bigHandle) &  FAT_CHAIN) ? Handle4Id ( *p_Handle, *p_bigHandle ): Handle2Id ( *p_Handle ));
		}else{
			Page= str->Handle >> 5;
			Id = NEW_STREAM_HANDLE_TO_ID( *p_Handle, *p_bigHandle );
		}*/
	}
	return Id;
}

//##ModelId=3BFE7DEB0138
int	StreamFile :: DelHandle ( int bigHandle, Stream *str )
{
	if ( str->Handle == 0 )
		return 1;

	int	Page = ((bigHandle &  FAT_CHAIN) ? Handle4Page ( str->Handle ) : Handle2Page ( str->Handle ));

	if(str->m_Id > 0){
		int	Offs= FindSubBlock ( Page, str->m_Id);

		if ( Offs < 0 ){
			LOG_E (("StreamFile :: NewHandle, FindSubBlock, [%s]", file->FileName));
			abort();
		}
		if(Flags & SF_LOAD_FAT_ON_DEMAND){
			bigHandle= ((Page / (file->PageSize / sizeof(*Fat)) ) * (file->PageSize / sizeof(*Fat))) + 1;
			if(!(Fat[bigHandle] & FAT_CHAIN) && !file->GetPage(bigHandle, Fat+bigHandle-1)){
				abort();
			}
		}
		RemoveBlock ( Page, Offs );
	}else
		return FreePageChain ( Page );

	return 1;
}

int	StreamFile :: FindPage ( int Handle, int PageNo, int Per4Bytes )
{
	int Page = ((Per4Bytes &  FAT_CHAIN) ? Handle4Page ( Handle ) : Handle2Page ( Handle ));
	if(PageNo){
		do{
			PageNo--;
			assert ( ( Fat[Page] & FAT_CHAIN ) != 0 );
			Page = Fat[Page] & ~FAT_CHAIN;
		}while( Page && PageNo > 0 );
	}
	return Page;
}

int	StreamFile :: AddNewPage    ( int i, int bigHandle ){
	// set hi-bit to 1 and set next page
	int Page = AllocPage (bigHandle);
	AddFat(i, (int)(FAT_CHAIN | (int) Page) - (int)Fat[i]);
	if(lastFatPage == i)
		Fat[Page]= FAT_CHAIN;
	else
		AddFat(Page, (int)FAT_CHAIN - (int)Fat[Page]);
	Flags     |= PF_MODIFIED;
	return Page;
}

int	StreamFile :: AppendPage ( int Handle, int bigHandle ){
	int	i = ((bigHandle &  FAT_CHAIN) ? Handle4Page ( Handle ) : Handle2Page ( Handle ));
	assert ( ( Fat[i] & FAT_CHAIN ) != 0 );
	for (; Fat[i] & ~FAT_CHAIN; )	// find last page
		i = Fat[i] & ~FAT_CHAIN;
	return AddNewPage( i, bigHandle );
}

//##ModelId=3BFE7DEB019B
int	StreamFile :: FreePageChain ( int Page )
{
	while ( Page != 0 )
	{
		int	nextPage;

		if(	!(Flags & SF_IN_FILE_DIRECT) && (Flags & SF_LOAD_FAT_ON_DEMAND)
			&& !(Fat[(nextPage= ((Page / (file->PageSize / sizeof(*Fat)) ) * (file->PageSize / sizeof(*Fat))) + 1)] & FAT_CHAIN)
			&& !file->GetPage(nextPage, Fat+nextPage-1))
		{
				LOG_E (("StreamFile :: FreePageChain, file->GetPage, [%d,%s]", nextPage, file->FileName));
				abort();
		}
		nextPage = (int) ( Fat[Page] & ~FAT_CHAIN );

		if(!( Fat[Page] & FAT_CHAIN ) || nextPage == Page){
			LOG_E (("StreamFile :: FreePageChain, not find next Page in Long Stream, [%d,%s]", Page, file->FileName));
			abort();
		}

		AddFatNext(Page, (int)file->PageSize - (int)Fat[Page]);// mark page as FREE

		file -> DelPage ( Page );

		Page= nextPage;
	}

	Flags |= PF_MODIFIED;

	return 1;
}

/*!
	load block ( page ) from stream with a given number
	returns
	# of bytes transferred, or -1 if error
*/

//##ModelId=3BFE7DEB0155
int	StreamFile :: LoadBlock ( Stream *str, int PageNo, void * buf)
{
	int page= ( str->isBigHandle() ? FindPage ( str->Handle, PageNo, str->allocatedSize) : FindPage ( str->Handle, PageNo ));
	if ( str->m_Id == 0 )			// chain of pages
	{
		if(page){
			if ( GetPage ( page, buf ) )
				return file -> PageSize;
			LOG_E (("StreamFile :: LoadBlock, GetPage, [%d,%s]", page, file->FileName));
			abort();
		}else
			return 1;
	}
	// it's a subblock on a page
	int	Offs = FindSubBlock ( page, str->m_Id );
	if ( Offs < 0 )
		// error
		return -1;

	BlockDesc * BlockPtr = (BlockDesc *) ( SysBuf + Offs );
	if(*(short*)SysBuf > -1){
		memmove ( buf, BlockPtr + 1, BlockPtr -> Size );
		return BlockPtr -> Size;
	}
	Offs= BlockPtr->Size - (Offs == sizeof(short) ? 0 :(BlockPtr - 1)->Size);
	memcpy( buf, SysBuf + file -> PageSize - BlockPtr->Size, Offs );
	return Offs;
}


/*!
	saves block ( page ) from stream with a given number
	Handle may be modified due to reallocation
	returns
	# of bytes transferred, or -1 if error
*/

int StreamFileFastAdd :: prePut_for_test_IO ()
{
	return 1;
}

int StreamFile :: prePut_for_test_IO ()
{
	return file->PutPage(LastCreatedBlockPage, SysBuf);
}

int StreamFile::directSysBuf(int Page, bool bPut)
{
	if(Flags & SF_IN_FILE_DIRECT || file->curr_last < Page){
		CachedPage *pFnd= 0;
		if(!m_PagesCacheBlocks){
			m_PagesCacheBlocks= new CachePagesMap(0);
		}else if((pFnd= (CachedPage *)m_PagesCacheBlocks->seek(Page))){
			if(bPut){
				if((m_PagesCacheBlocks->contents(pFnd))->m_Data != SysBuf)
					PutStrsPageFromCache( Page, SysBuf );
				else{
					(m_PagesCacheBlocks->contents(pFnd))->m_changed= 1;
					UpActualLevel(m_PagesCacheBlocks->contents(pFnd),m_PagesCacheBlocks);
				}
			}
		}
		if(!bPut && !pFnd){
			AddPageFromCache(Page	, m_PagesCacheBlocks
									, file
									, SysBuf
									, &m_pCacheBlocksStack
									, &m_pCacheBlocksStackCount);

			pFnd= (CachedPage *)m_PagesCacheBlocks->GetRootG_SimpleSplayNode();
		}
		if(pFnd){
			SysBuf= (m_PagesCacheBlocks->contents(pFnd))->m_Data;nSysP= Page;
		}else if(bPut){
			if(Page == LastCreatedBlockPage){
				/*if(!prePut_for_test_IO()){
					LOG_E (("abort in Stream :: Save (prePut)"));
					abort();
				}*/
				AddPageFromCache(	LastCreatedBlockPage
										, m_PagesCacheBlocks
										, file
										, SysBuf
										, &m_pCacheBlocksStack
										, &m_pCacheBlocksStackCount);
				CachedPage *pFnd= m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
				UpActualLevel(pFnd,m_PagesCacheBlocks);
				pFnd->m_changed= 1;
				SysBuf= pFnd->m_Data;
				nSysP= LastCreatedBlockPage;
				//file->Flags |= SF_UPDT_ACTUAL;
			}
			return 0;
		}else{
			LOG_E (("abort in StreamFile::directSysBuf"));
			abort();
		}
	}else
		return 1;

	return 0;
}

int	StreamFile::SaveBlock(Stream *str, int PageNo, void * buf, int Size, int *p_bigHandle)
{
	static char Err77[]= "abort in Index::New Handle - New Page Only Clone format (%d)";
	int	Delta= 0, Page;

	if ( str->Handle == 0 ){
		str->m_Id= NewHandle ( Size, p_bigHandle,  buf, &str->Handle);
		Delta= -1;
	}
Retry:
	if ( str->m_Id == 0 )				// chain of pages
	{
		if(Flags & SF_NEW_HANDLE){
			Page=Handle4Page( str->Handle );
			if(PageNo){
				PageNo += 1;//(int)(Page - 1) + new_fatPages;
				Page = AllocPage (*p_bigHandle);
				//if(Page != (int)(PageNo + 1))
					//new_fatPages++;
				AddFatNext(PageNo, (int)(FAT_CHAIN | (int) Page) - (int)Fat[PageNo]);
				AddFatNext(Page, (int)FAT_CHAIN - (int)Fat[Page]);
				Flags     |= PF_MODIFIED;
			}
		}else{
			if (( Page = FindPage ( str->Handle, PageNo, *p_bigHandle ) ) == 0)
				Page = AppendPage ( str->Handle, p_bigHandle ? *p_bigHandle : 0 );
		}
#ifndef WRITE_KEYS_PAGE_INBACKUP
		Point Fnd0;
		if(pWritedPages && (Fnd0= pWritedPages->seek(Page))){
			memcpy(pWritedPages->contents(Fnd0).GetData(), buf, file->PageSize);
			return Size;
		}else
#endif
		if ( ((Flags & SF_NEW_HANDLE) && !PageNo) ||  PutPage ( Page, buf ) )
			return Size;
		else
			return -1;
	}
	int	Offs;
	Page= ((p_bigHandle && ((*p_bigHandle) &  FAT_CHAIN)) ? Handle4Page ( str->Handle ) : Handle2Page ( str->Handle ));
	if(Delta != -1){
		if(nSysP != Page){
			GetStrsPageFromCache( Page, (SysBuf= aSysBuf) ); nSysP= Page;
		}
		if(!m_stepWriteBuff && (Flags & SF_IN_TRANSCTN)){
			if(Flags & SF_IN_FILE_DIRECT)
				;
			else{
				if(file->curr_last >= Page){
				  if(!pWritedPages && !(pWritedPages= new NDTKPageMap(MapDefltStr))) {
					LOG_E (("abort in Index::New Handle 1111"));
					abort();
				  }
				  if(!pWritedPages->seek(Page))
					pWritedPages->get(Page) = NDTKPage(file, 0);
				}
				/*if(!LastCreatedBlockPage){
					LastCreatedBlockPage= GetLastCreatedBlockPage();
					if(LastCreatedBlockPage != -1){
						if(!(m_PagesCacheBlocks->seek(LastCreatedBlockPage))){
							void *ttt= alloca(file->PageSize);
							GetStrsPageFromCache( LastCreatedBlockPage, ttt);
						}
					}else{
						LastCreatedBlockPage = AllocPage (p_bigHandle ? *p_bigHandle : 0);
						void *NewData= alloca(file->PageSize);
						memset(NewData, 0, file->PageSize);
						Fat[LastCreatedBlockPage]= file->PageSize;
						if ( !PutStrsPageFromCache( LastCreatedBlockPage, NewData ) )
							return -1;
						file->Flags &= ~SF_UPDT_ACTUAL;
					}
				}*/
			}
		}else if(Flags & SF_IN_FILE_DIRECT)
			;
		else
			AsUpdated(Page,SysBuf);

		Offs = FindSubBlock ( 0, str->m_Id );
	}else
		Offs = FindSubBlock ( 0, str->m_Id );

	if ( Offs < 0 )
		// error
		return -1;

	BlockDesc * BlockPtr = (BlockDesc *) ( SysBuf + Offs );

	if(*(short*)SysBuf > -1){
		if ( !Delta ){
			if (Fat[Page] - (Delta = Size - BlockPtr -> Size) < 0){
				if(p_bigHandle)
					RemoveBlock ( Page, Offs, str, Size, buf );
				else{
					RemoveBlock ( Page, Offs, str, Size, buf );
					if(nSysP == LastCreatedBlockPage){
						p_bigHandle= &(str->allocatedSize);
						*p_bigHandle |= FAT_CHAIN;
					}else if(LastCreatedBlockPage == file->LastPage){
						if(*(short*)SysBuf > -1){
							LOG_E ((Err77, 1));
							abort();
						}else{
							p_bigHandle= &(str->allocatedSize);
							*p_bigHandle |= FAT_CHAIN;
						}
					}
				}
				Delta= -1;
				goto Retry;
			}
		}else
			Delta = Size - BlockPtr -> Size;

		Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;
		if(file -> PageSize - Offs - Delta < 0){
			char msf[]= "(%x,%d,%x)abort in StreamFile::SaveBlock(Bad BlockDesc!)(%s)";
#ifdef PLAIN_GKDB
			LOG_E ((msf, this, /*Current Thread ID*/1999, str->Handle, file->FileName));
#else
			LOG_E ((msf, this, ACE_OS::thr_self(), str->Handle, file->FileName));
#endif
			abort();
		}
		if(Delta){
			memmove ( SysBuf + Offs + Delta, SysBuf + Offs, file -> PageSize - Offs - Delta );
			memmove ( BlockPtr + 1, buf, Size );
			BlockPtr -> Size   = Size;
			if(Fat[Page] == file -> PageSize && Delta < 0) {
				AddFat(Page, -(int)Delta);
				memset(SysBuf + file -> PageSize - Fat[Page], '\0', Fat[Page]);
			}else{
				AddFat(Page, -(int)Delta);
			}
		}else
			memmove ( BlockPtr + 1, buf, Size );
	}else{
		if(Delta != -1){
			Delta= BlockPtr->Size - (Offs == sizeof(short) ? 0 :(BlockPtr - 1)->Size);
			if(Flags & SF_LOAD_FAT_ON_DEMAND){
				if(Delta < Size){
					int calcFatPage= ((Page / (file->PageSize / sizeof(*Fat)) ) * (file->PageSize / sizeof(*Fat))) + 1;
					if(!(Fat[calcFatPage] & FAT_CHAIN) && !file->GetPage(calcFatPage, Fat+calcFatPage-1)){
						abort();
					}
					if (Fat[Page] - (Delta= Size - Delta) < 0){
						if(p_bigHandle)
							RemoveBlock ( Page, Offs, str, Size, buf );
						else{
							RemoveBlock ( Page, Offs, str, Size, buf );
							if(nSysP == LastCreatedBlockPage){
								p_bigHandle= &(str->allocatedSize);
								*p_bigHandle |= FAT_CHAIN;
							}else if(LastCreatedBlockPage == file->LastPage){
								if(*(short*)SysBuf > -1){
									LOG_E ((Err77, 1));
									abort();
								}else{
									p_bigHandle= &(str->allocatedSize);
									*p_bigHandle |= FAT_CHAIN;
								}
							}
						}
						Delta= -1;
						goto Retry;
					}
				}else
					Delta= Size - Delta;
			}else if (Fat[Page] - (Delta= Size - Delta) < 0){
				if(p_bigHandle)
					RemoveBlock ( Page, Offs, str, Size, buf );
				else{
					RemoveBlock ( Page, Offs, str, Size, buf );
					if(nSysP == LastCreatedBlockPage){
						p_bigHandle= &(str->allocatedSize);
						*p_bigHandle |= FAT_CHAIN;
					}else if(LastCreatedBlockPage == file->LastPage){
						if(*(short*)SysBuf > -1){
							LOG_E ((Err77, 1));
							abort();
						}else{
							p_bigHandle= &(str->allocatedSize);
							*p_bigHandle |= FAT_CHAIN;
						}
					}
				}
				Delta= -1;
				goto Retry;
			}
		}else
			Delta= Size - (BlockPtr->Size - (Offs == sizeof(short) ? 0 :(BlockPtr - 1)->Size));
		if(Delta){
			BlockDesc *BlockPtrLast= (BlockDesc *)(SysBuf + sizeof(BlockDesc) * (-(*(short*)SysBuf)-1) + sizeof(short));
			if(BlockPtr < BlockPtrLast){
				// move next data //
				memmove(SysBuf + file -> PageSize - BlockPtrLast->Size - Delta,
						SysBuf + file -> PageSize - BlockPtrLast->Size,
							BlockPtrLast->Size - BlockPtr->Size);
				do{
					BlockPtrLast->Size += Delta;
				}while(--BlockPtrLast > BlockPtr);
			}
			BlockPtr->Size += Delta;
			AddFat(Page, -(int)Delta);
			if(!LastCreatedBlockPage){
				LastCreatedBlockPage= GetLastCreatedBlockPage();
				if(LastCreatedBlockPage != -1){
					if(!(m_PagesCacheBlocks->seek(LastCreatedBlockPage))){
						void *ttt= alloca(file->PageSize);
						GetStrsPageFromCache( LastCreatedBlockPage, ttt);
					}
				}else{
					LastCreatedBlockPage = AllocPage (p_bigHandle ? *p_bigHandle : 0);
					void *NewData= alloca(file->PageSize);
					memset(NewData, 0, file->PageSize);
					Fat[LastCreatedBlockPage]= file->PageSize;
					if ( !PutStrsPageFromCache( LastCreatedBlockPage, NewData ) )
						return -1;
					//file->Flags &= ~SF_UPDT_ACTUAL;
				}
			}
		}	
		memmove(	SysBuf + file -> PageSize - BlockPtr->Size, buf, Size );
	}
	Flags             |= PF_MODIFIED;

	if(directSysBuf(Page, true)){
#ifndef WRITE_KEYS_PAGE_INBACKUP
	  if(!pWritedPages && !(pWritedPages= new NDTKPageMap(MapDefltStr))) {
		LOG_E (("abort in Index::New Handle 1"));
		abort();
	  }
	  Point Fnd = pWritedPages->seek(Page);
	  if(Fnd){
		  if(pWritedPages->contents(Fnd).GetData() != SysBuf){
			memcpy(pWritedPages->contents(Fnd).GetData(),SysBuf,file->PageSize);
		  }/* else{
				if(Flags & SF_IN_TRANSCTN){
				}else{
					// Поддерживаем изоляционность...
					CachedPage *pFnd;
					if((pFnd= (CachedPage *)m_PagesCacheBlocks->seek(Page))){
						pFnd= m_PagesCacheBlocks->contents(pFnd);
						UpActualLevel(pFnd,m_PagesCacheBlocks);
						SysBuf= (char*)(pFnd->m_Data);
					}else
						SysBuf= aSysBuf;
				}
		  }*/
	  }else
#endif
		if ( !PutStrsPageFromCache( Page, SysBuf ) )
			return -1;
	}
	return Size;
}

//##ModelId=3BFE7DEB0187
int	StreamFile :: TruncStream ( Stream * str, int NewSize, int *p_bigHandle, char *newData )
{
	if(str->m_Id > 0)
	{
		int Page = ((p_bigHandle && ((*p_bigHandle) &  FAT_CHAIN)) ? Handle4Page ( str -> Handle ) : Handle2Page ( str -> Handle ));
		int Offs= 0;
		BlockDesc * BlockPtr= 0;

		if ( ( Offs = FindSubBlock ( Page, str->m_Id ) ) < 0 )
			return -1;

		BlockPtr = (BlockDesc *)( SysBuf + Offs );

		if(*(short*)SysBuf > -1){
			NewSize = (int)( BlockPtr -> Size - NewSize );
			if ( !NewSize  )
				return 1; // Не стоит переливать из пустого в порожнее :-)
			assert ( NewSize > 0 );
			int	Offs2 = Offs + BlockPtr -> Size + sizeof ( BlockDesc );


			memmove ( SysBuf + Offs2 - NewSize, SysBuf + Offs2, file -> PageSize - Offs2 );
			memset  ( SysBuf + file -> PageSize - NewSize, '\0', NewSize );
			BlockPtr -> Size -= (short)NewSize;
			if(newData){
				memmove ( BlockPtr + 1, newData, BlockPtr -> Size );
			}
		}else{
			NewSize= (BlockPtr->Size - (Offs == sizeof(short) ? 0 :(BlockPtr - 1)->Size)) - NewSize;

			if(NewSize < 1){
				if(newData){
					memmove(	SysBuf + file -> PageSize - BlockPtr->Size, newData, str->Pos );
					AsUpdated(Page,SysBuf);
				}
				return 1;
			}
			BlockDesc *BlockPtrLast= (BlockDesc *)(SysBuf + sizeof(BlockDesc) * (-(*(short*)SysBuf)-1) + sizeof(short));
			if(BlockPtr < BlockPtrLast){
				// move next data //
				memmove(SysBuf + file -> PageSize - BlockPtrLast->Size + NewSize,
						SysBuf + file -> PageSize - BlockPtrLast->Size, BlockPtrLast->Size - BlockPtr->Size);
				do{
					BlockPtrLast->Size -= NewSize;
				}while(--BlockPtrLast > BlockPtr);
			}
			BlockPtr->Size -= (short)NewSize;
			if(newData){
				memmove(	SysBuf + file -> PageSize - BlockPtr->Size, newData, str->Pos );
			}
		}
		AddFat(Page, (int)NewSize);
		AsUpdated(Page,SysBuf);
	}else{
		if ( !IsNotBlock( NewSize ) )
		{
			FreePageChain ( (str -> Handle= ((p_bigHandle && ((*p_bigHandle) &  FAT_CHAIN)) ? Handle4Page ( str -> Handle ) : Handle2Page ( str -> Handle ))) );
			str->Handle = 0;
			str->allocatedSize= FAT_CHAIN | NewSize;
			return SaveBlock(str, 0, newData, NewSize, &(str->allocatedSize));
		}
		int Page= (int)( (NewSize-1) / file -> PageSize ), nextPage;

		Page= FindPage ( str -> Handle, Page, (p_bigHandle && ((*p_bigHandle) &  FAT_CHAIN)) ? *p_bigHandle : 0 );

		if((nextPage = (int) ( Fat[Page] & ~FAT_CHAIN ))){
			AddFat(Page, (int)FAT_CHAIN - (int)Fat[Page]); // clear low-order bits (Next = 0)
			FreePageChain ( nextPage );
		}
	}
	Flags |= PF_MODIFIED;

	return 1;
}

void StreamFile :: AsUpdated(int Page, void *NewBody)
{
	if(NewBody == SysBuf && !directSysBuf(Page, true))
		;
	else if(Flags & SF_IN_FILE_DIRECT || file->curr_last < Page){
		PutStrsPageFromCache( Page, NewBody );
	}else{
#ifndef WRITE_KEYS_PAGE_INBACKUP
	  if(!pWritedPages){
		if(!(pWritedPages= new NDTKPageMap(MapDefltStr))) {
			LOG_E (("abort in Index::New Handle 1"));
			abort();
		}
		pWritedPages->get(Page) = NDTKPage(file, NewBody);
	  }else{
		Point Fnd= pWritedPages->seek(Page);
		if(!Fnd)
			pWritedPages->get(Page) = NDTKPage(file, NewBody);
		else if(pWritedPages->contents(Fnd).GetData() != NewBody){
			memcpy(pWritedPages->contents(Fnd).GetData(), NewBody, file->PageSize);
		}else
			SysBuf= SysBuf;
	  }
	  if(Page == nSysP)
		  SysBuf= (char*)(pWritedPages->contents(pWritedPages->GetRootG_SimpleSplayNode()).GetData());
#else
	  PutPage ( Page, NewBody );
#endif
	}
}

int	*StreamFile :: RemoveBlock ( int Page, int Offs, Stream *str, int NewSize, void *pNewData )
{
	int putFree= 0;
	if(Page !=	LastCreatedBlockPage && m_pFreeOnPages){
		putFree++;
	}
	AsUpdated(Page,SysBuf);
	Flags |= PF_MODIFIED;

	BlockDesc * BlockPtr = (BlockDesc *)( SysBuf + Offs );
	int Size;
	if(*(short*)SysBuf > -1){
		int Size     = BlockPtr -> Size;
		int	    Offs2    = Offs + sizeof ( BlockDesc ) + Size;

		memmove ( SysBuf + Offs, SysBuf + Offs2, file -> PageSize - Offs2 );
		memset  ( SysBuf + file -> PageSize - sizeof ( BlockDesc ) - Size, '\0', sizeof ( BlockDesc ) + Size );
		if(Fat[Page]) 
			AddFat(Page, sizeof ( BlockDesc ) + Size, putFree);		// hope hi-bit won't be affected
		else{
			AddFat(Page, sizeof ( BlockDesc ) + Size, putFree);
			memset(SysBuf + file -> PageSize - Fat[Page], '\0', Fat[Page]);
		}
	}else if(*(short*)SysBuf == -1){
		*(short*)SysBuf= 0;
		AddFat(Page, (int)file -> PageSize - (int)Fat[Page], putFree);
		//LastCreatedBlockPage= Page;
	}else{
		Size= BlockPtr->Size - (Offs == sizeof(short) ? 0 :(BlockPtr - 1)->Size);
		BlockDesc *BlockPtrLast= (BlockDesc *)(SysBuf + sizeof(BlockDesc) * (-(*(short*)SysBuf)-1) + sizeof(short));
		if(BlockPtr < BlockPtrLast){
			// move next data //
			memmove(SysBuf + file -> PageSize - BlockPtrLast->Size + Size,
					SysBuf + file -> PageSize - BlockPtrLast->Size,
						BlockPtrLast->Size - BlockPtr->Size);
			while(++BlockPtr <= BlockPtrLast){
				(BlockPtr-1)->Id= BlockPtr->Id;
				(BlockPtr-1)->Size= BlockPtr->Size - Size;
			}
		}
		(*(short*)SysBuf)++;
		AddFat(Page, (int)Size + sizeof ( BlockDesc ), putFree);
	}
	if(Page !=	LastCreatedBlockPage && !m_pFreeOnPages && (Fat[Page] > (int)((sizeof ( BlockDesc ) + sizeof(short) + sizeof(int)) & 0x7fffffff))){
		m_pFreeOnPages= new mapShortTo_pmapLongToChar((mapLongToChar*)0);
		mapLongToChar *tmpMap= new mapLongToChar((char)0);
		tmpMap->get(Page)= (char)0;
		m_pFreeOnPages->get((short)Fat[Page]) = tmpMap;
	}
	if(str)
		str->m_Id = NewHandle ( NewSize, &(str->allocatedSize),  pNewData, &(str->Handle));

	return 0;
}

//##ModelId=3BFE7DEB01A8
int	StreamFile :: CheckPage ( int page )
/*
 * return 0 if page ok; 
 *        diff otherwise
 */
{
	if ( Fat[page] & FAT_CHAIN )
		return 0;

	int	FreeSpace1 = Fat[page];
	int	FreeSpace2 = file -> PageSize;
	void  * buf = file -> AllocBuf ();

	BlockDesc     * BlockPtr = (BlockDesc *) buf;

	GetPage ( page, buf );

	for ( int Offs = 0; Offs < (int)(file -> PageSize - sizeof ( BlockDesc )) && BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( Offs + (char *) buf ) )
	{
		FreeSpace2 -= sizeof ( BlockDesc ) + BlockPtr -> Size;
		Offs       += sizeof ( BlockDesc ) + BlockPtr -> Size;
	}

	file -> FreeBuf ( buf );

	return FreeSpace1 - FreeSpace2;
}

//##ModelId=3BFE7DEB01B0
int	StreamFile :: Check ()
{
	int diff;
	int rv = 1;
	for ( int i = fatPages + 1; i <= file -> LastPage; i++ ){
		diff = CheckPage ( i );
		if ( diff ) {
			fprintf (stdout, "Streams : error on page %ld (%d)\n", i, diff );
			rv =  0;
		}
	}

	return rv;
}
int StreamFile::GetKeysPageFromCache(int Page, void *buff){
	return GetPageFromCache(	Page
								, &m_PagesCacheKeys
								, pFirst->file
								, buff
								, &m_pCacheKeysStack
								, &m_pCacheKeysStackCount);
}

int StreamFile::GetStrsPageFromCache(int Page, void *buff){
	if(!(file->m_mode & (~0x3000)) || Flags & SF_IN_FILE_DIRECT){
		return GetPageFromCache(	Page
									, &m_PagesCacheBlocks
									, file
									, buff
									, &m_pCacheBlocksStack
									, &m_pCacheBlocksStackCount);
	}
  Point Fnd= 0;
  if(pWritedPages) {
	Fnd = pWritedPages->seek(Page);
  }
  CachedPage *updt= (CachedPage *)m_PagesCacheBlocks->seek(Page);
  if(Fnd){
	  memcpy(buff,pWritedPages->contents(Fnd).GetData(),file->PageSize);
  }else if(updt){
	  updt= m_PagesCacheBlocks->contents(updt);
	  memcpy(buff,updt->m_Data,file->PageSize);
	  UpActualLevel(updt,m_PagesCacheBlocks);
	  /*if(file->curr_last >= Page && !bpages->seek(Page))
		rpages->get(Page) = 0;*/
  }else{
	if ( !GetPage ( Page, buff ) )
		return -1;
	AddPageFromCache(Page	, m_PagesCacheBlocks
							, file
							, buff
							, &m_pCacheBlocksStack
							, &m_pCacheBlocksStackCount);
	UpActualLevel(m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode()),m_PagesCacheBlocks);
  }
  return 1;
}

int StreamFile::PutKeysPageFromCache(int Page, void *buff){
#ifdef DISABLE_PF_CACHE
	return pFirst->file->PutPage(Page, buff);
#endif
	return PutPageFromCache(	Page
								, &m_PagesCacheKeys
								, pFirst->file
								, buff
								, &m_pCacheKeysStack
								, &m_pCacheKeysStackCount);
}

int StreamFile::PutStrsPageFromCache(int Page, void *buff){
#ifdef DISABLE_PF_CACHE
	return file->PutPage(Page, buff);
#endif
	return PutPageFromCache(	Page
								, &m_PagesCacheBlocks
								, file
								, buff
								, &m_pCacheBlocksStack
								, &m_pCacheBlocksStackCount);
}

void StreamFile::AddPageFromCache(int page, CachePagesMap *pMap, ::PagedFile *FileDef1, void *buff, char **ppPagesStack, int *pCount, int as_changed)
{
	if((*pCount) == ((NPagedFile *)FileDef1)->m_maxPageCountInCache){
		QuickValSplayMapOnStackPerSize(ACE_UINT64,G_Point,ActualPageMap,pMap->length(),0);
		unsigned int complex64[2];
		G_Point t, t0;
		CachedPage *pCP;

		for(complex64[0]= 0, t= pMap->first(); t ; pMap->next(t)){
			pCP= pMap->contents(t);
			complex64[1]= pCP->actualLevel;
			ActualPageMap.get(*(ACE_UINT64*)complex64) = t;
			complex64[0]++;
		}
		complex64[0] = (((NPagedFile *)FileDef1)->m_maxPageCountInCache) / 4;

		QuickValSplayMapOnStackPerSize(int,G_Point,FlashedPageMap,complex64[0],1);

		for(t0= ActualPageMap.first(); t0 ; ActualPageMap.next(t0)){
			t= ActualPageMap.contents(t0);
			if(complex64[0] > 0){
				complex64[0]--;
				pCP= pMap->contents(t);
				if(file == FileDef1 && pMap->key(t) == nSysP){
					pMap->contents(t)->actualLevel= 3;
					complex64[0]++;
				}else{
					(*pCount)--;
					if(pCP->m_changed){
						FlashedPageMap.get(pMap->key(t))= t;
						FileDef1->ppCPages[(*pCount)]= pCP->m_Data;
					}else{
						/*if(file == FileDef1){
							if(pWritedPages && pWritedPages->seek(pMap->key(t)) && !PrePutPage(pMap->key(t), 0, pCP->m_Data))
								abort();
						}else if(pFirst->pWritedPages->seek(pMap->key(t))){
							pFirst->PutPage(pMap->key(t), pCP->m_Data);
						}*/
						pMap->del(t);
						FileDef1->ppCPages[(*pCount)]= pCP->m_Data;
						delete pCP;
					}
				}
			}else{
				pMap->contents(t)->actualLevel= 2;
			}
		}
		for(t0= FlashedPageMap.first(); t0 ; FlashedPageMap.next(t0)){
			t= FlashedPageMap.contents(t0);
			pCP= pMap->contents(t);
			if(file == FileDef1 && pWritedPages && pWritedPages->seek(pMap->key(t))){
				if(!PrePutPage(pMap->key(t), 0, pCP->m_Data)){
					LOG_E (("StreamFile :: AddPageFromCache, PrePutPage, [%d,%s]", pMap->key(t), file->FileName));
					abort();
				}
			}
			if(!FileDef1->PutPage(pMap->key(t), pCP->m_Data)){
				LOG_E (("StreamFile :: AddPageFromCache, FileDef1->PutPage, [%d,%s]", pMap->key(t), file->FileName));
				abort();
			}
			pMap->del(t);
			delete pCP;
		}
	}
	fc= (NPagedFile *)FileDef1;
	pMap->get(page)= new CachedPage( (::PagedFile *)this, buff, pCount, as_changed);
}
/*{
	NPagedFile *FileDef= (NPagedFile *)FileDef1;

	if((*pCount) == FileDef->m_maxPageCountInCache){
		if(pMap->pActualPageMap){
			pMap->pActualPageMap->clear();
		}else{
			pMap->pActualPageMap= new QuickValSplayMap<ACE_UINT64,G_Point>(0,1,FileDef->m_maxPageCountInCache);
		}
		unsigned int complex64[2];

		G_Point t, t0;
		CachedPage *pCP;
		for(complex64[0]= 0, t= pMap->first(); t ; pMap->next(t)){
			pCP= pMap->contents(t);
			complex64[1]= pCP->actualLevel;
			pMap->pActualPageMap->get(*(ACE_UINT64*)complex64) = t;
			complex64[0]++;
		}
		int FlushCount = FileDef->m_HardFlushCount, reC= FileDef->m_AllocPageCountInCache;
		char *tmpPtr;
		for(t0= pMap->pActualPageMap->first(); t0 ; pMap->pActualPageMap->next(t0)){
			if(FlushCount-- > 0){
				t= pMap->pActualPageMap->contents(t0);
				pCP= pMap->contents(t);
				(*pCount)--;
				reC--;
				tmpPtr= FileDef->ppCPages[reC];
				FileDef->ppCPages[reC]= pCP->m_Data;
				FileDef->ppCPages[(*pCount)]= tmpPtr;
//if(FileDef->zz1 == pMap->key(t) || FileDef->zz2 == pMap->key(t))
//   t= t;
				if(pCP->m_changed){
					if(!pMap->pFlashedPageMap){
						pMap->pFlashedPageMap= new QuickValSplayMap<int,G_Point>(0,1,FileDef->m_HardFlushCount);
					}
					pMap->pFlashedPageMap->get(pMap->key(t))= t;
				}else{
					pMap->del(t);
					delete pCP;
				}
			}else{
				pMap->contents(pMap->pActualPageMap->contents(t0))->actualLevel= 1;
			}
		}
		if(pMap->pFlashedPageMap && (t0= pMap->pFlashedPageMap->first())){
			{
				//GUARD (FileDef->m_mtxThreadWrite);
				if(!FileDef->pParamTAlloc){
					FileDef->ppParamT= (LPSF_INFILE *)malloc(sizeof(*FileDef->ppParamT));
					FileDef->pParamTAlloc
						= (LPSF_INFILE)malloc(FileDef->m_AllocPageCountInCache*sizeof(*FileDef->pParamTAlloc));
					FileDef->pCnt= (int*)malloc(sizeof(*FileDef->pCnt));
				}
				(*FileDef->ppParamT)= FileDef->pParamTAlloc;
				for(reC= 0; t0 ; pMap->pFlashedPageMap->next(t0)){
					t= pMap->pFlashedPageMap->contents(t0);
					FileDef->pParamTAlloc[reC].Page= pMap->key(t);
					FileDef->pParamTAlloc[reC++].pBff= (pMap->contents(t))->m_Data;
				}
				*FileDef->pCnt= reC;
			}
			InFile(FileDef);
			for(t0= pMap->pFlashedPageMap->first(); t0 ; pMap->pFlashedPageMap->next(t0)){
				t= pMap->pFlashedPageMap->contents(t0);
				delete pMap->contents(t);
				pMap->del(t);
			}
			pMap->pFlashedPageMap->clear();
		}
	}
	pMap->get(page)= new CachedPage( FileDef, buff, pCount, as_changed);
}*/

void StreamFile::FlushCache(CachePagesMap **ppMap, ::PagedFile *FileDef, char **ppPagesStack, int *pCount)
{
#ifndef DISABLE_PF_CACHE
	QuickValSplayMapOnStackPerSize(int,G_Point,FlashedPageMap,(*ppMap)->length(),1);
	G_Point t, t0;
	CachedPage *pCP;

	*ppPagesStack= 0;

	for(t= (*ppMap)->first(); t ; (*ppMap)->next(t)){
		pCP= (*ppMap)->contents(t);
		if(pCP->m_changed)
			FlashedPageMap.get((*ppMap)->key(t)) = t;
	}
	{
		//GUARD (FileDef->m_mtxThreadWrite);
		for(t0= FlashedPageMap.first(); t0 ; FlashedPageMap.next(t0)){
			t= FlashedPageMap.contents(t0);
			FileDef->PutPage((*ppMap)->key(t), (*ppMap)->contents(t)->m_Data);
		}
		/*if(FileDef->pParamTAlloc){
			free(FileDef->pParamTAlloc);
			FileDef->pParamTAlloc= 0;
			free(FileDef->ppParamT);
			free(FileDef->pCnt);
		}*/
	}
	for(t= (*ppMap)->first(); t ; (*ppMap)->next(t)){
		pCP= (*ppMap)->contents(t);
		delete pCP;
	}
	delete (*ppMap);
	if(FileDef->cache_tmp_buf) free(FileDef->cache_tmp_buf);FileDef->cache_tmp_buf= 0;
	if(FileDef->ppCPages) free(FileDef->ppCPages);FileDef->ppCPages= 0;
	if(((NPagedFile*)FileDef)->m_maxPageCountInCache > 0){
		((NPagedFile*)FileDef)->m_maxPageCountInCache= -(((NPagedFile*)FileDef)->m_AllocPageCountInCache);
	}
	*ppMap= 0;
	*ppPagesStack= 0;
	*pCount= 0;
#endif
}

Stream :: Stream ( StreamFile * sFile )
{
	m_bAsNew= false;
	file     = sFile;
	Flags    = 0;
	realSize = allocatedSize    = 0;
	roundV = 0;
	Pos      = 0;
	Handle   = 0;
	IndexBuf = IndexFreeBuf= Buf= 0;
	if(file){
		BufSize  = file -> file -> PageSize;
		hBuf= Buf = new char [BufSize + roundV];
		memset ( Buf, '\0', BufSize );
	}
	Rec      = 0;
	ImmSize  = 0;
	m_extBlobFileHandle= -1;
}

Stream::Stream(StreamFile*sFile,IndexRecordData*rec,int rec_size,int rv,int otherFile)
{
	sFile->m_LastNewId= 0;
	m_Id= 0;
	m_bAsNew= false;
	file     = sFile;
	PreLoadBlock= 1;
	sFile->InitFirstStr( this );
	streamID= sFile->streamID++;
#ifdef _DEBUG
	(*file->ostreams) [streamID] = 0;
#else
	//if(sFile->streamID == 712625)
	//	blocks= 0;
#endif
	blocks= 0;
	oPos= -1;
	oPage= 0;
	Flags    = 0;
	Rec= 0;
	hBuf= Buf= 0;
	realSize = allocatedSize    = 0;
	IndexFreeBuf= IndexBuf= 0;
	Handle = 0;

	if(rec){
		/*if(rec->header.realDataLength < 0)
			realSize= 0x7f & ((char*)&(rec->header.realDataLength))[3];
		else*/
			realSize= rec->header.realDataLength;

			//if(rec->header.allocatedDataLength == -2130702344 && rec->data.handle == 635072)
			//	rv= rv;

		roundV = rv;
		Pos      = 0;
		BufSize  = file -> file -> PageSize;

		if(!(file->file->m_mode & (~0x3000)) && realSize > 1){
			hBuf= Buf = (char*)malloc( BufSize + roundV) ;
		}else if(file->Flags & SF_IN_FILE_DIRECT){
			hBuf= Buf = 0;
		}else if(file->m_stepWriteBuff){
			hBuf= Buf = (char*)malloc( BufSize + roundV) ;
#ifdef _DEBUG
	{
		int tmpMM= BufSize + roundV;
		while(tmpMM--)
			hBuf[tmpMM]= 0;
	}
#endif
		}
		Rec      = rec;
		/*if(!rec->header.realDataLength || rec->header.realDataLength & 0x80000000)
			ImmSize  = rec_size + 7;
		else*/
			ImmSize  = rec_size;

		if ( realSize <= ImmSize  ){
			if(realSize > 0){
				//if(!hBuf)
				//	file->m_stepWriteBuff= Buf = file->aSysBuf + file->file->PageSize;

				//if(ImmSize  == rec_size){
				//	memcpy(Buf, rec->data.bin, realSize );
				/*}else{
					memcpy(Buf, &(rec->header), 3 );
					if(realSize > 3){
						memcpy(Buf+3, &(rec->header.allocatedDataLength), realSize-3 );
					}
				}*/
				if(hBuf){
					memcpy(hBuf, Rec->data.bin, realSize);
				}else
				Buf= (char*)(Rec->data.bin);
			}else{
				//Buf= (char*)rec;
				Buf= (char*)(Rec->data.bin);
			}
			if(NdtClone::CreatedBigStream)
				allocatedSize=FAT_CHAIN;

		}/*else if(rec->header.allocatedDataLength == -2130702344 && rec->data.handle == 635072){
			allocatedSize = rec->header.allocatedDataLength;
			Handle = rec ->data.handle;
			file -> LoadBlock ( Handle, 0, hBuf, allocatedSize );
		}*/else{
			allocatedSize = rec->header.allocatedDataLength;

			if (!(allocatedSize & 0xfffff)){
				Handle= -1;
			}else if(file->IsNotBlock( allocatedSize & 0xfffff )) {
				Handle= -1;
				// старый формат короткого стрима //
				if((allocatedSize & 0xfffff) <= file->file->PageSize - 4 && (allocatedSize & 0xfffff) >= file->file->PageSize - 10 ){
					Handle= ((allocatedSize &  FAT_CHAIN) ? Handle4Page ( rec->data.handle ) : Handle2Page ( rec->data.handle ));
					if(file->Flags & SF_LOAD_FAT_ON_DEMAND){
						// старые базы созданные не MRGLIB, но модифицированные New NDTClone поддерживают FAT по требованию //
						Handle= ((Handle / (file->file->PageSize / sizeof(*file->Fat)) ) * (file->file->PageSize / sizeof(*file->Fat))) + 1;
						if(!(file->Fat[Handle] & FAT_CHAIN) && !file->GetPage(Handle, file->Fat+Handle-1)){
							LOG_E (("Stream::Stream, file->GetPage, [%d,%s]", Handle, file->file->FileName));
							file->abort();
						}
						if((file->Fat[((allocatedSize &  FAT_CHAIN)
										? Handle4Page ( rec->data.handle ) : Handle2Page ( rec->data.handle ))] & FAT_CHAIN)){
							Handle= -1;
						}
					}else if(file->Fat[Handle] & FAT_CHAIN)
						Handle= -1;
				}
			}
			if (Handle == -1) {
				Point FndW= 0;
				if(file->pFirst->pWritedPages == file->pWritedPages){
					FndW = file->pWritedPages->seek(rec->data.handle);
					if(!FndW){
						file->pWritedPages->get(rec->data.handle) = NDTKPage(file->pFirst->file, file->SysBuf);
						FndW= file->pWritedPages->GetRootG_SimpleSplayNode();
					}
					Buf= (char*)file->pWritedPages->contents(FndW).GetData();
				}else{
					Handle= rec->data.handle;
					Pos= realSize;
					firstAllocBlocks();
					Pos= 0;
					if(file->m_stepWriteBuff){
						hBuf= Buf = (char*)malloc( BufSize + roundV) ;
						assert ( hBuf != 0 );
					}
					if(otherFile && otherFile == STREAM_AS_COLLECTION){
						PreLoadBlock= 0;
					}else{
	#ifndef WRITE_KEYS_PAGE_INBACKUP
						if(hBuf){
							if(file->pWritedPages && (FndW = file->pWritedPages->seek(blocks[0]))){
								memcpy(Buf, file->pWritedPages->contents(FndW).GetData(), file->file->PageSize);
							}else{
								if(!file->GetStrsPageFromCache( blocks[0], Buf )){
									LOG_E (("Stream::Stream, file->GetStrsPageFromCache(hBuf), [%d,%s]", blocks[0], file->file->FileName));
									file->abort();
								}
							}
						}else{
							if(file->pWritedPages && (FndW = file->pWritedPages->seek(blocks[0]))){
								Buf= (char*)file->pWritedPages->contents(FndW).GetData();
							}else{
								if(!file->GetStrsPageFromCache( blocks[0], alloca(file->file->PageSize) )){
									LOG_E (("Stream::Stream, file->GetStrsPageFromCache(0), [%d,%s]", blocks[0], file->file->FileName));
									file->abort();
								}
								Buf= (char*)(file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode())->m_Data);
							}
						}
	#else
						file->GetPage( blocks[0], Buf );
	#endif
					}
				}
			}else{
				Handle= rec->data.handle;
				/*if(hBuf)
					file -> LoadBlock ( Handle, 0, hBuf, allocatedSize );
				else*/{
					BlockDesc * BlockPtr;

					int	Offs;
					{
	/////////////////////////////////
	int Page= ((allocatedSize &  FAT_CHAIN) ? Handle4Page ( Handle ) : Handle2Page ( Handle ));
	CachedPage *pFnd;
	Point FndW= 0;
	if(file->pWritedPages && (FndW = file->pWritedPages->seek(Page))){
		file->SysBuf= (char*)file->pWritedPages->contents(FndW).GetData();
	}else{
		if(!file->m_PagesCacheBlocks){
			file->m_PagesCacheBlocks= new CachePagesMap(0);
		}
		if((pFnd= (CachedPage *)file->m_PagesCacheBlocks->seek(Page))){
			pFnd= file->m_PagesCacheBlocks->contents(pFnd);
		}else{
			if(file->GetPage(Page, (file->SysBuf= file->aSysBuf))){
				file->AddPageFromCache(Page	, file->m_PagesCacheBlocks
										, file->file
										, file->SysBuf
										, &file->m_pCacheBlocksStack
										, &file->m_pCacheBlocksStackCount);
				pFnd= file->m_PagesCacheBlocks->contents(
						file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
			}else{
				LOG_E (("abort in Stream :: Stream 1"));
				file->abort();
			}
		}
		file->SysBuf= (char*)(pFnd->m_Data);
		file->UpActualLevel(pFnd,file->m_PagesCacheBlocks);
	}
	/*if(Page == 20456 && *(file->file->FileName+22) == '8'){
		m_Id = ((allocatedSize &  FAT_CHAIN) ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle ));
		fprintf(presfile,"(%d,%d,%d)...",file->Fat[20456],file->nSysP,m_Id);
		if(m_Id==98){
			fprintf(presfile, " Take ! ...\n");
			fflush(presfile);
			getchar();
		}
		BlockPtr = (BlockDesc *) file->SysBuf;
		for ( Offs = 0; BlockPtr -> Id != 98 && BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( file->SysBuf + Offs ) )
		{
			Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;

			if ( Offs >= file->file-> PageSize ){
				fprintf(presfile, " Error 4 \n");
				fflush(presfile);
				file->abort();
			}
		}
		if ( m_Id == 98 && BlockPtr -> Id != 98 ){
				fprintf(presfile, "Error 5 \n");
				fflush(presfile);
			file->abort();
		}
		fprintf(presfile, "\n");
		fflush(presfile);
	}*/
	file->nSysP= Page;
	BlockPtr = 0;

	if((*(short*)file->SysBuf) > -1){
		m_Id = ((allocatedSize &  FAT_CHAIN) ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle ));
		BlockPtr = (BlockDesc *) file->SysBuf;
		for ( Offs = 0; BlockPtr -> Id != m_Id && BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( file->SysBuf + Offs ) )
		{
			Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;

			if ( Offs >= file->file-> PageSize ){
				LOG_E (("abort in Stream :: Stream 4"));
				file->abort();
			}
		}
		if ( BlockPtr -> Id != m_Id ){
			LOG_E (("abort in Stream :: Stream 5"));
			file->abort();
		}
	}else{
		m_Id = NEW_STREAM_HANDLE_TO_ID( Handle, allocatedSize );
		if(!(BlockPtr = (BlockDesc *)::bsearch( &m_Id, file->SysBuf+sizeof(short)
												, -(*(short*)file->SysBuf), sizeof(BlockDesc), compBlockDescID))){
			LOG_E (("abort in Stream :: Stream 6"));
			file->abort();
		}
		Offs= int(((char*)BlockPtr - file->SysBuf)&0x7fffffff);
	}
	/////////////////////////////////
					}
					if ( Offs < 0 ){
						LOG_E (("abort in Stream :: Stream 0"));
						file->abort();
					}
					BlockPtr = (BlockDesc *) ( file->SysBuf + Offs );
					if(*(short*)file->SysBuf > -1){
						Buf= (char*)(BlockPtr + 1);
					}else{
						Buf= (file->SysBuf + file->file->PageSize - BlockPtr->Size);
					}
					if(hBuf){
						memcpy(hBuf, Buf, realSize);
						Buf= hBuf;
					}
					/*if(!(file->file->m_mode & (~0x3000)) || file->Flags & SF_IN_FILE_DIRECT){
						;
					}else if(file->m_stepWriteBuff){
						hBuf= (char*)malloc( BufSize + roundV);
						memcpy(hBuf, Buf, realSize);
						Buf= hBuf;
					}else{
						file->m_stepWriteBuff= file->aSysBuf + file->file->PageSize;
						memcpy(file->m_stepWriteBuff, Buf, realSize);
						Buf= file->m_stepWriteBuff;
					}*/

				}
			}
		}
		m_extBlobFileHandle= -1;
		//m_PostMessageForResorceTomFunc= DefaultMessageForResorceTomFunc;
		if(otherFile && otherFile != STREAM_PER_4BYTES && otherFile != STREAM_AS_COLLECTION){
			Pos= (int)MAX_BYTE_FILE_SIZE;
			realSizeExt= realSize= *((int*)Buf+1);
			int pgcount= realSize / file->file->PageSize;
			if(realSize & ((1 * file->file->PageSize)-1)){
				pgcount++;
				realSizeExt= pgcount * file->file->PageSize;
			}
			m_Pos= 0L;
			m_extBlobFileHandle= -1;
		}
	}
}

void Stream :: closeAttrs ()
{
	if(Buf){
		if(Modified ()){
			if ( Flags & SF_BUFDIRTY && !Save()){
				LOG_E (("StreamFile :: closeAttrs, Save(), [%s]", file->file->FileName));
				file->abort();
			}
			if ( Rec != 0 )
			{
				if ( realSize > ImmSize ){
					Rec->header.realDataLength = realSize;
					Rec->header.allocatedDataLength = allocatedSize;
					Rec->data.handle = Handle;
				}
			}
		}
			if(m_extBlobFileHandle != -1)
		{
			c_io_close(m_extBlobFileHandle);
		}
		if(hBuf){
			free( hBuf );hBuf= 0;
		}
		file->Flags &= ~SF_NEW_HANDLE;
		file->m_stepWriteBuff= 0;
	}
	Buf= 0;
}

Stream :: ~Stream ()
{
	if(global_IsBlock())
		return;

	closeAttrs ();
	if(IndexFreeBuf)
		free( IndexFreeBuf );
	if(blocks)
		free( blocks );
}

//##ModelId=3BFE7DEB00E0
int	Stream :: Save ()
{
	Flags &= ~SF_BUFDIRTY;

	if ( realSize <= ImmSize && Rec != 0 )
	{
		file->m_stepWriteBuff= 0;
		memcpy(Rec->data.bin, Buf, realSize );
		Rec->header.realDataLength = realSize;
		Rec->header.allocatedDataLength = allocatedSize;
		/*memcpy(&(Rec->header.realDataLength), Buf, 3);
		if(realSize > 3)
			memcpy(&(Rec->header.allocatedDataLength), Buf+3, realSize-3);
		((char*)&(Rec->header.realDataLength))[3] = 0x80 |  ((*(char*)&realSize) & 0x7f);*/
		return 1;
	}else{
		if(blocks){
		  int Page= blocks[(Pos-1)/BufSize];
			if(!Page){
				Page= file->AddNewPage ( blocks[((Pos-1)/BufSize) - 1], isBigHandle() ? allocatedSize : 0 );
			}else if(!(Pos%BufSize)){
				// skip write curent page after this->Write //
				Flags |= SF_NOT_ACTUAL;
			}else if(	!(file->Flags & SF_IN_FILE_DIRECT) && file->file->curr_last >= Page && !file->bpages->seek(Page)){
				file->rpages->get(Page) = 0;
				if(!(Flags & SF_NOT_ACTUAL)){
					if(!file->PrePutPage(Page, 0)){
						LOG_E (("Stream :: Save(), file->PrePutPage, [%d,%s]", Page, file->file->FileName));
						file->abort();
					}
				}
			}

		  if(Flags & SF_UPDT_ACTUAL)
			  Flags &= ~SF_NOT_ACTUAL;
		  if( !(Flags & SF_NOT_ACTUAL)){
			  if(!(Pos /= BufSize)){
				  file->AsUpdated(Page, Buf);
			  }else{
				CachedPage *pFnd;
				if(!file->m_PagesCacheBlocks){
					file->m_PagesCacheBlocks= new CachePagesMap(0);
				}
				if((pFnd= (CachedPage *)file->m_PagesCacheBlocks->seek(Page))){
					pFnd= file->m_PagesCacheBlocks->contents(pFnd);
					memcpy(pFnd->m_Data, Buf, file->file->PageSize);
					pFnd->m_changed= 1;
				}else if(file->writeBigStreamPage(Page, Buf, Pos) && !WritePage( Page, Buf ))
					return 0;
			  }
		  }
		  file->m_stepWriteBuff= 0;
		  return 1;
		}else{
			BufSize= SaveBlockSize ();
			if ( Handle == 0 && isBigHandle() && file->IsNotBlock( BufSize ) )
				allocatedSize= FAT_CHAIN;

			if(!file->SaveBlock(	this,
									(int)(Pos/file->file->PageSize),
									Buf, 
									BufSize, isBigHandle() ? &allocatedSize : 0))
				return 0;

			file->m_stepWriteBuff= 0;
			BufSize= file->file->PageSize;
			return 1;
		}
	}
}

//##ModelId=3BFE7DEB00DF
int	Stream :: SaveBlockSize ()
{
	int rv;

	if ( (Handle == 0)	|| (!(allocatedSize &  FAT_CHAIN) && Handle2Id(Handle)) ){
		if(Handle)
			rv= 0;
		rv = ((realSize+roundV-1)/roundV)*roundV;
		if( rv >= BufSize ){
			rv = BufSize - 1;
		}
		allocatedSize &= 0xfff00000;
		allocatedSize |= rv;
	}else{
		rv = allocatedSize &0xfffff;
		if (!rv || (rv+4) <= BufSize){	
			rv = ((realSize+roundV-1)/roundV)*roundV;
			if( rv >= BufSize ){
				rv = BufSize - 1;
			}
			allocatedSize &= 0xfff00000;
			allocatedSize |= rv;
		}if(1){
		}else {
			rv =  BufSize;
		}
	}

	return rv;
}

int Stream :: nxtBlock ( unsigned int *pPgNo, void *Readed ){
	if(file->Flags & SF_LOAD_FAT_ON_DEMAND){
		int calcFatPage= ((blocks[*pPgNo] / (file->file->PageSize / sizeof(*file->Fat)) ) * (file->file->PageSize / sizeof(*file->Fat))) + 1;
		if(!(file->Fat[calcFatPage] & FAT_CHAIN) && !file->GetPage(calcFatPage, file->Fat+calcFatPage-1)){
			LOG_E (("Stream :: nxtBlock, file->GetPage, [%d,%s]", calcFatPage, file->file->FileName));
			file->abort();
		}
	}
	++(*pPgNo);
	blocks[(*pPgNo)]= (file->Fat[blocks[(*pPgNo)-1]] & ~FAT_CHAIN);
	if(Readed && blocks[*pPgNo] > 1){
		CachedPage *pFnd= 0;
		if(!file->m_PagesCacheBlocks){
			file->m_PagesCacheBlocks= new CachePagesMap(0);
		}else if((pFnd= (CachedPage *)file->m_PagesCacheBlocks->seek(blocks[*pPgNo]))){
			pFnd= file->m_PagesCacheBlocks->contents(pFnd);
			memcpy(Readed, pFnd->m_Data, file->file->PageSize);
		}
		if(!pFnd){
			if(!file->GetPage ( blocks[*pPgNo], Readed))
				return 0;
			else if(!file->writeBigStreamPage(blocks[*pPgNo], Readed, *pPgNo)){
((CachedPage *)file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode()))->m_changed= 0;
			}
		}
	}
	return blocks[*pPgNo];
}

int	Stream :: ReadEx ( void  * buf, int Count )
{
	/*if(*(file->file->FileName+34) == '_' && *(file->file->FileName+36) == 'v'){
		LOG_E (("Rdd key(%d, %d)... (%s,%d)", ((long*)this->IndexBuf)[0], ((long*)this->IndexBuf)[1], file->file->FileName+31,Count));
	}*/
	//int SingleTrans= 1;
	if((file->Flags & SF_IN_OPERATION)){
		LOG_E (("abort in Stream :: ReadEx"));
		file->abort();
	}else if(file->Flags & SF_IN_TRANSCTN){
		//SingleTrans= 0;
	}
	file->BeginOperation(file->pFirst, file->read_stream);
	if ( Pos + Count > realSize )
		Count = realSize - Pos;

	unsigned int	TotalCount = Count;
	unsigned int	PageNo     = ( Pos / BufSize );

	unsigned int	BlockSize;
	unsigned int	TransfSize;

	void *Readed= (char*)Buf;


	if( Count > 0 )	{
		if(Handle && (allocatedSize &0xfffff) && !file->IsNotBlock( allocatedSize & 0xfffff )){
			BlockSize= realSize;
		}else
			BlockSize= BufSize - ( Pos % BufSize );

		if(Flags & SF_UPDT_ACTUAL){
			char *tmpPage= (char*)alloca(BufSize);
			if(!file->file->GetPage ( blocks[PageNo], tmpPage ) ){
				LOG_E (("Stream :: ReadEx, file->GetPage, [%d,%s]", blocks[PageNo], file->file->FileName));
				file->abort();
			}
			TransfSize= Pos % BufSize;
			tmpPage += TransfSize;
			memcpy(Buf + TransfSize, tmpPage, BufSize - TransfSize);
			if( !WritePage( blocks[PageNo], Buf ) ){
				LOG_E (("Stream :: ReadEx, WritePage, [%d,%s]", blocks[PageNo], file->file->FileName));
				file->abort();
			}
			Flags &= ~(SF_UPDT_ACTUAL|SF_BUFDIRTY);
			TransfSize = Count < (int)BlockSize ? Count : BlockSize;
			memcpy(buf, tmpPage, TransfSize);
		}else{
			TransfSize = Count < (int)BlockSize ? Count : BlockSize;
			memmove ( buf, Buf + ( Pos % BufSize ), TransfSize );
		}
		buf    = TransfSize + (char  *) buf;

		Pos   += TransfSize;
		Count -= TransfSize;

		if ( Pos / BufSize != (int)PageNo ) {
			if ( Flags & SF_BUFDIRTY ){	
				// save buffer if it has been modified
				if(isBigHandle()){
					file -> SaveBlock ( this, PageNo, Buf, m_Id != 0 ? (int)realSize : BufSize, &allocatedSize);
				}else{
					file -> SaveBlock ( this, PageNo, Buf, m_Id != 0 ? (int)realSize : BufSize, 0);
				}
				Flags &= ~SF_BUFDIRTY;
			}
			if(m_Id){
				file -> LoadBlock ( this, ++ PageNo, Readed );
			}else{
				if(Buf != file->m_stepWriteBuff && Buf != hBuf){
					if(file->m_stepWriteBuff)
						Buf= hBuf= (char*)malloc( BufSize + roundV);
					else
						Buf= file->m_stepWriteBuff= file->aSysBuf + file->file->PageSize;
				}
				if(TransfSize == BufSize && Count >= BufSize){
					Readed= buf;
				}else{
					Readed= Buf;
				}
				if(!nxtBlock(&PageNo, Readed)){
					if(blocks[PageNo]){
						LOG_E (("Stream :: ReadEx, blocks[PageNo] != 0, [%d,%s]", blocks[PageNo], file->file->FileName));
						file->abort();
					}
				}
			}
		}
	}
	if( Count > 0 )	{
		while(1){
			if(Count < BufSize){
				if(Readed == Buf){
					if(blocks[PageNo]){
						if(Buf != file->m_stepWriteBuff && Buf != hBuf){
							Buf= hBuf= (char*)malloc( BufSize + roundV) ;
							if(!file->file->GetPage ( blocks[PageNo], Buf ) ){
								LOG_E (("Stream :: ReadEx, file->file->GetPage(second), [%d,%s]", blocks[PageNo], file->file->FileName));
								file->abort();
							}
						}
						memcpy( buf, Buf, Count );
					}
				}else
					memcpy( Buf, buf, BufSize );
				Pos += Count;
				break;
			}else{
				Count -= BufSize;
				if(Readed != buf){
					memcpy( buf, Buf, BufSize );
				}else if(Buf != file->m_stepWriteBuff && Buf != hBuf){
					if(!file->file->GetPage ( blocks[PageNo], Readed ) ){
						LOG_E (("Stream :: ReadEx, file->file->GetPage(first), [%d,%s]", blocks[PageNo], file->file->FileName));
						file->abort();
					}
				}
				buf = BufSize + (char  *) buf;
				if(Count < BufSize){
					Readed= Buf;
				}else
					Readed= buf;
				Pos += BufSize;

				if ( Pos / BufSize != (int)PageNo )
					nxtBlock(&PageNo, Readed);
			}
		}
	}
	file->EndOperation();
	return TotalCount;
}

bool StreamFile :: writeBigStreamPage(int Pg, void *bf, int pageNo)
{
	if(!pageNo){
	 if(m_PagesCacheBlocks->seek(Pg)){
		 if(file->curr_last >= Pg){
	  if(!pWritedPages){
		if(!(pWritedPages= new NDTKPageMap(MapDefltStr))) {
			LOG_E (("abort in StreamFile :: writeBigStreamPage"));
			abort();
		}
		pWritedPages->get(Pg) = NDTKPage(file, bf);
	  }else{
		Point Fnd= pWritedPages->seek(Pg);
		if(!Fnd)
			pWritedPages->get(Pg) = NDTKPage(file, bf);
		else
			memcpy(pWritedPages->contents(Fnd).GetData(), bf, file->PageSize);
	  }
		 }else{
			memcpy(m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode())->m_Data, bf, file->PageSize);
			UpActualLevel(m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode()),m_PagesCacheBlocks);
			m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode())->m_changed= 1;
			//file->Flags |= SF_UPDT_ACTUAL;
		 }
	 }else{
		AddPageFromCache(	Pg
							, m_PagesCacheBlocks
							, file
							, bf
							, &m_pCacheBlocksStack
							, &m_pCacheBlocksStackCount);

		bf= m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
		UpActualLevel((CachedPage *)bf,m_PagesCacheBlocks);
		((CachedPage *)bf)->m_changed= 1;
		//file->Flags |= SF_UPDT_ACTUAL;
	 }
	 return false;
	}
	return true;
}

bool StreamFileFastAdd :: writeBigStreamPage(int Pg, void *bf, int /*pageNo*/)
{
	AddPageFromCache(	Pg
						, m_PagesCacheBlocks
						, file
						, bf
						, &m_pCacheBlocksStack
						, &m_pCacheBlocksStackCount);

	bf= m_PagesCacheBlocks->contents(m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
	((CachedPage *)bf)->actualLevel= 0;
	((CachedPage *)bf)->m_changed= 1;
	return false;
}

void Stream :: firstAllocBlocks()
{
	if(!blocks){
		blocks_count= Pos/BufSize;
		blocks= (int*)calloc(sizeof(*blocks), 1 + blocks_count);
		blocks[0]= ((allocatedSize &  FAT_CHAIN) ? Handle4Page ( Handle ) : Handle2Page ( Handle ));
	}
}

int	Stream :: Write ( const void  * buf, int Count )
{
	/*if(*(file->file->FileName+34) == '_' && *(file->file->FileName+36) == 'v'){
		LOG_E (("Wrt key(%d, %d)... (%s,%d)", ((long*)this->IndexBuf)[0], ((long*)this->IndexBuf)[1], file->file->FileName+31, Count));
	}*/
	if((file->Flags & SF_IN_OPERATION)){
		LOG_E (("(%x:%x)abort in Stream :: Write[%s](InOperation!)", ((int*)&streamID)[1], ((int*)&streamID)[0], strrchr(file->file->FileName, '_')));
		abort();
	}else/* if(file->Flags & SF_IN_TRANSCTN){
		if(!hBuf && Handle && Pos+Count > realSize){
			hBuf= (char*)malloc( BufSize + roundV) ;
#ifdef _DEBUG
	{
		int tmpMM= BufSize + roundV;
		while(tmpMM--)
			hBuf[tmpMM]= 0;
	}
#endif
			memcpy(hBuf, Buf, Pos%BufSize);
			Buf= hBuf;
		}
	}else if(file->Flags & SF_IN_FILE_DIRECT){
		if(!hBuf && Handle && Pos+Count > realSize){
			hBuf= (char*)malloc( BufSize + roundV) ;
#ifdef _DEBUG
	{
		int tmpMM= BufSize + roundV;
		while(tmpMM--)
			hBuf[tmpMM]= 0;
	}
#endif
			memcpy(hBuf, Buf, Pos%BufSize);
			Buf= hBuf;
		}
	}else */if(/*Buf != (char*)Rec->data.bin && */!hBuf && file->m_stepWriteBuff != Buf){
		if(!file->m_stepWriteBuff){
			file->m_stepWriteBuff= file->aSysBuf + file->file->PageSize;
			memcpy(file->m_stepWriteBuff, Buf, Pos % file->file->PageSize);
			if(realSize > Pos+Count && Count < file->file->PageSize){
				if(realSize < file->file->PageSize)
					memcpy(file->m_stepWriteBuff+Pos+Count, Buf+Pos+Count, realSize - (Pos+Count));
				else
					memcpy(file->m_stepWriteBuff+(Pos % file->file->PageSize)+Count
							, Buf+(Pos % file->file->PageSize)+Count, file->file->PageSize - ((Pos % file->file->PageSize)+Count));
			}
			Buf= file->m_stepWriteBuff;
		}else{
			hBuf= (char*)malloc( BufSize + roundV) ;
			memcpy(hBuf, Buf, Pos % file->file->PageSize);
			if(realSize > Pos+Count && Count < file->file->PageSize){
				if(realSize < file->file->PageSize)
					memcpy(hBuf+Pos+Count, Buf+Pos+Count, realSize - (Pos+Count));
				else
					memcpy(file->m_stepWriteBuff+(Pos % file->file->PageSize)+Count
							, Buf+(Pos % file->file->PageSize)+Count, file->file->PageSize - ((Pos % file->file->PageSize)+Count));
			}
			Buf= hBuf;
		}
	}
	file->BeginOperation(file->pFirst, file->write_stream);
	/*if(ImmSize == 4 && Rec->header.realDataLength > 0 && Rec->header.realDataLength <= ImmSize + 7
		//!(Rec->header.allocatedDataLength & 0x80000000) && (Pos+Count) <= ImmSize + 7
		){
		// перепаковываем очень короткие стримы //
		if(!(Rec->header.allocatedDataLength & 0x80000000)){
			file -> DelHandle ( Handle, 0 );
			allocatedSize= 0x80000000;
		}else
			file -> DelHandle ( Handle, allocatedSize );
		
		Handle= 0;
		((char*)&(Rec->header.realDataLength))[3] = 0x80 |  ((*(char*)&realSize) & 0x7f);
		ImmSize += 7;
	}*/
	int	TotalCount = Count;
	int	PageNo     = (int)( Pos / BufSize );
	char *Writed;

	while ( Count > 0 )	{
		int	BlockSize = static_cast<int>( std::min<int> ( Count, BufSize - ( Pos % BufSize ) ) ); // GARANT_STL

		if(Pos % BufSize){
			memmove ( Buf + (int)( Pos % BufSize ), buf, BlockSize );
			Writed= Buf;
		}else
			Writed= (char*)buf;

		buf    = BlockSize + (char *) buf;
		Count -= BlockSize;
		Pos   += BlockSize;
		Flags |= SF_BUFDIRTY;

		if ( Pos > realSize )
			realSize = Pos;

		if ( Pos / BufSize != PageNo )		// there're more bytes to copy
		{
			if(blocks){
				if(blocks_count == PageNo){
					blocks= (int*)realloc(blocks, sizeof(*blocks)*(2 + blocks_count));
					blocks_count++;blocks[blocks_count]= 0;
				}
				if(file->Flags & SF_NEW_HANDLE){
					if(!blocks[PageNo]){
						blocks[PageNo] = file->AllocPage (allocatedSize);
						file->AddFatNext(blocks[PageNo-1], (int)(FAT_CHAIN | (int) blocks[PageNo]) - (int)file->Fat[blocks[PageNo-1]]);
						file->AddFatNext(blocks[PageNo], (int)FAT_CHAIN - (int)file->Fat[blocks[PageNo]]);
					}
					if(!file->m_PagesCacheBlocks){
						file->m_PagesCacheBlocks= new CachePagesMap(0);
					}
					if(file->writeBigStreamPage(blocks[PageNo], Writed, PageNo) && !WritePage( blocks[PageNo], Writed ) ){
						LOG_E (("Stream :: Write, file->writeBigStreamPage, [%d,%s]", blocks[PageNo], file->file->FileName));
						abort();
					}
				}else{
					if(!blocks[PageNo]){
						blocks[PageNo]= file->AddNewPage ( blocks[PageNo-1], isBigHandle() ? allocatedSize : 0 );
					}
					if(!PageNo){
						file->AsUpdated(blocks[PageNo],Writed);
					}else if(!(file->Flags & SF_IN_FILE_DIRECT)	&& file->file->curr_last >= blocks[PageNo]
															&& !file->bpages->seek(blocks[PageNo])){
						file->rpages->get(blocks[PageNo]) = 0;
						if(!file->PrePutPage(blocks[ PageNo], 0)){
							LOG_E (("Stream :: Write, file->PrePutPage, [%d,%s]", blocks[PageNo], file->file->FileName));
							abort();
						}
						//file->PutStrsPageFromCache( blocks[ PageNo], Writed );
						if( file->writeBigStreamPage(blocks[PageNo], Writed, PageNo) && !WritePage( blocks[PageNo], Writed ) ){
							LOG_E (("Stream :: Write, file->writeBigStreamPage(22), [%d,%s]", blocks[PageNo], file->file->FileName));
							abort();
						}
					}else if( file->writeBigStreamPage(blocks[PageNo], Writed, PageNo) && !WritePage( blocks[PageNo], Writed ) ){
						LOG_E (("Stream :: Write, file->writeBigStreamPage(33), [%d,%s]", blocks[PageNo], file->file->FileName));
						abort();
															}
				}
			}else{
				if(Handle){
					/*unsigned short Id = m_Id;//((allocatedSize &  FAT_CHAIN) ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle ));
	if(!Id){
		firstAllocBlocks();
		if( !WritePage( blocks[PageNo], Writed ) )
			abort();
	}else{*/
		file -> SaveBlock ( this, PageNo, Writed, SaveBlockSize (), (allocatedSize &  FAT_CHAIN) ? &allocatedSize : 0);
		/*Id = (allocatedSize == ((allocatedSize &  FAT_CHAIN) ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle )));
		if(!Id){*/
			firstAllocBlocks();
		/*}
	}*/
				}else{
					char *tmp00= file -> SysBuf;
					file -> SysBuf= Writed;
					file -> SaveBlock ( this, PageNo, Writed, SaveBlockSize (),
													isBigHandle() ? &allocatedSize : 0);
					if(file->Flags & SF_NEW_HANDLE){
						file->writeBigStreamPage((blocks_count= Handle4Page ( Handle )), Writed, PageNo);
							/*int FirstPage= Handle4Page ( Handle );
							if(//!file->m_PagesCacheBlocks->seek(FirstPage)
								1){
								file->AddPageFromCache(	FirstPage
														, file->m_PagesCacheBlocks
														, file->file
														, Writed
														, &file->m_pCacheBlocksStack
														, &file->m_pCacheBlocksStackCount);
								CachedPage *pFnd= file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
								UpActualLevel(pFnd,m_PagesCacheBlocks);
								// Только для GSPLIT
								pFnd->actualLevel= 0;
								pFnd->m_changed= 1;
							}*/

						firstAllocBlocks();
						if(!file->m_PagesCacheBlocks || !file->m_PagesCacheBlocks->seek(blocks[PageNo])){
							file->file->PutPage(blocks[PageNo],Writed);
						}
					}
					file -> SysBuf= tmp00;
				}
			}
			Flags &= ~SF_BUFDIRTY;
		}else if(Writed != Buf){
			if(Pos >= realSize){
				/*if(Buf ==	(char*)Rec->data.bin
							//(&(Rec->header.allocatedDataLength))
																		){
					if(!file->m_stepWriteBuff){
						file->m_stepWriteBuff= Buf = file->aSysBuf + file->file->PageSize;
					}else{
						hBuf= Buf = (char*)malloc( BufSize + roundV) ;
#ifdef _DEBUG
	{
		int tmpMM= BufSize + roundV;
		while(tmpMM--)
			hBuf[tmpMM]= 0;
	}
#endif
					}
				}*/
#ifndef WITH_NOT_PACK_PAGED_FILE
				//else
					if(!hBuf){
					memmove ( Buf, Writed, BlockSize );
					Flags &= ~SF_NOT_ACTUAL;
					Flags |= SF_MODIFIED;
					file->EndOperation();
					return TotalCount;
				}else if (!Handle){
					memset ( Buf+BlockSize, '\0', BufSize-BlockSize );
				}
#endif
				Flags &= ~SF_NOT_ACTUAL;
			}
			else if(Flags & SF_NOT_ACTUAL){
				if(Pos / BufSize != PageNo)
					Flags |= SF_UPDT_ACTUAL;
				else{
					if ( Flags & SF_MODIFIED ){
						// обновляем буфер для следующей записи в имеющийся странице //
						if(!file->GetNextPageFromBigStreamForUpdate( blocks[PageNo], Buf ) ){
							LOG_E (("Stream :: Write, file->GetNextPageFromBigStreamForUpdate(44), [%d,%s]", blocks[PageNo], file->file->FileName));
							abort();
						}
					  if(!(file->Flags & SF_IN_FILE_DIRECT) && file->file->curr_last >= blocks[PageNo] && !file->bpages->seek(blocks[PageNo])){
						file->rpages->get(blocks[PageNo]) = 0;
						if(!file->PrePutPage(blocks[ PageNo], 0, Buf))
							abort();
					  }
						Flags &= ~SF_NOT_ACTUAL;
					}else{
						// обновляем буфер после первой записи в имеющийся странице //
						if(!file->file->GetPage ( blocks[PageNo], Buf ) ){
							LOG_E (("Stream :: Write, file->file->GetPage(55), [%d,%s]", blocks[PageNo], file->file->FileName));
							abort();
						}
					  if(!(file->Flags & SF_IN_FILE_DIRECT) && file->file->curr_last >= blocks[PageNo] && !file->bpages->seek(blocks[PageNo])){
						file->rpages->get(blocks[PageNo]) = 0;
						if(!file->PrePutPage(blocks[ PageNo], 0, Buf)){
							LOG_E (("Stream :: Write, file->PrePutPage(66), [%d,%s]", blocks[PageNo], file->file->FileName));
							abort();
						}
					  }
						Flags &= ~SF_NOT_ACTUAL;
					}
				}
			}
			memmove ( Buf, Writed, BlockSize );
		}
		if ( Pos / BufSize != PageNo ){
			// reload buffer, so it always contains current position
			// before reloading buffer must save
			if ( Flags & SF_BUFDIRTY )	{
			  if(blocks){
				if(!blocks[PageNo]){
					if(blocks_count == PageNo){
						blocks= (int*)realloc(blocks, sizeof(*blocks)*(2 + blocks_count));
						blocks_count++;blocks[blocks_count]= 0;
					}
					if(file->Flags & SF_NEW_HANDLE){
						blocks[PageNo] = file->AllocPage (allocatedSize);
						file->AddFatNext(blocks[PageNo-1], (int)(FAT_CHAIN | (int) blocks[PageNo]) - (int)file->Fat[blocks[PageNo-1]]);
						file->AddFatNext(blocks[PageNo], (int)FAT_CHAIN - (int)file->Fat[blocks[PageNo]]);
					}else{
						blocks[PageNo]= file->AddNewPage ( blocks[PageNo-1], isBigHandle() ? allocatedSize : 0 );
						if(	!(file->Flags & SF_IN_FILE_DIRECT)	&& file->file->curr_last >= blocks[PageNo]
																&& !file->bpages->seek(blocks[PageNo])){
							file->rpages->get(blocks[PageNo]) = 0;
						}
					}
				}else if(	!(file->Flags & SF_IN_FILE_DIRECT)	&& file->file->curr_last >= blocks[PageNo]
																&& !file->bpages->seek(blocks[PageNo])){
					file->rpages->get(blocks[PageNo]) = 0;
					if(!file->PrePutPage(blocks[ PageNo], 0))
						abort();
					//file->PutStrsPageFromCache( blocks[ PageNo], Buf );
					if( file->writeBigStreamPage(blocks[PageNo], Buf, PageNo) && !WritePage( blocks[PageNo], Buf ) )
						abort();
				}else if(file->writeBigStreamPage(blocks[PageNo], Buf, PageNo) &&
				/*// Только для GSPLIT
				if(//!PageNo && !file->m_PagesCacheBlocks->seek(Page)
					1){
					file->AddPageFromCache(	blocks[PageNo]
											, file->m_PagesCacheBlocks
											, file->file
											, Buf
											, &file->m_pCacheBlocksStack
											, &file->m_pCacheBlocksStackCount);
					CachedPage *pFnd= file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
					pFnd->actualLevel= 0;
					pFnd->m_changed= 1;
				}
				else
					if( */!WritePage(blocks[PageNo], Buf) )
						abort();
			 }else if(Handle){
					//unsigned short Id = ((allocatedSize &  FAT_CHAIN) ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle ));
	if(!m_Id){
		firstAllocBlocks();
		if( !WritePage( blocks[PageNo], Buf ) )
			abort();
	}else{
		file -> SaveBlock ( this, PageNo, Buf, SaveBlockSize (),
										(allocatedSize &  FAT_CHAIN) ? &allocatedSize : 0);
		/*Id = ((allocatedSize &  FAT_CHAIN) ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle ));
		if(!Id){*/
			firstAllocBlocks();
		//}
	}
			  }else{
				file -> SaveBlock ( this, PageNo, Buf, SaveBlockSize (), isBigHandle() ? &allocatedSize : 0);
				if(file->Flags & SF_NEW_HANDLE){
					firstAllocBlocks();
				}
			  }
			  Flags &= ~SF_BUFDIRTY;
			}

			//PageNo ++;		// since block has changed

			if ( Pos < realSize )	// there're bytes to c_io_read
			{
				if(blocks){
					nxtBlock((unsigned int*)(&PageNo));
					Flags &= ~SF_UPDT_ACTUAL;
					Flags |= SF_NOT_ACTUAL;
				}else
					file -> LoadBlock ( this, PageNo, Buf );
			}else if(!(file->Flags & SF_NEW_HANDLE)){
				if(blocks){
					blocks= (int*)realloc(blocks, sizeof(*blocks)*(2 + blocks_count));
					nxtBlock((unsigned int*)(&PageNo));
					//blocks[PageNo]= (file->Fat[blocks[PageNo-1]] & ~FAT_CHAIN);
					blocks_count++;blocks[blocks_count]= 0;
				}
				//memset ( Buf, '\0', BufSize );
			}else
				PageNo++;
		}
	}
	Flags |= SF_BUFDIRTY | SF_MODIFIED;
	file->EndOperation();
	return TotalCount;
}

//##ModelId=3BFE7DEB00CB
int	Stream :: SeekEx ( int NewPos )
{
    if(Pos == MAX_BYTE_FILE_SIZE)
    {
		if ( NewPos > realSizeExt )	// do not allow to position past eof
			NewPos = realSizeExt;
		return m_Pos = NewPos;
    }
	bool bSkipTestNextRead= false;
	if ( NewPos > realSize )	// do not allow to position past eof
		NewPos = realSize;
	else if ( NewPos == realSize )
		bSkipTestNextRead= true;

	unsigned int	CurPageNo = (int) ( Pos / BufSize );
	unsigned int	PageNo = (int) ( NewPos / BufSize );

	if ( CurPageNo != PageNo ) {
		if(Flags & SF_UPDT_ACTUAL){
			char *tmpPage= (char*)alloca(BufSize);
			if(!file->file->GetPage ( blocks[CurPageNo], tmpPage ) ){
				abort();
			}
			Pos %= BufSize;
			memcpy(Buf + Pos, tmpPage + Pos, BufSize - Pos);
			Flags &= ~SF_UPDT_ACTUAL;
		}
		if ( Flags & SF_BUFDIRTY ){	
			// save buffer if it has been modified
			if( !blocks[CurPageNo] ){
				if(blocks_count == CurPageNo){
					blocks= (int*)realloc(blocks, sizeof(*blocks)*(2 + blocks_count));
					blocks_count++;
				}
				if(!Save())
					abort();
			}else if( !(Flags & SF_NOT_ACTUAL)){
			    Flags= SF_NOT_ACTUAL;
				if(!(file->Flags & SF_IN_FILE_DIRECT)	&& file->file->curr_last >= blocks[CurPageNo]
														&& !file->bpages->seek(blocks[CurPageNo])){
					file->rpages->get(blocks[CurPageNo]) = 0;
					if(!file->PrePutPage(blocks[CurPageNo], 0))
						abort();
					//file->PutStrsPageFromCache( blocks[CurPageNo], Buf );
					if( file->writeBigStreamPage(blocks[CurPageNo], Buf, CurPageNo) && !WritePage( blocks[CurPageNo], Buf ) )
						abort();
				}else if( file->writeBigStreamPage(blocks[CurPageNo], Buf, CurPageNo) && !WritePage( blocks[CurPageNo], Buf ) )
					abort();
			}
			Flags &= ~SF_BUFDIRTY;
		}
		Pos= 0;
		if(blocks[PageNo] == 0){
			while(CurPageNo < PageNo)
				nxtBlock(&CurPageNo);
			Pos++;
		}else{
			if(!PageNo){
				Point FndW= 0;
				if(file->pWritedPages && (FndW = file->pWritedPages->seek(blocks[0]))){
					Buf= (char*)file->pWritedPages->contents(FndW).GetData();
				}else{
					if(!file->GetStrsPageFromCache( blocks[0], alloca(file->file->PageSize) ))
						abort();
					if(!(file->file->m_mode & (~0x3000))){
						memcpy(hBuf, file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode())->m_Data,
								file->file->PageSize);
					}else
						Buf= (char*)(file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode())->m_Data);
				}
			}else{
				CachedPage *pFnd;
				if(!file->m_PagesCacheBlocks){
					file->m_PagesCacheBlocks= new CachePagesMap(0);
				}
				if((pFnd= (CachedPage *)file->m_PagesCacheBlocks->seek(blocks[PageNo]))){
					pFnd= file->m_PagesCacheBlocks->contents(pFnd);
					memcpy(Buf, pFnd->m_Data, file->file->PageSize);
				}else
					Pos++;
			}
		}
		if(Pos){
			if(Buf != file->m_stepWriteBuff && Buf != hBuf){
				if(file->file->m_mode & (~0x3000)){
					if(!file->m_stepWriteBuff)
						Buf= file->m_stepWriteBuff= file->aSysBuf + file->file->PageSize;
					else
						Buf= hBuf= (char*)malloc( BufSize + roundV);
				}else
					Buf= hBuf= (char*)malloc( BufSize + roundV) ;
			}
			if(blocks[PageNo] == 0){
				if(!bSkipTestNextRead)
					abort();
			}else if(!file->GetPage ( blocks[PageNo], Buf ))
				abort();
		}
	}
	return Pos = NewPos;
}

/*
	Truncates stream at a current position
	returns
	new size
*/

//##ModelId=3BFE7DEB00CD
int	Stream :: Trunc ()
{
	/*if(*(file->file->FileName+34) == '_' && *(file->file->FileName+36) == 'v'){
		LOG_E (("Tnc key(%d, %d)... (%s,%d)", ((long*)this->IndexBuf)[0], ((long*)this->IndexBuf)[1], file->file->FileName+31, Pos));
	}*/
	if ( Pos >= realSize )
		return realSize;

	if (/*Rec->header.realDataLength & 0x80000000 && */Pos <= ImmSize){
		file -> DelHandle ( isBigHandle() ? allocatedSize : 0, this );
	}else /*if ( !(Rec->header.realDataLength & 0x80000000) && Pos <= ImmSize+7){
		Rec->header.realDataLength |= 0x80000000;
		ImmSize += 7;
		file -> DelHandle ( Handle, isBigHandle() ? allocatedSize : 0 );
		allocatedSize= 0x80000000;
		Handle = 0l;
	}else */{
		int savePos= 0;
		if ( m_Id > 0 ){
			savePos = ((Pos+roundV-1)/roundV)*roundV;
			if(!blocks && savePos == ((realSize+roundV-1)/roundV)*roundV){
				Flags |= SF_MODIFIED;
				return realSize = Pos;
			}
			if( savePos >= BufSize ){
				savePos = BufSize - 1;
			}
			allocatedSize &= 0xfff00000;
			allocatedSize |= savePos;
			if(Flags & SF_BUFDIRTY){
				file -> TruncStream ( this, savePos, isBigHandle() ? &allocatedSize : 0, Buf);
				Flags &= ~SF_BUFDIRTY;
				Flags |= SF_MODIFIED;
			}else{
				file -> TruncStream ( this, savePos, isBigHandle() ? &allocatedSize : 0, Buf);
				Flags |= SF_MODIFIED | SF_BUFDIRTY;
			}

			if(blocks){
				free(blocks);
				blocks= 0;
			}
		}else{
			unsigned int	CurPageNo = (int) ( Pos / BufSize );
			if(Flags & SF_UPDT_ACTUAL){
				if(!(file->Flags & SF_IN_FILE_DIRECT)	&& file->file->curr_last >= blocks[CurPageNo]
														&& !file->bpages->seek(blocks[CurPageNo])){
					file->rpages->get(blocks[CurPageNo]) = 0;
				}
				CachedPage *pFnd;
				if(!file->m_PagesCacheBlocks){
					file->m_PagesCacheBlocks= new CachePagesMap(0);
				}
				if(!CurPageNo && (pFnd= (CachedPage *)file->m_PagesCacheBlocks->seek(blocks[CurPageNo]))){
					pFnd= file->m_PagesCacheBlocks->contents(pFnd);
					memcpy(pFnd->m_Data, Buf, file->file->PageSize);
					pFnd->m_changed= 1;
				}else if( file->writeBigStreamPage(blocks[CurPageNo], Buf, CurPageNo) && !WritePage( blocks[CurPageNo], Buf ) )
					abort();
				Flags &= ~SF_UPDT_ACTUAL;
			}else if ( Flags & SF_BUFDIRTY ){	
				// save buffer if it has been modified
				if( !blocks[CurPageNo] ){
					if(blocks_count == CurPageNo){
						blocks= (int*)realloc(blocks, sizeof(*blocks)*(2 + blocks_count));
						blocks_count++;
					}
					if(!Save())
						abort();
				}else if( !(Flags & SF_NOT_ACTUAL)){
					Flags= SF_NOT_ACTUAL;
					if(!(file->Flags & SF_IN_FILE_DIRECT)	&& file->file->curr_last >= blocks[CurPageNo]
															&& !file->bpages->seek(blocks[CurPageNo])){
					}else{
						if( file->writeBigStreamPage(blocks[CurPageNo], Buf, CurPageNo) && !WritePage( blocks[CurPageNo], Buf ) )
							abort();
						Flags &= ~SF_NOT_ACTUAL;
					}
				}
				Flags &= ~SF_BUFDIRTY;
			}
	if(CurPageNo < 1)
	{
		// урезание, возможно, короткого стрима, пробуем всегда с выравниванием //
		savePos = ((Pos+roundV-1)/roundV)*roundV;
		if( savePos >= BufSize ){
			savePos = BufSize - 1;
		}
		file->Flags |= SF_SRC_AS_SHORT;
		if ( !file->IsNotBlock( savePos ) ){
			file->TruncStream ( this, savePos, isBigHandle() ? &allocatedSize : 0, Buf );
			Flags |= SF_MODIFIED;
			return realSize = Pos;
		}
		savePos= file->FindPage ( Handle, ( (savePos-1) / file->file->PageSize ), (allocatedSize & FAT_CHAIN) ? allocatedSize : 0);
		if((CurPageNo = (int) ( file->Fat[savePos] & ~FAT_CHAIN ))){
			file->AddFat(savePos, (int)FAT_CHAIN - (int)file->Fat[savePos]);
			file->FreePageChain ( CurPageNo );
		}
		savePos= -1;
		CurPageNo= 0;
	}
	if(Flags & SF_NOT_ACTUAL){
		file->rpages->get(blocks[CurPageNo]) = 0;
		if(!file->PrePutPage(blocks[CurPageNo], 0))
			abort();
		//file->PutStrsPageFromCache( blocks[CurPageNo], Buf );
		if( file->writeBigStreamPage(blocks[CurPageNo], Buf, CurPageNo) && !WritePage( blocks[CurPageNo], Buf ) )
			abort();
		if(savePos < 0){
			Flags |= SF_MODIFIED;
			return realSize = Pos;
		}
	}
	if(savePos != -1)
		file->TruncStream ( this, Pos, isBigHandle() ? &allocatedSize : 0, Buf );
	Flags |= SF_MODIFIED;
		}
	}
	return realSize = Pos;
}

int StreamFile::GetPage(int page, void *buff)
{
	if(!(Flags & SF_IN_FILE_DIRECT)){
		if(file->curr_last < page)
			;
		else if(!bpages->seek(page))
			rpages->get(page) = 0;
	}
	return file->GetPage(page, buff);
}

extern const char *pBuckupFileExt;


void StreamFile::FirstRecord()
{
	if(!m_hBackup){
		int atry = 0;
		char tmpO[NDTC_MAX_PATH_SIZE];
		sprintf(tmpO, "%s%s",file->FileName, pBuckupFileExt);
		if((m_hBackup = c_io_open(tmpO, ACE_OS_O_WRONLY|ACE_OS_O_BINARY)) != -1){
			// use_old
		}/*else while ( atry++ < 10) {
			m_hBackup = c_io_open(tmpO, ACE_OS_O_CREAT|//ACE_OS_O_TRUNC|
									ACE_OS_O_WRONLY|ACE_OS_O_BINARY);
			if ( m_hBackup != -1 )
				break;
			::ace_os_sleep(1000);
		}
		atry = 0;
		if( m_hBackup == -1 ||  c_io_write(m_hBackup, &atry, sizeof(atry)) != sizeof(atry) || c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0) {
			LOG_E (("abort in StreamFile::PutPage (%s)", GetBackupName() ));
			abort();
		}
		if(!(Flags & SF_NOT_FIRST_DUMP)){
			SaveFat(m_hBackup);
		}
		Flags |= SF_NOT_FIRST_DUMP;*/
	}
}

extern void IndexInLog(PagedFile *, StreamFile *);

void StreamFile::first_bb()
{
	if(Flags & SF_FIRST_POS_BCKP){
		Flags &= ~SF_FIRST_POS_BCKP;
		int nNul[]= {-1, 0};
		char errBB[]= "abort in StreamFile::first_bb(%s)";
		if(pFirst->file->SystemPageBuf == file->SystemPageBuf){
			*(pFirst->file->m_postFilePoss)= 1;
			pFirst->file->FreePage= 1;
			if(	c_io_lseek(m_hBackup, file->PageSize, ACE_OS_SEEK_SET) != file->PageSize || c_io_write(m_hBackup, nNul, 8) != 8){
				LOG_E ((errBB, pFirst->file->FileName));
				abort();
			}
			pFirst->file->GetPage(0,0);
		}else{
			if(	c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0 || c_io_write(m_hBackup, nNul, 4) != 4
				|| c_io_lseek(m_hBackup, pFirst->file->PageSize, ACE_OS_SEEK_SET) != pFirst->file->PageSize
				|| c_io_write(m_hBackup, nNul+1, 4) != 4) {
				LOG_E ((errBB, pFirst->file->FileName,"old"));
				abort();
			}
		}
	}
}

int StreamFile::PrePutPage(int page, void *buff, void *DirectBuf)
{
	pFirst->StartBackupEx();
	Point Fnd= bpages->seek(page);
	if(!Fnd && (Fnd= rpages->seek(page))){
		if(m_hBackup){
			if(!(Flags & SF_NOT_FIRST_DUMP)){
				SaveFat(m_hBackup);
			}
			Flags |= SF_NOT_FIRST_DUMP;
		}
		int job= 0;
		if(!(Flags & SF_IN_AUTOTRANSCTN)) {
			FirstRecord();
			{
				void *pBff= alloca(file->PageSize);
				if(!pBff) {
					LOG_E (("abort in StreamFile::PutPage(pBff= 0)"));
					abort();
				}
				if(DirectBuf){
					pBff= DirectBuf;
				}else{
					CachedPage *pFnd= 0;
					if(m_PagesCacheBlocks){
						if((pFnd= (CachedPage *)m_PagesCacheBlocks->seek(page))){
							pFnd= m_PagesCacheBlocks->contents(pFnd);
						}
					}
					if(pFnd){
						pBff= pFnd->m_Data;
					}else if(!file->GetPage(page, pBff)) {
						LOG_E (("abort in StreamFile::PutPage(%d,%d,%s)", page, file->LastPage, strrchr(file->FileName, '_')));
						file->GetPage(page, pBff);
						abort();
					}
				}
				first_bb();
				if(pFirst->file->SystemPageBuf == file->SystemPageBuf)
					pFirst->file->FreePage++;
				job = 0;
				if(c_io_write(m_hBackup, pBff, file->PageSize) != file->PageSize) {
					LOG_E (("abort in StreamFile::PutPage(os_Write page buff)"));
					abort();
				}
				if(c_io_write(m_hBackup, &job, 4) != 4) {
					LOG_E (("abort in StreamFile::PutPage in Created File(os_Write nul)"));
					abort();
				}
				c_io_lseek(m_hBackup, -(file->PageSize + 4 + 4), SEEK_CUR);
				if(c_io_write(m_hBackup, &page, 4) != 4) {
					LOG_E (("abort in StreamFile::PutPage in Created File(os_Write page)"));
					abort();
				}
				/*if(pFirst->file->SystemPageBuf == file->SystemPageBuf){
					c_io_lseek(m_hBackup, file->PageSize + 4, SEEK_CUR);
					*(pFirst->file->m_postFilePoss)= 0;
				}else*/
					c_io_lseek(m_hBackup, file->PageSize + 4, SEEK_CUR);
				job= 1;
			}
		}else if((Flags & SF_IN_FIRST_COPY)){
			Flags &= ~SF_IN_FIRST_COPY;
			IndexInLog( pFirst->file, this );
			job= 1;
		}
		if(job){
			(*bpages) [page] = 0;
			rpages->del(page);
		}
	}
	return 1;
}

int Stream::WritePage(int page, void *buff)
{
	return file->PutPage(page, buff);
}

int StreamFile::PutPage(int page, void *buff)
{
	//GUARD (file->m_mtxCheckInWrite);
	if(!(Flags & SF_IN_FILE_DIRECT)){
		PrePutPage(page, buff);
	}else if(pFirst)
		pFirst->StartBackupEx();
	return file->PutPage(page, buff);
}

char *StreamFile::GetBackupName()
{
	if(!pNameBackupName){
		char tmp[NDTC_MAX_PATH_SIZE];
		sprintf(tmp, "%s%s",
#ifdef MIN_MEM_CONTEXT
							"c:\\nul.str"
#else
							file->FileName
#endif
							, pBuckupFileExt);
		pNameBackupName= strdup(tmp);
	}
	return pNameBackupName;
}

void StreamFile::FlushIndexPagedFileAdaptiveCache()
{
	if(m_pCacheKeysStackCount)
		FlushCache(&m_PagesCacheKeys, pFirst->file, &m_pCacheKeysStack, &m_pCacheKeysStackCount);

	if(m_pCacheBlocksStackCount)
		FlushCache(&m_PagesCacheBlocks, file, &m_pCacheBlocksStack, &m_pCacheBlocksStackCount);
}

/*class BTreeMaxKey
{
public:
	BTreeMaxKey()
	{
		m_pIndex= 0;
		m_key= 0;
	}
	BTreeMaxKey(const int)
	{
		m_pIndex= 0;
		m_key= 0;
	}
	BTreeMaxKey(Index *pIndex, const void *pKey, const int szKey)
	{
		m_pIndex= pIndex;
		m_key= (char*)malloc(szKey);
		if(!m_key)
			throw NdtClone::Error ();
		memcpy(m_key, pKey, szKey);
	}
	BTreeMaxKey(const void *pKey, Index *pIndex)
	{
		m_pIndex= pIndex;
		m_key= (char*)pKey;
	}
	~BTreeMaxKey(){
	}
	const Index *GetIndex() { return m_pIndex;}
	const void *GetKey() { return m_key;}
	char *m_key;
protected:
	Index *m_pIndex;
};

template <class Key, class Data>
class QuickIndexMap: public QuickSplayMap<Key, Data> {
public:
	QuickIndexMap(const Data dflt, int reAllocF= 1, int reAllocS= 0) : QuickSplayMap<Key,Data>(dflt){
	}
	int key_cmp (const Key& a, const Key& b) const {

		if(((BTreeMaxKey*)&a)->GetIndex() > ((BTreeMaxKey*)&b)->GetIndex())
			return 1;
		if(((BTreeMaxKey*)&a)->GetIndex() < ((BTreeMaxKey*)&b)->GetIndex())
			return -1;
		return ((BTreeMaxKey*)&a)->GetIndex()->Compare( ((BTreeMaxKey*)&a)->GetKey()
														, ((BTreeMaxKey*)&b)->GetKey());
	}
};
typedef QuickIndexMap<BTreeMaxKey, int> tempDelKeys;*/

Stream * Index :: OpenN ( BTKEY key, int sn, int AutoCreate, int *pCreated )
{
	if(global_IsBlock())
		return 0;

	int nsobj= streams->get_guard();
	if(streams->Flags & SF_POST_REST_FAT){
		streams->Flags &= ~SF_POST_REST_FAT;
		streams->pFirst->StartBackupEx();
		char *buff= (char*)alloca(file->PageSize+4);
		file->m_readed.processMode= ACE_OS_O_RDONLY;
		file->m_readed.page= 1;
		file->m_readed.buf= buff;
		file->m_readed.pHeader= streams->m_PagedBackupSystemPage;
		*file->m_postFileHandles= streams->m_hBackup;
		file->m_readed.pFilePoss= file->m_postFilePoss;
		file->m_readed.pFileHandles= file->m_postFileHandles;

		while(otherReadOrWrite(&file->m_readed) != -1 && *(int*)buff){
			if(!streams->rpages->seek(*(int*)buff)){
				if(FAT_CHAIN & *(int*)buff){
					if(!streams->m_PagesCacheKeys){
						streams->m_PagesCacheKeys= new CachePagesMap(0);
					}
					(*(streams->bpages))[(~FAT_CHAIN) & *(int*)buff] = 0;
					streams->AddPageFromCache(streams->bpages->key(streams->bpages->GetRootG_SimpleSplayNode())
												, streams->m_PagesCacheKeys
												, file
												, buff+4
												, &streams->m_pCacheKeysStack
												, &streams->m_pCacheKeysStackCount, 1);
					//pWritedPages->get((~FAT_CHAIN) & *(int*)buff) = NDTKPage(file, buff+4);
				}else{
					streams->AddPageFromCache(*(int*)buff
												, streams->m_PagesCacheBlocks
												, streams->file
												, buff+4
												, &streams->m_pCacheBlocksStack
												, &streams->m_pCacheBlocksStackCount, 1);
					//streams->AsUpdated(*(int*)buff, buff+4);
				}
			}else{
				streams->fpages->get(*(int*)buff)= int(( (streams->Fat + *(int*)buff -1) - streams->Fat)&0x7fffffff);
			}
			file->m_readed.page++;
		}
		streams->Flags |= SF_RESTR_LONG_BKP;
		streams->rpages->clear();
		*file->m_postFileHandles= file->file;
		file->m_readed.pFilePoss= streams->file->m_postFilePoss;
		file->m_readed.pFileHandles= streams->file->m_postFileHandles;
	}
	if(key && (!KeyCount||AutoCreate)){
		if(AutoCreate){
			StartBackupEx();
			/*
			// Хотелось сделать директивное создание нового индекса уже на файле, содержащим 
			// другой индекс...
			if(streams->GetTransactionCounter() == 1 && !streams->pFirst->pWritedPages->length()){
				key= key;
			}*/
		}else{
			streams->kill_guard(nsobj);
			return 0;
		}
	}
	int SingleTrans= 1;
	if(streams->Flags & SF_IN_OPERATION){
		LOG_E (("(%x)(%s,%s)abort in Index::OpenN(In Operation)", this, Name,strrchr(streams->file->FileName, '_')));
		abort();
	}else if(streams->Flags & SF_IN_TRANSCTN){
		SingleTrans= 0;
	}
#ifdef _DEBUG
	else if(streams->ostreams){
		Point firstI= streams->ostreams->first();
		if(firstI){
			ACE_UINT64 streamID= streams->ostreams->key(firstI);
			LOG_E (("(%x,%x:%x)(%s,%s)abort in Index::OpenN", this, ((int*)&streamID)[1], ((int*)&streamID)[0], Name,strrchr(streams->file->FileName, '_')));
			abort();
		}
	}
	ClosedID= -1;
#endif
	//double sec1 = streams->pFirst->file->hrcON.get_seconds ();
	/*class oGetPause
	{
	public:
		oGetPause(StreamFile *pCalc){
			m_pCalc= pCalc;
			m_start_count= pCalc->hi_res_counter.get_count();
		}
		~oGetPause()
		{
			ACE_hrtime_t all_count = m_pCalc->hi_res_counter.get_count() - m_start_count;

			unsigned s;
			unsigned ms;
			unsigned us;

			m_pCalc->hi_res_counter.tiks_to_time(all_count,s,ms,us);
			m_pCalc->m_ms += ms;
			m_pCalc->m_s += s;
			if(m_pCalc->m_ms > 1000){
				m_pCalc->m_ms -= 1000;
				m_pCalc->m_s++;
			}
		}
	protected :
		StreamFile *m_pCalc;
		ACE_hrtime_t m_start_count;
	};*/
	//oGetPause calT(streams);
	streams->BeginOperation(this);

	Stream *str= 0;
	char *keyBuf= 0;
	int oPage= 0, oPos= -1;
	Point removedFnd= 0;
	CollectionStream= 0;
	if(sn == -33){
		streams->EndOperation();
		str= (Stream *)DelKey ( key );
		return str;
	}else if(sn != -22){
		/*if(sn > 555554){
			char *KeyBuf= (char*)alloca(KeyLength);
			IndexRecordData *pOne= 0, *pRstl= 0;
			sn -= 555555;
			if(sn < 20000){
				pOne= recordData(KeyBuf,0);
				CollectionStream= nstreams;
				while(CollectionStream--)
					memset(pOne+CollectionStream, 0, sizeof(*pOne));
				memcpy(KeyBuf, key, (char*)pOne - KeyBuf);
				if(sn < 10000)
					pRstl= pOne+sn;
				else
					pRstl= pOne+(sn-10000);
			}else{
				pRstl= (IndexRecordData *)key;
				memset(pRstl, 0, sizeof(*pRstl));
			}
			skipInitRecord();
			Stream tmpS(streams,pRstl,ImmDataSize,roundv);
			streams->Flags &= ~SF_IN_OPERATION;
			if(sn < 10000 && tmpS.Write(pCreated, AutoCreate) != AutoCreate){
				Close(&tmpS);
				return 0;
			}else if(sn >= 10000){
				char **ppBuf= (char **)pCreated;
				int iii=0, endI= AutoCreate/0x10000;
				while(iii < endI){
					if(tmpS.Write(ppBuf[iii++], 0x10000) != 0x10000){
						Close(&tmpS);
						return 0;
					}
				}
				if(tmpS.Write(ppBuf[iii], AutoCreate%0x10000) != AutoCreate%0x10000){
					Close(&tmpS);
					return 0;
				}
			}
			tmpS.closeAttrs ();
			tmpS.IndexFreeBuf= 0;
			if(tmpS.blocks)
				free( tmpS.blocks );
			tmpS.blocks= 0;
			if(sn < 20000 && (FindKey( KeyBuf, KeyBuf, 1 ) != GKDB::BT_NONE)){
#ifdef	_DEBUG
				LOG_E (("(%x,%x:%x)abort in Index(%s,%s)::Close(Method on BTree)!)", this, ((int*)&ClosedID)[1], ((int*)&ClosedID)[0], Name,strrchr(streams->file->FileName, '_')));
#endif
				abort();
			}
	#ifdef _DEBUG
			streams->ostreams->del(tmpS.streamID);
			if(!streams->ostreams->first()){
				streams->CountAllFlush++;
				if(!(streams->Flags & SF_IN_TRANSCTN)){
					streams->BackupTransaction();
				}
			}
	#endif
			//streams->pFirst->file->tckON += streams->pFirst->file->hrcON.get_seconds () - sec1;
			return (Stream*)1;
		}else */if ( (file->m_mode & (~0x3000)) ) {
			if(sn >= 3333){
				sn -= 3333;
				CollectionStream = 3;
			}else if(sn >= 2222){
				sn -= 2222;
				CollectionStream = 2;
			}else if(sn >= 1111){
				sn -= 1111;
				CollectionStream = 1;
			}
			keyBuf = (char *) malloc ( KeyLength );
			assert ( keyBuf != 0 );
			if ( pCreated ) *pCreated = 0;
		}
		if(!pWritedPages){
			if(!streams->pFirst){
				LOG_E (("(%x)(%s,%s)abort in Index::OpenN(Bad First!)", this, Name,strrchr(streams->file->FileName, '_')));
				abort();
			}
			pWritedPages= streams->pFirst->pWritedPages;
		}
	/*if(*(file->FileName+34) == '_' && *(file->FileName+36) == 'v'){
		LOG_E (("Opn key(%d, %d)... (%s,%d streams)", ((long*)key)[0], ((long*)key)[1], file->FileName+31,sn));
	}*/
		if(AutoCreate && ((streams->fatPages+1) & 0x8000))
			AutoCreate= 0;

		switch ( FindKey ( key, keyBuf, AutoCreate ) )
		{
			case GKDB::BT_NONE:			// append new key
				if(CollectionStream != 55){
					if ( !AutoCreate )
					{
						if( keyBuf )
							free ( keyBuf );
						streams->EndOperation();
		//#ifdef BIG_CLONE_LOG
						//LOG_D (("(%x)(%s,%s)(NotFindKey!)", this, Name,strrchr(streams->file->FileName, '_')));
		//#endif
						streams->kill_guard(nsobj);
						return 0;
					}
					if ( pCreated ) *pCreated = 1;
				}
				if(Stack [Sp+1].buf == (void*)-1){
					Stack [Sp+1].buf= 0;
					oPage= Stack [Sp+1].Page;
					oPos= Stack [Sp+1].Pos;
				}
				//update_SystemPage();
				break;

			case GKDB::BT_OK:			// key found
				if(sn == -1){
					str= new Stream(streams,0,ImmDataSize,roundv);
					oPage= Stack [Sp-1].Page;
					oPos= Stack [Sp-1].Pos;
				}else if(!(file->m_mode & (~0x3000)))
					keyBuf= (char*)RecOffs ( Stack [Sp-1].buf, Stack [Sp-1].Pos );
				else if(!(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))){
					memcpy(keyBuf, RecOffs ( Stack [Sp-1].buf, Stack [Sp-1].Pos ), KeyLength);
				}else/*if(!removedFnd)*/{
					oPage= Stack [Sp-1].Page;
					oPos= Stack [Sp-1].Pos;
					memcpy(keyBuf, Stack [Sp-1].curKey, KeyLength);
				}
				break;

			default:			// some error occurred
				streams->kill_guard(nsobj);
				LOG_E (("abort in Index::OpenN(some error occurred)"));
				free ( keyBuf );
				streams->EndOperation();
					abort();
				return 0;
		}
		if(!str){
			switch(CollectionStream){
				case 3:
					str= new StoredSortedRefCollectionPlus(streams,recordData(keyBuf,sn),ImmDataSize,roundv);
					break;
				case 2:
					str= new StoredSortedRefCollection(streams,recordData(keyBuf,sn),ImmDataSize,roundv);
					break;
				case 1:
					str= new StoredSortedCollection(streams,recordData(keyBuf,sn),ImmDataSize,roundv);
					break;
				default:
					str= makeStream(streams,recordData(keyBuf,sn),ImmDataSize,roundv);
			}
		}
		str->m_bAsNew= m_bAsNew;
		if(oPage){
#ifdef	_DEBUG
			ClosedID= str->streamID;
#endif
			str->oPage= oPage;
			str->oPos= oPos;
		}
	}else{
		str=new Stream(streams,(IndexRecordData *)key,ImmDataSize,roundv, AutoCreate);
		str->m_bAsNew= m_bAsNew;
	}
	if(str) {
#ifdef WRITE_KEYS_PAGE_INBACKUP
		if(str->Length() <= ImmDataSize)
			PutPage(streams->lastKeyPage, 0);
#endif
		str -> IndexBuf = keyBuf;
#ifdef BIG_CLONE_LOG
{
	char *pfn0= 0;
		if((file->m_mode & (~0x3000)))
		pfn0= strrchr(streams->file->FileName, '_');
	if(pfn0 && pfn0[1] == 'f')
		LOG_D (("(%x,%x:%x)(%s,%s)(Str)", this, ((int*)&(str->streamID))[1], ((int*)&(str->streamID))[0], Name,strrchr(streams->file->FileName, '_')));
		}
#endif
		streams->EndOperation();
		return str;
	}else{
		streams->kill_guard(nsobj);
		LOG_E (("(%x)(%s,%s)abort in Index::OpenN(Not Create Str)", this, Name,strrchr(streams->file->FileName, '_')));
		free(keyBuf);
		streams->EndOperation();
		abort();
		return 0;
	}
}

void *Index :: DeleteUpKey()
{
	if(nstreams > 1)
		streams->StartTransaction();
	char* keyBuf = (char *) malloc ( KeyLength );
	memcpy(keyBuf, RecOffs ( Stack [Sp].buf, Stack [Sp].Pos ), KeyLength);
	int rptD= 0;
	Stream *pOld= makeStream(streams,recordData(keyBuf,rptD),ImmDataSize,roundv);
	pOld->oPage= Stack [Sp].Page;
	pOld->oPos= Stack [Sp].Pos;
	pOld->IndexBuf = keyBuf;
	while(rptD < nstreams){
		int pssz= (int)(streams->file->PageSize & 0x7fff);
		char *updtBuf= (char*)alloca(pssz);

		if(pOld->Handle && pOld->m_Id < 1){
			/* Закоментарино, т.к. бэкапить нет смысла, в рамках текущей транзакции
				удалённые страницы переписываться не будут !
			memset(updtBuf, 0, pssz);
			int rpt= pOld->Length() / pssz;
			rpt++;
			while(rpt--){
				if(pOld->Write(updtBuf,pssz) != pssz){
					LOG_E (("abort in Index :: Delete - trunc 0"));
					abort();
				}
			}*/
			streams->Flags |= SF_SRC_AS_SHORT;
			pOld->file->DelHandle( pOld->isBigHandle() ? pOld->allocatedSize : 0, pOld );
		}else{
			if (pOld->Length() > pOld->ImmSize){
				pOld->Trunc();
			}
		}
		pOld->Flags &= ~SF_MODIFIED;
		rptD++;
		m_bAsNew= false;
		if(rptD < nstreams){
			streams->EndOperation();
			Index::Close(pOld);
			keyBuf = (char *) malloc ( KeyLength );
			memcpy(keyBuf, RecOffs ( Stack [Sp].buf, Stack [Sp].Pos ), KeyLength);
			pOld= makeStream(streams,recordData(keyBuf,rptD),ImmDataSize,roundv);
			pOld->oPage= Stack [Sp].Page;
			pOld->oPos= Stack [Sp].Pos;
			pOld->IndexBuf = keyBuf;
		}
	}
	return pOld;
}

int	Index :: Delete ( BTKEY key )
{
	StartBackupEx();
	Stream *pOld= Index::OpenN( key, -33 );
	if ( !pOld ){
		if(nstreams > 1)
			streams->EndTransaction();
		return GKDB::BT_NOTFOUND;
	}
	Index::Close(pOld, 1);
	if(nstreams > 1)
		streams->EndTransaction();
	return GKDB::BT_OK;
}

void StreamFile::EndTransaction(int Buckup)
{
	if (m_transaction_counter == 1) {
	  if(pFirst && pFirst->streams != this){
		pFirst->streams->EndTransaction(Buckup);
	  }else{
#ifdef _DEBUG
		if((Flags & SF_IN_OPERATION) || !(Flags & SF_IN_TRANSCTN) || (ostreams && ostreams->first())) {
			if((file->m_mode & (~0x3000))){
				if(ostreams){
					Point firstI= ostreams->first();
					ACE_UINT64 streamID= ostreams->key(firstI); // GARANT_MSVCRTT
					LOG_E (("(%x:%x)(%s)abort in StreamFile::EndTransaction",
								((int*)&streamID)[1], ((int*)&streamID)[0], pFirst->Name));
				}else
					LOG_E (("abort in StreamFile::EndTransaction"));
				abort();
			}else if(ostreams){
				Point firstI= ostreams->first();
				LOG_E (("not closed Stream with ID64 (%x:%x)!", ((int*)&streamID)[1], ((int*)&streamID)[0]));
			}
		}
#endif
		/*if(m_pDelKeys){
			tempDelKeys *pDelKeys= (tempDelKeys*)m_pDelKeys; m_pDelKeys= 0;
			G_Point t;
			Index *pLocalIndex;
			Stream *pDelStr;
			for(t= pDelKeys->first(); t; pDelKeys->next(t)){
				pLocalIndex= (Index*)pDelKeys->key(t).GetIndex();
				pDelStr= new Stream(pLocalIndex->streams,0,pLocalIndex->ImmDataSize,pLocalIndex->roundv);
				pDelStr->IndexBuf= (char*)(pDelKeys->key(t).GetKey());
				pLocalIndex->Close(pDelStr,1);
			}
			delete pDelKeys;
		}*/
		int clearBackupKeys= 0, CloseLocalTransaction= 0;
		if((Flags & SF_IN_PRE_ATRANSCTN) || (Flags & SF_IN_AUTOTRANSCTN)){
			if((CloseLocalTransaction= pFirst->IsGlobalTransaction(SF_IN_FIRST_COPY)) != -1){
				if(++CloseLocalTransaction > 1 ){
					Flags &= ~SF_IN_TRANSCTN;
					m_transaction_counter--;
					pFirst->StartAutoLocalTransaction();
					CloseLocalTransaction= 0;
					pFirst->streams->Flags &= ~( SF_IN_FIRST_COPY | SF_IN_NOT_COPY );
					m_transaction_counter++;
				}
			}
		}else if(!(m_transaction_counter - 1) && pFirst->IsGlobalTransaction((Flags & SF_IN_NOT_COPY))){
			Flags &= ~SF_IN_NOT_COPY;
			pFirst->StartAutoLocalTransaction();
		}else
			CloseLocalTransaction++;
		if(CloseLocalTransaction){
			if((Flags & SF_IN_NOT_COPY) && !CountAllFlush && m_hBackup && m_hBackup != -1 /*m_hBackupKeys && m_hBackupKeys != -1*/)
				clearBackupKeys++;
			BackupTransaction();
			/*if((Flags & SF_IN_NOT_COPY) &&  m_hBackup){
				c_io_close(m_hBackup);Flags &= ~SF_NOT_FIRST_DUMP;
				m_hBackup= 0;
				if(CloseLocalTransaction != -1){
					ace_os_unlink(GetBackupName());
					if(clearBackupKeys){
						clearBackupKeys= 0;
						//if(	c_io_lseek(m_hBackupKeys, 0, SEEK_SET)
						//		||
						//	ace_os_ltrunc(m_hBackupKeys, 0)
						//		||
						//		pFirst->BuckupRoot(m_hBackupKeys)) {
						//	LOG_E (("abort in StreamFile::EndTransaction::BackupTransaction"));
						//	abort();
						//}
					}
				}
			}*/
			Flags &= ~SF_IN_TRANSCTN;
		}
	  }
	}
	if(Buckup)
		m_transaction_counter--;
	else if (m_transaction_counter == 1)
			m_transaction_counter--;
}

void StreamFile::StartTransaction()
{
	if (m_transaction_counter == 0) {
		if(((PagedFileHeader*)file->SystemPageBuf)->Signature != BASE_DATA_VERSION){
			if(!(Flags & SF_CREATE) && pFirst->KeyCount == 0 && pFirst->file->file == -2 && file->file == -2){
				void *kkk= alloca(pFirst->KeyLength);
				memset(kkk,0,pFirst->KeyLength);
				Stream *sss= pFirst->OpenN(kkk,0,1);
				if(!sss)
					abort();
				else{
					sss->Write(kkk,pFirst->ImmDataSize+1);
					pFirst->Close(sss);
					*(short*)(m_PagesCacheKeys->contents(m_PagesCacheKeys->GetRootG_SimpleSplayNode())->m_Data)= 0;
					pFirst->streams->Fat[LastCreatedBlockPage]= 6;
					pFirst->KeyCount= 0;
				}
				pFirst->file->curr_last= 1;
				file->curr_last= file->LastPage;
			}else if(file->m_mode & ACE_OS_O_RDWR){
				file->curr_last= file->LastPage;
				pFirst->file->curr_last= pFirst->file->LastPage;
			}else if(pFirst->file->file == file->file && file->file > 0){
				void *buff= alloca(file->PageSize);
				if(!(file->GetPage(1,buff)))
					abort();
				else{
					(*(ACE_HANDLE*)(pFirst->file->m_postFileHandles))
						= ::ACE_OS::open(file->FileName, ACE_OS_O_RDONLY|ACE_OS_O_BINARY, ACE_DEFAULT_OPEN_PERMS);
					if((*(ACE_HANDLE*)pFirst->file->m_postFileHandles) == ACE_INVALID_HANDLE)
						abort();
					{
						pFirst->file->file= 0;
						*pFirst->file->m_postFilePoss= 0;
						pFirst->file->m_readed.cur_Seek= file->m_readed.cur_Seek;
						pFirst->file->m_readed.cur_Read= file->m_readed.cur_Read;
					}

				}
			}
		}else{
			file->curr_last= -1;
			pFirst->file->curr_last= -1;
		}
		Flags |= SF_IN_TRANSCTN;
	}
	m_transaction_counter++;
}

void StreamFile::PreBackupTransaction(int skipWritePage)
{
	if(m_hBackup){
#ifdef WRITE_KEYS_PAGE_INBACKUP
		if(c_io_close(m_hBackupKeys)) {
			LOG_E (("abort in StreamFile::BackupTransaction6"));
			abort();
		}
		m_hBackupKeys= 0;
		*Fnd= '~';ace_os_unlink(pNameF);
#else
		Flags |= SF_FIRST_POS_BCKP;
		/*if(	ace_os_ltrunc(m_hBackup, 0)
				||
			(!skipWritePage && pFirst->BuckupRoot(m_hBackup))) {
			LOG_E (("abort in StreamFile::BackupTransaction7"));
			abort();
		}*/
#endif
	}
}

bool write_System(PagedFile *file,int tmp_pos)
{
	((PagedFileHeader*)(file->SystemPageBuf))->LastPage = file->LastPage;
	((PagedFileHeader*)(file->SystemPageBuf))->FreePage = file->FreePage;
	((PagedFileHeader*)(file->SystemPageBuf))->lastFreePage = file->lastFreePage;
	if(	c_io_lseek(file->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
		|| c_io_write(file->GetFileHandle(), file->SystemPageBuf, file->PageSize ) != file->PageSize
		|| c_io_lseek(file->GetFileHandle(), tmp_pos, ACE_OS_SEEK_SET) != tmp_pos){
		LOG_E (("abort in StreamFile::BackupTransaction55first"));
		return true;
	}
	return false;
}

bool StreamFile::backup_System()
{
	int ret0= 1, firstBkp= 0;

	char *pKeySys= pFirst->file->SystemPageBuf == file->SystemPageBuf ? m_PagedBackupSystemPage : pFirst->file->SystemPageBuf;
	int KeyHnd= pFirst->file->SystemPageBuf == file->SystemPageBuf ? m_hBackup : pFirst->file->GetFileHandle();
	short psize= pFirst->file->SystemPageBuf == file->SystemPageBuf ? ((PagedFileHeader*)pKeySys)->PageSize : pFirst->file->PageSize;

	if(*(int*)(pKeySys+psize) == *(int*)(pKeySys))
		ret0= memcmp(pKeySys+psize, pKeySys, psize);
	else{
		if(*(int*)(pKeySys+psize) == 0){
			ret0= c_io_tell(file->GetFileHandle());
			if(	c_io_lseek(file->GetFileHandle(), 0, ACE_OS_SEEK_SET) != 0
				|| c_io_read(file->GetFileHandle(), file->SystemPageBuf+file->PageSize, file->PageSize ) != file->PageSize
				|| c_io_lseek(file->GetFileHandle(), ret0, ACE_OS_SEEK_SET) != ret0){
				LOG_E (("abort in StreamFile::backup_System() 050"));
				abort();
			}
			ret0= c_io_tell(KeyHnd);
			if(	c_io_lseek(KeyHnd, 0, ACE_OS_SEEK_SET) != 0
				|| c_io_read(KeyHnd, pKeySys+psize, psize ) != psize
				|| c_io_lseek(KeyHnd, ret0, ACE_OS_SEEK_SET) != ret0){
				LOG_E (("abort in StreamFile::backup_System() 060"));
				abort();
			}
			firstBkp++;
		}else{
			LOG_E (("abort in StreamFile::backup_System() 070"));
			abort();
		}
	}
	int ret1= 1;
	if(*(int*)(file->SystemPageBuf+file->PageSize) == *(int*)(file->SystemPageBuf)){
		ret1= firstBkp || memcmp(file->SystemPageBuf+file->PageSize, file->SystemPageBuf, file->PageSize);
	}else{
		if((ret1= firstBkp)){
		}else{
			LOG_E (("abort in StreamFile::backup_System() 080"));
			abort();
		}
	}
	if(ret0 || ret1){
		if(ret1 && *(int*)(file->SystemPageBuf+file->PageSize) == *(int*)(file->SystemPageBuf)){
			file->SystemPageBuf += file->PageSize;
			file -> GetAttr ( pFatSizeName, &ret1, sizeof ( short ));
			((int*)(((PagedFileHeader*)(pKeySys+psize))->reserved))[1]
														= ret1;
			((int*)(((PagedFileHeader*)(pKeySys+psize))->reserved))[2]
														= ((PagedFileHeader*)file->SystemPageBuf)->LastPage;
			file->SystemPageBuf -= file->PageSize;
			if((psize - file->PageSize) == 4)
				*(int*)(pKeySys+psize+file->PageSize)= pFirst->file->FreePage;
			if(	c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0
				|| c_io_write(m_hBackup, pKeySys+psize, psize ) != psize){
				LOG_E (("abort in StreamFile::backup_System() 0"));
				abort();
			}
			if(firstBkp)
				ret1= memcmp(file->SystemPageBuf+file->PageSize, file->SystemPageBuf, file->PageSize);
		}
		if(ret0){
			memcpy(pKeySys+psize, pKeySys, psize);
			if(pFirst->file->SystemPageBuf == file->SystemPageBuf)
				;
			else
				reConnectFirst(pFirst->file->m_pCryptoTag);
		}
		if(ret1){
			memcpy(file->SystemPageBuf+file->PageSize, file->SystemPageBuf, file->PageSize);
			ret1= c_io_tell(file->GetFileHandle());
			if(ret1 == -1 || write_System(file,ret1)){
				LOG_E (("abort in StreamFile::write_System"));
				abort();
			}
		}
	}
	return false;
}
void StreamFile::reConnectFirst(char *defCryproTagK){
	//if(pFirst->file->PageSize > *(int*)pFirst->file->m_pCryptoTag){
		if(write_System(pFirst->file,c_io_tell(pFirst->file->GetFileHandle()))
			|| pFirst->file->FlushAllHandles(0,pFirst->file->FileName))
			abort();
	//}
}

void StreamFile::UpActualLevel(CachedPage *pFnd, CachePagesMap *pMap)
{
	if(pFnd->actualLevel < (0x7fffffff - GKDB::BT_MAXDEPTH)){
		// Up actual unlocked page, only //
		pFnd->actualLevel++;
		if(pFnd->actualLevel > 0x5ffffffd){
			for(G_Point t= pMap->first(); t ; pMap->next(t)){
				pFnd= pMap->contents(t);
				if(pFnd->actualLevel < (0x7fffffff - GKDB::BT_MAXDEPTH)){
					pFnd->actualLevel /= 2;
				}else
					m_uCountLockedPage++;
			}
		}
	}
}

void StreamFile::modifyBKP(bool old)
{
	if(m_hBackup == -1){
		int atry = 0;
		if(old)
#ifndef __MINGW32__
		  while ( atry++ < 10) {
#endif
                        m_hBackup = c_io_open(GetBackupName(), ACE_OS_O_CREAT|ACE_OS_O_WRONLY|ACE_OS_O_BINARY);
                        if ( m_hBackup != -1 )
#ifndef __MINGW32__
                            break;
                        ::ace_os_sleep(1000);
                  }
#else
                            abort();
#endif
		else{
		  char tmpO[NDTC_MAX_PATH_SIZE];
if(file->SystemPageBuf == pFirst->file->SystemPageBuf){
  		  sprintf(tmpO, "%s%s",pFirst->file->FileName, pBuckupFileExt);
}else
  		  sprintf(tmpO, "%s%s",file->FileName, pBuckupFileExt);
		  m_hBackup = c_io_open(tmpO, ACE_OS_O_EXCL|ACE_OS_O_CREAT|ACE_OS_O_WRONLY|ACE_OS_O_BINARY);
		}
		atry = 0;
		clearTmp(&atry);
		if(old)
			Flags &= ~SF_NOT_RENAME_OLD_BCKP;
	}else
		if(Flags & SF_NOT_RENAME_OLD_BCKP)
			;
		else
			not_actual_BKP();
}

void StreamFile::clearTmp(int *pStartVa)
{
	if(file->SystemPageBuf == pFirst->file->SystemPageBuf){
		memcpy(m_PagedBackupSystemPage+file->AttrOffs, file->SystemPageBuf+file->AttrOffs, file->PageSize-file->AttrOffs);
		((PagedFileHeader*)(m_PagedBackupSystemPage))->PageSize = file->PageSize+4;
		((PagedFileHeader*)(m_PagedBackupSystemPage))->AttrOffs = file->AttrOffs;
		if(/*((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION &&*/ (file->PageSize < *(short*)file->m_pCryptoTag)){
			char *frst= (char *)alloca(((PagedFileHeader*)(m_PagedBackupSystemPage))->PageSize * 3);
			memcpy(frst, m_PagedBackupSystemPage, file->PageSize);
			*(int*)(m_PagedBackupSystemPage + file->PageSize)= 0;
			((PagedFileHeader*)(m_PagedBackupSystemPage))->LastPage = 2;
			if( m_hBackup == -1 ||  c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0 || c_io_write(m_hBackup, frst, (file->PageSize+4)*3-4) != (file->PageSize+4)*3-4) {
				LOG_E (("abort in Index :: clearTmp(%s)", GetBackupName() ));
				abort();
			}
		}/*else{
			((PagedFileHeader*)(m_PagedBackupSystemPage))->LastPage = 0;
			if( m_hBackup == -1 ||  c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0 || c_io_write(m_hBackup, m_PagedBackupSystemPage, file->PageSize) != file->PageSize) {
				LOG_E (("abort in Index :: clearTmp(%s)", GetBackupName() ));
				abort();
			}
		}*/
	}
	if( m_hBackup == -1 ||  c_io_write(m_hBackup, pStartVa, 4) != 4 || c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0) {
		LOG_E (("abort in Index :: StartBackupEx(%s)", GetBackupName() ));
		abort();
	}
	if(!(Flags & SF_NOT_FIRST_DUMP)){
		SaveFat(m_hBackup);
	}
	Flags |= SF_NOT_FIRST_DUMP;
	Flags |= SF_NOT_RENAME_OLD_BCKP;
}

void StreamFile::not_actual_BKP()
{
	char tmpO[NDTC_MAX_PATH_SIZE];
	sprintf(tmpO, "%s%s",file->FileName, pBuckupFileExt);
	if(strcmp(GetBackupName(), tmpO))
		ace_os_rename(GetBackupName(), tmpO);
}

extern NDTKPageMap *createWCM();

void StreamFile::abort(void)
{
	static char msgKill[]= "StreamFile::abort(%d) - kill current process[%s]";
#ifdef	_DEBUG
  #ifdef	_MSC_VER
	__debugbreak ();
  #endif
#endif
	if(!m_notAutoRoll++ && pFirst){
		try{
			{
				NPagedFile kk(pFirst->file->FileName, ACE_OS_O_RDWR, pFirst->file->database_version());
				{
					StreamFile Rstrs(0);
					{
						Index Rstri(&kk, pFirst->Name, &Rstrs);
					}
				}
			}
			int AllI= 0;
			Index *pRstrI= pFirst;
			IndexInfo info;
			if(pCreateOtherK)
				AllI= iCreateOther;
			do{
				if(pRstrI->file->GetAttr ( pRstrI->Name, &info, sizeof (info))){
					pRstrI->pWritedPages= createWCM();
					pRstrI->init(pRstrI->file, &(info.btinit));
				}else{
					LOG_E((msgKill, 1, file->FileName));
					::exit(-65);
				}
			}while(AllI-- && (pRstrI= pCreateOtherK[AllI]));
			CachePagesMap *pnxt= m_PagesCacheKeys;
			int *pnxtI= &m_pCacheKeysStackCount;
			G_Point t, t0;
			unsigned int complex64[2];
			CachedPage *pCP;
			::PagedFile *FileDef1= pFirst->file;
			do{
				QuickValSplayMapOnStackPerSize(ACE_UINT64,G_Point,ActualPageMap,pnxt->length(),0);
				for(complex64[0]= 0, complex64[1]= 0, t= pnxt->first(); t ; pnxt->next(t)){
					complex64[1]++;
					ActualPageMap.get(*(ACE_UINT64*)complex64) = t;
					complex64[0]++;
				}
				for(t0= ActualPageMap.first(); t0 ; ActualPageMap.next(t0)){
					t= ActualPageMap.contents(t0);
					pCP= pnxt->contents(t);
					pCP->m_changed= 0;
					if(*pnxtI == 1){
						pnxt->GetRootG_SimpleSplayNode()->item = 1;
						if(!FileDef1->PagedFile::GetPage(1, pCP->m_Data)){
							LOG_E((msgKill, 4, file->FileName));
							exit(-66);
						}
					}else{
						(*pnxtI)--;
						pnxt->del(t);
						FileDef1->ppCPages[(*pnxtI)]= pCP->m_Data;
						delete pCP;
					}
				}
			}while(pnxt != m_PagesCacheBlocks && (pnxt= m_PagesCacheBlocks) && (pnxtI= &m_pCacheBlocksStackCount) && (FileDef1= file));
			Flags &= ~(SF_IN_OPERATION|SF_IN_TRANSCTN);
		   #ifdef _DEBUG
			ostreams->clear();
		   #endif
		  #ifdef PLAIN_GKDB
			global_Block();
		  #else
			throw NdtClone::Error ();
		  #endif
		}catch(...){
			LOG_E((msgKill, 2, file->FileName));
			exit(-64);
		}
	}else{
		LOG_E((msgKill, 3, file->FileName));
		::exit(-63);
	}
	global_Block();
}

void StreamFile::Clone_IO_File(PagedFile * tf)
{
	tf->SetFileHandle(file->getFHandle());
	tf->m_readed.pFileHandles= file->m_postFileHandles;
	tf->m_readed.pFilePoss= file->m_postFilePoss;
	tf->SystemPageBuf= file->SystemPageBuf;
	tf->PageSize= file->PageSize;
	tf->LastPage= file->PageSize;
	tf->curr_last= file->curr_last;
}

bool StreamFile::write_FirstGKDB()
{
	if(write_System(pFirst->file,c_io_tell(pFirst->file->GetFileHandle())))
		return true;
	return false;
}

bool StreamFileFastAdd::write_FirstGKDB()
{
	Index *pFlush= pFirst;
	int nxt= iCreateOther;
	IndexInfo stat;
	do{
		pFlush->shutdown(&(stat.btinit));
		stat.immdatasize=	pFlush->ImmDataSize;
		stat.rndv=			pFlush->roundv;
		stat.nstreams=		pFlush->nstreams;
		stat.btinit.LastId=	pFlush->KeyCount;
		if(!pFirst->file->PutAttr(pFlush->Name, &stat, int(sizeof(stat))))
			break;
	}while(nxt-- && (pFlush= pCreateOtherK[nxt]));
	return StreamFile::write_FirstGKDB();
}

void StreamFile::BackupTransaction()
{
	if(CountAllFlush){
		// flush buckup //
		pFirst->StartBackupEx();
		if(Flags & SF_RESTR_LONG_BKP){
			Flags &= ~SF_RESTR_LONG_BKP;
			bpages->get(0)= 0;
		}
		CountAllFlush= 0;
		char *pFirstRestore= 0;
#ifdef WRITE_KEYS_PAGE_INBACKUP
		int m_hBackupEnd;
		*Fnd= '#';
		if(-1 == (m_hBackupEnd= c_io_open(pNameF, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_WRONLY|ACE_OS_O_BINARY))){
			LOG_E (("abort in StreamFile::BackupTransaction0"));
			abort();
		}
		SaveFat(m_hBackupEnd);
		if(pFirst->BuckupRoot(m_hBackupEnd)) {
			LOG_E (("abort in StreamFile::BackupTransaction1"));
			abort();
		}
		c_io_close(m_hBackupEnd);
#else
		Point ii= 0;
		char *cur_real_page= ((char*)alloca(int(0x7fff & (file->PageSize + 4)))) + 4;
		int skipWritePage= 0;
		if(!((Flags & SF_IN_PRE_ATRANSCTN) || (Flags & SF_IN_AUTOTRANSCTN))){
			G_Point tF, tK;
			CachedPage *updt;
			QuickValSplayMapOnStackPerSize(int,G_Point,FlashedKeyPageMap,m_PagesCacheKeys->length(),0);
			if(m_PagesCacheKeys){
				for(tF= m_PagesCacheKeys->first(); tF ; m_PagesCacheKeys->next(tF)){
					updt= m_PagesCacheKeys->contents(tF);
					if(updt->m_changed)
					{
						updt->m_changed= 0;
						FlashedKeyPageMap.get(m_PagesCacheKeys->key(tF)) = tF;
					}
				}
			}
			tK= FlashedKeyPageMap.first();
			ii= pFirst->pWritedPages->first();
			int flushed= 0;
			char *tmpNameStrFile= 0;
#ifdef OLD_SHORT_STR
			if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
				strcpy(strrchr(file->FileName, '.')+4,".ntmp(0)");
				pFirstRestore= strrchr(file->FileName, '.');
				tmpNameStrFile= strrchr(pFirstRestore, '(');
			}else
#endif
				if(pFirst->file->SystemPageBuf == file->SystemPageBuf){
					if(Flags & SF_POST_CREATE_AS_TMP){
						pFirstRestore= strrchr(file->FileName, '.');
						if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION)
							tmpNameStrFile= strrchr(pFirstRestore, '(');
					}
				}else if((pFirstRestore= strrchr(file->FileName, '.')) && !(tmpNameStrFile= strrchr(pFirstRestore, '(')))
					pFirstRestore= 0;
			if(!(Flags & SF_IN_NOT_COPY)){
				if(!m_hBackup/*!m_hBackupKeys*/){
					if(!tmpNameStrFile){
						if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
							char tmp_pre[NDTC_MAX_PATH_SIZE];
							strcpy(tmp_pre, file->FileName);
							strcpy(file->FileName, "\\nul.s");
							pFirst->InitBackupStatstcsFile();
							strcpy(file->FileName,tmp_pre);
						}else if(Flags & SF_POST_CREATE_AS_TMP)
							;// tmpNameStrFile - not actual !
						else{
							pFirst->InitBackupStatstcsFile();
							PreBackupTransaction();
						}
					}
					//skipWritePage++;
				}//else/* if(!c_io_lseek(m_hBackupKeys, 0, ACE_OS_SEEK_CUR))*/{
					//PreBackupTransaction();
					skipWritePage++;
				//}
			}
			NDTKPage *pDta;
			char *cur;
			bool bkpF;
			G_Point pFndOld;
			PagedFile *fileAddNew= pFirst->file->SystemPageBuf == file->SystemPageBuf ? file : pFirst->file;
			while(ii){
				cur= 0;
				bkpF= 0;
				bkpF= true;
				if( pFirst->file->curr_last < (flushed= pFirst->pWritedPages->key(ii))
						&& pFirst->file->curr_last)
					; // Skip backup key page //
				else{
					char e01[]= "abort in StreamFile::BackupTransaction3(%s)";
					if(pFirst->file->SystemPageBuf != file->SystemPageBuf || (bkpF= (!bpages->seek(flushed)))){
						if((pFndOld= m_PagesCacheKeys->seek(flushed)))
							cur= m_PagesCacheKeys->contents(pFndOld)->m_Data;
						else if(pFirst->file->GetPage(flushed, cur_real_page))
							cur= cur_real_page;
					}
					/*if(pFirst->file->SystemPageBuf == file->SystemPageBuf){
						first_bb();
						pFirst->file->m_readed.processMode= ACE_OS_O_WRONLY;
						pFirst->file->m_readed.page= pFirst->file->FreePage++;
						pFirst->file->m_readed.buf= cur-4;
						*(int*)(pFirst->file->m_readed.buf)= flushed;
						pFirst->file->m_readed.pHeader= m_PagedBackupSystemPage;
						*pFirst->file->m_postFileHandles= m_hBackup;
						pFirst->file->m_readed.pFilePoss= pFirst->file->m_postFilePoss;
						pFirst->file->m_readed.pFileHandles= pFirst->file->m_postFileHandles;
						if(	otherReadOrWrite(&pFirst->file->m_readed) == -1
							|| (*(int*)(pFirst->file->m_readed.buf)= 0)
							|| c_io_write(m_hBackup, pFirst->file->m_readed.buf, 4) != 4
							|| c_io_lseek(m_hBackup, -4, ACE_OS_SEEK_CUR) == -1  )
						{
							LOG_E ((e01, pFirst->file->FileName));
							abort();
						}
						pFirst->file->m_readed.pHeader= file->SystemPageBuf;
						pFirst->file->m_readed.pFilePoss= file->m_postFilePoss;
						pFirst->file->m_readed.pFileHandles= file->m_postFileHandles;
						*pFirst->file->m_postFileHandles= file->file;
					}else*/{
						if(cur){
							first_bb();
							*(int*)(cur-4)= flushed | FAT_CHAIN;
							*(int*)(cur+pFirst->file->PageSize)= 0;
							if(pFirst->file->SystemPageBuf == file->SystemPageBuf)
								pFirst->file->FreePage++;
							if(	c_io_lseek(m_hBackup, -4, ACE_OS_SEEK_CUR) == -1 || c_io_write(m_hBackup, cur-4, pFirst->file->PageSize+8) != pFirst->file->PageSize+8) {
								LOG_E ((e01, pFirst->file->FileName));
								abort();
							}
						}
					}
				}
				/*while(tF){ // Не архвируемые "дырки" в файле ключей //
					if(m_PagesCacheKeys->key(FlashedKeyPageMap.contents(tF)) < flushed){
						if(!pFirst->file->PutPage(m_PagesCacheKeys->key(FlashedKeyPageMap.contents(tF))
											, (m_PagesCacheKeys->contents(FlashedKeyPageMap.contents(tF)))->m_Data)) abort();
						FlashedKeyPageMap.next(tf);
					}else
						break;
				}*/
				pDta= &(pFirst->pWritedPages->contents(ii));
				if(pFirst->file->SystemPageBuf == file->SystemPageBuf && FlashedKeyPageMap.seek(flushed)){
					;// в целевой записано будет один раз //
				}else if(	!pDta || !(fileAddNew->PutPage(flushed, pDta->GetData()))) {
					LOG_E (("abort in StreamFile::BackupTransaction4"));
					abort();
				}
				if(!(Flags & SF_SKIP_UPDT_CACHE)){
					if(!cur){
						if(bkpF){
							// первая запись страницы ключей //
							pFirst->PutPage(flushed, pDta->GetData(), 1);
						}
					}else
						memcpy(cur, pDta->GetData(), pFirst->file->PageSize);
				}
				delete []pDta->GetData();
				pDta->KillData();
				pFirst->pWritedPages->next(ii);
			}
			//if(pFirst->file->getFHandle() != -2){
				while(tK){
					if(!fileAddNew->PutPage(m_PagesCacheKeys->key(FlashedKeyPageMap.contents(tK))
										, (m_PagesCacheKeys->contents(FlashedKeyPageMap.contents(tK)))->m_Data)) abort();
					FlashedKeyPageMap.next(tK);
				}
			/*}else if(	file->getFHandle() == -2
						&& (	file->setFHandle(c_io_open(file->FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT)) == -1
								|| !(file->Flags | SF_UPDT_ACTUAL))){
				LOG_E (("(%x)(%s,%s)abort in Index::OpenN(!!!)",
							this, pFirst->Name,strrchr(file->FileName, '_')));
				abort();
			}*/
#ifdef SAVE_ALL_FAT_ON_BUCKUP
			SaveFat();
#else
			{
				bool skip_nSysP= true;
				if(m_PagesCacheBlocks/* && ((Flags & SF_IN_TRANSCTN) || (file->Flags & SF_UPDT_ACTUAL))*/){	//file->Flags &= ~ SF_UPDT_ACTUAL;
					QuickValSplayMapOnStackPerSize(int,G_Point,FlashedPageMap,m_PagesCacheBlocks->length(),1);
					for(tF= m_PagesCacheBlocks->first(); tF ; m_PagesCacheBlocks->next(tF)){
						updt= m_PagesCacheBlocks->contents(tF);
						if(updt->m_changed
							/*&& !fpages->seek(m_PagesCacheBlocks->key(tF))
							&& (!pWritedPages || !pWritedPages->seek(m_PagesCacheBlocks->key(tF)))*/ )
						{
							updt->m_changed= 0;
							flushed= m_PagesCacheBlocks->key(tF);
							if(flushed > file->LastPage)
								file->LastPage= flushed;
							FlashedPageMap.get(flushed) = tF;
						}
					}
					/*if(Flags & SF_IN_FILE_DIRECT){
						int pF= 1;
						if(Flags & SF_IN_FILE_DIRECT){
							if(!file->PutAttr(SF_FAT_OD, &pF, sizeof(pF)))
								abort();
						}
						pF= (*(int*)file->m_pCryptoTag)/file->PageSize ? (*(int*)file->m_pCryptoTag)/file->PageSize : 1;
						char* ptr = (char*) Fat;
						for(tF= FlashedPageMap.first(); tF ; FlashedPageMap.next(tF)){
							while(pF && m_PagesCacheBlocks->key(FlashedPageMap.contents(tF)) > pF){
								if(!file->PutPage(pF, ptr)) abort();
								pF= (Fat[pF] & ~FAT_CHAIN);
								ptr += file->PageSize;
							}
							if(!file->PutPage(m_PagesCacheBlocks->key(FlashedPageMap.contents(tF))
												, (m_PagesCacheBlocks->contents(FlashedPageMap.contents(tF)))->m_Data)) abort();
						}
						while(pF){
							if(!file->PutPage(pF, ptr)) abort();
							pF= (Fat[pF] & ~FAT_CHAIN);
							ptr += file->PageSize;
						}
						if(!file -> PutAttr ( pFatSizeName, &fatPages, int(sizeof ( short )) ))
							abort();
						Flags &= ~PF_MODIFIED;
					}else*/{
						for(tF= FlashedPageMap.first(); tF ; FlashedPageMap.next(tF)){
							if(!file->PutPage(FlashedPageMap.key(tF), (m_PagesCacheBlocks->contents(FlashedPageMap.contents(tF)))->m_Data))
								abort();
						}
					}
					/*if(Flags & SF_SKIP_UPDT_CACHE){
						FlushIndexPagedFileAdaptiveCache();
					}*/
				}
				first_bb();
				tF= fpages->first();
				if(tF){
					if(!file -> PutAttr ( pFatSizeName, &fatPages, int(sizeof ( short )))
						|| !(((PagedFileHeader*)(file->SystemPageBuf))->LastPage = file->LastPage)){
						LOG_E (("abort in StreamFile::BackupTransaction44first"));
						abort();
					}
					if((tmpNameStrFile && ((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION) || (Flags & SF_POST_CREATE_AS_TMP)){
						((PagedFileHeader*)file->SystemPageBuf)->AttrOffs= file->AttrOffs;
						if(write_System(file,c_io_tell(file->GetFileHandle()))){
							LOG_E (("abort in StreamFile::write_System"));
							abort();
						}
					}
					if(file->PageSize < *(int*)file->m_pCryptoTag && !(Fat[1] & (~FAT_CHAIN))){
						Fat[1]= 0;
						flushed= fpages->key(tF);
						if(!file->PutPage(flushed, Fat + fpages->contents(tF))){
							LOG_E (("abort in StreamFile::BackupTransaction66"));
							abort();
						}
						fpages->next(tF);
						Fat[1]= FAT_CHAIN;
					}
					while(tF){
						flushed= fpages->key(tF);
						if(!file->PutPage(flushed, Fat + fpages->contents(tF))){
							LOG_E (("abort in StreamFile::BackupTransaction66"));
							abort();
						}
						fpages->next(tF);
					}
					fpages->clear();
				}
				if(pWritedPages){
					NDTKPage *pDta;
					tF= pWritedPages->first();
					void *tmp_bufOld= alloca(file->PageSize);
					while(tF){
						flushed= pWritedPages->key(tF);
						if(!bpages->seek(flushed))
							rpages->get(flushed) = 0;
						updt= (Flags & SF_SKIP_UPDT_CACHE) ? 0 :(CachedPage *)m_PagesCacheBlocks->seek(flushed);
						if(	!(pDta= &pWritedPages->contents(tF))
							||	(updt && (	!(*(int*)(((updt= m_PagesCacheBlocks->contents(updt))->m_Data)-4)= flushed) ||  (*(int*)(updt->m_Data + pFirst->file->PageSize)= 0)
											|| c_io_lseek(m_hBackup, -4, ACE_OS_SEEK_CUR) == -1
											|| c_io_write(m_hBackup, updt->m_Data - 4, pFirst->file->PageSize+8) != pFirst->file->PageSize+8
											|| !file->PutPage(flushed, pDta->GetData())))	)
						{
							LOG_E (("abort in StreamFile::BackupTransaction78"));
							abort();
						}else if(	!updt && (	!file->GetPage(flushed, tmp_bufOld)
												|| (!PrePutPage(flushed, pDta->GetData(), tmp_bufOld))
												|| !file->PutPage(flushed, pDta->GetData())
												)	)
						{
							LOG_E (("abort in StreamFile::BackupTransaction77"));
							abort();
						}
						if(!(Flags & SF_SKIP_UPDT_CACHE)){
							if(updt){
								memcpy(updt->m_Data, pDta->GetData(), file->PageSize);
								if(skip_nSysP && flushed == nSysP){
									skip_nSysP= false;
									SysBuf= updt->m_Data;
								}
								UpActualLevel(updt,m_PagesCacheBlocks);
							}/*else{
								AddPageFromCache(flushed
													, m_PagesCacheBlocks
													, file
													, pDta->GetData()
													, &m_pCacheBlocksStack
													, &m_pCacheBlocksStackCount);

								updt= m_PagesCacheBlocks->contents(
										m_PagesCacheBlocks->GetRootG_SimpleSplayNode());
								UpActualLevel(updt,m_PagesCacheBlocks);
							}*/
						}
						delete []pDta->GetData();
						pDta->KillData();
						pWritedPages->next(tF);
					}
					delete pWritedPages;
					pWritedPages= 0;
				}
				if(skip_nSysP){
					SysBuf= aSysBuf;
					nSysP= 0;
				}
			}
#endif
			if((Flags & SF_IN_PRE_ATRANSCTN) || (Flags & SF_IN_AUTOTRANSCTN))
				;
			else{
				int tmp1= file->FreePage, tmp2= file->lastFreePage;
				char *defCryproTagS= file->m_pCryptoTag, *defCryproTagK= pFirst->file->m_pCryptoTag;
		/*#ifdef MIN_MEM_CONTEXT
				if(pOtherBackuped && pOtherBackuped->pDeletedPage){
					G_Point nxt= pOtherBackuped->pDeletedPage->first();
					if(nxt){
						void *pNxtBuff;
						((PagedFileHeader*)pOtherBackuped->SystemPageBuf)->FreePage = pOtherBackuped->FreePage;
						((PagedFileHeader*)pOtherBackuped->SystemPageBuf)->lastFreePage = pOtherBackuped->lastFreePage;
						if((pNxtBuff= malloc(pOtherBackuped->PageSize))){
							int NDTPage= 0 | 0x80000000l;
							if(c_io_write(m_hBackup, &NDTPage, sizeof(NDTPage)) != sizeof(NDTPage)) {
								LOG_E (("abort in StreamFile::BackupTransaction45a"));
								abort();
							}
							if(c_io_write(m_hBackup, pOtherBackuped->SystemPageBuf, pOtherBackuped->AttrOffs)
									!= pOtherBackuped->AttrOffs)
							{
								LOG_E (("abort in StreamFile::BackupTransaction45b"));
								abort();
							}
							do{
								NDTPage= pOtherBackuped->pDeletedPage->key(nxt);
								pOtherBackuped->GetPage(NDTPage, pNxtBuff);
								NDTPage |= 0x80000000l;
								if(c_io_write(m_hBackup, &NDTPage, sizeof(NDTPage)) != sizeof(NDTPage)) {
									LOG_E (("abort in StreamFile::BackupTransaction45a1"));
									abort();
								}
								if(c_io_write(m_hBackup, pNxtBuff, pOtherBackuped->PageSize)
										!= pOtherBackuped->PageSize)
								{
									LOG_E (("abort in StreamFile::BackupTransaction45b2"));
									abort();
								}
								pOtherBackuped->DelPage(NDTPage & (~0x80000000l));
								pOtherBackuped->pDeletedPage->next(nxt);
							}while(nxt);
							free(pNxtBuff);
						}else{
							LOG_E (("abort in StreamFile::BackupTransaction45"));
							abort();
						}
						pOtherBackuped->pDeletedPage->clear();
					}
				}
		#endif*/
#ifndef BRDR32
				/*if(file->PageSize > *(int*)file->m_pCryptoTag)*/{
					if((tmpNameStrFile && ((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION) || (Flags & SF_POST_CREATE_AS_TMP)){
					  if(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION){
						char tmpPreStr[NDTC_MAX_PATH_SIZE];
						*pFirstRestore= '.';
						strcpy(tmpPreStr, file->FileName);
						*pFirstRestore= 0;

						pFirst->InitBackupStatstcsFile();
						modifyBKP(true);
						strcpy(file->FileName, tmpPreStr);
						pFirstRestore= strrchr(pFirst->file->FileName, '.');
						strcpy(tmpPreStr, pFirst->file->FileName);
						*pFirstRestore= 0;
						pFirst->file->m_postFilePoss[0]= 1;
						((PagedFileHeader*)pFirst->file->SystemPageBuf)->AttrOffs= pFirst->file->AttrOffs;
						if(	!(file->PutAttr(SF_FAT_OD, pFirst->file->m_postFilePoss, sizeof(*pFirst->file->m_postFilePoss)))
							|| write_FirstGKDB())
						{
							LOG_E (("abort in KeyFile"));
							abort();
						}
						pFirst->file->m_postFilePoss[0]= 0;
						((PagedFileHeader*)file->SystemPageBuf)->AttrOffs= file->AttrOffs;
						pFirstRestore= strrchr(file->FileName, '.');
						strcpy(pFirst->file->FileName, file->FileName);
						file->get_protected_path_name(pFirst->file->FileName);
						*pFirstRestore= 0;
						if(write_System(file,c_io_tell(file->GetFileHandle())) || file->setFHandle(file->getFHandle()) == -1)
							abort();
						memcpy(file->SystemPageBuf+file->PageSize, file->SystemPageBuf, file->PageSize);
						memcpy(pFirst->file->SystemPageBuf+pFirst->file->PageSize, pFirst->file->SystemPageBuf, pFirst->file->PageSize);
						pKfile= pFirst->file;
					}else
					  {
						/*char tmpPreStr[NDTC_MAX_PATH_SIZE];
						*pFirstRestore= '.';
						strcpy(tmpPreStr, file->FileName);
						*pFirstRestore= 0;*/
						//mpcxc_chmod(file->FileName, MPCXC_FILE_ATTR_RW); // GARANT_CROSSP
						//ace_os_rename(tmpPreStr, file->FileName);
						/*if(!tK)
							reConnectFirst(defCryproTagK);
						else*/{
							/*if(pFirst->file->setFHandle(c_io_open(pFirst->file->FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT))
								== -1)
							{
								LOG_E (("(%x)(%s,%s)abort in Index::OpenN(!!!)",
											this, pFirst->Name,strrchr(pFirst->file->FileName, '_')));
								abort();
							}*/
							/*int currW;
							QuickValSplayMapOnStackPerSize(int,char,skipRootWrite,m_PagesCacheKeys->length(),1);
							while(tK){
								skipRootWrite.get((currW=m_PagesCacheKeys->key(FlashedKeyPageMap.contents(tK))));
								if(!pFirst->file->PutPage(currW , (m_PagesCacheKeys->contents(FlashedKeyPageMap.contents(tK)))->m_Data))
									abort();
								FlashedKeyPageMap.next(tK);
							}
							int oo= iCreateOther;
							while(oo--){
								tK= m_PagesCacheKeys->seek(currW=pCreateOtherK[oo]->Root);
								if(tK && !(skipRootWrite.seek(currW)) && !pFirst->file->PutPage(currW, (m_PagesCacheKeys->contents(tK))->m_Data)){
										abort();
								}
							}
							tK= m_PagesCacheKeys->seek(currW=pFirst->Root);
							if(tK && !(skipRootWrite.seek(currW)) && !pFirst->file->PutPage(currW, (m_PagesCacheKeys->contents(tK))->m_Data)){
									abort();
							}*/
							//pFirst->InitBackupStatstcsFile();
							//modifyBKP(((PagedFileHeader*)file->SystemPageBuf)->Signature == BASE_DATA_VERSION);
							//strcpy(file->FileName, tmpPreStr);
							//PreBackupTransaction();
							//pFirstRestore= strrchr(pFirst->file->FileName, '.');
							//strcpy(tmpPreStr, pFirst->file->FileName);
							//*pFirstRestore= 0;
							//mpcxc_chmod(tmpPreStr, MPCXC_FILE_ATTR_RW); // GARANT_CROSSP
							/*pFirst->file->m_postFilePoss[0]= 1;
						if(file->SystemPageBuf != pFirst->file->SystemPageBuf){
							((PagedFileHeader*)pFirst->file->SystemPageBuf)->AttrOffs= pFirst->file->AttrOffs;
							if(	!(file->PutAttr(SF_FAT_OD, pFirst->file->m_postFilePoss, sizeof(*pFirst->file->m_postFilePoss)))
								|| write_System(pFirst->file,c_io_tell(pFirst->file->GetFileHandle())))
							{
								LOG_E (("abort in KeyFile"));
								abort();
							}
						}else if(!(file->PutAttr(SF_FAT_OD, pFirst->file->m_postFilePoss, 4)))
						{
							LOG_E (("abort in SF_FAT_OD"));
							abort();
						}
							pFirst->file->m_postFilePoss[0]= 0;*/
							m_hBackup= file->protected_path_handle;
							/*pFirstRestore= strrchr(file->FileName, '.');
							strcpy(pFirst->file->FileName, file->FileName);
							file->get_protected_path_name(pFirst->file->FileName);
							*pFirstRestore= 0;
							if(write_System(file,c_io_tell(file->GetFileHandle())))
								abort();*/
							memcpy(file->SystemPageBuf+file->PageSize, file->SystemPageBuf, file->PageSize);
							m_PagedBackupSystemPage= (char*)realloc(m_PagedBackupSystemPage, 2*(file->PageSize+4));
							memcpy(m_PagedBackupSystemPage, file->SystemPageBuf, file->PageSize);
							*(int*)(m_PagedBackupSystemPage+file->PageSize)= 0;
							((PagedFileHeader*)m_PagedBackupSystemPage)->PageSize= file->PageSize+4;
							((PagedFileHeader*)m_PagedBackupSystemPage)->LastPage= 0;
							pFirstRestore[0]= 0;
							pFirstRestore[-1]= 'k';
							if(file->protected_path_handle == -3){
								if((m_hBackup= file->protected_path_handle= c_io_open(file->FileName, ACE_OS_O_EXCL | ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT)) == -1
									||c_io_write(m_hBackup, m_PagedBackupSystemPage, pFirst->file->PageSize+4 ) != pFirst->file->PageSize+4)
								{
									LOG_E (("abort in post-post KeyFile"));
									throw Error();
								}
							}else if(	c_io_write(m_hBackup, m_PagedBackupSystemPage, file->PageSize+4 ) != file->PageSize+4
										|| c_io_close(m_hBackup) || c_io_file_flush(file->file)
										|| ace_os_rename(pFirst->file->FileName, file->FileName)
										|| (m_hBackup= file->protected_path_handle= c_io_open(file->FileName, ACE_OS_O_EXCL | ACE_OS_O_RDWR | ACE_OS_O_BINARY)) == -1){
								LOG_E (("abort in KeyFile"));
								throw Error();
							}
							pFirstRestore[-1]= 's';
							memcpy(m_PagedBackupSystemPage+file->PageSize+4, m_PagedBackupSystemPage, file->PageSize+4);
							Clone_IO_File(pFirst->file);
							pKfile= pFirst->file;
							pFirst->file->FileName[pFirstRestore-file->FileName]= 0;
							Flags &= ~SF_POST_CREATE_AS_TMP;
						}
					  }
					}else{
						pFirstRestore= 0;
						if(	(bpages->seek(0) == 0 && backup_System()) || !(pFirstRestore= (char*)-1))
						{
							abort();
						}
					}
					file->m_pCryptoTag= defCryproTagS;
					file->FreePage= tmp1; file->lastFreePage= tmp2;
				}
				Flags &= ~PF_MODIFIED;
				if(!pFirstRestore)
					reConnectFirst(defCryproTagK);
				if(pFirst->file->SystemPageBuf != file->SystemPageBuf)
					pFirst->file->curr_last= pFirst->file->LastPage;
				else
					pFirst->file->curr_last= file->LastPage;
				file->curr_last= file->LastPage;
#endif
			}
		}
#endif
		if(m_hBackup){
#ifdef MIN_MEM_CONTEXT
#else
			char ee77[]= "abort in StreamFile::BackupTransaction717(%s)";

		if(pFirst->file->SystemPageBuf != file->SystemPageBuf){
			if( c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0 || c_io_file_flush(m_hBackup)|| file->FlushAllHandles(0,file->FileName)
				||  c_io_write(m_hBackup, pFirst->file->SystemPageBuf+pFirst->file->PageSize-4, 4) != 4 || c_io_file_flush(m_hBackup)
				|| c_io_lseek(m_hBackup, 0, ACE_OS_SEEK_SET) != 0)
			{
				LOG_E ((ee77, file->FileName));
				abort();
			}
		}else if(pFirstRestore == (char*)-1){
			if( c_io_lseek(m_hBackup, file->PageSize, ACE_OS_SEEK_SET) != file->PageSize || c_io_file_flush(m_hBackup)|| file->FlushAllHandles(0,file->FileName)
				||  c_io_write(m_hBackup, pFirst->file->SystemPageBuf+pFirst->file->PageSize-4, 4) != 4 || c_io_file_flush(m_hBackup))
			{
				LOG_E ((ee77, pFirst->file->FileName));
				abort();
			}
		}
#endif
			/*c_io_close(m_hBackup);Flags &= ~SF_NOT_FIRST_DUMP;
			m_hBackup= 0;
			if((Flags & SF_IN_PRE_ATRANSCTN) || (Flags & SF_IN_AUTOTRANSCTN))
				m_hBackup= 0;
			else
				ace_os_unlink(GetBackupName());*/
			Flags |= SF_FIRST_POS_BCKP;
		}
		if((Flags & SF_IN_PRE_ATRANSCTN) || (Flags & SF_IN_AUTOTRANSCTN))
			;
		else{
			//if(pFirstRestore && m_hBackupKeys){
			//	if(((PagedFileHeader*)file->SystemPageBuf)->Signature != BASE_DATA_VERSION && ace_os_ltrunc(m_hBackupKeys, 0) == -1) {
			//		LOG_E (("abort in StreamFile::BackupTransaction716"));
			//		abort();
			//	}
				/*char *pNameF= GetBackupName(), *Fnd= strrchr(pNameF, '.')+1;
				if(c_io_close(m_hBackupKeys)) {
					LOG_E (("abort in StreamFile::BackupTransaction716"));
					abort();
				}
				m_hBackupKeys= 0;
				*Fnd= '~';//ace_os_unlink(pNameF);
				while(*Fnd != '.') Fnd--;
				*Fnd= 0;
				*pFirstRestore= 0;
				strcat( pNameBackupName, pBuckupFileExt);
				Fnd= strrchr(pNameBackupName, '.')+1;
				*Fnd= '~';
				if(-1 == (m_hBackupKeys= c_io_open(	pNameF
																, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_WRONLY
																	|ACE_OS_O_BINARY))){
					*Fnd= 'b';
					LOG_E (("abort in StreamFile::BackupTransaction717"));
					abort();
				}
				*Fnd= 'b';*/
			//}else{
			//	PreBackupTransaction(skipWritePage);
			//}
	#ifndef WRITE_KEYS_PAGE_INBACKUP
			pFirst->pWritedPages->clear();
	#else
			free(pNameF);
			pFirst->pReadedPages->clear();
			pFirst->pBuckupedPages->clear();
	#endif
			bpages->clear();
			rpages->clear();
			if(Flags & SF_SRC_AS_SHORT){
				Flags &= ~SF_SRC_AS_SHORT;
				LastCreatedBlockPage= 0;
				LastCreatedBlockPage= GetLastCreatedBlockPage();
			}
		}
	}
}

static int dflt_l;

NPagedFile :: NPagedFile ( const char * name, int mode, int database_version
#ifdef COMPATIBILITY_FILE_SIZE
				, int max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE
#endif
				) : NdtClone::PagedFile ( name, database_version == BASE_DATA_VERSION ? mode : (mode | ACE_OS_O_EXCL), database_version
#ifdef COMPATIBILITY_FILE_SIZE
											, max_paged_file_per_bytes
#endif
				)
{
	m_mode &= ~ACE_OS_O_EXCL;
	m_maxPageCountInCache= -40;
	//pParamTAlloc= 0;
	FreePages= 0;
}

NPagedFile :: NPagedFile ( LPPF_PARAM pFile ) : NdtClone::PagedFile ( pFile )
{
	 FreePages= 0;
}

int	NPagedFile :: NewPage ()
{
	Flags   |= PF_MODIFIED;			// allocation of a new page always modifies file

	if ( FreePage == -1l )			// no free pages, so create new at the end of file
	{
		/*if(  (((unsigned int)LastPage + 1) * (unsigned int)PageSize)
			> ((unsigned int)0x7fffffff - (unsigned int)PageSize) ) {
			LOG_E (("abort in NPagedFile :: NewPage"));
			abort();
		}*/
		++LastPage;
		/*if((LastPage + 1) < curr_last)
			ace_os_ftruncate(getFHandle(), (LastPage + 1) * (int)PageSize);*/
		return LastPage;
	}

	int	page = FreePage;

	if(!FreePages)
		FreePages= new NDTPagesFreeMap(dflt_l);

	FreePage= ((*FreePages)[FreePage]);

	if ( page == lastFreePage )
		lastFreePage = -1l;		// it's no inter free

	if(!FreePage)
		FreePage= -1;

	return page;
}

void	NPagedFile :: DelPage ( int page )
{
	return;
	if ( FreePage == -1l )
		FreePage = page;

	if(!FreePages)
		FreePages= new NDTPagesFreeMap(dflt_l);

	if ( lastFreePage != -1l )
	{
		((*FreePages)[lastFreePage]) = page;
	}
	((*FreePages)[page]) = -1;

	lastFreePage = page;

	Flags   |= PF_MODIFIED;
}

int NPagedFile :: Delete(int Remove)
{
	//unlockPath();

	if((m_mode & ACE_OS_O_BINARY) && FreePages != 0){
		delete FreePages;
		FreePages= 0;
	}
	int ret= PagedFile::Delete(Remove);
	if(Remove){
		// Сайдовые эффекты знаний агрегатов об агрегируемых, "выпрямляется"
		// верным деревом классов, где на "выпрямление" всё нет времени/денег, увы... //
		int ln= (int)(::strlen(FileName)&0x7fff), aclear= 0, lnE= (int)(::strlen(pBuckupFileExt)&0x7fff);
		char *pRm= (char*)alloca(ln+4+1);
		memcpy(pRm, FileName, ln+1);
		if(this->IsOk()){
			/*if(Remove == 222){
// костыль для удаления индексов пустых, но созданных,
				memcpy(pRm+ln, pBuckupFileExt, lnE+1);
				ace_os_unlink(pRm);
			}else*/{
				// НЭ надо тормозить лишней перестраховкой, т.к. нет коробочной версии с такой версией темп-файла
				// unlink_pre_tmp(pRm);
			}
		}else{
			if(pRm[ln-1] == ')')
				aclear= 1;
			memcpy(pRm+ln, pBuckupFileExt, lnE+1);
			ace_os_unlink(pRm);
			if(aclear && ln){
				// после сенсовой авточистки пустого индекса //
				ln--;
				while(ln && pRm[ln--] != '.');
				ln++;
			}
		}
		if(Remove != 222 && pRm[ln-1] == 's'){
			// после сенсовой безошибочной модификации индекса //
			memcpy(pRm+ln, pBuckupFileExt, lnE+1);
			ace_os_unlink(pRm);
			/*{
// костыль для удаления индексов пустых, но созданных,
				char ee[]= "k.ntmp(1968).tmp";
				int ln0= strlen(ee)+1;
				char *pRm0= (char*)alloca(ln+ln0);
				memcpy(pRm0, pRm, ln);
				memcpy(pRm0+ln, ee+1, ln0-1);
				ace_os_unlink(pRm0);
				memcpy(pRm0+ln-1, ee, ln0);
				ace_os_unlink(pRm0);
			}*/
		}
	}
	if(SystemPageBuf != 0 && PageSize > *(int*)m_pCryptoTag){
		FreeBuf(SystemPageBuf);
		SystemPageBuf= 0;
	}
	m_mode &= ~ACE_OS_O_BINARY;

	return ret;
}

int NPagedFile :: Connect( const char * name, int mode
#ifdef COMPATIBILITY_FILE_SIZE
				, int max_paged_file_per_bytes
#endif
				)
{
	int ret= PagedFile::Connect(name, mode
#ifdef COMPATIBILITY_FILE_SIZE
									, int max_paged_file_per_bytes
#endif
																	);
	if(!FreePages)
		FreePages= new NDTPagesFreeMap(dflt_l);

	return ret;
}

NPagedFile ::~NPagedFile ()
{
	if(global_IsBlock())
		return;

	if(FreePages){
		delete FreePages;
		FreePages= 0;
	}
	Delete();
}

void StreamFile::BeginOperation(void *pVal, opertionS_t curr_){
	Flags |= SF_IN_OPERATION;
	m_curr_= curr_;
	m_pVal= pVal;
#ifdef BIG_CLONE_LOG
	char *pfn0= 0;
	if((file->m_mode & (~0x3000)))
		pfn0= strrchr(((Index*)m_pVal)->streams->file->FileName, '_');
	bool out00= (pfn0 && pfn0[1] == 'f');
#endif
	switch(m_curr_){
	case open_n_index:
#ifdef BIG_CLONE_LOG
		if ( out00 )
		LOG_D (("(%x)BO[%s,%s]::O", m_pVal, ((Index*)m_pVal)->Name, pfn0));
#endif
		break;
	case close_index:
#ifdef BIG_CLONE_LOG
		if ( out00 )
#ifdef	_DEBUG
		LOG_D (("(%x,%x:%x)BO[%s,%s]::C", m_pVal, ((int*)&(((Index*)m_pVal)->ClosedID))[1], ((int*)&(((Index*)m_pVal)->ClosedID))[0], ((Index*)m_pVal)->Name, pfn0));
#endif
#endif
		break;
	case read_stream:
#ifdef BIG_CLONE_LOG
		if ( out00 )
		LOG_D (("(%x:%x)BO[%s]::R", ((int*)&(((Stream*)m_pVal)->streamID))[1], ((int*)&(((Stream*)m_pVal)->streamID))[0], pfn0));
#endif
		break;
	case write_stream:
#ifdef BIG_CLONE_LOG
		if ( out00 )
		LOG_D (("(%x:%x)BO[%s]::W", ((int*)&(((Stream*)m_pVal)->streamID))[1], ((int*)&(((Stream*)m_pVal)->streamID))[0], pfn0));
#endif
		break;
	default:
		{
			LOG_E (("abort in StreamFile::BeginOperation"));
			abort();
		}
	}
}

void StreamFile::EndOperation(){
#ifdef BIG_CLONE_LOG
	char *pfn0= 0;
	if((file->m_mode & (~0x3000)))
		pfn0= strrchr(((Index*)m_pVal)->streams->file->FileName, '_');
	bool out00= (pfn0 && pfn0[1] == 'f');
#endif
	switch(m_curr_){
	case open_n_index:
#ifdef BIG_CLONE_LOG
		if ( out00 )
		LOG_D (("(%x)EO[%s,%s]::O", m_pVal, ((Index*)m_pVal)->Name, pfn0));
#endif
		break;
	case close_index:
#ifdef BIG_CLONE_LOG
		if ( out00 )
#ifdef	_DEBUG
		LOG_D (("(%x,%x:%x)EO[%s,%s]::C", m_pVal, ((int*)&(((Index*)m_pVal)->ClosedID))[1], ((int*)&(((Index*)m_pVal)->ClosedID))[0], ((Index*)m_pVal)->Name, pfn0));
#endif
#endif
		break;
	case read_stream:
#ifdef BIG_CLONE_LOG
		if ( out00 )
		LOG_D (("(%x:%x)EO[%s]::R", ((int*)&(((Stream*)m_pVal)->streamID))[1], ((int*)&(((Stream*)m_pVal)->streamID))[0], pfn0));
#endif
		break;
	case write_stream:
#ifdef BIG_CLONE_LOG
		if ( out00 )
		LOG_D (("(%x:%x)EO[%s]::W", ((int*)&(((Stream*)m_pVal)->streamID))[1], ((int*)&(((Stream*)m_pVal)->streamID))[0], pfn0));
#endif
		break;
	default:
		{
			LOG_E (("abort in StreamFile::BeginOperation"));
			abort();
		}
	}
	Flags &= ~SF_IN_OPERATION;
}

StoredSortedCollection :: StoredSortedCollection (	StreamFile*sFile
												,IndexRecordData*rec
												,int rec_size
												,int rv
												,int otherFile)

	: Stream(sFile, rec, rec_size, rv, STREAM_AS_COLLECTION), BTree()
{
	BTree::Order= 0;
	BTree::KeyLength= 0;
	BTree::Height= 1;
	BTree::LastId= 0;
	BTree::file= sFile->file;
	BTree::Root= 1;
	m_firstPos= 0;
	m_lastPos= realSize;
	BTree::KeyCount= 0;
	if(!Stream::PreLoadBlock){
		BTree::Root += (m_lastPos / 2) / BTree::file->PageSize;
	}
	if(Stream::blocks && BTree::Root == 1)
		BTree::file->GetPage(Stream::blocks[0], Stream::Buf);
}

char * StoredSortedCollection :: PrepareStackBuff( int page, char *cur, void* buf1)
{
	return (char*)(Stack [Sp].buf= buf1);
}

int StoredSortedCollection :: LastCompare( BTKEY a, BTKEY b, int preComp){
	int ret= Compare(a,b);
	if(preComp && ret < 0 && m_lastPos != Pos){
		m_lastPos= -1;
		return ret;
	}
	return ret;
}

short StoredSortedCollection :: GetCount ( void * buf ) const
{
	if(realSize == Pos && (realSize % BTree::file->PageSize))
		return (short)((realSize % BTree::file->PageSize)/BTree::KeyLength);
	return Stream::file->file->PageSize/BTree::KeyLength;
}

int StoredSortedCollection :: GetNext ( char *keyPtr )
{
		if(Stack [Sp].Pos > 0){
			if(Pos >= m_lastPos)
				return 0;
			m_firstPos= Pos;
			return Stack [Sp].Page + 1 + ((m_lastPos - Pos) / 2) / BTree::file->PageSize;
		}else{
			if(Pos > m_lastPos)
				return 0;
			if(Pos == m_lastPos){
				m_lastPos= -1;
				return Stack [Sp].Page - 1 - (((Pos - BTree::file->PageSize) - m_firstPos) / 2) / BTree::file->PageSize;
			}
			m_lastPos= Pos - BTree::file->PageSize;
			return Stack [Sp].Page - 1 - ((m_lastPos - m_firstPos) / 2) / BTree::file->PageSize;
		}
}

int StoredSortedRefCollection::ChangeNode(void *pNode, void * buf, int& no, int& Page)
{
	if(LocateKey(pNode, buf, no, Page) == GKDB::BT_NONE){
		Page= Stack[Sp-1].Page;
		no= Stack[Sp-1].Pos;
		return GKDB::BT_NONE;
	}
	if ( ((::Ref*)pNode)->Sub > 0
		&& ((::Ref*)pNode)->Sub & 0x40000000 ) {
			::Ref *pFnd= (::Ref *)((char*)buf + no * BTree::KeyLength);
		if(!(pFnd->Sub & 0x40000000)){
			pFnd->Sub |= 0x40000000;
			Page--;
			if(Stream::blocks){
				if(!Stream::blocks[Page])
					Stream::blocks[Page]= Stream::blocks[Page];
				Stream::WritePage(Stream::blocks[Page], buf);
			}else{
				Stream::Seek(0);
				Stream::Write(buf, Stream::realSize);
				Stream::Save();
			}
			Stream::Flags &= ~(SF_MODIFIED|SF_BUFDIRTY);
		}
	}
	return GKDB::BT_OK;

}

int StoredSortedClassRefCollection::ChangeNode(void *pNode, void * buf, int& no, int& Page)
{
	if(LocateKey(pNode, buf, no, Page) == GKDB::BT_NONE){
		Page= Stack[Sp-1].Page;
		no= Stack[Sp-1].Pos;
		return GKDB::BT_NONE;
	}
	if ( ((::Ref*)pNode)->Sub > 0
		&& !(((::Ref*)pNode)->Sub & 0x40000000) ) {
			::Ref *pFnd= (::Ref *)((char*)buf + no * BTree::KeyLength);
		if((pFnd->Sub & 0x3fffffff) != pFnd->Sub){
			pFnd->Sub &= 0x3fffffff;
			Page--;
			if(Stream::blocks){
				if(!Stream::blocks[Page])
					Stream::blocks[Page]= Stream::blocks[Page];
				Stream::WritePage(Stream::blocks[Page], buf);
			}else{
				Stream::Seek(0);
				Stream::Write(buf, Stream::realSize);
				Stream::Save();
			}
			Stream::Flags &= ~(SF_MODIFIED|SF_BUFDIRTY);
		}
	}
	return GKDB::BT_OK;

}

int StreamFile::PutPageFromCache(int page, CachePagesMap **ppMap, ::PagedFile *FileDef, void *buff, char **ppPagesStack, int *pCount){
	if(!(*ppMap)){
		(*ppMap)= new CachePagesMap(0);
	}
	Point Fnd= (*ppMap)->seek(page);
	if(Fnd){
		fc= (NdtClone::NPagedFile *)FileDef;
		(*ppMap)->contents(Fnd)->PutPage(buff, this);
		return 1;
	}
	//FileDef->Flags |= SF_UPDT_ACTUAL;
	AddPageFromCache(page, (*ppMap), FileDef, buff, ppPagesStack, pCount, 1);
	return 1;
}

void StreamFile :: DirectFlush(::PagedFile * otherFile)
{
#ifndef MAKE_HDD
	*(long*)otherFile->SystemPageBuf= BASE_DATA_VERSION_OUT;
	*(long*)file->SystemPageBuf= BASE_DATA_VERSION_OUT;
	this->EndTransaction();
#endif
}

CachedPage::CachedPage(::PagedFile *file1, void *buff, int *pCount, int changed)
{
	StreamFile *pCorrector= (StreamFile *)file1;
	m_changed= changed;
	if(!*pCount){
		//pCorrector->fc->pzz1= 0;
		pCorrector->fc->m_AllocPageCountInCache= - pCorrector->fc->m_maxPageCountInCache;
		pCorrector->fc->m_HardFlushCount= pCorrector->fc->m_AllocPageCountInCache/4;
		pCorrector->fc->m_maxPageCountInCache= pCorrector->fc->m_HardFlushCount*3;
		pCorrector->fc->cache_tmp_buf= (char*)malloc( ((pCorrector->fc->PageSize+4) * pCorrector->fc->m_AllocPageCountInCache) + 4);
#ifdef _DEBUG
	{
		int tmpMM= pCorrector->fc->PageSize * pCorrector->fc->m_AllocPageCountInCache;
		while(tmpMM--)
			pCorrector->fc->cache_tmp_buf[tmpMM]= 0;
	}
#endif
		pCorrector->fc->ppCPages= (char**)malloc( sizeof(char*) * pCorrector->fc->m_AllocPageCountInCache );
		for(actualLevel= 0; actualLevel < (unsigned int)(pCorrector->fc->m_AllocPageCountInCache & 0xfffffff); actualLevel++){
			pCorrector->fc->ppCPages[actualLevel]= (pCorrector->fc->cache_tmp_buf + actualLevel * (pCorrector->fc->PageSize+4))+4;
		}
		m_Data= pCorrector->fc->ppCPages[0];
		*pCount= 1;
	}else{
		m_Data= pCorrector->fc->ppCPages[(*pCount)++];
		//if(pCorrector->fc->pzz1 == m_Data)
		//	m_Data= pCorrector->fc->pzz1;
	}
	actualLevel= 1;
	memcpy(m_Data, buff, pCorrector->fc->PageSize);
}
void CachedPage::PutPage(void *buff, void *pSfl){
	m_changed= 1;
	actualLevel++;
	memcpy(m_Data, buff, ((StreamFile*)pSfl)->fc->PageSize);
}
void CachedPage::GetPage(void *buff, void *pSfl){
	actualLevel++;
	memcpy(buff, m_Data, ((StreamFile*)pSfl)->fc->PageSize);
}

//#include "shared/Core/sys/synch.h"
//::Core::Mutex globalRW_blocked;

static int isBlockOperations= 0;

bool global_IsBlock()
{
	if(!isBlockOperations)
		return false;
	return true;
}

void global_Block()
{
	isBlockOperations++;
#ifndef PLAIN_GKDB
	throw Error ()
#else
	::abort()
#endif
		;
}

void global_check()
{
	if(global_IsBlock())
#ifndef PLAIN_GKDB
	throw Error ()
#else
	::abort()
#endif
		;
}

} // namespace NdtClone

/*static void threadWrite(void *args)
{
	::PagedFile *FileDef= (::PagedFile *)args;
	GUARD (FileDef->m_mtxThreadWrite);
	LPSF_INFILE pCrnt= 0;
	do{
		GUARD (FileDef->m_mtxCheckInWrite);
		if(!((*(FileDef->pCnt))--))
			break;
		if(!FileDef->PutPage((*FileDef->ppParamT)->Page, (*FileDef->ppParamT)->pBff)){
			abort();
		}
		++(*FileDef->ppParamT);
	}while(1);
}

void InFile(::PagedFile *FileDef)
{
	HANDLE hInstllThread0;
	DWORD m_ThreadID0;
	hInstllThread0 = CreateThread(	0, 8000000, (LPTHREAD_START_ROUTINE)threadWrite,
									FileDef, CREATE_SUSPENDED,(LPDWORD)&m_ThreadID0);
	if(hInstllThread0 == 0){
		abort();
	}else{
		//SetThreadPriority(hInstllThread0, THREAD_PRIORITY_ABOVE_NORMAL);
		ResumeThread(hInstllThread0);
	}
}*/
