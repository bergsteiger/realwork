// filesys.h -- filesystem support functions for Windows
// NOTE: no include guard

 #if _WIN32_C_LIB
#define READONLY_PERMS	\
	_Perms(perms::all & ~WRITE_PERMS)
#define WRITE_PERMS	\
	_Perms(perms::owner_write | perms::group_write | perms::others_write)

 #if FILESYS_WIDE
  #define TCHAR		wchar_t
  #define TCHMOD	_wchmod
  #define TFUN(x)	x##W
  #define TLIT(x)	L##x
  #define TSTRING	wstring

	// CRT functions

 #else /* FILESYS_WIDE */
  #define TCHAR		char
  #define TCHMOD	_chmod
  #define TFUN(x)	x##A
  #define TLIT(x)	x
  #define TSTRING	string

	// CRT functions
 #endif /* FILESYS_WIDE */

  #define TAILORED_RETURN(retval)

		// DIRECTORY FUNCTIONS
static TCHAR *_Strcpy(TCHAR (&_Dest)[_MAX_FILESYS_NAME], const TCHAR *_Src)
	{	// copy an NTBS
	TCHAR *_Pdest = _Dest;
	TCHAR *_Ans = _Dest;
	size_t _Left = _MAX_FILESYS_NAME - 1;
	for (; *_Src != TLIT('\0') && 0 < _Left; --_Left)
		*_Pdest++ = *_Src++;
	*_Pdest = TLIT('\0');
	return (_Ans);
	}

 #if FILESYS_WIDE
_FS_DLL TCHAR *_PCDECL _Read_dir(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME], void *_Handle, _File_type& _Ftype)
	{	// read a directory entry
	TFUN(WIN32_FIND_DATA) _Dentry;

	for (; ; )
		if (TFUN(FindNextFile)((HANDLE)_Handle, &_Dentry) == 0)
			{	// fail
			_Ftype = _File_type::unknown;
			return (_Strcpy(_Dest, TLIT("")));
			}
		else if (_Dentry.cFileName[0] == TLIT('.')
			&& (_Dentry.cFileName[1] == TLIT('\0')
				|| (_Dentry.cFileName[1] == TLIT('.')
					&& _Dentry.cFileName[2] == TLIT('\0'))))
			;	// skip "." and ".."
		else
			{	// get file type and return name
			_Ftype = _Map_mode(_Dentry.dwFileAttributes);
			return (_Strcpy(_Dest, &_Dentry.cFileName[0]));
			}
	}

_FS_DLL int _PCDECL _To_wide(const char *_Bsrc, wchar_t *_Wdest)
	{	// return nonzero on success
	return (MultiByteToWideChar(
		AreFileApisANSI() ? CP_THREAD_ACP : CP_OEMCP,
			0, _Bsrc, -1, _Wdest, _MAX_FILESYS_NAME));
	}

_FS_DLL int _PCDECL _To_byte(const wchar_t *_Wsrc, char *_Bdest)
	{	// return nonzero on success
	return (WideCharToMultiByte(
		AreFileApisANSI() ? CP_THREAD_ACP : CP_OEMCP,
			0, _Wsrc, -1, _Bdest, _MAX_FILESYS_NAME, NULL, NULL));
	}

 #else /* FILESYS_WIDE */
_FS_DLL char *_PCDECL _Read_dir(char (&_Dest)[_MAX_FILESYS_NAME],
	void *_Handle, _File_type& _Ftype)
	{	// read a directory entry
	wchar_t _Dest_wide[_MAX_FILESYS_NAME];	// Same size as _Dest
	_Read_dir(_Dest_wide, _Handle, _Ftype);

	// use default ANSI CP and default flags to convert to ANSI
	if (_Dest_wide[0] == L'\0'
		|| _To_byte(_Dest_wide, _Dest) == 0)
		return (_Strcpy(_Dest, ""));

	return (_Dest);
	}
 #endif /* FILESYS_WIDE */

 #if FILESYS_WIDE
 #if _GHS	/* compiler test */
_FS_DLL void *_Open_dir(
	char (&_Dest)[_MAX_FILESYS_NAME], const char *_Dirname, int& _Errno,
	_File_type& _Ftype);

_FS_DLL void *_Open_dir(
	wchar_t (&_Dest)[_MAX_FILESYS_NAME], const wchar_t *_Dirname, int& _Errno,
	_File_type& _Ftype)
	{	// open a directory for reading
	char _Dest_byte[_MAX_FILESYS_NAME];
	char _Dirname_byte[_MAX_FILESYS_NAME];

	if (_To_byte(_Dirname, _Dirname_byte) == 0)
		{	// conversion to wide char failed
		_Errno = ERROR_BAD_PATHNAME;
		*_Dest = L'\0';
		return (0);
		}

	void *_Handle = _Open_dir(_Dest_byte, _Dirname_byte, _Errno, _Ftype);

	// use default ANSI CP and default flags to convert dest to wide
	if (_Dest_byte[0] == '\0'
		|| _To_wide(_Dest_byte, _Dest) == 0)
		*_Dest = L'\0';

	return (_Handle);
	}

 #else /* _GHS */
_FS_DLL void *_PCDECL _Open_dir(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME], const TCHAR *_Dirname, int& _Errno,
	_File_type& _Ftype)
	{	// open a directory for reading
	TFUN(WIN32_FIND_DATA) _Dentry;
	TSTRING _Wildname(_Dirname);
	if (!_Wildname.empty())
		_Wildname.append(TLIT("\\*"));

	void *_Handle = TFUN(FindFirstFileEx)(_Wildname.c_str(),
		FindExInfoStandard, &_Dentry, FindExSearchNameMatch, NULL, 0);
	if (_Handle == INVALID_HANDLE_VALUE)
		{	// report failure
		_Errno = ERROR_BAD_PATHNAME;
		*_Dest = TLIT('\0');
		return (0);
		}
	else
		{	// success, get first directory entry
		_Errno = 0;
		if (_Dentry.cFileName[0] == TLIT('.')
			&& (_Dentry.cFileName[1] == TLIT('\0')
				|| _Dentry.cFileName[1] == TLIT('.')
					&& _Dentry.cFileName[2] == TLIT('\0')))
			{	// skip "." and ".."
			_Read_dir(_Dest, _Handle, _Ftype);
			if (_Dest[0] != TLIT('\0'))
				return (_Handle);
			else
				{	// no entries, release handle
				_Close_dir(_Handle);
				return (0);
				}
			}
		else
			{	// get file type and return handle
			_Strcpy(_Dest, &_Dentry.cFileName[0]);
			_Ftype = _Map_mode(_Dentry.dwFileAttributes);
			return (_Handle);
			}
		}
	}
 #endif /* _GHS */

 #else /* FILESYS_WIDE */
 #if _GHS	/* compiler test */
_FS_DLL void *_Open_dir(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME], const TCHAR *_Dirname, int& _Errno,
	_File_type& _Ftype)
	{	// open a directory for reading
	TFUN(WIN32_FIND_DATA) _Dentry;
	TSTRING _Wildname(_Dirname);
	if (!_Wildname.empty())
		_Wildname.append(TLIT("\\*"));

	void *_Handle = FindFirstFile(_Wildname.c_str(), &_Dentry);
	if (_Handle == INVALID_HANDLE_VALUE)
		{	// report failure
		_Errno = ERROR_BAD_PATHNAME;
		*_Dest = TLIT('\0');
		return (0);
		}
	else
		{	// success, get first directory entry
		_Errno = 0;
		if (_Dentry.cFileName[0] == TLIT('.')
			&& (_Dentry.cFileName[1] == TLIT('\0')
				|| _Dentry.cFileName[1] == TLIT('.')
					&& _Dentry.cFileName[2] == TLIT('\0')))
			{	// skip "." and ".."
			_Read_dir(_Dest, _Handle, _Ftype);
			if (_Dest[0] != TLIT('\0'))
				return (_Handle);
			else
				{	// no entries, release handle
				_Close_dir(_Handle);
				return (0);
				}
			}
		else
			{	// get file type and return handle
			_Strcpy(_Dest, &_Dentry.cFileName[0]);
			_Ftype = _Map_mode(_Dentry.dwFileAttributes);
			return (_Handle);
			}
		}
	}

 #else /* _GHS */
_FS_DLL void *_PCDECL _Open_dir(
	char (&_Dest)[_MAX_FILESYS_NAME], const char *_Dirname, int& _Errno,
	_File_type& _Ftype)
	{	// open a directory for reading
	wchar_t _Dest_wide[_MAX_FILESYS_NAME];
	wchar_t _Dirname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Dirname, _Dirname_wide) == 0)
		{	// conversion to wide char failed
		_Errno = ERROR_BAD_PATHNAME;
		*_Dest = '\0';
		return (0);
		}

	void *_Handle = _Open_dir(_Dest_wide, _Dirname_wide, _Errno, _Ftype);

	// use default ANSI CP and default flags to convert dest to ANSI
	if (_Dest_wide[0] == L'\0'
		|| _To_byte(_Dest_wide, _Dest) == 0)
		*_Dest = '\0';

	return (_Handle);
	}
 #endif /* _GHS */
 #endif /* FILESYS_WIDE */

_FS_DLL bool _PCDECL _Current_get(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME])
	{	// get current working directory
	return (TFUN(GetCurrentDirectory)(_MAX_FILESYS_NAME, &_Dest[0]) != 0);
	}

_FS_DLL bool _PCDECL _Current_set(const TCHAR *_Dirname)
	{	// set current working directory
	return (TFUN(SetCurrentDirectory)(_Dirname) != 0);
	}

_FS_DLL TCHAR *_PCDECL _Symlink_get(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME], const TCHAR *)
	{	// get symlink -- DUMMY
	_Dest[0] = TCHAR(0);
	return (&_Dest[0]);
	}

 #if FILESYS_WIDE
_FS_DLL TCHAR *_PCDECL _Temp_get(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME])
	{	// get temp directory
	TCHAR _Dentry[MAX_PATH];
	return (_Strcpy(_Dest,
		TFUN(GetTempPath)(MAX_PATH, &_Dentry[0]) == 0
			? TLIT(".") : &_Dentry[0]));
	}

 #else /* FILESYS_WIDE */
_FS_DLL TCHAR *_PCDECL _Temp_get(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME])
	{	// get temp directory
 #if defined(_CRT_APP)
	return (_Strcpy(_Dest, TLIT(".")));	// no support

 #else /* defined(_CRT_APP) */
	TCHAR _Dentry[MAX_PATH];
	return (_Strcpy(_Dest,
		TFUN(GetTempPath)(MAX_PATH, &_Dentry[0]) == 0
			? TLIT(".") : &_Dentry[0]));
 #endif /* defined(_CRT_APP) */
	}
 #endif /* FILESYS_WIDE */

_FS_DLL int _PCDECL _Make_dir(const TCHAR *_Fname,
	const TCHAR *)
	{	// make a new directory (ignore attributes)
	int _Ans = TFUN(CreateDirectory)(_Fname, 0);

	if (_Ans != 0)
		return (1);
	else if (GetLastError() == ERROR_ALREADY_EXISTS)
		return (0);
	else
		return (-1);
	}

_FS_DLL bool _PCDECL _Remove_dir(const TCHAR *_Fname)
	{	// remove a directory
	return (TFUN(RemoveDirectory)(_Fname) != 0);
	}

		// FILE STATUS FUNCTIONS
 #if FILESYS_WIDE
_FS_DLL _File_type _PCDECL _Stat(const TCHAR *_Fname, _Perms *_Pmode)
	{	// get file status
	WIN32_FILE_ATTRIBUTE_DATA _Data;

	if (TFUN(GetFileAttributesEx)(_Fname, GetFileExInfoStandard, &_Data))
		{	// get file type and return permissions
		if (_Pmode != 0)
			*_Pmode = _Data.dwFileAttributes & FILE_ATTRIBUTE_READONLY
				? READONLY_PERMS : perms::all;
		return (_Map_mode(_Data.dwFileAttributes));
		}
	else
		{	// invalid, get error code
		int _Errno = GetLastError();

		if (_Errno == ERROR_BAD_NETPATH
			|| _Errno == ERROR_BAD_PATHNAME
			|| _Errno == ERROR_FILE_NOT_FOUND
			|| _Errno == ERROR_INVALID_DRIVE
			|| _Errno == ERROR_INVALID_NAME
			|| _Errno == ERROR_INVALID_PARAMETER
			|| _Errno == ERROR_PATH_NOT_FOUND)
			return (_File_type::not_found);
		else
			return (_File_type::unknown);
		}
	}

 #else /* FILESYS_WIDE */
_FS_DLL _File_type _PCDECL _Stat(const char *_Fname, _Perms *_Pmode)
	{	// get file status
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname, _Fname_wide) != 0)
		return (_Stat(_Fname_wide, _Pmode));
	else
		return (_File_type::unknown);
	}
 #endif /* FILESYS_WIDE */

_FS_DLL _File_type _PCDECL _Lstat(const TCHAR *_Fname, _Perms *_Pmode)
	{	// get symlink file status
	return (_Stat(_Fname, _Pmode));	// symlink not supported
	}

 #if FILESYS_WIDE
_FS_DLL _ULonglong _PCDECL _Hard_links(const TCHAR *_Fname)
	{	// get hard link count
  #if defined (_CRT_APP)
	_FILE_STANDARD_INFO _Info = {0};
	bool _Ok = false;

	HANDLE _Handle = CreateFile2(_Fname, FILE_READ_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		OPEN_EXISTING, 0);
	if (_Handle != INVALID_HANDLE_VALUE)
		{	// get file info
		_Ok = GetFileInformationByHandleEx(_Handle, FileStandardInfo,
			&_Info, sizeof(_Info)) != 0;
		CloseHandle(_Handle);
		}
	return (_Ok ? _Info.NumberOfLinks : (_ULonglong)-1);

  #else /* defined(_CRT_APP) */
	BY_HANDLE_FILE_INFORMATION _Info = {0};
	bool _Ok = false;

	HANDLE _Handle = TFUN(CreateFile)(_Fname, FILE_READ_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		0, OPEN_EXISTING, 0, 0);
	if (_Handle != INVALID_HANDLE_VALUE)
		{	// get file info
		_Ok = GetFileInformationByHandle(_Handle, &_Info) != 0;
		CloseHandle(_Handle);
		}
	return (_Ok ? _Info.nNumberOfLinks : (_ULonglong)-1);
  #endif /* defined(_CRT_APP) */
	}

 #else /* FILESYS_WIDE */
_FS_DLL _ULonglong _PCDECL _Hard_links(const TCHAR *_Fname)
	{	// get hard link count
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname, _Fname_wide) == 0)
		return ((_ULonglong)-1);
	else
		return (_Hard_links(_Fname_wide));
	}
 #endif /* FILESYS_WIDE */

 #if FILESYS_WIDE
_FS_DLL _ULonglong _PCDECL _File_size(const TCHAR *_Fname)
	{	// get file size
	WIN32_FILE_ATTRIBUTE_DATA _Data;

	if (!TFUN(GetFileAttributesEx)(_Fname, GetFileExInfoStandard, &_Data))
		return ((_ULonglong)-1);
	else
		return ((_ULonglong)_Data.nFileSizeHigh << 32 | _Data.nFileSizeLow);
	}

 #else /* FILESYS_WIDE */
_FS_DLL _ULonglong _PCDECL _File_size(const char *_Fname)
	{	// get file size
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname, _Fname_wide) == 0)
		return ((_ULonglong)-1);
	else
		return (_File_size(_Fname_wide));
	}
 #endif /* FILESYS_WIDE */

// 3 centuries with 24 leap years each:
//		1600 is excluded, 1700/1800 are not leap years
// 1 partial century with 17 leap years:
//		1900 is not a leap year
//		1904 is leap year #1
//		1908 is leap year #2
//		1968 is leap year #17

 #define WIN_TICKS_PER_SECOND	10000000ULL

 #define WIN_TICKS_FROM_EPOCH \
	(((1970 - 1601) * 365 + 3 * 24 + 17) * 86400ULL * WIN_TICKS_PER_SECOND)

 #if FILESYS_WIDE
_FS_DLL int64_t _PCDECL _Last_write_time(const TCHAR *_Fname)
	{	// get last write time
	WIN32_FILE_ATTRIBUTE_DATA _Data;

	if (!TFUN(GetFileAttributesEx)(_Fname, GetFileExInfoStandard, &_Data))
		return (-1);
	else
		{	// success, convert time
		_ULonglong _Wtime =
			(_ULonglong)_Data.ftLastWriteTime.dwHighDateTime << 32
				| _Data.ftLastWriteTime.dwLowDateTime;
		return ((int64_t)(_Wtime - WIN_TICKS_FROM_EPOCH));
		}
	}

 #else /* FILESYS_WIDE */
_FS_DLL int64_t _PCDECL _Last_write_time(const char *_Fname)
	{	// get last write time
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname, _Fname_wide) == 0)
		return (-1);
	else
		return (_Last_write_time(_Fname_wide));
	}
 #endif /* FILESYS_WIDE */

 #if FILESYS_WIDE
_FS_DLL int _PCDECL _Set_last_write_time(const TCHAR *_Fname,
	int64_t _When)
	{	// set last write time
  #if defined(_CRT_APP)
	HANDLE _Handle = CreateFile2(_Fname, FILE_WRITE_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		OPEN_EXISTING, 0);
  #else /* defined(_CRT_APP) */
	HANDLE _Handle = TFUN(CreateFile)(_Fname, FILE_WRITE_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		0, OPEN_EXISTING, 0, 0);
  #endif /* defined(_CRT_APP) */

	if (_Handle == INVALID_HANDLE_VALUE)
		return (0);
	else
		{	// convert time_t to FILETIME and set
		_ULonglong _Wtime = (_ULonglong)_When + WIN_TICKS_FROM_EPOCH;
		FILETIME _Ftime;

		_Ftime.dwLowDateTime = (DWORD)_Wtime;
		_Ftime.dwHighDateTime = (DWORD)(_Wtime >> 32);
		SetFileTime(_Handle, 0, 0, &_Ftime);
		CloseHandle(_Handle);
		return (1);
		}
	}

 #else /* FILESYS_WIDE */
_FS_DLL int _PCDECL _Set_last_write_time(const char *_Fname, int64_t _When)
	{	// set last write time
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname, _Fname_wide) == 0)
		return (0);
	else
		return (_Set_last_write_time(_Fname_wide, _When));
	}
 #endif /* FILESYS_WIDE */

 #if FILESYS_WIDE
_FS_DLL space_info _PCDECL _Statvfs(const TCHAR *_Fname)
	{	// get space information for volume
	space_info _Ans = {(uintmax_t)-1, (uintmax_t)-1, (uintmax_t)-1};
	TSTRING _Devname = _Fname;

	if (_Devname.empty()
		|| _Devname.back() != TLIT('/') && _Devname.back() != TLIT('\\'))
		_Devname.append(TLIT("/"));
	_ULARGE_INTEGER _Available, _Capacity, _Free;

	if (TFUN(GetDiskFreeSpaceEx)(_Devname.c_str(),
		&_Available, &_Capacity, &_Free))
		{	// convert values
		_Ans.capacity = _Capacity.QuadPart;
		_Ans.free = _Free.QuadPart;
		_Ans.available = _Available.QuadPart;
		}
	return (_Ans);
	}

 #else /* FILESYS_WIDE */
_FS_DLL space_info _PCDECL _Statvfs(const char *_Fname)
	{	// get space information for volume
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];
	space_info _Ans = {(uintmax_t)-1, (uintmax_t)-1, (uintmax_t)-1};

	if (_To_wide(_Fname, _Fname_wide) == 0)
		return (_Ans);
	else
		return (_Statvfs(_Fname_wide));
	}
 #endif /* FILESYS_WIDE */

 #if FILESYS_WIDE
_FS_DLL int _PCDECL _Equivalent(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// test for equivalent file names
  #if defined (_CRT_APP)
	_FILE_ID_INFO _Info1 = {0};
	_FILE_ID_INFO _Info2 = {0};
	bool _Ok1 = false;
	bool _Ok2 = false;

	HANDLE _Handle = CreateFile2(_Fname1, FILE_READ_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		OPEN_EXISTING, 0);
	if (_Handle != INVALID_HANDLE_VALUE)
		{	// get file1 info
		_Ok1 = GetFileInformationByHandleEx(_Handle, FileIdInfo,
			&_Info1, sizeof(_Info1)) != 0;
		CloseHandle(_Handle);
		}

	_Handle = CreateFile2(_Fname2, FILE_READ_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		OPEN_EXISTING, 0);
	if (_Handle != INVALID_HANDLE_VALUE)
		{	// get file2 info
		_Ok2 = GetFileInformationByHandleEx(_Handle, FileIdInfo,
			&_Info2, sizeof(_Info2)) != 0;
		CloseHandle(_Handle);
		}

	if (!_Ok1 && !_Ok2)
		return (-1);
	else if (!_Ok1 || !_Ok2)
		return (0);
	else
		{	// test existing files for equivalence
		return (_Info1.VolumeSerialNumber != _Info2.VolumeSerialNumber
			|| memcmp(&_Info1.FileId, &_Info2.FileId, sizeof(_Info1.FileId)) != 0
				? 0 : 1);
		}

  #else /* defined(_CRT_APP) */
	BY_HANDLE_FILE_INFORMATION _Info1 = {0};
	BY_HANDLE_FILE_INFORMATION _Info2 = {0};
	bool _Ok1 = false;
	bool _Ok2 = false;

	HANDLE _Handle = TFUN(CreateFile)(_Fname1, FILE_READ_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		0, OPEN_EXISTING, 0, 0);
	if (_Handle != INVALID_HANDLE_VALUE)
		{	// get file1 info
		_Ok1 = GetFileInformationByHandle(_Handle, &_Info1) != 0;
		CloseHandle(_Handle);
		}

	_Handle = TFUN(CreateFile)(_Fname2, FILE_READ_ATTRIBUTES,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		0, OPEN_EXISTING, 0, 0);
	if (_Handle != INVALID_HANDLE_VALUE)
		{	// get file2 info
		_Ok2 = GetFileInformationByHandle(_Handle, &_Info2) != 0;
		CloseHandle(_Handle);
		}

	if (!_Ok1 && !_Ok2)
		return (-1);
	else if (!_Ok1 || !_Ok2)
		return (0);
	else
		{	// test existing files for equivalence
		return (_Info1.dwVolumeSerialNumber != _Info2.dwVolumeSerialNumber
			|| _Info1.nFileIndexHigh != _Info2.nFileIndexHigh
			|| _Info1.nFileIndexLow != _Info2.nFileIndexLow
				? 0 : 1);
		}
  #endif /* defined(_CRT_APP) */
	}

 #else /* FILESYS_WIDE */
_FS_DLL int _PCDECL _Equivalent(const char *_Fname1,
	const char *_Fname2)
	{	// test for equivalent file names
	wchar_t _Fname1_wide[_MAX_FILESYS_NAME];
	wchar_t _Fname2_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname1, _Fname1_wide) == 0
		|| _To_wide(_Fname2, _Fname2_wide) == 0)
		return (-1);
	else
		return (_Equivalent(_Fname1_wide, _Fname2_wide));
	}
 #endif /* FILESYS_WIDE */

		// FILE LINKAGE FUNCTIONS
 #if _HAS_HARDLINKS
_FS_DLL int _PCDECL _Link(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// link _Fname2 to _Fname1
	TAILORED_RETURN(errno = EDOM);	// no support

	return (TFUN(CreateHardLink)(_Fname2, _Fname1, 0) != 0
		? 0 : GetLastError());
	}

 #else /* _HAS_HARDLINKS */
_FS_DLL int _PCDECL _Link(const TCHAR *, const TCHAR *)
	{	// link _Fname2 to _Fname1
	return (errno = EDOM);	// hardlinks not supported
	}
 #endif /* _HAS_HARDLINKS */

 #if _HAS_SYMLINKS
_FS_DLL int _PCDECL _Symlink(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// link _Fname2 to _Fname1
	TAILORED_RETURN(errno = EDOM);	// no support

	return (TFUN(CreateSymbolicLink)(_Fname2, _Fname1, 0) != 0
		? 0 : GetLastError());
	}

 #else /* _HAS_SYMLINKS */
_FS_DLL int _PCDECL _Symlink(const TCHAR *, const TCHAR *)
	{	// link _Fname2 to _Fname1
	return (errno = EDOM);	// symlinks not supported
	}
 #endif /* _HAS_SYMLINKS */

_FS_DLL int _PCDECL _Rename(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// rename _Fname1 as _Fname2
	return (TFUN(MoveFile)(_Fname1, _Fname2) != 0
		? 0 : GetLastError());
	}

 #if FILESYS_WIDE
_FS_DLL int _PCDECL _Resize(const TCHAR *_Fname, uintmax_t _Newsize)
	{	// change file size
	bool _Ok = false;

  #if defined (_CRT_APP)
	HANDLE _Handle = CreateFile2(_Fname, FILE_GENERIC_WRITE,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		OPEN_EXISTING, 0);
  #else /* defined(_CRT_APP) */
	HANDLE _Handle = TFUN(CreateFile)(_Fname, FILE_GENERIC_WRITE,
		FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
		0, OPEN_EXISTING, 0, 0);
  #endif /* defined(_CRT_APP) */

	if (_Handle != INVALID_HANDLE_VALUE)
		{	// set file pointer to new size and trim
		LARGE_INTEGER _Large;
		_Large.QuadPart = _Newsize;
		_Ok = SetFilePointerEx(_Handle, _Large, 0, FILE_BEGIN) != 0
			&& SetEndOfFile(_Handle) != 0;
		CloseHandle(_Handle);
		}
	return (_Ok ? 0 : GetLastError());
	}

 #else /* FILESYS_WIDE */
_FS_DLL int _PCDECL _Resize(const TCHAR *_Fname, uintmax_t _Newsize)
	{	// change file size
	wchar_t _Fname_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname, _Fname_wide) == 0)
		return (-1);
	else
		return (_Resize(_Fname_wide, _Newsize));
	}
 #endif /* FILESYS_WIDE */

_FS_DLL int _PCDECL _Unlink(const TCHAR *_Fname)
	{	// unlink _Fname
	return (TFUN(DeleteFile)(_Fname) != 0
		? 0 : GetLastError());
	}

 #if FILESYS_WIDE
_FS_DLL int _PCDECL _Copy_file(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// copy _Fname1 to _Fname2
 #if defined(_ONECORE) || defined(_KERNELX)
	COPYFILE2_EXTENDED_PARAMETERS _Params = {0};
	_Params.dwSize = sizeof(COPYFILE2_EXTENDED_PARAMETERS);
	_Params.dwCopyFlags = 0;

	return (SUCCEEDED(CopyFile2(_Fname1, _Fname2, &_Params))
		? 0 : GetLastError());

 #else /* defined(_ONECORE) || defined(_KERNELX) */
	return (TFUN(CopyFile)(_Fname1, _Fname2, 0) != 0
		? 0 : GetLastError());
 #endif /* defined(_ONECORE) || defined(_KERNELX) */
	}

 #else /* FILESYS_WIDE */
_FS_DLL int _PCDECL _Copy_file(const char *_Fname1, const char *_Fname2)
	{	// copy _Fname1 to _Fname2
	wchar_t _Fname1_wide[_MAX_FILESYS_NAME];
	wchar_t _Fname2_wide[_MAX_FILESYS_NAME];

	if (_To_wide(_Fname1, _Fname1_wide) == 0
		|| _To_wide(_Fname2, _Fname2_wide) == 0)
		return (GetLastError());
	else
		return (_Copy_file(_Fname1_wide, _Fname2_wide));
	}
 #endif /* FILESYS_WIDE */

_FS_DLL int _PCDECL _Chmod(const TCHAR *_Fname, _Perms _Newmode)
	{	// change file mode to _Newmode
	WIN32_FILE_ATTRIBUTE_DATA _Data;

	if (!TFUN(GetFileAttributesEx)(_Fname, GetFileExInfoStandard, &_Data))
		return (-1);
	else
		{	// got mode, alter readonly bit
		DWORD _Oldmode = _Data.dwFileAttributes;
		DWORD _Mode = _Oldmode & ~FILE_ATTRIBUTE_READONLY;
		if ((_Newmode & WRITE_PERMS) == perms::none)
			_Mode |= FILE_ATTRIBUTE_READONLY;
		return (_Mode == _Oldmode ? 0
			: TFUN(SetFileAttributes)(_Fname, _Mode) != 0 ? 0 : -1);
		}
	}

  #undef FILESYS_WIDE
  #undef TCHAR
  #undef TCHMOD
  #undef TFUN
  #undef TLIT
  #undef TSTRING


  #undef READONLY_PERMS
  #undef WRITE_PERMS

 #elif _HAS_POSIX_C_LIB

#define ALL_PERMS	(S_IRWXU | S_IRWXG | S_IRWXO)

 #if FILESYS_WIDE
  #define NARROWED(dest, src)	dest
  #define STRNARROW(dest, src)	_Strcpy_narrow(dest, src)
  #define STRWIDEN(dest, src)	_Strcpy_widen(dest, src)
  #define TEMPBUF(temp)			char temp[_MAX_FILESYS_NAME];
  #define TCHAR		wchar_t
  #define TFUN(x)	w##x
  #define TLIT(x)	L##x

 #else /* FILESYS_WIDE */
  #define NARROWED(dest, src)	src
  #define STRNARROW(temp, src)	src
  #define STRWIDEN(dest, src)	_Strcpy(dest, src)
  #define TEMPBUF(temp)
  #define TCHAR		char
  #define TFUN(x)	x
  #define TLIT(x)	x
 #endif /* FILESYS_WIDE */

static TCHAR *_Strcpy(TCHAR *_Dest, const TCHAR *_Src)
	{	// copy an NTBS
	TCHAR *_Ans = _Dest;
	size_t _Left = _MAX_FILESYS_NAME - 1;
	for (; *_Src != TLIT('\0') && 0 < _Left; --_Left)
		*_Dest++ = *_Src++;
	*_Dest = TLIT('\0');
	return (_Ans);
	}

TCHAR *_Read_dir(TCHAR (&_Dest)[_MAX_FILESYS_NAME], void *_Handle,
	_File_type& _Ftype)
	{	// read a directory entry
	struct dirent *_Pdentry = 0;
	struct dirent _Dentry;

	for (; ; )
		if (readdir_r((DIR *)_Handle, &_Dentry, &_Pdentry) != 0
			|| _Pdentry == 0)
			{	// fail
			_Ftype = _File_type::unknown;
			return (_Strcpy(_Dest, TLIT("")));
			}
		else if (_Dentry.d_name[0] == '.'
			&& (_Dentry.d_name[1] == '\0'
				|| (_Dentry.d_name[1] == '.'
					&& _Dentry.d_name[2] == '\0')))
			;	// skip "." and ".."
		else
			{	// get file type and return name
 #ifndef _DT_REG
			_Ftype = _File_type::unknown;

 #else /* _DT_REG */
			if (_Dentry.d_type == DT_REG)
				_Ftype = _File_type::regular;
			else if (_Dentry.d_type == DT_DIR)
				_Ftype = _File_type::directory;
			else if (_Dentry.d_type == DT_LNK)
				_Ftype = _File_type::symlink;
			else if (_Dentry.d_type == DT_BLK)
				_Ftype = _File_type::block;
			else if (_Dentry.d_type == DT_CHR)
				_Ftype = _File_type::character;
			else if (_Dentry.d_type == DT_FIFO)
				_Ftype = _File_type::fifo;
  #ifdef S_ISSOCK
			else if (_Dentry.d_type == DT_SOCK)
				_Ftype = _File_type::socket;
  #endif /* S_ISSOCK */
			else
				_Ftype = _File_type::unknown;
 #endif /* DT_REG */
			return (STRWIDEN(_Dest, &_Dentry.d_name[0]));
			}
	}

void *_Open_dir(TCHAR (&_Dest)[_MAX_FILESYS_NAME], const TCHAR *_Dirname,
	int& _Errno, _File_type& _Ftype)
	{	// open a directory for reading
	TEMPBUF(_Xname)

	errno = 0;
	void *_Handle = opendir(STRNARROW(_Xname, _Dirname));
	if (_Handle == 0)
		{	// failed, return null handle
		_Errno = errno;
		return (0);
		}
	else
		{	// read first entry
		_Errno = 0;
		_Read_dir(_Dest, _Handle, _Ftype);
		if (_Dest[0] != TLIT('\0'))
			return (_Handle);
		else
			{	// no entries, release handle
			_Close_dir(_Handle);
			return (0);
			}
		}
	}

bool _Current_get(TCHAR (&_Dest)[_MAX_FILESYS_NAME])
	{	// get current working directory
	struct dirent _Dentry;	// for d_name buffer

	if (getcwd(&_Dentry.d_name[0], sizeof (_Dentry.d_name)) == 0)
		{	// fail, copy empty string and return failure
		STRWIDEN(_Dest, "");
		return (false);
		}
	else
		{	// success, copy name and return success
		STRWIDEN(_Dest, &_Dentry.d_name[0]);
		return (true);
		}
	}

bool _Current_set(const TCHAR *_Dirname)
	{	// set current working directory
	TEMPBUF(_Xname)

	return (chdir(STRNARROW(_Xname, _Dirname)) == 0);
	}

TCHAR *_PCDECL _Symlink_get(
	TCHAR (&_Dest)[_MAX_FILESYS_NAME], const TCHAR *_Name)
	{	// get symlink
	char _Buf[_MAX_FILESYS_NAME];
	TEMPBUF(_Xname)

	int _Size = readlink(STRNARROW(_Xname, _Name), _Buf, _MAX_FILESYS_NAME);
	_Buf[0 < _Size ? _Size : 0] = '\0';
	return (STRWIDEN(_Dest, &_Buf[0]));
	}

TCHAR *_PCDECL _Temp_get(TCHAR (&_Dest)[_MAX_FILESYS_NAME])
	{	// get temp directory
	const char *_Dirp;
	int _Errno;

	if ((_Dirp = getenv("TMPDIR")) != 0
		|| (_Dirp = getenv("TMP")) != 0
		|| (_Dirp = getenv("TEMP")) != 0
		|| (_Dirp = getenv("TEMPDIR")) != 0)
		return (STRWIDEN(_Dest, _Dirp));
	else
		return (_Strcpy(_Dest, TLIT("/tmp")));
	}

int _Make_dir(const TCHAR *_Fname,
	const TCHAR *_Attrs)
	{	// make a new directory
	TEMPBUF(_Xname)
	mode_t _Mode = ALL_PERMS;

	errno = 0;
	if (_Attrs != 0)
		{	// get mode bit from _Attrs
		struct stat _Status;
		if (stat(STRNARROW(_Xname, _Attrs), &_Status) != 0)
			return (-1);
		_Mode = _Status.st_mode;
		}
	if (mkdir(STRNARROW(_Xname, _Fname), _Mode) == 0)
		return (1);
	else if (errno == EEXIST)
		return (0);
	else
		return (-1);
	}

bool _Remove_dir(const TCHAR *_Fname)
	{	// remove a directory
	TEMPBUF(_Xname)

	return (rmdir(STRNARROW(_Xname, _Fname)) == 0);
	}

		// FILE STATUS FUNCTIONS
_File_type _Stat(const TCHAR *_Fname, _Perms *_Pmode)
	{	// get file status
	struct stat _Status;
	TEMPBUF(_Xname)
	_File_type _Ans;

	errno = 0;
	if (stat(STRNARROW(_Xname, _Fname), &_Status) == 0)
		{	// get file type and return permissions
		if (_Pmode != 0)
			*_Pmode = (_Perms)(_Status.st_mode & (int)perms::mask);
		_Ans = _Map_mode(_Status.st_mode);
		}
	else if (errno == ENOENT || errno == ENOTDIR)
		_Ans = _File_type::not_found;
	else
		_Ans = _File_type::unknown;
	return (_Ans);
	}

_File_type _Lstat(const TCHAR *_Fname, _Perms *_Pmode)
	{	// get file/symlink status
	struct stat _Status;
	TEMPBUF(_Xname)
	_File_type _Ans;

	errno = 0;
 #ifdef S_ISSYM
	if (lstat(STRNARROW(_Xname, _Fname), &_Status) == 0)
 #else /* defined S_ISSYM */
	if (stat(STRNARROW(_Xname, _Fname), &_Status) == 0)
 #endif /* defined S_ISSYM */
		{	// get file type and return permissions
		if (_Pmode != 0)
			*_Pmode = (_Perms)(_Status.st_mode & (int)perms::mask);
		_Ans = _Map_mode(_Status.st_mode);
		}
	else if (errno == ENOENT || errno == ENOTDIR)
		_Ans = _File_type::not_found;
	else
		_Ans = _File_type::unknown;
	return (_Ans);
	}

_ULonglong _File_size(const TCHAR *_Fname)
	{	// get file size
	struct stat _Status;
	TEMPBUF(_Xname)

	return (stat(STRNARROW(_Xname, _Fname), &_Status) == 0
		? _Status.st_size : (_ULonglong)-1);
	}

_ULonglong _Hard_links(const TCHAR *_Fname)
	{	// get hard link count
	struct stat _Status;
	TEMPBUF(_Xname)

	return (stat(STRNARROW(_Xname, _Fname), &_Status) == 0
		? _Status.st_nlink : (_ULonglong)-1);
	}

int64_t _Last_write_time(const TCHAR *_Fname)
	{	// get last write time
	struct stat _Status;
	TEMPBUF(_Xname)

	return (stat(STRNARROW(_Xname, _Fname), &_Status) == 0
		? _Status.st_mtime : (time_t)-1);
	}

int _Set_last_write_time(const TCHAR *_Fname, int64_t _Newtime)
	{	// set last write time
	struct stat _Status;
	struct utimbuf _Utime;
	TEMPBUF(_Xname)

	if (stat(STRNARROW(_Xname, _Fname), &_Status) != 0)
		return (0);
	else
		{	// alter last write time and set it
		_Utime.actime = _Status.st_atime;
		_Utime.modtime = _Newtime;
		utime(NARROWED(_Xname, _Fname), &_Utime);
		return (1);
		}
	}

space_info _Statvfs(const TCHAR *_Fname)
	{	// get space information for volume
	struct statvfs _Vstat;
	space_info _Ans = {(uintmax_t)-1, (uintmax_t)-1, (uintmax_t)-1};
	TEMPBUF(_Xname)

	if (statvfs(STRNARROW(_Xname, _Fname), &_Vstat) == 0)
		{	// succeeded, get size information
		_Ans.capacity = (_ULonglong)_Vstat.f_blocks * _Vstat.f_frsize;
		_Ans.free = (_ULonglong)_Vstat.f_bfree * _Vstat.f_frsize;
		_Ans.available = (_ULonglong)_Vstat.f_bavail * _Vstat.f_frsize;
		}
	return (_Ans);
	}

int _Equivalent(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// test for equivalent file names
	struct stat _Status1;
	struct stat _Status2;
	TEMPBUF(_Xname)

	bool _Ok1 = stat(STRNARROW(_Xname, _Fname1), &_Status1) == 0
		&& (S_ISREG(_Status1.st_mode)
 #ifdef S_ISSYM
			|| S_ISSYM(_Status1.st_mode)
 #endif /* defined S_ISSYM */
			|| S_ISDIR(_Status1.st_mode));

	bool _Ok2 = stat(STRNARROW(_Xname, _Fname2), &_Status2) == 0
		&& (S_ISREG(_Status2.st_mode)
 #ifdef S_ISSYM
			|| S_ISSYM(_Status2.st_mode)
 #endif /* defined S_ISSYM */
			|| S_ISDIR(_Status2.st_mode));

	if (!_Ok1 && !_Ok2)
		return (-1);
	else if (!_Ok1 || !_Ok2)
		return (0);
	else
		return (_Status1.st_dev != _Status2.st_dev
			|| _Status1.st_ino != _Status2.st_ino
				? 0 : 1);
	}

		// FILE LINKAGE FUNCTIONS
int _Link(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// link _Fname2 to _Fname1
	TEMPBUF(_Xname1)
	TEMPBUF(_Xname2)

	errno = 0;
	return (link(STRNARROW(_Xname1, _Fname1),
		STRNARROW(_Xname2, _Fname2)) == 0
		? 0 : errno);
	}

 #ifdef S_ISSYM
int _Symlink(const TCHAR *_Fname1, const TCHAR * _Fname2)
	{	// symlink _Fname2 to _Fname1
	TEMPBUF(_Xname1)
	TEMPBUF(_Xname2)

	errno = 0;
	return (symlink(STRNARROW(_Xname1, _Fname1),
		STRNARROW(_Xname2, _Fname2)) == 0
		? 0 : errno);
	}

 #else /* defined S_ISSYM */
int _Symlink(const TCHAR *, const TCHAR *)
	{	// symlink _Fname2 to _Fname1
	return (errno = EDOM);	// symlinks not supported
	}
 #endif /* defined S_ISSYM */

int _Rename(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// rename _Fname1 as _Fname2
	TEMPBUF(_Xname1)
	TEMPBUF(_Xname2)

	errno = 0;
	if (link(STRNARROW(_Xname1, _Fname1),
		STRNARROW(_Xname2, _Fname2)) != 0)
		return (errno);
	else
		return (unlink(NARROWED(_Xname1, _Fname1)) == 0
			? 0 : errno);
	}

int _Resize(const TCHAR *_Fname, uintmax_t _Newsize)
	{	// change file size
	TEMPBUF(_Xname)

	return (truncate(STRNARROW(_Xname, _Fname), _Newsize));
	}

int _Unlink(const TCHAR *_Fname)
	{	// unlink _Fname
	TEMPBUF(_Xname)

	errno = 0;
	return (unlink(STRNARROW(_Xname, _Fname)) == 0
		? 0 : errno);
	}

int _Copy_file(const TCHAR *_Fname1, const TCHAR *_Fname2)
	{	// copy _Fname1 to _Fname2
	struct stat _Status;
	TEMPBUF(_Xname1)
	TEMPBUF(_Xname2)

	errno = 0;
	if (stat(STRNARROW(_Xname1, _Fname1), &_Status) != 0)
		return (errno);
	else
		{	// try to copy
		TFUN(ifstream) _Is(_Fname1,
			ios_base::in | ios_base::binary);
		TFUN(ofstream) _Os(_Fname2,
			ios_base::out | ios_base::trunc | ios_base::binary);
		_Os << _Is.rdbuf();
		_Is.close();
		_Os.close();

		return (chmod(NARROWED(_Xname2, _Fname2), _Status.st_mode
			& (S_ISUID | S_ISGID | ALL_PERMS)) == 0
				? 0 : errno);
		}
	}

int _Chmod(const TCHAR *_Fname, _Perms _Newmode)
	{	// change file mode to _Mode
	TEMPBUF(_Xname)

	return (chmod(STRNARROW(_Xname, _Fname), (int)_Newmode));
	}

  #undef FILESYS_WIDE
  #undef NARROWED
  #undef STRNARROW
  #undef STRWIDEN
  #undef TEMPBUF
  #undef TCHAR
  #undef TFUN
  #undef TLIT

 #else /* library type */
  #error Unknown platform
 #endif	/* library type */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
