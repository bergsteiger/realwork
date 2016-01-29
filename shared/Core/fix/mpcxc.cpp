////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/mpcxc.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::mpcxc
// Файл реализации утилитного набора mpcxc
//
// множественные исправления ACE, и др...
// От этого НУЖНО избавиться!!!
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/fix/mpcxc.h"
// by <<uses>> dependencies
#include "shared/Core/os/IniFile.h"
#include "shared/Core/fix/Win32Exception.h"
#include "shared/Core/sys/Logs.h"

//#UC START# *45011F4F00FA_CUSTOM_INCLUDES*
#include <string>
#include <cstring>
#include <cmath>
#include <iostream>
#include <locale>
#include <set>
#include <algorithm>

#if defined(_MSC_VER) || defined(WIN32)
#include <io.h> // for windows proprietary call _chmod(), ask Yaroslav why
#include <windows.h>
#endif

#include "ace/Singleton.h"
#include "ace/Null_Mutex.h"
#include "ace/OS.h" // must be last include to avoid incorrect redefining of O_RDONLY-like macros
#include "ace/Configuration.h"
#include "ace/Configuration_Import_Export.h"

namespace { // local

char chrdig(int ost) {
  if (ost < 10) return static_cast<char>('0' + ost - 0);
  else return static_cast<char>('A' + ost - 10);
}

class Encoding {
	friend class ACE_Singleton<Encoding, ACE_Recursive_Thread_Mutex>;
	private:
		std::string m_encoding;
	public:
		Encoding() {
			char* env = ACE_OS::getenv("MPCXC_LOG_ENCODING");
			if (env) {
				if (!ACE_OS::strcasecmp(env, "koi")) m_encoding = "koi"; else
				if (!ACE_OS::strcasecmp(env, "win")) m_encoding = "win"; else
				if (!ACE_OS::strcasecmp(env, "dos")) m_encoding = "dos"; else
				if (!ACE_OS::strcasecmp(env, "mac")) m_encoding = "mac";
			} else {
#if defined(WIN32) // GARANT_TO_IMPROVE_CODING
				m_encoding = "dos";
#else
				m_encoding = "koi";
#endif
			}
		}
		const char* get_encoding() const { return m_encoding.c_str(); }
};

typedef ACE_Singleton<Encoding, ACE_Recursive_Thread_Mutex> EncodingSingleton;

} // namespace local

std::string platform_independent_path(const std::string& path) /*throw (std::logic_error)*/ {
#if defined(PLATFORM_INDEPENDENT_PATH)
  if (path.find(":") == 1) {
    throw std::logic_error("platform_independent_path: couldn't process drive letter: use Core::splitpath first");
  }
  std::string ret = path;
  std::string::size_type siz = ret.size();
  for(std::string::size_type i=0; i<siz; i++) {
    if (ret[i]=='\\') {
    	ret[i]='/';
    }
  }
  return ret;
#else
  return path;  
#endif
}

char* mpcxc_ulltoa_cpp(ACE_UINT64 value, char* strout, int radix) {
  std::string s_res;
  do {
    s_res = chrdig(int(value % radix)) + s_res; // GARANT_PLAN
    value = value / radix;
  } while(value!=0);
  strcpy(strout, s_res.c_str());
  return strout;
}


#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0)
void mpcxc_set_se_handler () {
	Core::Win32Exception::install_handler ();
}
#else
void mpcxc_set_se_handler () {
}
#endif


#include <map>
typedef std::map <int, ACE_HANDLE> FileHandlesTableUpperCRTL;
static FileHandlesTableUpperCRTL NdtCloneTableUpperCRTL;
static ACE_Recursive_Thread_Mutex mutexNdtCloneTableUpperCRTL;
static int nextHandle_NdtCloneTableUpperCRTL= 0;
static FileHandlesTableUpperCRTL NdtCloneTableUpperCRTL_Cleared;


extern "C" {

#if !(defined(_MSC_VER) || defined(WIN32))
int getch(void) { // GARANT_GCC_WIN_LIN
std::cerr<<"call getch(): press key to read, then press ENTER: "<<std::flush;
char c;
std::cin>>c;
std::cerr<<std::endl;
return int(c);
}
#endif

const size_t MPCXC_STACK_SIZE = 128*1024*1024;

namespace {
struct MainParams {
	MainFunctionPtr m_fptr;
	int m_argc;
	char **m_argv;
};
ACE_THR_FUNC_RETURN run_main (void *p) {
	MainParams* m_p_ptr = (MainParams*) p;
	int res = (*m_p_ptr->m_fptr) (m_p_ptr->m_argc, m_p_ptr->m_argv);
	return (ACE_THR_FUNC_RETURN) res;
} 
}

int mpcxc_run_main_stack_size (MainFunctionPtr main_ptr, int argc, char *argv[], size_t stack_size) {
	//char* stack_ptr = new char [stack_size];
	ACE_thread_t working_thread_id = 0;
	ACE_hthread_t working_thread_handle = 0;
	MainParams run_main_params_ptr [1];
	run_main_params_ptr [0].m_fptr = main_ptr;
	run_main_params_ptr [0].m_argc = argc;
	run_main_params_ptr [0].m_argv = argv;
	int res = ACE_OS::thr_create (
		run_main
		, run_main_params_ptr
		, THR_NEW_LWP | THR_JOINABLE
		, &working_thread_id
		, &working_thread_handle
		, ACE_DEFAULT_THREAD_PRIORITY
		, 0 //stack_ptr
		, stack_size
	);
	if (res < 0) {
		std::cerr<<"can't spawn thread for main"<<std::endl;
		abort();
	}
	ACE_THR_FUNC_RETURN status = 0;
	res = ACE_OS::thr_join (working_thread_handle, &status);
	//delete [] stack_ptr;
#if defined (_LP64)  
	return 0;
#else
	return (int)status;
#endif	
}

long mpcxc_timezone(void) {
	return ACE_OS::timezone();
}

// slash replacemant
FILE* mpcxc_fopen(const char* fname, const char* mode) {
//MyMutexAutoLocker mmal;
  std::string pip_fname = platform_independent_path(fname);
  FILE* ret = ::fopen(pip_fname.c_str(), mode);
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"MPCXC::fopen(pip_fname="<<pip_fname<<",mode="<<mode<<")="<<ret<<std::endl;
  return ret;
}

long mpcxc_fseek(FILE* fd, long pos, int origin) {
	int res = ::fseek(fd, pos, origin);
	if (res != 0) return -1;
	return ::ftell(fd);
}

void mpcxc_fgetpos(FILE* fp, long* posp) {
	*posp = ::ftell(fp);
}

void mpcxc_fsetpos(FILE* fp, const long* posp) {
	::fseek (fp, *posp, ACE_OS_SEEK_SET);
}

const char* mpcxc_encoding() {
	return EncodingSingleton::instance() -> get_encoding();
}

code_t mpcxc_cd_cursys() {
	const char* env = mpcxc_encoding();
	if (!ACE_OS::strcasecmp(env, "koi")) return (cd_koi); else
	if (!ACE_OS::strcasecmp(env, "win")) return (cd_win); else
	if (!ACE_OS::strcasecmp(env, "dos")) return (cd_dos); else
	if (!ACE_OS::strcasecmp(env, "mac")) return (cd_mac); else
#if defined(WIN32) // GARANT_TO_IMPROVE_CODING
		return (cd_dos);
#else
		return (cd_koi);
#endif
}

char* mpcxc_strtolower(char* ptr, unsigned int len) {
	for(unsigned int i=0; i<len; i++) {
		ptr[i] = std::tolower(ptr[i], std::locale::classic());
	}
	return ptr;
}

char* mpcxc_strtoupper(char* ptr, unsigned int len) {
	for(unsigned int i=0; i<len; i++) {
		ptr[i] = std::toupper(ptr[i], std::locale::classic());
	}
	return ptr;
}

const int MPCXC_FILE_ATTR_RW = 0;
const int MPCXC_FILE_ATTR_RO = 1;

bool mpcxc_chmod(const char *fname, int mpcxc_mode) {
#if !(defined(_MSC_VER) || defined(WIN32))
	return true;
#else
	int wmod = (mpcxc_mode == MPCXC_FILE_ATTR_RO) ? _S_IREAD : _S_IREAD | _S_IWRITE;
	int wres = _chmod(fname, wmod);
	return (wres == 0) ? true : false;
#endif
}

char* mpcxc_ltoa(long value_in, char* strout, int radix) {
  long value = abs(value_in);
  std::string s_res;
  do {
    s_res = chrdig(value % radix) + s_res; // GARANT_PLAN
    value = value / radix;
  } while(value!=0);
  if (value_in < 0) {
    s_res = '-' + s_res;
  }
  strcpy(strout, s_res.c_str());
  return strout;
}

char* mpcxc_ultoa(unsigned long value, char* strout, int radix) {
  std::string s_res;
  do {
    s_res = chrdig(value % radix) + s_res; // GARANT_PLAN
    value = value / radix;
  } while(value!=0);
  strcpy(strout, s_res.c_str());
  return strout;
}

char* mpcxc_ulltoa(double value_in, char* strout, int radix) {
  ACE_UINT64 value = static_cast<ACE_UINT64>(value_in);
  std::string s_res;
  do {
    s_res = chrdig(int(value % radix)) + s_res; // GARANT_PLAN
    value = value / radix;
  } while(value!=0);
  strcpy(strout, s_res.c_str());
  return strout;
}


void mpcxc_makepath(char *path, const char *drive, const char *dir, const char *fname, const char *ext) {
  std::string s_drive = (drive != 0) ? drive : "";
  std::string s_dir = (dir != 0) ? dir : "";
  std::string s_fname = (fname != 0) ? fname : "";
  std::string s_ext = (ext != 0) ? ext : "";
  if ((s_drive.size() > 0) && (s_drive.find(":") == std::string::npos)) {
		s_drive += ":";
  }
  if ((s_ext.size() > 0) && (s_ext.find(".") == std::string::npos)) {
		s_ext = "." + s_ext;
  }
  if (s_dir.size () && s_dir[s_dir.size ()-1] != '\\' && s_dir[s_dir.size ()-1] != '/') {
		s_dir += '\\';
  }
  std::string s_res = s_drive + s_dir + s_fname + s_ext;
  strcpy(path, s_res.c_str());
}

ssize_t enum_sections (ACE_Configuration_Heap& cfg, char* lpReturnedString, const int nSize) {
	const ACE_Configuration_Section_Key& root_section = cfg.root_section ();
	ACE_TString name;
	ssize_t read_bytes = 0;
	for (int i = 0; nSize > read_bytes; ++i) {
		int res = cfg.enumerate_sections (root_section, i, name);
		if (res == 1) {
			break;
		} else if (res == -1) {
			return ACE_OS::last_error();
		}
		const size_t len = std::min <size_t> (nSize, name.length () + 1);
		ACE_OS::strncpy (lpReturnedString, name.c_str (), len);
		lpReturnedString += len;
		read_bytes += len;
	}
	*lpReturnedString = '\0';
	return read_bytes;
}

ssize_t enum_values (
	ACE_Configuration_Heap& cfg
	, const ACE_Configuration_Section_Key& section
	, char* lpReturnedString
	, const int nSize
) {
	ACE_Configuration::VALUETYPE type;
	ACE_TString name;
	ssize_t read_bytes = 0;
	for (int i = 0; nSize > read_bytes; ++i) {
        int res = cfg.enumerate_values (section, i, name, type);
		if (res == 1) {
			break;
		} else if (res == -1) {
			return ACE_OS::last_error();
		}
		const size_t len = std::min <size_t> (nSize, name.length () + 1);
		ACE_OS::strncpy (lpReturnedString, name.c_str (), len);
		lpReturnedString += len;
		read_bytes += len;
	}
	*lpReturnedString = '\0';
	return read_bytes;
}

size_t MPCXC_GetPrivateProfileString(
  const char* lpAppName
  , const char* lpKeyName
  , const char* lpDefault
  , char* lpReturnedString
  , unsigned int nSize
  , const char* lpFileName
  ) {
	const unsigned len = (unsigned) ACE_OS::strnlen (lpDefault, nSize) + 1;
	ACE_OS::strncpy (lpReturnedString, lpDefault, std::min (nSize, len));

	ACE_Configuration_Heap cfg;
	cfg.open ();
	ACE_Ini_ImpExp import (cfg);
	if (import.import_config (lpFileName)) {
		LOG_E (("MPCXC_GetPrivateProfileString: ACE_Ini_ImpExp::import_config for '%s' is FAIL.", lpFileName));
		return 0;
	}
	if (!lpAppName) {
		return enum_sections (cfg, lpReturnedString, nSize);
	}
	ACE_Configuration_Section_Key section;
	if (cfg.open_section (cfg.root_section (), lpAppName, 1, section)) {
		LOG_E ((
			"MPCXC_GetPrivateProfileString: open_section '[%s]' for '%s' is error %d."
			, lpAppName, lpFileName, ACE_OS::last_error()
		));
		return 0;
	}
	if (!lpKeyName) {
		return enum_values (cfg, section, lpReturnedString, nSize);
	}
	ACE_TString value;
	if (cfg.get_string_value (section, lpKeyName, value)) {
		LOG_E ((
			"MPCXC_GetPrivateProfileString: get_string_value '%s' of '[%s]' for '%s' is error %d."
			, lpKeyName, lpAppName, lpFileName, ACE_OS::last_error()
		));
		return 0;
	}
	size_t res = std::min <size_t> (nSize - 1, value.length ());
	ACE_OS::strncpy (lpReturnedString, value.c_str (), res);
	lpReturnedString [res] = '\0';
	return res;
  }
            
bool MPCXC_WritePrivateProfileString(
  const char* lpAppName
  , const char* lpKeyName
  , const char* lpString
  , const char* lpFileName
  ) {
	ACE_Configuration_Heap cfg;
	cfg.open ();
	ACE_Ini_ImpExp import (cfg);
	if (import.import_config (lpFileName) && ACE_OS::last_error () != ENOENT) {
		LOG_E (("MPCXC_WritePrivateProfileString: ACE_Ini_ImpExp::import_config for '%s' is FAIL.", lpFileName));
		return false;
	}
	if (!lpKeyName) {
		if (cfg.remove_section (cfg.root_section (), lpAppName, 1)) {
			LOG_E ((
				"MPCXC_WritePrivateProfileString: remove_section '%s' for '%s' is error %d."
				, lpAppName, lpFileName, ACE_OS::last_error ()
			));
			return false;
		}
		if (import.export_config (lpFileName)) {
			LOG_E (("MPCXC_WritePrivateProfileString: ACE_Ini_ImpExp::export_config for '%s' is FAIL.", lpFileName));
			return false;
		}
		return true;
	}
	ACE_Configuration_Section_Key section;
	if (cfg.open_section (cfg.root_section (), lpAppName, 1, section)) {
		LOG_E ((
			"MPCXC_GetPrivateProfileString: open_section '[%s]' for '%s' is error %d."
			, lpAppName, lpFileName, ACE_OS::last_error ()
		));
		return false;
	}	
	if (!lpString) {
		if (cfg.remove_value (section, lpKeyName)) {
			LOG_E ((
				"MPCXC_WritePrivateProfileString: remove_value '%s' of '[%s]' for '%s' is error %d."
				, lpKeyName, lpAppName, lpFileName, ACE_OS::last_error ()
			));
			return false;
		}
		if (import.export_config (lpFileName)) {
			LOG_E (("MPCXC_WritePrivateProfileString: ACE_Ini_ImpExp::export_config for '%s' is FAIL.", lpFileName));
			return false;
		}
		return true;
	}
	ACE_TString value (lpString);
	if (cfg.set_string_value (section, lpKeyName, value)) {
		LOG_E ((
			"MPCXC_WritePrivateProfileString: set_string_value '%s' of '[%s]' for '%s' is error %d."
			, lpKeyName, lpAppName, lpFileName, ACE_OS::last_error ()
		));
		return false;
	}
	if (import.export_config (lpFileName)) {
		LOG_E (("MPCXC_WritePrivateProfileString: ACE_Ini_ImpExp::export_config for '%s' is FAIL.", lpFileName));
		return false;
	}
	return true;
  }

bool MPCXC_CharToOem(const char* from, char* to) {
  strcpy(to, from);
  return true;
}

char* mpcxc_strrev(char *pOut) {
	unsigned len = (unsigned) strlen(pOut);
	char *pLast= pOut + len, *pFirst= pOut, *pTmp= pLast;
	while((len-=2) > -1) {
		pLast--;
		*pTmp= *pLast;
		*pLast= *pFirst;
		*pFirst= *pTmp;
		pFirst++;
	}
	*pTmp= '\0';
	return pOut;
}
#include <fcntl.h>

const int ACE_OS_O_RDONLY = O_RDONLY;
const int ACE_OS_O_WRONLY = O_WRONLY;
const int ACE_OS_O_RDWR = O_RDWR;
const int ACE_OS_O_CREAT = O_CREAT;
const int ACE_OS_O_TRUNC = O_TRUNC;
const int ACE_OS_O_BINARY = O_BINARY;
const int ACE_OS_O_TEXT = O_TEXT;
const int ACE_OS_O_EXCL = O_EXCL;

const int ACE_OS_SEEK_SET = SEEK_SET;
const int ACE_OS_SEEK_CUR = SEEK_CUR;
const int ACE_OS_SEEK_END = SEEK_END;

#if (_MSC_VER < 1900)
 #ifdef WIN32
  // функция предоставляющая ВСЕ режимы открытия файлов в Windows x32/x64		//
  // для C-API Low-level input and output calls do not buffer or format data	//
  extern errno_t __cdecl _sopen_helper (	const _TSCHAR *path,
										int oflag,
										int shflag,
										int pmode,
										int * pfh,
										int bSecure	);
 #endif
#endif


std::set<int> set_of_opened_files;
  
int c_io_open(const char* fname, int flags)
{
#ifdef WIN32
	int retH= -1;
	ACE_HANDLE tstH= ACE_INVALID_HANDLE;
	if(*fname == '*')
		return -1;
	else{
#if (_MSC_VER < 1900)
		if((flags & ACE_OS_O_EXCL) && ((flags & ACE_OS_O_WRONLY)||(flags & ACE_OS_O_RDWR))){
		  int repeat= 5;
		  char msgWW[]= "Open file in monopoly mode";
		  while(repeat--){
			int fh;
			errno_t e;
			if(flags & ACE_OS_O_CREAT){
				e= _sopen_helper((const _TSCHAR *)fname, flags & (~ACE_OS_O_CREAT), 0x10, 0, &fh, 0);
				if( e )
					e= _sopen_helper((const _TSCHAR *)fname, flags, 0x10, _S_IWRITE, &fh, 0);
			}else
				e= _sopen_helper((const _TSCHAR *)fname, flags, 0x10, 0, &fh, 0);

			retH= e ? -1 : fh;

			if(retH == -1){
				if(repeat == 4){
					if((tstH= ::ACE_OS::open(	fname
												, flags & (~(ACE_OS_O_WRONLY|ACE_OS_O_RDWR|ACE_OS_O_EXCL|ACE_OS_O_CREAT))
												, ACE_DEFAULT_OPEN_PERMS)
							) != ACE_INVALID_HANDLE)
					{
						::ACE_OS::close(tstH);
						tstH= ACE_INVALID_HANDLE;
						LOG_W(("Not first %s(%s)", msgWW, fname));
					}else
						return -1;
				}
				ace_os_sleep	(	200
 #ifdef _DEBUG
									* 10
 #endif
								);
			}else{ 
				if(repeat < 4)
					LOG_W(("%s(%s)", msgWW, fname));
				repeat= 0;
			}
		  }
		  if(retH == -1){
			  if(flags & ACE_OS_O_CREAT)
				;
			  else{
				char msgWW[]= "Not monopoly C-RTL %s Open exist file(%s)";
				retH= ::_open(fname, flags & (~ACE_OS_O_EXCL), _S_IREAD|_S_IWRITE);
				if(retH != -1)
					LOG_W((msgWW, "ReadWrite", fname));
				else if((flags & ACE_OS_O_WRONLY)||(flags & ACE_OS_O_RDWR)){
					retH= ::_open(fname, flags & (~(ACE_OS_O_EXCL|ACE_OS_O_WRONLY|ACE_OS_O_RDWR)), _S_IREAD|_S_IWRITE);
					if(retH != -1)
						LOG_W((msgWW, "ReadOnly", fname));
				}
			  }
		  }
		}else
#endif
			retH= ::_open(fname, flags, _S_IREAD|_S_IWRITE);

		if(retH == -1 && (tstH= ::ACE_OS::open(	fname
												, flags & (~(ACE_OS_O_WRONLY|ACE_OS_O_RDWR|ACE_OS_O_EXCL|ACE_OS_O_CREAT))
												, ACE_DEFAULT_OPEN_PERMS)
							) != ACE_INVALID_HANDLE)
		{
			//LOG_W(("Not find C-RTL Handle for exist file(%s)", fname));
			// закончились файловые хендлы C-RTL //
			if((flags & ACE_OS_O_WRONLY)||(flags & ACE_OS_O_RDWR)){
				ACE_HANDLE tstWH= ::ACE_OS::open(fname, (flags & (~(ACE_OS_O_CREAT|ACE_OS_O_EXCL))), ACE_DEFAULT_OPEN_PERMS);
				if(tstWH != ACE_INVALID_HANDLE){
					::ACE_OS::close(tstH);
					tstH= tstWH;
				}
			}
			{
				ACE_Guard<ACE_Recursive_Thread_Mutex> lock(mutexNdtCloneTableUpperCRTL);
				if(nextHandle_NdtCloneTableUpperCRTL > -1)
					nextHandle_NdtCloneTableUpperCRTL= -100;
				else
					nextHandle_NdtCloneTableUpperCRTL--;

				std::map <int, ACE_HANDLE>::const_iterator map_it = NdtCloneTableUpperCRTL_Cleared.begin();
				if(map_it != NdtCloneTableUpperCRTL_Cleared.end()){
					int fndF= map_it->first;
					NdtCloneTableUpperCRTL.insert(std::map <int, ACE_HANDLE>::value_type (fndF, tstH));
					NdtCloneTableUpperCRTL_Cleared.erase(fndF);
				}else{
					if(nextHandle_NdtCloneTableUpperCRTL > -1)
						return -1;
					NdtCloneTableUpperCRTL.insert(std::map <int, ACE_HANDLE>::value_type (nextHandle_NdtCloneTableUpperCRTL, tstH));
				}
			}
			return nextHandle_NdtCloneTableUpperCRTL;

		}else if(retH == -1 && tstH == ACE_INVALID_HANDLE){
			if(flags & ACE_OS_O_CREAT){
				LOG_E(("Not Create file in monopoly mode (%s)", fname));
			}else
				return -1;
		}
	}
	/*
	if (flags == 34050 || flags == 33794 || flags == 32770 || flags == 33537)
		set_of_opened_files.insert (retH);
	*/
	return retH;
#else
	return ace_os_open(fname, flags);
#endif
}

int c_io_read(int fd, void* buf, int len)
{
#ifdef WIN32
	if(fd < -99){
		ACE_HANDLE tstH;
		{
			ACE_Guard<ACE_Recursive_Thread_Mutex> lock(mutexNdtCloneTableUpperCRTL);
			tstH= NdtCloneTableUpperCRTL.find(fd)->second;
		}
		ssize_t rres= ::ACE_OS::read(tstH, buf, len);
		return (int)(rres & 0x7fffffff);
	}
	return ::_read(fd,buf,len);
#else
	return ace_os_read(fd,buf,len);
#endif
}
int c_io_write(int fd, const void* buf, int len)
{
#ifdef WIN32
	if(fd < -99){
		ACE_HANDLE tstH;
		{
			ACE_Guard<ACE_Recursive_Thread_Mutex> lock(mutexNdtCloneTableUpperCRTL);
			tstH= NdtCloneTableUpperCRTL.find(fd)->second;
		}
		ssize_t rres= ::ACE_OS::write(tstH, buf, len);
		return (int)(rres & 0x7fffffff);
	}
	return ::_write(fd,buf,len);
#else
	return ace_os_write(fd,buf,len);
#endif
}
int c_io_lseek(int fd, int offset, int whence)
{
#ifdef WIN32
	if(fd < -99){
		ACE_HANDLE tstH;
		{
			ACE_Guard<ACE_Recursive_Thread_Mutex> lock(mutexNdtCloneTableUpperCRTL);
			tstH= NdtCloneTableUpperCRTL.find(fd)->second;
		}
		ssize_t rres= ::ACE_OS::lseek(tstH, offset, whence);
		return (int)(rres & 0x7fffffff);
	}
	return ::_lseek(fd, offset, whence);
#else
	return ace_os_lseek(fd, offset, whence);
#endif
}
int c_io_tell(int fd)
{
#ifdef WIN32
	return c_io_lseek(fd, 0, ACE_OS_SEEK_CUR);
#else
	return ace_os_tell(fd);
#endif
}
int c_io_filesize(int fd)
{
#ifdef WIN32
	return ::_lseek(fd, 0, SEEK_END);
#else
	return ace_os_filesize(fd);
#endif
}
int c_io_file_flush(int fd)
{
#ifdef WIN32
	/*
	if(fd < -99){
		ACE_HANDLE tstH;
		{
			ACE_Guard<ACE_Recursive_Thread_Mutex> lock(mutexNdtCloneTableUpperCRTL);
			tstH= NdtCloneTableUpperCRTL.find(fd)->second;
			//NdtCloneTableUpperCRTL_Cleared.insert(std::map <int, ACE_HANDLE>::value_type (fd, tstH));
			NdtCloneTableUpperCRTL.erase(fd);
		}
		return 0;//::ACE_OS::_commit(tstH);
	}
	return ::_commit(fd);
	*/
	return 0;
#else
	return ace_os_close(fd);
#endif
}

int c_io_close(int fd)
{
	/*
	if (set_of_opened_files.find (fd) != set_of_opened_files.end ())
		set_of_opened_files.erase (set_of_opened_files.find (fd));
	*/
#ifdef WIN32
	if(fd < -99){
		ACE_HANDLE tstH;
		{
			ACE_Guard<ACE_Recursive_Thread_Mutex> lock(mutexNdtCloneTableUpperCRTL);
			tstH= NdtCloneTableUpperCRTL.find(fd)->second;
			//NdtCloneTableUpperCRTL_Cleared.insert(std::map <int, ACE_HANDLE>::value_type (fd, tstH));
			NdtCloneTableUpperCRTL.erase(fd);
		}
		return ::ACE_OS::close(tstH);
	}
	return ::_close(fd);
#else
	return ace_os_close(fd);
#endif
}

void	close_opened_files ()
{
	for (std::set<int>::const_iterator it = set_of_opened_files.begin (); it != set_of_opened_files.end (); it++)
		c_io_close (*it);
}

int ace_os_open(const char* fname, int flags) {
	std::string pip_fname = platform_independent_path(fname);
//MyMutexAutoLocker mmal;
	int prot = 0666;
  #if defined(WIN32) || defined(_MSC_VER)
	prot = ACE_DEFAULT_OPEN_PERMS;
  #endif  	
	ACE_HANDLE handle = ::ACE_OS::open(pip_fname.c_str(), flags, prot);
//	std::string dbgstrfl;
//	dbgstrfl += (flags & O_CREAT) ? "c" : "-";
//	dbgstrfl += (flags & O_TRUNC) ? "t" : "-";
//	dbgstrfl += (flags & O_EXCL) ? "e" : "-";
//	dbgstrfl += (flags & O_RDONLY) ? "r" : "-";
//	dbgstrfl += (flags & O_WRONLY) ? "w" : "-";
//	dbgstrfl += (flags & O_RDWR) ? "f" : "-";
//	dbgstrfl += (flags & O_BINARY) ? "b" : "-";
//	dbgstrfl += (flags & O_TEXT) ? "x" : "-";
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"ace_os_open(pip_fname="<<pip_fname<<",flags="<<dbgstrfl<<")="<<handle<<std::endl;
	return (handle != ACE_INVALID_HANDLE) ? (int)(handle) : -1;
}
/*
int ace_os_open3(const char* fname, int flags, int prot) {
	ACE_HANDLE handle = ::ACE_OS::open(fname, flags, prot);
	return (handle != ACE_INVALID_HANDLE) ? (int)(handle) : -1;
}
*/
int ace_os_read(int fd, void* buf, size_t len) {
//MyMutexAutoLocker mmal;
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	ssize_t rres = ::ACE_OS::read(handle, buf, len);
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"ace_os_read(handle="<<handle<<",buf="<<buf<<",len="<<len<<")="<<rres<<"|crc32="<<ACE::crc32(reinterpret_cast<const char*>(buf), len)<<std::endl;
	return (int) rres;
}

int ace_os_write(int fd, const void* buf, size_t len) {
//MyMutexAutoLocker mmal;
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	ssize_t wres = ::ACE_OS::write(handle, buf, len);
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"ace_os_write(handle="<<handle<<",buf="<<buf<<",len="<<len<<")="<<wres<<"|crc32="<<ACE::crc32(reinterpret_cast<const char*>(buf), len)<<std::endl;
	return (int) wres;
}

long ace_os_lseek(int fd, long offset, int whence) {
//MyMutexAutoLocker mmal;
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	off_t lres = ::ACE_OS::lseek(handle, offset, whence);
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"ace_os_lseek(handle="<<handle<<",offset="<<offset<<",whence="<<whence<<")="<<lres<<std::endl;
	return lres;
}

long ace_os_tell(int fd) {
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	off_t lres = ::ACE_OS::lseek(handle, 0, SEEK_CUR);
	return lres;
}

long ace_os_filesize(int fd) {
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	off_t lres = ::ACE_OS::filesize(handle);
	return lres;
}

#ifdef ftruncate
#undef ftruncate
#endif
int ace_os_ltrunc(int fd, long loffset) {
	if (::ACE_OS::ftruncate((ACE_HANDLE)(fd), loffset) == -1) {
		//std::cerr<<"ace_os_ftruncate: -1ftrunc: "<<handle<<": "<<loffset<<std::endl;
		return -1;
	}
	return 0;
}

int ace_os_ftruncate(int fd, long loffset) {
//MyMutexAutoLocker mmal;
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"ace_os_ftruncate(h="<<handle<<",loffset="<<loffset<<")"<<std::endl;
	
	off_t lpos = ::ACE_OS::lseek(handle, 0, SEEK_CUR); // gets current file position
	if (lpos == -1) {
		//std::cerr<<"ace_os_ftruncate: -1getpos: "<<handle<<std::endl;
		return -1;
	}
	if (::ACE_OS::ftruncate(handle, loffset) == -1) {
		//std::cerr<<"ace_os_ftruncate: -1ftrunc: "<<handle<<": "<<loffset<<std::endl;
		return -1;
	}
	// restore file position or set to the end 
	off_t lres = ::ACE_OS::lseek(handle, lpos, SEEK_SET);
	//off_t lres = ACE_OS::lseek(handle, ( (lpos < loffset) ? lpos : loffset ), SEEK_SET);
	if (lres == -1) {
		//std::cerr<<"ace_os_ftruncate: -1setpos: "<<handle<<": "<<lpos<<std::endl;
		return -1;
	}
	
//std::cerr<<"thr_self:"<<ACE_OS::thr_self()<<"|"<<"ace_os_ftruncate()=SUCCESS"<<std::endl;
		
	return 0;
}

int ace_os_close(int fd) {
	ACE_HANDLE handle = (ACE_HANDLE)(fd);
	int res = ::ACE_OS::close(handle);
/*	
	if (res == -1) {
		std::cerr<<"ace_os_close: -1: "<<handle<<std::endl;
	}
*/	
	return res;
}

extern int ace_os_file_flush(int fd)
{
#ifdef WIN32
	return ::_commit(fd);
#else
	return -1;
#endif
}

int ace_os_unlink(const char* fname) {
	int res = ::ACE_OS::unlink(platform_independent_path(fname).c_str());
/*	
	if (res == -1) {
		std::cerr<<"ace_os_unlink: -1: "<<fname<<std::endl;
	}
*/	
	return res;
}

int ace_os_rename(const char* fname1, const char* fname2) {
	int res = ::ACE_OS::rename(platform_independent_path(fname1).c_str(), platform_independent_path(fname2).c_str());
/*	
	if (res == -1) {
		std::cerr<<"ace_os_rename: -1: "<<fname1<<": "<<fname2<<std::endl;
	}
*/	
	return res;
}

int ace_os_copyfile(const char* fname1, const char* fname2) {
#ifdef WIN32
	CopyFile(platform_independent_path(fname1).c_str(), platform_independent_path(fname2).c_str(),1);
	return 0;
#else
	return -1;
#endif
}

void ace_os_date_win32(long *dosdateptr) {
	struct DosDateValue {
		unsigned short ddv_day: 5;
		unsigned short ddv_month: 4;
		unsigned short ddv_year: 7; // since 1980
	};
	union DosDate {
		DosDateValue dd_val;
		ACE_UINT16 ui_val;
	};
	struct DosTimeValue {
		unsigned short dtv_sec: 5; // div by 2
		unsigned short dtv_min: 6; // 0-59
		unsigned short dtv_hour: 5; // 0-23
	};
	union DosTime {
		DosTimeValue dt_val;
		ACE_UINT16 ui_val;
	};
	time_t tv;
	time(&tv);
	tm* mygmt = ::ACE_OS::gmtime(&tv); // return is rewritable static from an std. lib
	DosDate dd;
	dd.dd_val.ddv_day = mygmt->tm_mday;
	dd.dd_val.ddv_month = mygmt->tm_mon+1;
	dd.dd_val.ddv_year = mygmt->tm_year - (1980 - 1900);
	*(reinterpret_cast<unsigned short *>(dosdateptr)) = dd.ui_val;
	DosTime dt;
	dt.dt_val.dtv_sec = mygmt->tm_sec/2+1;
	dt.dt_val.dtv_min = mygmt->tm_min;
	dt.dt_val.dtv_hour = mygmt->tm_hour;
	*(reinterpret_cast<unsigned short *>(dosdateptr)+1) = dt.ui_val;
}

void ace_os_sleep(unsigned long milliseconds) {
	ACE_Time_Value tv;
	tv.msec(static_cast<long>(milliseconds));
	::ACE_OS::sleep(tv);
}

int ace_os_mkdir(const char* dirname) {
	int prot = 0755;
#if defined(WIN32) || defined(_MSC_VER)
	prot = ACE_DEFAULT_DIR_PERMS;
#endif  
	int res = ::ACE_OS::mkdir(platform_independent_path(dirname).c_str(), mode_t(prot));
	return res;
}

extern int ace_os_dup(int fd) {
	ACE_HANDLE handle = ACE_OS::dup((ACE_HANDLE)(fd));
	return (handle != ACE_INVALID_HANDLE) ? (int)(handle) : -1;
}

extern FILE* ace_os_fdopen(int fd, const char* mode) {
	FILE* res = ACE_OS::fdopen((ACE_HANDLE)(fd), mode);
	return res;
}

} // extern "C"
//#UC END# *45011F4F00FA_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45011F4F00FA*
//#UC END# *45011F4F00FA*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

