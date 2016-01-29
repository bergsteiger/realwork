#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: pagefile.h,v 1.21 2012/06/13 08:51:23 yaroslav Exp $
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

#ifndef	__PILOT_PAGED_FILE__
#define	__PILOT_PAGED_FILE__

#include <cassert>
#include <cstdlib>

#ifndef PLAIN_GKDB
	#include "exceptions.h"
	#include "ace/OS.h"
#endif

#include "../../../../libs/gkdb/src/pagefile.h"

namespace NdtClone {

extern bool global_IsBlock();
extern void global_Block();
extern void global_check();

#pragma pack(1)
struct  BTInit
{
        int    Root;
        short   Order;
        short   KeyLength;
        int    KeyCount;
        short   Height;
        int    LastId;
};

struct IndexInfo
{
    struct BTInit btinit;
    short  immdatasize; /* size of the data may be stored with the key */
    short  rndv;        /* round value, set to 0 or 1 to disable */
                        /* additional space allocation */
    short nstreams;     /* number of data streams per key */
};

struct IndexRecordData
{
	struct RecordDataHeader {
		int realDataLength;
		int allocatedDataLength;
	} header;
	union RecordData {
		int handle;
		char   bin[4];		
	} data;
};
#pragma pack()

extern "C" int DefValCryptoTag;

class	PagedFile : public ::PagedFile
{
public:
	virtual void abort(void){
		global_Block();
	}
	void *pFirst;
	int curr_last;
	PagedFile ( const char * name, int mode, int database_version )
		: ::PagedFile(name, mode)
	{
		curr_last= 0;
		pFirst= 0;
		if(!::PagedFile::Exist()){
			if(database_version != BASE_DATA_VERSION){
				const char *fndTS= strrchr(name, '.');
				if(fndTS && fndTS[1] == 'k' && fndTS[2] == 0 && (fndTS-name) > 8 && fndTS[-8] <= '9' ){
					((char*)fndTS)[1] = 's';
					ace_os_unlink(name);
					((char*)fndTS)[1] = 'k';
				}
			}
		}
		m_database_version= database_version;
		protected_path_handle= -1;
	}
	PagedFile (  LPPF_PARAM pFile )
		: ::PagedFile(pFile)
	{
		curr_last= 0;
		pFirst= 0;
		if(::PagedFile::Exist()){
			m_database_version= BASE_DATA_VERSION;
		}else
		m_database_version= BASE_DATA_VERSION;
		protected_path_handle= -1;
	}
	virtual	void Create  ( short page_size, bool bLockPath= true )
	{
		PageSize = page_size;
		setFHandle(-2);
		m_mode= ACE_OS_O_RDWR | ACE_OS_O_CREAT;
		if((m_postProtected_path_handle= bLockPath)){
			// See PostCreate()
		}
		if ( ( SystemPageBuf = (char *) calloc ( 1, PageSize+PageSize ) ) == 0 )
			return;
		
		strcpy ( SystemPageBuf + 4, "Garant Database file. Copyright (C) 1990,96 Garant-Service" );

		((PagedFileHeader*)SystemPageBuf)->Signature = m_database_version;
		((PagedFileHeader*)SystemPageBuf)->PageSize = page_size;

		curr_last= LastPage = 0l;
		FreePage     = -1l;
		lastFreePage = -1l;
		AttrOffs     = sizeof(PagedFileHeader);
		if(!m_pCryptoTag)
			m_pCryptoTag= (char*)&DefValCryptoTag;
		m_mode |= ACE_OS_O_BINARY;
	}
	void PostCreate()
	{
		if(m_postProtected_path_handle){
			m_postProtected_path_handle= false;
			{
				static const char msg_err[]= "Cannot open file %s for writing.\n";
				char protected_path_name[1024];
				get_protected_path_name(protected_path_name);
				char *testWriteBuff= (char*)alloca((PageSize&0x7ffff)+(PageSize&0x7ffff));
				if(	(protected_path_handle= c_io_open(protected_path_name, ACE_OS_O_EXCL | ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT )) == -1
					|| c_io_write(protected_path_handle, testWriteBuff, (PageSize&0x7ffff)+(PageSize&0x7ffff))!=(PageSize&0x7ffff)+(PageSize&0x7ffff))
				{
					ace_os_unlink(protected_path_name);
					fprintf(stderr, msg_err, FileName);
#ifdef PLAIN_GKDB
					::abort();
#else
					throw Error ();
#endif
					return;		// and cannot be opened for 
				}
			}
		}
	}
	void get_protected_path_name(char *pOutName)
	{
		strcpy(pOutName, FileName);
		strcat(pOutName, ".tmp");
	}
	virtual	int	IsOk () const // whether file is OK
	{
		if (!this->Exist ()) {
			return 0;
		}
#ifndef BRDR32
		if (((PagedFileHeader*)SystemPageBuf)->Signature == m_database_version)
#endif
		{
			return 1;
		}
#ifdef PLAIN_GKDB
		::abort();
		return 0;
#else
		throw InvalidBaseVersion (m_database_version, ((PagedFileHeader*)SystemPageBuf)->Signature);
#endif
	}
	int database_version () {
		return m_database_version;
	}
	int getFHandle()
	{
		return ::PagedFile::GetFileHandle();
	}
	int setFHandle(int newH)
	{
		::PagedFile::SetFileHandle(newH);
		return newH;
	}
	/*void PagedFile::unlockPath()
	{
		if(IsWithProtectedPath()){
			c_io_close(protected_path_handle);
			protected_path_handle= -1;
			{
				char removedName[1024];
				get_protected_path_name(removedName);
				ace_os_unlink(removedName);
			}
		}
	}*/
	bool IsWithProtectedPath()
	{
		return (protected_path_handle != -1);
	}
	void tmp_as_worked()
	{
		setFHandle(protected_path_handle);
		protected_path_handle= -1;
	}
	int unlink_pre_tmp(const char *);
	int protected_path_handle;
protected:
	int m_database_version;
	bool m_postProtected_path_handle;
};

int	MemoryError ();

} // namespace NdtClone
#endif
