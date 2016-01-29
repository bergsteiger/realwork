////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/IniFile.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::IniFile
//
// работа с INI-файлом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_OS_INIFILE_H__
#define __SHARED_CORE_OS_INIFILE_H__

#include "ace/ACE.h"

//#UC START# *450034D40290_USER_INCLUDES*
#include "ace/Basic_Types.h"
#include "shared/Core/fix/mpcxc.h" //cycle

#define ERR_NO_PROFILE			0x302
#define ERR_NO_SECTION			0x303
#define ERR_NO_ENTRY			0x304
#define ERR_PROFILE_ACCESS_DENIED	0x305

#define ERR_OUT_OF_MEM			0x101
#define ERR_OUT_OF_DESTBUF		0x102

#define ERR_CANT_CREATE_TMPFILE		0x800
#define UNKNOWN_ERROR			0x888
#define DEF_SUCCESS			0

//#UC END# *450034D40290_USER_INCLUDES*

namespace Core {

//#UC START# *450034D40290_USER_DEFINITION*
class IniFile {
private:
	char	lpszProfilePath[256];  // (profile path)
	char	lpszProfileName[256];  // (profile path) + (profile name)
	long	dwLastSectionOffset;
	long	dwLastSectionStart;
	long	dwLastEntryOffset;
	char*	lpMainBuf;
	ACE_UINT16	wMaxBufSize;
	
	ACE_UINT16	CopyBlock(int src, int dest, ACE_UINT32 dwSrcStart, ACE_UINT32 dwSrcEnd);
public:
	IniFile(const char* lpszFileName);
	~IniFile();

	ACE_UINT16	DeleteEmptySection(const char* lpszSection);
	ACE_UINT16	ReadProfileString(const char* lpszSection, const char* lpszEntry, char* lpszBuf, ACE_UINT16* cbSize);
	ACE_UINT16	ReadProfileString(const char* lpszSection, const char* lpszEntry, char* lpszBuf, ACE_UINT16 cbSize);
	ACE_UINT16	ReadProfileLong(const char* lpszSection, const char* lpszEntry, long *value);
	ACE_UINT16	ReadProfileInt(const char* lpszSection, const char* lpszEntry, int *value);

	ACE_UINT16	WriteProfileString(const char* lpszSection, const char* lpszEntry, const char* lpszValue);
	ACE_UINT16	WriteProfileLong(const char* lpszSection, const char* lpszEntry, long value);
	ACE_UINT16	WriteProfileInt(const char* lpszSection, const char* lpszEntry, int value);

	ACE_UINT16	ReadAllEntries(const char* lpszSection, char* lpszBuf, ACE_UINT16* cbSize);
};

//#UC END# *450034D40290_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_OS_INIFILE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
