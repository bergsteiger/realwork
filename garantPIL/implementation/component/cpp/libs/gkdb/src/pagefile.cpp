#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: pagefile.cpp,v 2.273 2015/09/01 07:39:38 yaroslav Exp $
 */
//
// Basic classes for handling files with page structure
// Supports: page allocation & freeing, read/write ops, cachings
// DPMI & VCP support will be added
//
// Author: Alex V.Boreskoff
//

#include "../../zlib/src/pack.h"
#include "gardefs.h"

#if defined(NO_GSSCREEN)
 	#define clear_video() {}
 	#define show_message(X) {}
#else
	#ifndef MAKE_HDD
		#include "gsscreen.h" // GARANT_CROSSP: path of includes should be specified by project, not directly
		#include "toys.h"
	#endif
	// in GSSCREEN.LIB //
	extern void clear_video(void);     /*  Clear screen */
	// show message, trunc if lenght more then 50 //
	extern void show_message(const char *);
#endif

#include "pagefile.h"

#include <cstring>
#include <cstdlib>

#ifdef RD_RDONLY
	static char *pGetFileName= 0;
#elif defined(__WIN16__) || defined(AS_WIN16)
	extern void DefaultWin16CloseProcessFunc(int);
	static char *pGetFileName= 0;
	extern int DefaultWin16MessageForNextFunc(char *);
#endif

#ifdef BRDR32
	extern "C" {
		void add_crypto_tag(char **, int);
		extern int makedKey, makedStr, makedNdt, makedTmp;
	}
	#include <windows.h>
	int chk_sleep(){ ace_os_sleep(500); return 1; }
//#define OLD_CHK_READ
#ifdef OLD_CHK_READ
	#define chk_rd(xx, yy, zz, aa) (!(aa->rdStats= 0) && c_io_read(xx, yy, zz) != zz && chk_sleep() && c_io_read(xx, yy, zz) != zz && chk_sleep() && c_io_read(xx, yy, zz) != zz && chk_sleep() && (aa->rdStats= 1))
	#define chk_getPage(xx, yy, aa) (!(aa->rdStats= 0) && !GetPage(xx, yy) && chk_sleep() && !GetPage(xx, yy) && chk_sleep() && !GetPage(xx, yy) && chk_sleep() && (aa->rdStats= 1))
	#define chk_wr(xx, yy, zz, aa) (!(aa->wrStats= 0) && c_io_write(xx, yy, zz) != zz && chk_sleep() && c_io_write(xx, yy, zz) != zz && chk_sleep() && c_io_write(xx, yy, zz) != zz && chk_sleep() && (aa->wrStats= 1))
#else
	// look in garantPIL\implementation\component\cpp\libs\BdrPersn\msvc.win32\TestBreeder32Dlg.cpp
#endif
 void makeErrorFilename(GSScreen *pContext, PagedFile *pCurrent, PagedFile *pTarget)
 {
	char *pFndName;
	if(pContext->rdStats){
		pFndName= strrchr(pCurrent->FileName, '\\');
		if(pFndName != 0)
			pContext->pFileNameError= strdup(pFndName+1);
		else
			pContext->pFileNameError= strdup(pCurrent->FileName);
	}else{
		pFndName= strrchr(pTarget->FileName, '\\');
		if(pFndName != 0)
			pContext->pFileNameError= strdup(pFndName+1);
		else
			pContext->pFileNameError= strdup(pTarget->FileName);
	}
 }
#else
#define chk_rd(xx, yy, zz, aa) (c_io_read(xx, yy, zz) != zz)
#define chk_wr(xx, yy, zz, aa) (c_io_write(xx, yy, zz) != zz)
#endif

#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
const int giPackTableWindowSize= 513;
#endif

#ifdef  __cplusplus
	extern "C" {
#endif

#if defined(BRDR) || defined(BRDR32) || defined(INSTLL_CIB)
	void pl_GetLoginFromBase(char **, char *, int);
#endif

#ifdef	__BORLANDC__
#include <ctype.h>
#endif

#ifdef __cplusplus
		void DefaultCloseProcessFunc(int ret)
		{
#if defined(__WIN16__) || defined(AS_WIN16)
			// in Shell.Win16 //
			DefaultWin16CloseProcessFunc(-1);
#else
			clear_video();
			exit(ret);
#endif
		}
		int DefaultMessageForNextFunc(void)
		{
#if defined(GARANT_TOOLS) // GARANT_GCC
			return 1;
#elif defined(__WIN16__) || defined(AS_WIN16)
			// in Shell.Win16 //
			return DefaultWin16MessageForNextFunc(pGetFileName);
#else
/*	#ifndef BRDR32
			int ch;
			show_message("Next Paged SubFile is ready ? (Y or N) : ");
			do
			{
			  ch = getch();
			  ch = toupper( ch );
			} while( (char)ch != 'Y' && (char)ch != 'N');
			if((char)ch == 'Y')
				return 0;
	#endif */
			return 1;
#endif
		}
#endif
#if (defined(MAKE_HDD) && defined(__cplusplus)) || !defined(MAKE_HDD)
		int CreatedBigStream=
  #ifndef	_GCD_SERVER
								0
  #else
								1
  #endif
									;

		int longcmp(const void *l1, const void *l2)
		{
		  return (*((ACE_UINT32 *)l1) > (*(ACE_UINT32 *)l2)) ?
				1 : (*((ACE_UINT32 *)l1) < *((ACE_UINT32 *)l2)) ? -1 : 0;
		}
		extern char *GetBasedExtFileName( char *pFileName, int indx );
		int IsLogicalTom(LPPF_PARAM pPrm)
		{
			if(((struct PagedFileHeader *)pPrm->pHeader)->TomPerPages > 0
				&& ((struct PagedFileHeader *)pPrm->pHeader)->TomPerPages < MAX_COUNT_FILE_HANDLES)
				return 1;
			return 0;
		}
		int	IsNextTom(	LPPF_PARAM pPrm )
		{
			if(IsLogicalTom(pPrm)){
				int *pArray= (int *)((struct PagedFileHeader *)pPrm->pHeader)->reserved;
				pPrm->currentDisk= (int)((struct PagedFileHeader *)pPrm->pHeader)->TomPerPages*2;
				while(pPrm->currentDisk){
					pPrm->currentDisk -= 2;
					if(pArray[pPrm->currentDisk] == -1){
						pArray[pPrm->currentDisk]= pPrm->page;
						pPrm->page= 0;
						return (pPrm->currentDisk= pPrm->currentDisk/2+1);
					}else if(pArray[pPrm->currentDisk] <= pPrm->page && pPrm->page <= pArray[pPrm->currentDisk+1]){
						pPrm->page -= pArray[pPrm->currentDisk];
						return (pPrm->currentDisk= pPrm->currentDisk/2+1);
					}
					if(pPrm->page > pArray[pPrm->currentDisk+1])
						pPrm->page -= pArray[pPrm->currentDisk+1] - pArray[pPrm->currentDisk] + 1;
				}
			}else{
				int upper= 0;
				if(pPrm->PackArraySize != 0l)
					upper= pPrm->PackArraySize
								/ (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize + 1l;
				pPrm->currentDisk= (int)((pPrm->page+upper)/
						(pPrm->maxFile_per_bytes
							/(unsigned int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize));
				if(pPrm->currentDisk != 0l){
					pPrm->page -= (int)pPrm->currentDisk * (pPrm->maxFile_per_bytes
						/(unsigned int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize)
							- upper;
				}
			}
			return pPrm->currentDisk;
		}
#elif defined(__cplusplus)
	extern "C" {
			char *GetBasedExtFileName( char *, int );
			int IsLogicalTom(LPPF_PARAM);
			int IsNextTom(LPPF_PARAM);
	}
#endif


#ifdef __cplusplus
#ifdef BRDR32
		int IsPostExist(	int indx, LPPF_PARAM pPrm );
		int IsPostExistL(	int indx, LPPF_PARAM pPrm, int pos );
#endif
		int otherFileOpen(	int indx, LPPF_PARAM pPrm )
		{
			int zz= -1;
			if(pPrm->processMode != ACE_OS_O_WRONLY){
#ifndef BRDR32
			  if(pPrm->accesMode & ACE_OS_O_RDWR)
#endif
			  {
				if(pPrm->pFileHandles[indx] == -1){
				  int len;
				  if(	(len=strlen(pPrm->FileName)+1) < 2 ||
					GetBasedExtFileName((char*)memcpy(pPrm->buf,pPrm->FileName,len), indx) == 0){
					return -1;
				  }
				  if((zz= c_io_open((char*)pPrm->buf, pPrm->accesMode | ACE_OS_O_BINARY)) == -1){
#if defined(__WIN16__)  || defined(RD_RDONLY)
						pGetFileName= (char*)pPrm->buf;
					  if((pPrm->iPost=(*pPrm->MessageForNextFunc)())){
//						(*pPrm->CloseProcessFunc)(-5);
						return -1;
					}
					pPrm->pFilePoss[indx]= 0;
#endif
				  }
				}
#ifndef BRDR32
				if(!pPrm->iPost)
					pPrm->iPost= 1;
#endif
				if(zz != -1){
					if(pPrm->pFileHandles[indx] == -1){
						pPrm->pFileHandles[indx]= zz;
						pPrm->pFilePoss[indx]= 0;
					}else
						c_io_close(zz);
				}
			  }
			}else{
			  char pFileName[256];
			  if(pPrm->pFileHandles[indx] == -1 &&
					(
					(zz=strlen(pPrm->FileName)) < 1 ||
					GetBasedExtFileName((char*)memcpy(pFileName,pPrm->FileName,zz+1) , indx)
												== 0 ||
				(
					(pPrm->pFileHandles[indx]= c_io_open(pFileName, pPrm->accesMode | ACE_OS_O_BINARY | ACE_OS_O_EXCL)) == -1)
					&&
					(!indx || pPrm->accesMode != ACE_OS_O_RDWR ||

					(pPrm->pFileHandles[indx]= c_io_open(pFileName, ACE_OS_O_CREAT | pPrm->accesMode | ACE_OS_O_BINARY | ACE_OS_O_EXCL)) == -1)
				)
							){
				return -1;
			  }
			}
			return 0;
		}
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
		#include "../../GPersn/src/PL_Proto.h"
	#ifndef RD_AS_ETALON
		extern int _InitHash();
	#endif
		int lDefNdtCryptoTag= 512, DefValCryptoTag= 1;
		void pl_OpenBase(	LPPF_PARAM pKey, LPPF_PARAM pStr,
							char **keyTag, char **strTag, char **ndtTag)
		{
			int iKeySz, iStrSz;
			int CryptoCount=
#ifdef BRDR32
					(4096*100*2)//MAX_CRYPTED_BLOCK_IN_WORK
#else
					(4096*2)//MAX_CRYPTED_BLOCK_IN_WORK
#endif
					;
			if(	(iKeySz=c_io_lseek(*pKey->pFileHandles, 0l, ACE_OS_SEEK_END)) == -1
					||
				c_io_lseek(*pKey->pFileHandles,
						(int)((struct PagedFileHeader *)pKey->pHeader)->PageSize, ACE_OS_SEEK_SET)
							!= (int)((struct PagedFileHeader *)pKey->pHeader)->PageSize
					||
				(iStrSz=c_io_lseek(*pStr->pFileHandles, 0l, ACE_OS_SEEK_END)) == -1
					||
				c_io_lseek(*pStr->pFileHandles,
						(int)((struct PagedFileHeader *)pStr->pHeader)->PageSize, ACE_OS_SEEK_SET)
							!= (int)((struct PagedFileHeader *)pStr->pHeader)->PageSize)
			{
				return;
			}
			pl_CalcCryptoSizeInBase(&CryptoCount, iKeySz, iStrSz, CryptoCount);
			if(	(*keyTag= (char*)malloc(CryptoCount+SIZE_CRYPTO_HEADER+sizeof(int))) == 0
					||
				(*strTag= (char*)malloc(CryptoCount+SIZE_CRYPTO_HEADER+sizeof(int))) == 0
#ifndef BRDR32
					||
				(((pKey->accesMode & ACE_OS_O_RDWR) || (pKey->accesMode & ACE_OS_O_WRONLY)) ? pl_InitCrypto(0) :
  #ifndef RD_AS_ETALON
																		_InitHash()
  #else
																			0
  #endif
																									)
#endif
					||
				pl_UnCryptBase(	*pKey->pFileHandles, *pStr->pFileHandles,
								*ndtTag, *keyTag, *strTag, CryptoCount))
			{
				return;
			}
			if(pKey->accesMode & 0x2000){
				memcpy(	pKey->pUncompressBuffer+(int)((struct PagedFileHeader *)pKey->pHeader)->PageSize,
						(*keyTag) + sizeof(int),
						(int)((struct PagedFileHeader *)pKey->pHeader)->PageSize);
				if(*(int*)(*keyTag) > pKey->PackArraySize && pKey->PackArraySize - (iKeySz-*(int*)(*keyTag)) > 0){
					memcpy(	pKey->pPackTable,
							(*keyTag)+sizeof(int)
								+(iKeySz-pKey->PackArraySize)
									-(int)((struct PagedFileHeader *)pKey->pHeader)->PageSize,
							pKey->PackArraySize - (iKeySz-*(int*)(*keyTag)));
				}
			}
			if(pStr->accesMode & 0x2000){
				memcpy(	pStr->pUncompressBuffer+(int)((struct PagedFileHeader *)pStr->pHeader)->PageSize,
						(*strTag) + sizeof(int),
						(int)((struct PagedFileHeader *)pStr->pHeader)->PageSize);
				if(*(int*)(*strTag) > pStr->PackArraySize && pStr->PackArraySize - (iStrSz-*(int*)(*strTag)) > 0){
					memcpy(	pStr->pPackTable,
							(*strTag)+sizeof(int)
								+(iStrSz-pStr->PackArraySize)
									-(int)((struct PagedFileHeader *)pStr->pHeader)->PageSize,
							pStr->PackArraySize - (iStrSz-*(int*)(*strTag)));
				}
			}
#ifdef INSTLL_CIB
			*ndtTag= (char*)&lDefNdtCryptoTag;
#endif
		}
#endif
		int my_def_io_seek(int, void *hndls, int nfile, int npos, int whence)
		{
			return c_io_lseek(((int*)hndls)[nfile],npos,whence);
		}
		int my_def_io_read(int, void *hndls, int nfile, void *out_buf, int out_size)
		{
			return c_io_read(((int*)hndls)[nfile],out_buf, out_size);
		}
		int otherReadOrWrite(	LPPF_PARAM pPrm )
		{
			int indx;
			int first, page, szPack= 0l, pos;
			char *prePagePack;
			if(pPrm->page == 0l)
				return -1;
			if(pPrm->accesMode & 0x2000){
				if(pPrm->processMode != ACE_OS_O_RDONLY ||
					((struct PagedFileHeader *)pPrm->pHeader)->LastPage < pPrm->page)
					return -1;
				first= pPrm->page;
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
				if(pPrm->accesMode & 0x1000){
					if(first > pPrm->currPos && first <= (pPrm->currPos + giPackTableWindowSize))
						;
					else{
						pPrm->currPos= ((first-1)/giPackTableWindowSize)*giPackTableWindowSize;
						(*pPrm->cur_Seek)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->firstPos+pPrm->currPos*5, ACE_OS_SEEK_SET);
						(*pPrm->cur_Read)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->pStepPackTable, giPackTableWindowSize*5);
						pPrm->pFilePoss[0]= 1;
					}
					page= pPrm->page= (int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(prePagePack= 5 * ((first-1)%giPackTableWindowSize) + pPrm->pStepPackTable))
													/ (ACE_UINT64)((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
				}else{
					if(first > pPrm->currPos && first <= (pPrm->currPos + giPackTableWindowSize))
						;
					else{
						pPrm->currPos= ((first-1)/giPackTableWindowSize)*giPackTableWindowSize;
						(*pPrm->cur_Seek)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->firstPos+pPrm->currPos*4, ACE_OS_SEEK_SET);
						(*pPrm->cur_Read)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->pStepPackTable, giPackTableWindowSize*4);
						pPrm->pFilePoss[0]= 1;
					}
					prePagePack= 4 * ((first-1)%giPackTableWindowSize) + (char*)pPrm->pStepPackTable;
					page= pPrm->page= (*(int*)prePagePack) / ((struct PagedFileHeader *)(pPrm->pHeader))->PageSize;
				}
#else
				if(pPrm->accesMode & 0x1000){
					page= pPrm->page= 
	(int)(( ((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(prePagePack=(5 * (first-1) + (char*)pPrm->pPackTable)))
			/ (ACE_UINT64)((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
				}else{
					prePagePack= 4 * (first-1) + (char*)pPrm->pPackTable;
					page= pPrm->page= (*(int*)prePagePack) / ((struct PagedFileHeader *)(pPrm->pHeader))->PageSize;
				}
#endif
				indx= IsNextTom(pPrm);
				if(pPrm->pFilePoss[indx] - 1l == pPrm->page){
					szPack= 1l;
					pPrm->pFilePoss[indx]--;
				}
			}else{
				indx= IsNextTom(pPrm);
			}
			if(indx > -1){
				if(
#ifdef BRDR32
					szPack == 0l &&
#endif
									otherFileOpen(indx, pPrm))
					return -1;

#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
		pos= pPrm->page * (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize;
#endif
				if(
#ifndef BRDR32
						pPrm->pFilePoss[indx] != pPrm->page &&
#else
						szPack == 0l &&
#endif
  #ifdef BRDR32
					IsPostExistL(indx, pPrm, pos)
  #else
					(*pPrm->cur_Seek)(pPrm->accesMode, pPrm->pFileHandles, indx, pos, ACE_OS_SEEK_SET)
  #endif
								!= pos)
					return -1;

				pPrm->pFilePoss[indx] = pPrm->page + 1;

				if(pPrm->processMode == ACE_OS_O_RDONLY){
					if(szPack == 0l &&
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
						(
	#ifdef BRDR32
							pPrm->pCrptTag == 0 ||
	#endif
							indx > 0 || pos >= *(int*)pPrm->pCrptTag) &&
#endif
  #ifdef BRDR32
							IsPostExist(indx,pPrm) < 1
  #else
						(*pPrm->cur_Read)(pPrm->accesMode, pPrm->pFileHandles, indx, pPrm->buf,
							(int)(((struct PagedFileHeader *)pPrm->pHeader)->PageSize & 0x7fff) ) != (int)(((struct PagedFileHeader *)pPrm->pHeader)->PageSize & 0x7fff)
  #endif
																									){
					pPrm->pFilePoss[indx] = pPrm->page;
					return -1;
				}
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
				else if(
	#ifdef BRDR32
							pPrm->pCrptTag &&
	#endif
						szPack == 0l && indx == 0 && pos < *(int*)pPrm->pCrptTag && (pPrm->pFilePoss[indx]= 1)
						&& (*pPrm->cur_Seek)(pPrm->accesMode, pPrm->pFileHandles, indx, (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize, ACE_OS_SEEK_CUR)
						 && !memcpy(pPrm->buf, pPrm->pCrptTag
		+(pos-= ((struct PagedFileHeader *)pPrm->pHeader)->PageSize-sizeof(int)),
									(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize)){
					pPrm->pFilePoss[indx] = pPrm->page;
					return -1;
				}
#endif
	////////////////////////////////////////////////////
	if(pPrm->accesMode & 0x2000){
		// Смещение в первой странице //
		char	*pFirst;
		int EndPage;
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
		ACE_UINT64 prePagePackBuff;
		if(pPrm->accesMode & 0x1000)
			memcpy(&prePagePackBuff, prePagePack, 5);
		else
			memcpy(&prePagePackBuff, prePagePack, 4);
		prePagePack= (char*)&prePagePackBuff;
#endif
		if(pPrm->accesMode & 0x1000){
			pos= (int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)prePagePack)
			- (ACE_UINT64)page * ((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
		}else{
			pos= (*(int*)prePagePack) - page * ((struct PagedFileHeader *)pPrm->pHeader)->PageSize;
		}
		if(szPack == 0l)
			// Страницу временно сохранить //
			memcpy(pPrm->pUncompressBuffer+
					(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize * (indx+1), pPrm->buf,
							(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
		else
			// Страницу взять из сохранённого //
			memcpy(pPrm->buf, pPrm->pUncompressBuffer+
								(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize * (indx+1),
					(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
		// Плющенный Размер //
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
		if(pPrm->accesMode & 0x1000){
			if(first > pPrm->currPos && first < (pPrm->currPos + giPackTableWindowSize))
				;
			else{
				pPrm->currPos= (first/giPackTableWindowSize)*giPackTableWindowSize;
				(*pPrm->cur_Seek)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->firstPos+pPrm->currPos*5, ACE_OS_SEEK_SET);
				(*pPrm->cur_Read)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->pStepPackTable, giPackTableWindowSize*5);
				pPrm->pFilePoss[0]= 1;
			}
			pFirst= 5 * (first%giPackTableWindowSize) + pPrm->pStepPackTable;
		}else{
			if(first > pPrm->currPos && first < (pPrm->currPos + giPackTableWindowSize))
				;
			else{
				pPrm->currPos= (first/giPackTableWindowSize)*giPackTableWindowSize;
				(*pPrm->cur_Seek)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->firstPos+pPrm->currPos*4, ACE_OS_SEEK_SET);
				(*pPrm->cur_Read)(pPrm->accesMode, pPrm->pFileHandles, 0, pPrm->pStepPackTable, giPackTableWindowSize*4);
				pPrm->pFilePoss[0]= 1;
			}
			pFirst= 4 * (first%giPackTableWindowSize) + (char*)pPrm->pStepPackTable;
		}
#else
		if(pPrm->accesMode & 0x1000){
			pFirst= 5 * first + (char*)pPrm->pPackTable;
		}else{
			pFirst= 4 * first + (char*)pPrm->pPackTable;
		}
#endif
		if(pPrm->accesMode & 0x1000){
			szPack= (int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)pFirst)
						- (((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)prePagePack));
			EndPage= (int)(((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)pFirst) - (ACE_UINT64)1)
						/ ((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
		}else{
			szPack= (*(int*)pFirst)- *(int*)prePagePack;
			EndPage= ((*(int*)pFirst)-1) / ((struct PagedFileHeader *)pPrm->pHeader)->PageSize;
		}
		pFirst= (char *)pPrm->buf;
		if( EndPage != page){
			pPrm->buf= pPrm->pUncompressBuffer;
			pPrm->page= page + 1;
			pPrm->accesMode &= ~0x2000;
			if(otherReadOrWrite(pPrm) == -1)
				return -1;
			if(pPrm->page){
				// Страницу временно сохранить //
				memcpy(pPrm->pUncompressBuffer+
						(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize * (indx+1), pPrm->buf,
						(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
			}
			pPrm->accesMode |= 0x2000;
			// Остаток в первой странице //
			first= ((struct PagedFileHeader *)pPrm->pHeader)->PageSize - pos;

			memcpy(pFirst, pFirst + (int)pos, (int)first);
			if(szPack > (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize)
				memcpy(pFirst+(int)first, pPrm->pUncompressBuffer,
					(int)((int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize- first));
			else{
				memcpy(pFirst+(int)first, pPrm->pUncompressBuffer, (int)szPack- (int)first);
				if(!pPrm->page){
					first= (int)szPack- (int)first;
					memcpy(pPrm->pUncompressBuffer+
							(int)((struct PagedFileHeader *)pPrm->pHeader)
													->PageSize * (indx+2)+first,
							(char*)pPrm->buf+first,
							(int)((struct PagedFileHeader *)pPrm->pHeader)
									->PageSize-first);
				}
			}
		}else if(pos != 0l)
			memcpy(pFirst, pFirst + (int)pos, (int)szPack);

		if(szPack < (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize) { // GARANT_ZLIB
			char tmp_buff [4096];
			unsigned tmp_unpack_size_req = unsigned (((struct PagedFileHeader *)pPrm->pHeader)->PageSize);
			assert (tmp_unpack_size_req <= 4096);
			unsigned tmp_unpack_size = Zip::UnZip(pFirst, (int)szPack, tmp_buff, (int)tmp_unpack_size_req);
			assert (tmp_unpack_size == tmp_unpack_size_req);
			memcpy (pFirst, tmp_buff, tmp_unpack_size_req);
		}
	}
	////////////////////////////////////////////////////
				}else 
					if(
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
						(
#if defined(_DEBUG) || defined(BRDR32)
					pPrm->pCrptTag == 0 ||
#endif
					indx > 0 || pos >= *(int*)pPrm->pCrptTag) &&
#endif
						pPrm->processMode == ACE_OS_O_WRONLY
						&& 
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
						 (
#endif
							c_io_write( pPrm->pFileHandles[indx], pPrm->buf,
									(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize)
										!= (int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
								||
							(pPrm->processMode= ACE_OS_O_RDONLY)== ACE_OS_O_WRONLY
						  )
#endif
										)
						return -1;
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
					else if(pPrm->processMode == ACE_OS_O_WRONLY && (pPrm->pFilePoss[indx] = -1) == -1
								&& memcpy( pPrm->pCrptTag
						+ pos - ((struct PagedFileHeader *)pPrm->pHeader)->PageSize + sizeof(int),
											pPrm->buf,
											(int)((struct PagedFileHeader *)pPrm->pHeader)->PageSize) == 0)
						return -1;
#endif
			}
			return indx;
		}
#endif

#ifdef  __cplusplus
	}
#endif

#ifdef  __cplusplus
	#ifdef BRDR32
	  #ifdef ENGLISH_DEF_RC
		char	formatMsg[] = "Copying file %s";
	  #else
		char	formatMsg[] = "Копируется файл %s";
	  #endif
	#else
		char	formatMsg[] = "Copying %s";
	#endif
const char *getCopyingFormat()
{
	return &(formatMsg[0]);
}

int PagedFile :: FlushAllHandles(int startN, char *reOpenName)
{
#ifdef WIN32
	for(; startN < MAX_COUNT_FILE_HANDLES+1; startN++){
		if(m_postFileHandles[startN] != -1 && c_io_file_flush(m_postFileHandles[startN]))
			return 1;
	}
#else
	if(CloseAllHandles(startN))
		return -1;
	 SetFileHandle(c_io_open(reOpenName, ACE_OS_O_RDWR | ACE_OS_O_BINARY));
	 if(file == -1)
		 return -1;
#endif
	return 0;
}

int PagedFile :: CloseAllHandles(int startN)
{

	for(; startN < MAX_COUNT_FILE_HANDLES+1; startN++){
		if(m_postFileHandles[startN] != -1 && c_io_close(m_postFileHandles[startN]))
			return 1;
		m_postFileHandles[startN]= -1;
	}
	memset(m_postFilePoss, 0, MAX_COUNT_FILE_HANDLES*sizeof(*m_postFilePoss));
	return 0;
}

extern "C" {
	int my_def_ace_seek(int, void *hndls, int nfile, int npos, int whence)
	{
		ACE_HANDLE fh = ((ACE_HANDLE*)hndls)[nfile];
		off_t lres = ::ACE_OS::lseek(fh, (off_t)(npos & 0xffffffff), whence);
		if(lres < 0)
			return -1;
		return (int)(lres & 0x7fffffff);
	}
	int my_def_ace_read(int, void *hndls, int nfile, void *out_buf, int out_size)
	{
		ACE_HANDLE fh = ((ACE_HANDLE*)hndls)[nfile];
		ssize_t rres = ::ACE_OS::read(fh, out_buf, (size_t)(out_size & 0x7fffffff));
		return (int)(rres & 0x7fffffff);
	}
}

int PagedFile :: Delete(int Full)
{
	if(m_isRemoved == 1 || file == -1){
		return 0;
	}

	if(Full == 1 && (m_mode & ACE_OS_O_WRONLY)){
		return -33;
	}

	if ( (Flags & PF_MODIFIED) && SystemPageBuf != 0 )
	{
		char msgEW[]= "Not Write SystemPage(%s)";
		((PagedFileHeader*)SystemPageBuf)->AttrOffs = AttrOffs;
		((PagedFileHeader*)SystemPageBuf)->LastPage = LastPage;
		((PagedFileHeader*)SystemPageBuf)->FreePage = FreePage;
		((PagedFileHeader*)SystemPageBuf)->lastFreePage = lastFreePage;
		c_io_lseek(file, 0, ACE_OS_SEEK_SET);
		if(PageSize == 512 && ((PagedFileHeader*)SystemPageBuf)->Signature == BASE_DATA_VERSION){
			// открытая область атрибутов NDT файла НИКОГДА не появляется надиске //
			if(c_io_write(file, SystemPageBuf, AttrOffs) != AttrOffs){
#ifdef LOG_E
				LOG_E((msgEW, FileName));
#else
				printf(msgEW, FileName);
#endif
				return -22;
			}
		}else if(c_io_write(file, SystemPageBuf, PageSize) != PageSize){
#ifdef LOG_E
				LOG_E((msgEW, FileName));
#else
				printf(msgEW, FileName);
#endif
				return -22;
			}
	}else if(m_mode & ACE_OS_O_RDWR)
		;
	else{
		int rpt= 0;
		if(file)
			rpt= 1;
		else
			file= -2;
		if(m_readed.cur_Seek == my_def_ace_seek){
			for(; rpt < MAX_COUNT_FILE_HANDLES+1; rpt++){
				if((((ACE_HANDLE*)m_postFileHandles)[rpt]) != ACE_INVALID_HANDLE && ::ACE_OS::close(((ACE_HANDLE*)m_postFileHandles)[rpt]))
					return 1;
				((ACE_HANDLE*)m_postFileHandles)[rpt]= ACE_INVALID_HANDLE;
			}
		}
#ifndef MIN_MEM_CONTEXT
		else for(; rpt < MAX_COUNT_FILE_HANDLES+1; rpt++){
			if(
	#ifdef WIN32
				m_postFileHandles[rpt] != -1 && c_io_close(m_postFileHandles[rpt])
	#else
				(((ACE_HANDLE*)m_postFileHandles)[rpt]) != ACE_INVALID_HANDLE && ::ACE_OS::close(((ACE_HANDLE*)m_postFileHandles)[rpt])
	#endif
				)
				return 1;
	#ifdef WIN32
			m_postFileHandles[rpt]= -1
	#else
			((ACE_HANDLE*)m_postFileHandles)[rpt]= ACE_INVALID_HANDLE
	#endif
																		;
		}
#endif
	}
	if (rbuf)
		free(rbuf);
	rbuf= 0;
	if (pBff)
		free(pBff);
	pBff= 0;

	free_postFileNames();

	if(
#ifndef BRDR32
		(PageSize != 512 || (SystemPageBuf && ((PagedFileHeader*)SystemPageBuf)->Signature != BASE_DATA_VERSION))
		&& (!m_pCryptoTag || *(int*)m_pCryptoTag <= (int)PageSize) &&
#endif
		file != -2 && c_io_close ( file ))
	{
		abort();
	}else
		*m_postFileHandles= -1;

	CloseAllHandles(1);
	m_isRemoved= 1;
#ifdef BRDR32
	if(m_pCryptoTag && m_pCryptoTag != (char*)&DefValCryptoTag){
		if(PageSize != 512)
			free(m_pCryptoTag);
	}
	m_pCryptoTag= 0;
	if(pageOffs)
		free(pageOffs);
	pageOffs= 0;
#endif
	if(Full == 1){
		char *TmpName= strdup(FileName);
		int	i_retV= ace_os_unlink(	TmpName ),
			indx= (int)(LastPage/(m_max_paged_file_per_bytes/(int)PageSize));
		if(indx){
			for(int ii=0; ii < indx;){
				if(GetBasedExtFileName(TmpName, ++ii) != 0){
					if(i_retV == 0)
						i_retV= ace_os_unlink(	TmpName );
					else{
						ace_os_unlink(	TmpName );
					}
				}
			}
		}
		free(TmpName);
		return i_retV;
	}
	return 0;
}

PagedFile::PagedFile (LPPF_PARAM pAttrs)
{
	memcpy(&m_readed, pAttrs, sizeof(PF_PARAM));

	strcpy(FileName,pAttrs->FileName);
	free(pAttrs->FileName);
	pContext= (GSScreen *)pAttrs->pScreenCntxt;
	c_io_close(*pAttrs->pFileHandles);
	file= *pAttrs->pFileHandles= c_io_open(FileName, ACE_OS_O_RDWR|ACE_OS_O_BINARY);

	memcpy(m_postFileHandles, pAttrs->pFileHandles, sizeof(*m_postFileHandles) * (MAX_COUNT_FILE_HANDLES+1));
	memcpy(m_postFilePoss, pAttrs->pFilePoss, sizeof(*m_postFilePoss) * (MAX_COUNT_FILE_HANDLES+1));

	*m_postFilePoss= *pAttrs->pFilePoss= 0;

	SystemPageBuf= (char*)(pAttrs->pHeader);

	m_pCryptoTag= pAttrs->pCrptTag;

	AttrOffs = ((PagedFileHeader*)SystemPageBuf)->AttrOffs;
	LastPage = ((PagedFileHeader*)SystemPageBuf)->LastPage;
	FreePage = ((PagedFileHeader*)SystemPageBuf)->FreePage;
	lastFreePage = ((PagedFileHeader*)SystemPageBuf)->lastFreePage;

	PageSize= ((PagedFileHeader*)SystemPageBuf)->PageSize;

	m_max_paged_file_per_bytes= pAttrs->maxFile_per_bytes;

	m_mode= ACE_OS_O_RDWR;
	pBff= 0;

	if(m_mode & 0x2000) isPacked= 1;
	else isPacked= 0;

	rbuf= pAttrs->pUncompressBuffer;
	m_PackArraySize= pAttrs->PackArraySize;
	pageOffs= (unsigned int *)pAttrs->pPackTable;
	m_MessageForNextFunc= pAttrs->MessageForNextFunc;
	m_CloseProcessFunc= pAttrs->CloseProcessFunc;

	Flags = PF_MODIFIED;
	m_isRemoved= 0;
}

int PagedFile::Connect(const char * name, int mode, int max_paged_file_per_bytes)
{
	m_pCryptoTag= 0;
	isPacked = 0;
	Flags = 0;
	Total = 0;
	Hits  = 0;
	memset(&m_readed, 0, sizeof(m_readed));
	m_readed.iPost= 1;

	pageOffs = 0;
	rbuf = 0;
	pBff= 0;
	m_lstPackedPage= 0;
	m_readed.PackArraySize= m_PackArraySize= 0;
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
	m_readed.pStepPackTable= 0;
#endif
	m_CloseProcessFunc= DefaultCloseProcessFunc;
	m_MessageForNextFunc= DefaultMessageForNextFunc;

	memset(m_postFileHandles+1, -1, (MAX_COUNT_FILE_HANDLES+1)*sizeof(*m_postFileHandles));
	memset(m_postFilePoss, 0, MAX_COUNT_FILE_HANDLES*sizeof(*m_postFilePoss));
	memset(m_postFileNames, 0, MAX_COUNT_FILE_HANDLES*sizeof(*m_postFileNames));

	m_mode= 0;
	m_max_paged_file_per_bytes= max_paged_file_per_bytes;
	m_isRemoved= 0;
	pContext= 0;
	strcpy(FileName,name);

	m_readed.cur_Seek= my_def_io_seek;
	m_readed.cur_Read= my_def_io_read;

	m_readed.pFilePoss= m_postFilePoss;
	m_readed.pFileHandles= m_postFileHandles;

	file = c_io_open(FileName, mode | ACE_OS_O_BINARY);

	if (file != -1 ) {
		char testChar[PF_HD_SECTOR_SIZE];
		if (c_io_read(file,testChar,PF_HD_SECTOR_SIZE) != PF_HD_SECTOR_SIZE) {
			c_io_close ( file );
			file = -1;
			SystemPageBuf = 0;
			return 0;
		}
		if ( (SystemPageBuf = (char *) calloc ( 1, 2*(PageSize= *(short*)(testChar + 4l + COPYRIGHT_SIZE)) )) ) {
			if (PageSize < 512 || c_io_lseek(file, 0, ACE_OS_SEEK_SET) != 0l ||
				c_io_read(file, SystemPageBuf, PageSize) != PageSize) {
				c_io_close(file);
				file = -1;
				free(SystemPageBuf);
				SystemPageBuf = 0;
				return 0;
			}
#if defined(BRDR) || defined(BRDR32) || defined(INSTLL_CIB)
			pl_GetLoginFromBase( &m_pCryptoTag, SystemPageBuf, PageSize);
#endif
			AttrOffs = ((PagedFileHeader*)SystemPageBuf)->AttrOffs;
			LastPage = ((PagedFileHeader*)SystemPageBuf)->LastPage;
			FreePage = ((PagedFileHeader*)SystemPageBuf)->FreePage;
			lastFreePage = ((PagedFileHeader*)SystemPageBuf)->lastFreePage;
			if(
#ifndef BRDR32
				*(int *)SystemPageBuf == BASE_DATA_VERSION &&
#endif
				((PagedFileHeader*)SystemPageBuf)->TomPerPages != 0 && ((PagedFileHeader*)SystemPageBuf)->TomPerPages >= MAX_COUNT_FILE_HANDLES){
				m_max_paged_file_per_bytes= ((PagedFileHeader*)SystemPageBuf)->TomPerPages * PageSize;
			}else{
				if(mode)
					((PagedFileHeader*)SystemPageBuf)->TomPerPages= 0;
				m_max_paged_file_per_bytes= max_paged_file_per_bytes;
			}
		}
		if (file) {
			if (
#if (defined(BRDR32)||defined(INSTLL_CIB)) && !defined(RD_AS_ETALON)
				PageSize > 512 &&

#endif
				((PagedFile::GetAttr(ID_PACKED, (char*)"", 0) && (isPacked = 1))
					|| (PagedFile::GetAttr(ID_PACKED_NEW, (char*)"", 0) && (isPacked = 2)))
				)
					; 
				else isPacked = 0;

			if (isPacked) {
				int startPos;
				if(isPacked == 1)
					startPos= (LastPage + 1l) * sizeof(ACE_UINT32);
				else
					startPos= (LastPage + 1l) * 5;
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
				int StepPackTableCount;
				if(isPacked == 1){
					m_readed.pStepPackTable= (char*)malloc(StepPackTableCount=((giPackTableWindowSize + 1l) * sizeof(ACE_UINT32)));
					StepPackTableCount -= sizeof(ACE_UINT32);
				}else{
					m_readed.pStepPackTable= (char*)malloc(StepPackTableCount=((giPackTableWindowSize + 1l) * 5));
					StepPackTableCount -= 5;
				}
				m_readed.currPos= 0;
				m_readed.PackArraySize= startPos;
				m_PackArraySize= 64;
#else
				m_PackArraySize= m_readed.PackArraySize= startPos;
#endif
				pageOffs = (unsigned int gk_huge *)gk_malloc( sizeof(ACE_UINT64) + m_PackArraySize ); // GARANT_XXX but seems to be more safe

				if ( !pageOffs || c_io_lseek(file, -startPos, ACE_OS_SEEK_END) < PageSize )
				{
					if(pageOffs)
						free(pageOffs);
					pageOffs= 0;
					c_io_close(file);
					file = -1;
					free(SystemPageBuf);
					SystemPageBuf = 0;
					return 0;
				}else{
					char *pNxtRead= (char*)pageOffs;
					int rptRd= m_PackArraySize/(1024*1024);
					while(rptRd--){
						if(c_io_read(file, pNxtRead, 1024*1024) != 1024*1024){
							if(pageOffs)
								free(pageOffs);
							pageOffs= 0;
							c_io_close(file);
							file = -1;
							free(SystemPageBuf);
							SystemPageBuf = 0;
							return 0;
						}
						pNxtRead += 1024*1024;
					}
					rptRd= m_PackArraySize%(1024*1024);
					if(c_io_read(file, pNxtRead, rptRd) != rptRd){
						if(pageOffs)
							free(pageOffs);
						pageOffs= 0;
						c_io_close(file);
						file = -1;
						free(SystemPageBuf);
						SystemPageBuf = 0;
						return 0;
					}
				}
				u_int64_t FullSize = (u_int64_t)(LastPage & 0x7fffffff);
				FullSize *= PageSize;
				rbuf = (char *)malloc((size_t)((((FullSize/m_max_paged_file_per_bytes)+2)*(PageSize&0x7fff))&0x7fffffff));
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
				m_readed.firstPos= c_io_tell(file) - m_PackArraySize;
				if(startPos > m_PackArraySize){
					memcpy(m_readed.pStepPackTable, pageOffs, m_PackArraySize);


					if (	LastPage > (m_PackArraySize/sizeof(ACE_UINT32))
							&& c_io_read(file, m_readed.pStepPackTable+m_PackArraySize, (StepPackTableCount= StepPackTableCount - m_PackArraySize) ) != StepPackTableCount
							)
					{
						free(pageOffs);
						pageOffs= 0;
						c_io_close(file);
						file = -1;
						free(SystemPageBuf);
						SystemPageBuf = 0;
						return 0;
					}
				}else{
					memcpy(m_readed.pStepPackTable, pageOffs, startPos);
				}
				m_readed.PackArraySize= startPos;
#endif
			}
		}
		m_mode= mode;
		if(isPacked){
			m_mode |= 0x2000;
			c_io_lseek(file, PageSize, ACE_OS_SEEK_SET);
			c_io_read( file, rbuf+(int)PageSize, (int)PageSize );
			*m_postFilePoss= 2;
		}else
			*m_postFilePoss= 1;
		*m_postFileHandles= file;
		// Force open //
		m_readed.pFileHandles= m_postFileHandles;
		m_readed.accesMode= m_mode;
		m_readed.processMode= ACE_OS_O_RDONLY;
		if(m_mode & 0x2000){
#if ( !defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM) )
			if(isPacked == 1){
				c_io_lseek(file, m_readed.firstPos+((LastPage-1)*sizeof(ACE_UINT32)), ACE_OS_SEEK_SET);
				c_io_read(file, &(m_readed.page),sizeof(ACE_UINT32));
				m_readed.page /= PageSize;
			}else{
				c_io_lseek(file, m_readed.firstPos+((LastPage-1)*5), ACE_OS_SEEK_SET);
				char tmpPos[8];
				c_io_read(file, tmpPos,5);
				m_readed.page= (int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)tmpPos) / (ACE_UINT64)PageSize);
				m_mode |= 0x1000;
			}
			c_io_lseek(file, PageSize+PageSize, ACE_OS_SEEK_SET);
#else
			if(isPacked == 1)
				m_readed.page= pageOffs[LastPage-1] / PageSize;
			else{
				m_readed.page= 
	(int)((((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * (LastPage-1) + (char*)pageOffs))
			/ (ACE_UINT64)PageSize);
				m_mode |= 0x1000;
			}
#endif
		}else
			m_readed.page= LastPage;
		m_readed.FileName= FileName;
		m_readed.maxFile_per_bytes= m_max_paged_file_per_bytes;
		m_readed.pFilePoss= m_postFilePoss;
		m_readed.pHeader= SystemPageBuf;
		char TempName[4096];
		m_readed.buf= TempName;
		m_readed.pUncompressBuffer= rbuf;
		m_readed.pPackTable= pageOffs;
		//m_readed.PackArraySize= m_PackArraySize;
#ifndef BRDR32
		if(((PagedFileHeader*)SystemPageBuf)->TomPerPages == 0 || ((PagedFileHeader*)SystemPageBuf)->TomPerPages >= MAX_COUNT_FILE_HANDLES){
			int repeat= IsNextTom(&m_readed);
#ifndef MIN_MEM_CONTEXT
	#if (defined(__LP64__) || defined(WIN64))
			int repeatLast= repeat;
	#endif
#endif
			while(repeat){
				  int len;
				  if(	(len=strlen(m_readed.FileName)+1) < 2 ||
					GetBasedExtFileName((char*)memcpy(m_readed.buf,m_readed.FileName,len), repeat) == 0)
				  {
					c_io_close(file);
					file = -1;
					free(SystemPageBuf);
					SystemPageBuf = 0;
					return -1;
				  }
#ifndef MIN_MEM_CONTEXT
				  if(m_mode & ACE_OS_O_RDWR)
#endif
				  {
					m_postFileHandles[repeat]= c_io_open((char*)(m_readed.buf), ACE_OS_O_RDWR|ACE_OS_O_BINARY);
					if(m_postFileHandles[repeat] == -1){
						c_io_close(file);
						file = -1;
						free(SystemPageBuf);
						SystemPageBuf = 0;
						return -1;
						return 0;
					}
				  }
#ifndef MIN_MEM_CONTEXT
				  else{
					(((ACE_HANDLE*)m_postFileHandles)[repeat])
						= ::ACE_OS::open((char*)(m_readed.buf), ACE_OS_O_RDONLY|ACE_OS_O_BINARY, ACE_DEFAULT_OPEN_PERMS);
					if((((ACE_HANDLE*)m_postFileHandles)[repeat]) == ACE_INVALID_HANDLE){
						c_io_close(file);
						file = -1;
						free(SystemPageBuf);
						SystemPageBuf = 0;
						return -1;
						return 0;
					}
				  }
#endif
				repeat--;
#ifndef MIN_MEM_CONTEXT
				if(!mode){
					m_postFileNames[repeat]= strdup((char*)(m_readed.buf));
				}
#endif
			}
#ifndef MIN_MEM_CONTEXT
	#if (defined(__LP64__) || defined(WIN64))
			if(m_mode & ACE_OS_O_RDWR)
				;
			else do{
				((ACE_HANDLE*)m_postFileHandles)[++repeatLast]= ACE_INVALID_HANDLE;
			}while(repeatLast < MAX_COUNT_FILE_HANDLES+1);
	#endif
#endif
		}else if(rbuf){
				m_readed.pUncompressBuffer= rbuf= (char *)realloc(rbuf, PageSize * 10);
		}
#endif
	}
	else {
		SystemPageBuf = 0;
		PageSize = 0;
	}
#if (defined(BRDR) || defined(BRDR32))
	m_readed.pScreenCntxt= 0;
#elif (defined(INSTLL_CIB) || defined(MAKE_HDD))
	if(!m_pCryptoTag)
		m_pCryptoTag= (char*)&DefValCryptoTag;
#else
	m_pCryptoTag= 0;
#endif
	m_readed.currentDisk= 0;
	m_readed.pHeader= SystemPageBuf;
	return 0;
}

PagedFile :: PagedFile ( const char * name, int mode , int max_paged_file_per_bytes )
{
	m_readed.MessageForNextFunc= m_MessageForNextFunc;
	m_readed.CloseProcessFunc= m_CloseProcessFunc;

	if(Connect(name, mode, max_paged_file_per_bytes)){
		if(mode)
			abort();
	}
}

PagedFile :: ~PagedFile ()
{
	Delete();
}

void	PagedFile :: Create ( short psize, bool /*bLockPath= false*/  )
{
#ifdef  MIN_MEM_AND_RDONLY
	abort();
#else
  #ifdef BRDR32
	int ipause= 0;
  #endif
	if(psize < PF_HD_SECTOR_SIZE)
		psize= PF_HD_SECTOR_SIZE;

	file = c_io_open(FileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
	if (file != -1) {		// file exist and can be opened for reading
		c_io_close(file);
		file = c_io_open(FileName, ACE_OS_O_RDWR | ACE_OS_O_BINARY); 
		if (file == -1) {
			fprintf(stderr, "Cannot open file %s for writing.\n", 
				FileName);
			return;		// and cannot be opened for 
					// writing - bail out
		}
  #ifdef BRDR32
		ipause= 10;
  #endif
		c_io_close(file);		// file exist and can be opened RDWR
		if (ace_os_unlink(FileName) == -1) {
			fprintf(stderr, "Cannot erase file %s.\n", FileName);
			return;
		}
	}
	PageSize = psize;
  #ifdef BRDR32
	while(ipause-- && chk_sleep());
  #endif
	file = c_io_open(FileName,	ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT
  #ifdef BRDR32
								| ACE_OS_O_EXCL
  #endif
								);
	if (file == -1) {
		fprintf(stderr, "Cannot create file %s.\n", FileName);
		return;		// cannot be created
	}
	m_mode= ACE_OS_O_RDWR | ACE_OS_O_CREAT
  #ifdef BRDR32
								| ACE_OS_O_EXCL
  #endif
		;
	if ( ( SystemPageBuf = (char *)calloc ( 2, PageSize ) ) == 0 )
		return;
	
	strcpy ( SystemPageBuf + 4, "Garant Database file. Copyright (C) 1990,96 Garant-Service" );

	((PagedFileHeader*)SystemPageBuf)->Signature = BASE_DATA_VERSION;
	((PagedFileHeader*)SystemPageBuf)->PageSize = psize;

	LastPage     = 0l;
	FreePage     = -1l;
	lastFreePage = -1l;
	AttrOffs     = sizeof(PagedFileHeader);
	Flags        = PF_MODIFIED;
	isPacked	 = 0;

	*m_postFileHandles= file;
	*m_postFilePoss= 0;
  #ifdef INSTLL_CIB
	m_pCryptoTag= (char*)&DefValCryptoTag;
  #endif
#endif
}

void PagedFile :: skip_c_rtl_handle()
{
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	if(file && file != -1){
		(*(ACE_HANDLE*)m_postFileHandles)
			= ::ACE_OS::open(FileName, ACE_OS_O_RDONLY|ACE_OS_O_BINARY, ACE_DEFAULT_OPEN_PERMS);
		if((*(ACE_HANDLE*)m_postFileHandles) == ACE_INVALID_HANDLE){
			throw std::exception ();
		}
		c_io_close(file);
		file= 0;
		*m_postFilePoss= 0;
		m_readed.cur_Seek= my_def_ace_seek;
		m_readed.cur_Read= my_def_ace_read;
	}
#endif
}

int	PagedFile :: GetPage ( int page, void *buf )
{
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	if(m_mode & ACE_OS_O_RDWR)
		;
	else{
		skip_c_rtl_handle();
	}
#endif
	m_readed.accesMode= m_mode;
	m_readed.processMode= ACE_OS_O_RDONLY;
	m_readed.page= page;
	m_readed.buf= buf;
	m_readed.FileName= FileName;
	m_readed.maxFile_per_bytes= m_max_paged_file_per_bytes;
	m_readed.pHeader= SystemPageBuf;
	m_readed.pUncompressBuffer= rbuf;
	m_readed.pPackTable= pageOffs;
#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
	m_readed.pCrptTag= m_pCryptoTag;
#endif
#ifdef BRDR32
	m_readed.pScreenCntxt= pContext;
#endif
	if(otherReadOrWrite(&m_readed) == -1)
		return 0;

	return 1;
}

int	PagedFile :: PutPage ( int page, void * buf )
{
	PF_PARAM tmp;

	tmp.pFileHandles= m_readed.pFileHandles;
	tmp.pFilePoss= m_readed.pFilePoss;

	tmp.accesMode= m_mode;
	tmp.processMode= ACE_OS_O_WRONLY;
	tmp.page= page;
	tmp.buf= buf;
	tmp.FileName= FileName;
	tmp.maxFile_per_bytes= m_max_paged_file_per_bytes;
	tmp.pHeader= SystemPageBuf;
	tmp.PackArraySize= m_PackArraySize;
	tmp.MessageForNextFunc= m_MessageForNextFunc;
	tmp.CloseProcessFunc= m_CloseProcessFunc;

	tmp.pCrptTag= m_pCryptoTag;

	tmp.cur_Seek= my_def_io_seek;
	tmp.cur_Read= 0;

	if(otherReadOrWrite(&tmp) == -1)
		return 0;

	Flags |= PF_PUTPAGE;
	return 1;
}

int	PagedFile :: NewPage ()
{
	Flags   |= PF_MODIFIED;			// allocation of a new page always modifies file

	if ( FreePage == -1l )			// no free pages, so create new at the end of file
		return ++LastPage;

	void  * buf  = AllocBuf ();
	int	page = FreePage;

	if ( buf == 0 )
		return -1l;

	if ( !GetPage ( FreePage, buf ) )
		page = -1l;
	else
		FreePage = * (int *) buf;

	FreeBuf ( buf );

	if ( page == lastFreePage )
		lastFreePage = -1l;		// it's no inter free

	return page;
}

int	PagedFile :: NewContBlock ( int pages )
{
	Flags    |= PF_MODIFIED;		// allocation of a new page always modifies file
	LastPage += pages;			// simply allocate block at the end of file

	return LastPage - pages + 1;
}

void	PagedFile :: DelPage ( int page )
{
	return;
	if ( FreePage == -1l )
		FreePage = page;

	void  * buf = AllocBuf ();
	if ( buf == 0 )
		return;

	if ( lastFreePage != -1l )
	{
		* (int *) buf = page;
		PutPage ( lastFreePage, buf );
	}
	* (int *) buf = -1l;

	PutPage ( page, buf );
	FreeBuf ( buf );

	lastFreePage = page;
	Flags   |= PF_MODIFIED;
}

int	PagedFile :: GetAttr ( const char * name, void * buf, int size )
{
	int	len = strlen ( name );

	for ( int Offs = AttrOffs; SystemPageBuf && Offs < PageSize && SystemPageBuf [Offs] != '\0'; Offs += SystemPageBuf [Offs] )
		if ( !strcmp ( SystemPageBuf + Offs + 1, name ) )	// attrs found
		{
			memmove ( buf, SystemPageBuf + Offs + 2 + len, (((size) < (SystemPageBuf [Offs] - len - 2)) ? (size) : (SystemPageBuf [Offs] - len - 2))); // GARANT_STL

			return 1;
		}

	return 0;
}

#ifdef  __cplusplus
extern "C" {
int	_PutAttr (	short PageSize, char *SystemPageBuf, const char * name, void * buf, int size );
}
#endif

int	PagedFile :: PutAttr ( const char * name, void * buf, int size )
{
	if(_PutAttr(PageSize, SystemPageBuf + AttrOffs, name, buf, size)){
		Flags |= PF_PUTATTR;
		Flags |= PF_MODIFIED;
		return 1;
	}
	return 0;
}

int PagedFile::DelAttr(const char *name)
{
	int	len = strlen ( name );
	int Offs;
	for (Offs=AttrOffs; Offs<PageSize && SystemPageBuf[Offs]!='\0'; 
			Offs+=SystemPageBuf[Offs]) {
		if (!strncmp(SystemPageBuf+Offs+1, name, len))	// attrs found
			break;
	}

	if ((Offs>=PageSize) || (SystemPageBuf[Offs]=='\0')) // was not found
		return 0;

	int newOffs = Offs+SystemPageBuf[Offs], lstCount= 0;
	while(SystemPageBuf[newOffs]!='\0'){
		lstCount += SystemPageBuf[newOffs];
		newOffs+=SystemPageBuf[newOffs];
	}
	memcpy(SystemPageBuf+Offs,SystemPageBuf+Offs+SystemPageBuf[Offs],lstCount+1);
	Flags |= PF_MODIFIED;
	return 1;
}

int	PagedFile::SignatureValid ()
{
	return (SystemPageBuf && (* (int *) SystemPageBuf == BASE_DATA_VERSION));
}

int PagedFile::IsOk (){
#if defined(BRDR32) && defined(MULTI_INDEX_STREAM_FILE)
		const char *pFirstCharExt;
#endif
		return Exist () && (*(int *)SystemPageBuf == BASE_DATA_VERSION
#if defined(BRDR32) && defined(MULTI_INDEX_STREAM_FILE)
			||
		(	*(int *)SystemPageBuf == BASE_DATA_VERSION_OUT &&
			(	*(pFirstCharExt= strrchr(FileName, '.')+1) == '0'
				|| *pFirstCharExt == '1' || *pFirstCharExt == '2'
				|| *pFirstCharExt == '7' || *pFirstCharExt == '8' || *pFirstCharExt == '9'
				|| *pFirstCharExt == 'k' || *pFirstCharExt == 's' /* добавлено Владом, поскольку GL модифицирует */
				|| *pFirstCharExt == 'K' || *pFirstCharExt == 'S' /* Class6, и Index::~Index из Бридера не работал */
			)
		)
#endif
																		);
}

void PagedFile::free_postFileNames()
{
	char **pNxt= m_postFileNames;
	while(*pNxt){
		free(*pNxt);
		*pNxt= 0;
		pNxt++;
	}
}

int PagedFile::GetFileSizeInKbytes(int AsUnPacked)
{
	int aa= 0;
	if(IsPacked() && !AsUnPacked){
		if(m_mode & 0x1000){
			aa=
	(int)(( ((((ACE_UINT64)0xffffffffUL) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * LastPage + (char*)pageOffs))
								/ (ACE_UINT64)1024l);
		}else
			aa= (int)(1+pageOffs[LastPage] / 1024l);
	}else{
		switch(PageSize){
		case 512:
			aa += LastPage / 2;
			break;
		case 4096:
			aa += LastPage * 4;
			break;
		case 2048:
			aa += LastPage * 2;
			break;
		}
	}
	if(PageSize == 4096){
		int blb= 0;
		GetAttr("BLB", &blb, sizeof(blb));
		aa += 1 + blb/1024;
	}
	return aa;
}
	#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	// makePagedFile разлуивается включением/выключением Нового/Старого Индексного движка //
	#elif !(defined(BRDR32))
	PagedFile *makePagedFile(const char *name, int omode)
	{
		if(!omode){
			class	PFile : public PagedFile
			{
			  public:
				PFile(const char *name) : PagedFile ( name, ACE_OS_O_RDONLY)
				{
				}
				virtual int Delete(int Remove)
				{
					int ret= PagedFile::Delete(Remove);

					if(PageSize != 512 && SystemPageBuf){
						FreeBuf(SystemPageBuf);
						SystemPageBuf= 0;
					}
					return ret;
				}
				virtual	~PFile ()
				{
					this->Delete(0);
				}
			};
			return new PFile(name);
		}
		return new PagedFile(name, omode);
	}
	#endif
#endif