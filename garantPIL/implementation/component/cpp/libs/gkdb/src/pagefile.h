#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: pagefile.h,v 2.92 2015/09/01 07:39:38 yaroslav Exp $
 */
//
// Basic classes for handling files with page structure
// Supports: page allocation & freeing, read/write ops, cachings
// DPMI & VCP support will be added
//
// Protected files !!!
//
// Author: Alex V.Boreskoff
//
//

#ifndef	__PAGED_FILE__
#define	__PAGED_FILE__

#include "check.h"
#include "../../../include/osdep.h"

#define MAX_COUNT_FILE_HANDLES 400

// #define	VALID_SIGN	0x031C07CEl	// so guess what it is
// move into gkdb_ver.h, new name BASE_DATA_VERSION

#include	"gkdb_ver.h"

#ifdef __cplusplus
#include <cstdlib>
#else
#include <stdlib.h>
#endif

#define	COPYRIGHT_SIZE		76			// reserve this size in root page
#define	PF_MODIFIED			0x01		// root page modified flag
#define	PF_PUTPAGE			0x02		// not root page modified flag
#define	PF_PUTATTR			0x04		// attribs modified flag
#define PF_HD_SECTOR_SIZE	512

static const int sizePswdAttr= 25;
static const char tagPswdAttr[]= "Pswd";
static const char tagKIAttr[] = "KI";

#pragma pack(1)
#ifndef DEMO
struct PagedFileHeader {
	int Signature;
	char Copyright[COPYRIGHT_SIZE];
	short PageSize;
	short AttrOffs;
	int LastPage;
	int FreePage;
	int lastFreePage;
	int CRC;
	short isCrypted;
	int TomPerPages;
	char reserved[150];
}__PACKED__;
#else
struct PagedFileHeader {
	int Signature;
	char Copyright[COPYRIGHT_SIZE];
	char reserved[100];
	short AttrOffs;
	short PageSize;
	int LastPage;
	int FreePage;
	int lastFreePage;
	int CRC;
	short isCrypted;
}__PACKED__;
#endif

// указываем на приоритет скорости работы с упакованными страничными файлами
// над потреблением больших линейных участков ОЗУ...
#define BIG_PACKTABLE_IN_MEM
// как задел на будущее, для значительной экономии ОЗУ огромных пакованных комплектов, закоментарив BIG_PACKTABLE_IN_MEM, имеем:
//	Таблица реаллокации пакованных страниц GKDB::PageFile,
//	будет подчитыватся по необходимости маленькими кусучками из первого физического файла
//	при каждом вызове GKDB::PageFile::GetPage, возвращающего(как и сегодня) распакованное тело страницы.
//	см. в mdp.garant.ru коментарий 509695564.

#ifdef  __cplusplus
extern "C" {
#endif
	#define MAX_BYTE_FILE_SIZE 0x7fffffff
	typedef void (*CloseProcess)(int);
	typedef int (*MessageForNext)(void);
	typedef int (*f_SeekFile)(int amode, void *hndls, int nfile, int npos, int whence);
	typedef int (*f_ReadFile)(int amode, void *hndls, int nfile, void *out_buf, int out_size);
	extern int my_def_io_seek(int amode, void *hndls, int nfile, int npos, int whence);
	extern int my_def_io_read(int amode, void *hndls, int nfile, void *out_buf, int out_size);

	typedef struct PFPARAM_TAG
	{
		int		*pFileHandles;
		int		accesMode;
		int		processMode;
		int	page;
		void	*buf;
		char	*FileName;
		unsigned int	maxFile_per_bytes;
		int	*pFilePoss;
		void	*pHeader;
		MessageForNext MessageForNextFunc;
		CloseProcess CloseProcessFunc;
		char *pUncompressBuffer;
		unsigned int *pPackTable;
		int PackArraySize;
		int	currentDisk;
		int	iPost;
		void *pScreenCntxt;
		char *pCrptTag;
		f_SeekFile cur_Seek;
		f_ReadFile cur_Read;
		void *pBase;
#if (!defined(BRDR32) && !defined(BIG_PACKTABLE_IN_MEM))
		char *pStepPackTable;
		int firstPos, currPos;
#endif
	} PF_PARAM, *LPPF_PARAM;
	extern int	otherReadOrWrite	(	LPPF_PARAM );
	extern int DefaultMessageForNextFunc(void);
	extern void DefaultCloseProcessFunc(int);
	extern int	IsNextTom(LPPF_PARAM pPrm);
	extern int otherFileOpen(int, LPPF_PARAM);
	extern int IsLogicalTom(LPPF_PARAM pPrm);

#if defined(MAKE_HDD) || defined(BRDR32) || defined(INSTLL_CIB)
 #if defined(__WIN32__)
	extern int pl_ModifyBase(int, int, int, char **, char *);
 #endif
 extern int pl_UnCryptBase(int, int, char*, char*, char*, int);
 extern void pl_CalcCryptoSizeInBase(int *pRet, long iKeySz, long iStrSz, int DefaultSize);
 extern int pl_GetLoginOffest(); // GARANT_LINKAGE
#endif

#ifdef  __cplusplus
}
#endif

#pragma pack()

#define OLD_STREAM_HANDLE_TO_PAGE(_handle_) ((unsigned int)_handle_ >> 12)
#define OLD_STREAM_HANDLE_TO_ID(_handle_) ((short)( _handle_ & 0x0FFF ))
#define BIG_STREAM_HANDLE_TO_PAGE(_handle_) ((unsigned int)_handle_ >> 5)
#define BIG_STREAM_HANDLE_TO_ID(_handle_,_alloc_) ((short)( ( (_handle_ & 0x1f) << 7) | ( (_alloc_ >> 24) & 0x7f) ))
#define NEW_STREAM_HANDLE_TO_ID(_handle_,_alloc_) ((short)( ( (_handle_ & 0x1f) << 11) | ( (_alloc_ >> 20) & 0x7ff) ))

#ifdef  __cplusplus

#if defined(__GO32__) || defined(__BORLANDC__)
	#define PF_FILE_LOCK(xx) ::lock(xx, 0l, GD_TEXTPAGESIZE)
	#define PF_FILE_UNLOCK(xx) ::unlock(xx, 0l, GD_TEXTPAGESIZE)
#elif defined(_WINDOWS)
	#define PF_FILE_LOCK(xx) _locking(xx, _LK_LOCK, GD_TEXTPAGESIZE)
	#define PF_FILE_UNLOCK(xx) _locking(xx, _LK_UNLCK, GD_TEXTPAGESIZE)
#else
	#define PF_FILE_LOCK(xx) ;
	#define PF_FILE_UNLOCK(xx) ;
#endif

class GSScreen;

#define COPY_BUFF_SIZE 0x2000
#ifndef OLD_CHK_READ
	#define chk__rd(xx, yy, zz, aa) (!(aa->rdStats= 0) && c_io_read(xx, yy, zz) != zz && chk_sleep() && c_io_read(xx, yy, zz) != zz && chk_sleep() && c_io_read(xx, yy, zz) != zz && chk_sleep() && (aa->rdStats= 1))
	#define chk__wr(xx, yy, zz, aa) (!(aa->wrStats= 0) && c_io_write(xx, yy, zz) != zz && chk_sleep() && c_io_write(xx, yy, zz) != zz && chk_sleep() && c_io_write(xx, yy, zz) != zz && chk_sleep() && (aa->wrStats= 1))
#endif

class PagedFile {
public:
	int isPacked;					// 1 if file is packed
	int file;						// handle

	int	m_lstPackedPage;
	int	m_ppreLogicalPage[2];
	char *pBff;						// buffer for pack 
	ACE_UINT64	m_inOther; // GARANT_GCC

	char *cache_tmp_buf, **ppCPages;
	int	Flags;
	unsigned int* pageOffs; // GARANT_MSVC7: type conflict; GARANT_XXX, but seems to be more safe
	GSScreen *pContext;

	char *m_pCryptoTag;
	void SkipWriteSystemBuff() { this->Flags= 0; } // MPCXC debug this-> added

	MessageForNext m_MessageForNextFunc;
	CloseProcess m_CloseProcessFunc;

	char *rbuf;						// file read buffer
	int m_mode;

	int m_postFileHandles[
							MAX_COUNT_FILE_HANDLES+1
#if (defined(__LP64__) || defined(WIN64))
							+ MAX_COUNT_FILE_HANDLES+1
#endif
														];
	int m_postFilePoss[MAX_COUNT_FILE_HANDLES+1];

	int	m_PackArraySize;
	int	m_max_paged_file_per_bytes;

	char FileName [256];	// it's name
	short PageSize;			// size of page in bytes
	int	LastPage;			// max. page #
	int	FreePage;			// ref. to last free page
	int	lastFreePage;		// last freeed page
	short AttrOffs;			// offset to start of attributes
	char* SystemPageBuf;	// buffer to hold 1st page of the file
							// cache statistics
	int	Total;
	int	Hits;
	int	GetFileSizeInKbytes(int AsUnPacked= 0);

	PagedFile (LPPF_PARAM pAttrs);
	PagedFile ( const char *, int mode, int max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE);
	virtual	~PagedFile ();

	virtual	int Connect(const char *, int, int max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE);
	virtual int Delete(int Remove= 0);
	int Remove()
	{
		return this->Delete(1);
	}
	int m_isRemoved;

	void SetFileHandle(int newHandle)
		{	m_postFileHandles[0]= file= newHandle;
			m_postFilePoss[0] = 0l;
		}

	int GetFileHandle() { return file; }

	int	Exist() const
	{
		return file != -1 && SystemPageBuf != 0;
	}
	virtual void abort(void){
		::abort();
	}
	virtual	int IsOk ();
	virtual int IsPacked() const
	{
		return isPacked;
	}
	virtual int IsOpened() const
	{
		return (file != -1);
	}
	virtual int	SignatureValid ();
	void  * AllocBuf ()			// allocate new buffer and zero it
	{
		return calloc ( 1, PageSize );
	}
	void	FreeBuf  ( void * buf )		// free allocated buffer
	{
		free ( buf );
	}
	int GetAttr (const char * name, void * buf, int size);
	int PutAttr (const char * name, void * buf, int size);
	int DelAttr (const char *name);
	virtual	void Create  (short page_size, bool bLockPath= false);
	virtual	int GetPage (int page, void *buf);
	virtual	int PutPage (int page, void *buf);
	virtual	int NewPage ();	// allocate new page
	virtual	int NewContBlock (int);	// allocate continous block of pages
	virtual	void DelPage (int);	// free page
public:
	PF_PARAM m_readed;
	virtual void flushpages(int pcount= -1){};
	int cpn;
	int CloseAllHandles(int startN= 0);
	int FlushAllHandles(int startN, char *reOpenName);
	char *m_postFileNames[MAX_COUNT_FILE_HANDLES+1];
	void free_postFileNames();
	void skip_c_rtl_handle();
};

#endif

int	MemoryError ();

#endif