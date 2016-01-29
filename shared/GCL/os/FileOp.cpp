////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/os/FileOp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::FileOp
// Файл реализации утилитного набора FileOp
//
// расширенные операции над файлом (копирование, перенос, удаление)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/os/FileOp.h"
// by <<uses>> dependencies
#include <fstream>

//#UC START# *4503DEC603C8_CUSTOM_INCLUDES*
#include "ace/OS.h"
#include <cstring>
#if defined(_MSC_VER)
#include <direct.h> // for _getdrive() especially
#include <iterator>
#endif
//#UC END# *4503DEC603C8_CUSTOM_INCLUDES*

namespace GCL {
namespace FileOp {

//#UC START# *4503DEC603C8*
void throw_last_error (int er) throw (FOException) {
	switch (er) {
	case 0:
		return;
	case ENOENT:
		throw InvalidPath();
	case EACCES:
		throw AccessDenied();
	case ENOMEM:
	case ENOSPC:
		throw NotEnoughRoom();
	case EEXIST:		
		throw FileExists();
	default:
		throw UnknownError();
	}
}

namespace { // local
const int MY_BUFSIZ = 256*1024; // for copy_file
}

namespace { // local
	std::string replsym(const std::string& par, char cfrom, char cto) {
		std::string ret=par;
		std::string::size_type siz = par.size();
		for(std::string::size_type pos=0; pos<siz; pos++) {
			ret[pos] = (par[pos] == cfrom) ? cto : par[pos];
		}
		return ret;
	}
	std::string drv2str(int d) {
		std::string ret(1, char('a' + (d-1)));
		ret += ':';
		return ret;
	}
	std::string getdrv() {
		std::string ret;
#if defined (WIN32) || defined (_MSC_VER)
		ret = drv2str(_getdrive());
#else
		ret = ""; // mount ideology upon right OS
#endif
		return ret;
	}
	std::string getcwd() {

		std::string ret;
		char dir_buf[32*1024];

#if defined (WIN32) || defined (_MSC_VER)
		_getcwd(dir_buf, 32*1024);
		ret = dir_buf;

		std::string::size_type colon_pos = ret.find(':'); // due to ACE adds 'DRV': to cwd under Win32
		if (colon_pos != std::string::npos) {
			ret = ret.substr(colon_pos+1);
		}
		if (ret.size()>0) {
			if (ret[ret.size()-1] != '/') {
				ret += '\\';
			}
		}
		return ret;
#else
		ACE_OS::getcwd(dir_buf, 32*1024);
		ret = dir_buf;

		std::string::size_type colon_pos = ret.find(':'); // due to ACE adds 'DRV': to cwd under Win32
		if (colon_pos != std::string::npos) {
			ret = ret.substr(colon_pos+1);
		}

		ret = replsym(ret, '\\', '/');
		if (ret.size()>0) {
			if (ret[ret.size()-1] != '/') {
				ret += '/';
			}
		}
		return ret;
#endif
	}

} // namespace local

void splitpath (
	const std::string& path_in
	, std::string& drive
	, std::string& dir
	, std::string& fname
	, std::string& ext
	, bool dflt) {
#if defined (WIN32) || defined (_MSC_VER)
	if (path_in.size () > _MAX_DRIVE + _MAX_DIR + _MAX_FNAME + _MAX_EXT - 4) {
		std::cerr<<"splitpath (): to big path = "<<path_in<<std::endl;
	}

	char drive_c [_MAX_DRIVE];
	char dir_c [_MAX_DIR];
	char fname_c [_MAX_FNAME];
	char ext_c [_MAX_EXT];

	_splitpath (path_in.c_str (), drive_c, dir_c, fname_c, ext_c);
	drive = dflt ? getdrv () : drive_c;
	dir = dflt ? getcwd () : dir_c;
	fname = fname_c;
	ext = ext_c;
#else
	std::string path = path_in; // path will shrink during split
	std::string::size_type colon_pos = path.find(':');

	if (colon_pos != std::string::npos) { // ":" not found, gets default drive
		drive = path.substr(0, colon_pos+1); // with ':'
		path = path.substr(colon_pos+1); // rest path without drive
	}
	else {
		drive = dflt ? getdrv() : "";
	}

	path=replsym(path, '\\', '/');

	std::string::size_type slash_pos = path.rfind('/'); // gets dir boundary
	if (slash_pos != std::string::npos) {
		dir = path.substr(0, slash_pos+1); // dir with trailing '/'
		path = path.substr(slash_pos+1); // rest path without dir
	}
	else { // gets current directory
		dir = dflt ? getcwd() : "";
	}

	std::string::size_type dot_pos = path.find('.');
	if (dot_pos != std::string::npos) {
		fname = path.substr(0, dot_pos); // fname without '.'
		ext = path.substr(dot_pos); // ext with '.'
	}
	else {
		fname = path;
		ext = "";
	} 
#endif
}
//#UC END# *4503DEC603C8*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation


const char* AccessDenied::uid () const /*throw ()*/ {
	return "9C2019B6-02BE-45E7-9EA8-3EA654819814";
}

const char* AccessDenied::what () const throw () {
	//#UC START# *4507E9D200DA_WHAT_IMPL*
	return "AccessDenied (acess denied to make file operation)";
	//#UC END# *4507E9D200DA_WHAT_IMPL*
}




const char* FileExists::uid () const /*throw ()*/ {
	return "4D004300-71CE-400B-9BA9-0E77B56E676F";
}

const char* FileExists::what () const throw () {
	//#UC START# *4507E9BE005D_WHAT_IMPL*
	return "FileExists (cant complete move operation becouse destination file exists)";
	//#UC END# *4507E9BE005D_WHAT_IMPL*
}




const char* InvalidPath::uid () const /*throw ()*/ {
	return "24959E2D-22F0-4937-9414-A9F3EAA391FB";
}

const char* InvalidPath::what () const throw () {
	//#UC START# *4507E9E003A9_WHAT_IMPL*
	return "InvalidPath (invalid path specified for file opertion)";
	//#UC END# *4507E9E003A9_WHAT_IMPL*
}




const char* NotEnoughRoom::uid () const /*throw ()*/ {
	return "04AB1705-7FED-4FA7-B9EC-024F62E65967";
}

const char* NotEnoughRoom::what () const throw () {
	//#UC START# *4507EE51032C_WHAT_IMPL*
	return "NotEnoughRoom (not enough room to complete file opertion)";
	//#UC END# *4507EE51032C_WHAT_IMPL*
}




const char* UnknownError::uid () const /*throw ()*/ {
	return "29CACE5E-C2AB-4403-B47B-38E4F4C04187";
}

const char* UnknownError::what () const throw () {
	//#UC START# *4503DF17037A_WHAT_IMPL*
	return "UnknownError (Unknown File operation exception)";
	//#UC END# *4503DF17037A_WHAT_IMPL*
}



// Функция сравнивнения двух файлов.
// елсли as_binary = true - файлы сравнивают бинарно
int compare (const char* first, const char* second, bool as_binary) /*throw (AccessDenied, InvalidPath)*/ {
	//#UC START# *49ED6DBD005D*
	//если сравниваем сам с собой, то сразу возвращаем 0
	if (ACE_OS::strcmp (first, second) == 0) {
		return 0;
	}
	/*
	char* buf = new char[size];
	unsigned long right_size = 0;
	ReadFile(hFile, buf, size, &right_size, NULL);
	
	std::string mode (as_binary ? "rb" : "r");
	FILE* first_file = ACE_OS::fopen (first, mode.c_str ());
	FILE* first_file = ACE_OS::fopen (first, mode.c_str ());
	
	SetEndOfFile(hFile);				
	CloseHandle (hFile);

	// check for changes			
					
	bool is_diff = true;
	if (right_file) {
		fseek(right_file, 0, SEEK_END);
		right_size = ftell(right_file);
		if (right_size == size) {
			char* right_buf = new char [right_size];						
			rewind (right_file);
			fread (right_buf , right_size, 1, right_file);
			
			is_diff = memcmp (right_buf, buf, right_size) != 0;						
			delete [] right_buf;
		}
		fclose (right_file);					
	}
	delete buf;*/
	std::ios_base::openmode mode = std::ios::in;
	if (as_binary) {
		mode |= std::ios::binary;
	}
	
	std::ifstream first_is (first, mode);
	std::ifstream second_is (second, mode);
	if (!first_is || !second_is) {
		throw InvalidPath();
	}
	
	//читаем файлы в память
	std::string first_file_content;	
	std::copy(
		std::istreambuf_iterator<char>(first_is)
		, std::istreambuf_iterator<char>()
		, std::back_inserter(first_file_content)
	);
	first_is.close ();

	std::string second_file_content;	
	std::copy(
		std::istreambuf_iterator<char>(second_is)
		, std::istreambuf_iterator<char>()
		, std::back_inserter(second_file_content)
	);
	second_is.close ();

	return ACE_OS::strcmp (first_file_content.c_str (), second_file_content.c_str ());
	//#UC END# *49ED6DBD005D*
}

// копирует файл с возможностью перезаписи
void copy_file (const char* from, const char* to, bool overwrite) /*throw (FOException)*/ {
	//#UC START# *4503DF4D0000*
		if (strcmp(from, to) == 0) {
		return; // nothing to do
	}
	if (!overwrite) {
		if (ACE_OS::access(to, F_OK) != -1) { // but file exists
			throw_last_error(EEXIST);
			return;
		}
	}
	ACE_HANDLE hfrom = ACE_OS::open(from, O_RDONLY | O_BINARY);
	if (hfrom == ACE_INVALID_HANDLE) {
		throw_last_error(ACE_OS::last_error());
		return;
	}
	ACE_HANDLE hto = ACE_OS::open(to, O_WRONLY | O_BINARY | O_CREAT | O_TRUNC);
	if (hto == ACE_INVALID_HANDLE) {
		ACE_OS::close(hfrom);
		throw_last_error(ACE_OS::last_error());
		return;
	}
	char buf[MY_BUFSIZ]; // on stack, due to reentrant reason
	ssize_t r = 0;
	while ( (r=ACE_OS::read(hfrom, buf, MY_BUFSIZ)) > 0) {
		if (ACE_OS::write(hto, buf, r) < r) {
			ACE_OS::close(hfrom);
			ACE_OS::close(hto);
			throw_last_error(ACE_OS::last_error());
			return;
		}
	}
	if (r == -1) {
		ACE_OS::close(hfrom);
		ACE_OS::close(hto);
		throw_last_error(ACE_OS::last_error());
		return;
	}
	ACE_OS::close(hfrom);
	ACE_OS::close(hto);
	//#UC END# *4503DF4D0000*
}

// переносит файл с возможностью перезаписи
void move_file (const char* from, const char* to, bool overwrite) /*throw (FOException)*/ {
	//#UC START# *4507E9600177*
	if (!overwrite) {
		if (ACE_OS::access(to, F_OK) != -1) { // but file exists
			throw_last_error(EEXIST);
			return;
		}
	}
	int res = ACE_OS::rename(from, to); // ACE takes care to copy if needed
	if (res == -1) {
		throw_last_error(ACE_OS::last_error()); 
		return;
	}
	//#UC END# *4507E9600177*
}

// удаляет файл
void remove_file (const char* from) /*throw (FOException)*/ {
	//#UC START# *4507E98D02EE*
	int res = ACE_OS::unlink(from);
	if (res == -1) {
		throw_last_error(ACE_OS::last_error()); 
		return;
	}
	//#UC END# *4507E98D02EE*
}

} // namespace FileOp
} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

