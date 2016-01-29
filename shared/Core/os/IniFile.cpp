////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/IniFile.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::IniFile
// Файл реализации утилитного набора IniFile
//
// работа с INI-файлом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/os/IniFile.h"

//#UC START# *450034D40290_CUSTOM_INCLUDES*
#include "ace/ACE.h"
#include "ace/OS_String.h"
#include "ace/OS.h"
#include <cstring>
#include <cstdlib>
#include <cassert>
#include <cstdio>

//#UC END# *450034D40290_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *450034D40290*
IniFile::IniFile(const char* lpszFileName)
{
	wMaxBufSize = 49152U;
	memset (lpszProfileName, 0, sizeof(lpszProfileName));
	strcpy (lpszProfileName, lpszFileName);

	memset (lpszProfilePath, 0, sizeof(lpszProfilePath));
	strcpy (lpszProfilePath, lpszProfileName);
    
	size_t len = strlen(lpszProfilePath);

	if (len > 0) {                                          
	    for (size_t i=len-1; i>0; i--) {
			if ((lpszProfilePath[i]=='\\') || (lpszProfilePath[i]=='/'))
				break;
			else
				lpszProfilePath[i]='\0';
	    }
	}
	if (strlen(lpszProfilePath)==1)
		lpszProfilePath[0]='\0'; 

	lpMainBuf = (char*)calloc(1, wMaxBufSize+5);
}


IniFile::~IniFile()
{
	free (lpMainBuf);
}


ACE_UINT16 IniFile::ReadProfileString(const char* lpszSection, const char* lpszEntry, char* lpszBuf, ACE_UINT16* cbSize)
{
	int		file;                    // file handle
	long		dwFileSize;              // file size
	ACE_UINT16	i,k;					 // counters
	char		sect[256];               // full section name (including [])
	char		entry[256];              // full entry name (including =)
	char		rc[2];                   // temporary string
	size_t		wSectionLen;             // section length
	size_t		wEntryLen;               // entry length
	bool		isRequiredSection;       // true if required section is now active
	bool		isSectionFound;
	char*		lpsz;                    // temporary pointer
	char		_0D_0A[2];
	bool		isLastBlock;
	size_t		dwFOfs, dwCurFOfs;
	ACE_UINT16	wNumberOfBytes;

	if (lpMainBuf == 0) {
		return ERR_OUT_OF_MEM;
	}
	memset (lpMainBuf, 0, wMaxBufSize);

	if ((file = ace_os_open (platform_independent_path(lpszProfileName).c_str(), O_RDWR | O_BINARY )) == (-1))
	  return ERR_NO_PROFILE;

	/*  VADIM, LOOK AT THIS WITH ATTENTION !!!!  */
	if ( lpszBuf ) memset (lpszBuf, 0, *cbSize);
	else *cbSize = 0;
	
	dwLastSectionOffset = 0;
	dwLastEntryOffset = 0;

	isSectionFound = false;
	isRequiredSection = false;

	dwFileSize = ace_os_filesize(file);

	memset (rc,    0, sizeof(rc));
	memset (sect,  0, sizeof(sect));
	memset (entry, 0, sizeof(entry));

	_0D_0A[0]=0x0D;
	_0D_0A[1]=0x0A;

	// check 0D,0A at the end of file and write if it's not exist
	ace_os_lseek (file, (dwFileSize-2), SEEK_SET);
	ace_os_read (file, &rc, 1);
	if ((rc[0] != 0x0D) && (rc[0] != 0x0A)) {
		ace_os_lseek (file, dwFileSize, SEEK_SET);
		if (ace_os_write (file, &_0D_0A, sizeof(_0D_0A))==(-1)) {
			ace_os_close (file);
			return ERR_PROFILE_ACCESS_DENIED;
		}
	}
	ace_os_lseek (file, 0, SEEK_SET);

	sprintf(sect, "[%s]", lpszSection);  // sect = '['+lpszSection+']'
	sprintf(entry,"%c%c%s=", 0x0D, 0x0A, lpszEntry);     // entry = 0x0D+0x0A+lpszEntry+'='

	wSectionLen = strlen(sect);
	wEntryLen   = strlen(entry);

	dwFOfs = 0;

	if (dwFileSize > wMaxBufSize) {     // big INI-file
		isLastBlock = false;
		wNumberOfBytes = wMaxBufSize;
	}
	else {                                  // small INI-file
		isLastBlock = true;
		wNumberOfBytes = (ACE_UINT16)dwFileSize;
	}

	do {
	  if (!isLastBlock) {
		if ((long)(dwFOfs + wMaxBufSize) > dwFileSize) {
			wNumberOfBytes = (short)(dwFileSize-dwFOfs+1);
			isLastBlock = true;
		 } else wNumberOfBytes = wMaxBufSize;
	  }
		memset (lpMainBuf, 0, wMaxBufSize);
		ace_os_read (file, (void*)lpMainBuf, wNumberOfBytes);

		if (!isLastBlock) {
			i=0;
			do {
				i++;
				lpsz = lpMainBuf+wNumberOfBytes-i;
			} while (*lpsz != 0x0D);
			wNumberOfBytes -= i;
			wNumberOfBytes += 3;
			dwCurFOfs  = ace_os_lseek(file, 0, SEEK_CUR)-i+3;
			ace_os_lseek(file, (long) dwCurFOfs, SEEK_SET);
		}
		lpsz = lpMainBuf;

		for (i=0; i<wNumberOfBytes; i++) {
			if (*lpsz=='[') {   // it's section
				if (ACE_OS_String::strncasecmp(lpsz, sect, wSectionLen)==0) {   // it's required section
					dwLastSectionOffset = (long) (i+wSectionLen+sizeof(_0D_0A)+dwFOfs);
					dwLastSectionStart = (long) (i+dwFOfs);
					isRequiredSection = true;
					isSectionFound = true;
				}
				else {   // it's NOT required section
					if (isRequiredSection) {
						ace_os_close (file);
						return ERR_NO_ENTRY;
					}
				}
			}
			else {  // it's entry
				if ( (ACE_OS_String::strncasecmp(lpsz,entry,wEntryLen)==0) && (isRequiredSection) )  {
					dwLastEntryOffset = (long) (i+dwFOfs+sizeof(_0D_0A));  //!!!!!!!!!!!!!!!!!!!!!!!
					k=0;
			   do {
						rc[0] = *(lpsz+wEntryLen+k); 
						if ((rc[0]!=0x0D) && (rc[0]!=0x0A) && (rc[0]!=0) && (k<*cbSize) && (lpszBuf != 0)) {
							strcat (lpszBuf, rc);
				  }
				  k++;
			   } while ((rc[0] != 0x0D));

					ace_os_close (file);
					if ((k > *cbSize) || (lpszBuf == 0)) {
						*cbSize = k;
				  return ERR_OUT_OF_DESTBUF;
			   }
			   else {
				   return DEF_SUCCESS;
			   }
				}
			}
			lpsz++;
		}
		dwFOfs += wNumberOfBytes;
	} while (!isLastBlock);

	ace_os_close (file);

	if (!isSectionFound)
		return ERR_NO_SECTION;

	return ERR_NO_ENTRY;
}


ACE_UINT16 IniFile::ReadProfileString(const char* lpszSection, const char* lpszEntry, char* lpszBuf, ACE_UINT16 cbSize)
{
	return ReadProfileString(lpszSection, lpszEntry, lpszBuf, &cbSize);
}


ACE_UINT16 IniFile::ReadProfileLong(const char* lpszSection, const char* lpszEntry, long *value)
{
	char buf[32];
	ACE_UINT16 wRes,wBufSize;

	wBufSize = sizeof(buf);
	memset (buf, 0, wBufSize);
	wRes = ReadProfileString(lpszSection, lpszEntry, buf, &wBufSize);
	if (wRes==DEF_SUCCESS) {
		*value = atol(buf);
	} else {
		*value =0;
	}
	return wRes;
}


ACE_UINT16 IniFile::ReadProfileInt(const char* lpszSection, const char* lpszEntry, int *value)
{
	char buf[32];
	ACE_UINT16 wRes, wBufSize;

	wBufSize = sizeof(buf);
	memset (buf, 0, wBufSize);
	wRes = ReadProfileString(lpszSection, lpszEntry, buf, &wBufSize);
	if (wRes==DEF_SUCCESS) {
		*value = atoi(buf);
	} else {
		*value = 0;
	}
	return wRes;
}


ACE_UINT16 IniFile::CopyBlock(int src, int dest, ACE_UINT32 dwSrcStart, ACE_UINT32 dwSrcEnd)
{
	ACE_UINT16	i,Big,Small;
	ACE_UINT32	dwNumOfBytes;

	if (lpMainBuf == 0) {
		return ERR_OUT_OF_MEM;
	}
	memset (lpMainBuf, 0, wMaxBufSize);

	dwNumOfBytes = dwSrcEnd-dwSrcStart+1;

	Big = (ACE_UINT16)(dwNumOfBytes / wMaxBufSize);
	Small = (ACE_UINT16)(dwNumOfBytes - wMaxBufSize*Big);

	ace_os_lseek (src, dwSrcStart, SEEK_SET);
	ace_os_lseek (dest, ace_os_filesize(dest), SEEK_SET);

	if (Big>0) {
		for (i=1; i<=Big; i++) {
			ace_os_read  (src,  (void*)lpMainBuf, wMaxBufSize);
			ace_os_write (dest, lpMainBuf, wMaxBufSize);
		}
	}
	if (Small>0) {
		ace_os_read  (src,  (void*)lpMainBuf, Small);
		ace_os_write (dest, lpMainBuf, Small);
	}
	return DEF_SUCCESS;
}


ACE_UINT16 IniFile::DeleteEmptySection(const char* lpszSection)
{
	int		file, tmp_file;
	char*		lpsz;
	ACE_UINT16	i;
	ACE_UINT32	dwFileSize;
	bool		isDeleteSection;
	char		TmpName[256];
	
	memset (TmpName, 0, sizeof(TmpName));

	//strcpy (TmpName, tempnam(lpszProfilePath, "DES"));
   strcpy (TmpName, lpszProfilePath);
   strcat (TmpName, "DES_TMP.$1$");

	file = ace_os_open (platform_independent_path(lpszProfileName).c_str(), O_RDONLY | O_BINARY);

	dwFileSize = ace_os_filesize(file);
	memset (lpMainBuf, 0, wMaxBufSize);
	ace_os_lseek (file, dwLastSectionOffset, SEEK_SET);
	ace_os_read (file, (void*)lpMainBuf, wMaxBufSize);

	i=0;
	lpsz = lpMainBuf;
	isDeleteSection = true;

	while ((*lpsz!='[') && (i<wMaxBufSize) && (i<(dwFileSize-dwLastSectionOffset+1))) {
		if ((*lpsz!=0x0D)&&(*lpsz!=0x0A)) {
			isDeleteSection = false;
			break;
		}
		lpsz++;
		i++;
	} // while

	if (isDeleteSection) {
		tmp_file = ace_os_open (platform_independent_path(TmpName).c_str(), O_RDWR | O_BINARY | O_CREAT );
		if (tmp_file == (-1)) {
			ace_os_close (file);
			return ERR_CANT_CREATE_TMPFILE;
		}
		CopyBlock(file, tmp_file, 0, dwLastSectionStart-1);
		CopyBlock(file, tmp_file, (ACE_UINT32) (dwLastSectionStart+strlen(lpszSection)), dwFileSize-1);
		ace_os_close (file);
		ace_os_close (tmp_file);
		ace_os_unlink (platform_independent_path(lpszProfileName).c_str());
		ace_os_rename (platform_independent_path(TmpName).c_str(), platform_independent_path(lpszProfileName).c_str());
		return DEF_SUCCESS;
	} else {
		ace_os_close (file);
	}
	return DEF_SUCCESS;
}


ACE_UINT16 IniFile::WriteProfileString(const char* lpszSection, const char* lpszEntry, const char* lpszValue)
{
	int		file, tmp_file;
	ACE_UINT16	i,wRes;
	char		rc[2];
	char		sect[256];
	char		entry[256];
	char		_0D_0A[2];
	long		dwFileSize;
	char*		lpsz;
	char		TmpFileName[256];

	if (lpMainBuf == 0) {
		return ERR_OUT_OF_MEM;
	}
	memset (lpMainBuf, 0, wMaxBufSize);
	memset (TmpFileName, 0, sizeof(TmpFileName));

	//strcpy (TmpFileName, tempnam(lpszProfilePath, "WPS"));

	strcpy (TmpFileName, lpszProfilePath);
	strcat (TmpFileName, "WPS_TMP.$1!");

	memset (rc,    0, sizeof(rc));
	memset (sect,  0, sizeof(sect));
	memset (entry, 0, sizeof(entry));

	sprintf(sect,"[%s]", lpszSection); // sect = '['+lpszSection+']'
	sprintf(entry, "%s=", lpszEntry);  // entry = lpszEntry+'='

	_0D_0A[0]=0x0D;
	_0D_0A[1]=0x0A;

	wRes = ReadProfileString(lpszSection, lpszEntry, lpMainBuf, &wMaxBufSize);

	if (wRes == ERR_NO_PROFILE)
		file = ace_os_open (platform_independent_path(lpszProfileName).c_str(), O_WRONLY | O_BINARY | O_CREAT);
	else
		file = ace_os_open (platform_independent_path(lpszProfileName).c_str(), O_RDWR | O_BINARY);

	if (file == (-1)) {
		return ERR_PROFILE_ACCESS_DENIED;
   }

	dwFileSize = ace_os_filesize(file);

	switch (wRes) {

		// create new profile, new section and new entry
		case ERR_NO_PROFILE:
			ace_os_write (file, &sect, strlen(sect));
			ace_os_write (file, &_0D_0A, sizeof(_0D_0A));
			ace_os_write (file, &entry, strlen(entry));
			ace_os_write (file, lpszValue, strlen(lpszValue));
			ace_os_write (file, &_0D_0A, sizeof(_0D_0A));
			ace_os_close (file);
			return DEF_SUCCESS;

		// create new section and new entry
		case ERR_NO_SECTION:
			ace_os_lseek (file, dwFileSize, SEEK_SET);
			ace_os_write (file, &_0D_0A, sizeof(_0D_0A));
			ace_os_write (file, &sect, strlen(sect));
			ace_os_write (file, &_0D_0A, sizeof(_0D_0A));
			ace_os_write (file, &entry, strlen(entry));
			ace_os_write (file, lpszValue, strlen(lpszValue));
			ace_os_write (file, &_0D_0A, sizeof(_0D_0A));
			ace_os_close (file);
			return DEF_SUCCESS;

		// create new entry
		case ERR_NO_ENTRY:
			assert ((dwLastSectionOffset>=0) && (dwLastSectionOffset<=dwFileSize));
			tmp_file = ace_os_open (platform_independent_path(TmpFileName).c_str(), O_RDWR | O_BINARY | O_CREAT );
			if (tmp_file==(-1)) {
				ace_os_close (file);
				return ERR_CANT_CREATE_TMPFILE;
			}
			CopyBlock (file, tmp_file, 0, dwLastSectionOffset-1);
			ace_os_write (tmp_file, entry, strlen(entry));
			ace_os_write (tmp_file, lpszValue, strlen(lpszValue));
			ace_os_write (tmp_file, _0D_0A, sizeof(_0D_0A));
			CopyBlock (file, tmp_file, dwLastSectionOffset, dwFileSize-1);
			ace_os_close (file);
			ace_os_close (tmp_file);
			ace_os_unlink (platform_independent_path(lpszProfileName).c_str());
			ace_os_rename (platform_independent_path(TmpFileName).c_str(), platform_independent_path(lpszProfileName).c_str());
			return DEF_SUCCESS;

		// change value
		case DEF_SUCCESS:
			assert ((dwLastSectionOffset>=0) && (dwLastSectionOffset<=dwFileSize));
			assert ((dwLastEntryOffset>=0) && (dwLastEntryOffset<=dwFileSize));
			tmp_file = ace_os_open (platform_independent_path(TmpFileName).c_str(), O_RDWR | O_BINARY | O_CREAT );
			if (tmp_file==(-1)) {
				ace_os_close (file);
				return ERR_CANT_CREATE_TMPFILE;
			}
			CopyBlock (file, tmp_file, 0, dwLastEntryOffset-1);
			if (lpszValue != 0) {
				ace_os_write  (tmp_file, entry, strlen(entry));
				ace_os_write  (tmp_file, lpszValue, strlen(lpszValue));
				ace_os_write  (tmp_file, _0D_0A, sizeof(_0D_0A));
			};
			memset (lpMainBuf, 0, wMaxBufSize);
			ace_os_lseek (file, (long) (dwLastEntryOffset+strlen(entry)), SEEK_SET);
			ace_os_read (file, (void*)lpMainBuf, wMaxBufSize);
			i=0;
			lpsz=lpMainBuf;
			while (*lpsz != 0x0D) {
				i++;
				lpsz++;
			}
			CopyBlock (file, tmp_file, (long) (dwLastEntryOffset + strlen(entry) + i + sizeof(_0D_0A)), dwFileSize-1);
			ace_os_close (file);
			ace_os_close (tmp_file);
			ace_os_unlink(platform_independent_path(lpszProfileName).c_str());
			ace_os_rename(platform_independent_path(TmpFileName).c_str(), platform_independent_path(lpszProfileName).c_str());
			return DeleteEmptySection(sect);

		default:
			ace_os_close (file);
			break;
	}
	return UNKNOWN_ERROR;
}


ACE_UINT16 IniFile::WriteProfileLong(const char* lpszSection, const char* lpszEntry, long value)
{
	char buf[32];
	sprintf(buf,"%ld",value);
	return WriteProfileString(lpszSection, lpszEntry, buf);
}


ACE_UINT16 IniFile::WriteProfileInt(const char* lpszSection, const char* lpszEntry, int value)
{
	char buf[32];
	sprintf(buf,"%d",value);
	return WriteProfileString(lpszSection, lpszEntry, buf);
}


ACE_UINT16 IniFile::ReadAllEntries(const char* lpszSection, char* lpszBuf, ACE_UINT16* cbSize)
{
	#define NOT_EXISTED_SECTION "Vadim V. Ivanov"

	int		file;
	ACE_UINT16	i,wRes,wBufSize;
	long		dwFileSize;
	char*		lpsz;
	char		buf[12];
	char		ch =0 ,t_ch;

	wBufSize = sizeof(buf);

	wRes = ReadProfileString(lpszSection, NOT_EXISTED_SECTION, buf, &wBufSize);
	if (wRes != ERR_NO_ENTRY)
		return wRes;

	file = ace_os_open (platform_independent_path(lpszProfileName).c_str(), O_RDONLY | O_BINARY);
	dwFileSize = ace_os_filesize(file);

	assert((dwLastSectionOffset >= 0) && (dwLastSectionOffset < dwFileSize));
	ace_os_lseek(file, dwLastSectionOffset, SEEK_SET);

	lpsz = lpszBuf;
	
	i=1;
	while ((ace_os_lseek(file, 0, SEEK_CUR)<dwFileSize) && (ch!='[')) {
		ace_os_read (file, &ch, sizeof(ch));
		switch (ch) {
			case '=':
				do {
					ace_os_read (file, &t_ch, sizeof(t_ch));
				} while (t_ch != 0x0A);
				if (i<*cbSize) {
					*lpsz=0;
					lpsz++;
				}
				i++;
				break;

			default:
				if ((ch!=0x0D)&&(ch!=0x0A)&&(i<=*cbSize)&&(ch!='[')) {
					*lpsz=ch;
					lpsz++;
				}
				i++;
				break;
		}
	} // while
	if (i <= *cbSize) {
		*lpsz=0;
		return DEF_SUCCESS;
	}
	else {
		*cbSize=i;
		return ERR_OUT_OF_DESTBUF;
	}
}
//#UC END# *450034D40290*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

