#include "ace/ACE.h"

#include "shared/Core/mng/Aptr.h"
#include <WinInet.h>
#include "shared/Adapters/WinInet/WinInet.h"

namespace Adapters {

WinInet::WinInet () : m_handle (ACE_SHLIB_INVALID_HANDLE) {

	const ACE_TCHAR* name = (
		ACE_DLL_PREFIX \
		ACE_TEXT ("Wininet") \
		ACE_DLL_SUFFIX
	);

	m_handle = ACE_OS::dlopen (name);

	if (m_handle == ACE_SHLIB_INVALID_HANDLE) {
		throw LibraryLoadError ();
	}
}
	
WinInet::~WinInet () {
	try {
		if (m_handle != ACE_SHLIB_INVALID_HANDLE) {
			ACE_OS::dlclose (m_handle);
		}
	} catch (...) {
	}
}
	
void WinInet::get_proxy_info (std::string& host, unsigned short& port) {

	typedef BOOL (__stdcall *FunctionPtr) (HINTERNET, DWORD, LPVOID, LPDWORD);
	FunctionPtr function_ptr = (FunctionPtr) ACE_OS::dlsym (m_handle, ACE_TEXT ("InternetQueryOptionA"));

	if (!function_ptr) {
		throw FunctionLoadError ();
	}

	DWORD size (0);
	function_ptr (NULL, INTERNET_OPTION_PROXY, 0, &size);
	// HRESULT h = HRESULT_FROM_WIN32 (GetLastError ());

	Core::Aptr <char, Core::ArrayDeleteDestructor<char> > data (new char [size]);
	if (!function_ptr (NULL, INTERNET_OPTION_PROXY, data.ptr (), &size)) {
		throw FunctionLoadError ();
	}

	const INTERNET_PROXY_INFO* proxy_info = (INTERNET_PROXY_INFO*) data.in ();
	if (!proxy_info->lpszProxy) {
		host = "";
		port = 0;
	} else {
		std::string info (proxy_info->lpszProxy);
		size_t pos = info.rfind (':');
		if (pos == std::string::npos) {
			throw ProxyError ();
		}
		host = info.substr (0, pos);
		info.erase (0, pos + 1);
		port = static_cast<unsigned short> (atol (info.c_str ()));
	}
}


//void WinInet::get_proxy_auth_info (std::string& login,	std::string& password) {
//
//	typedef BOOL (__stdcall *FunctionPtr) (HINTERNET, DWORD, LPVOID, LPDWORD);
//	FunctionPtr function_ptr = (FunctionPtr) GetProcAddress (m_handle, "InternetQueryOptionA");

//	if (!function_ptr) {
//		throw FunctionLoadError ();
//	}

//	{
//		char* data (0);
//		DWORD size (0);
//		res = function_ptr (NULL, INTERNET_OPTION_PROXY_USERNAME, data, &size);
//		
//		data = new char [size];
//		res = function_ptr (NULL, INTERNET_OPTION_PROXY_USERNAME, data, &size);
//		login = data;
//		delete [] data;
//	}

//	{
//		char* data (0);
//		DWORD size (0);
//		res = function_ptr (NULL, INTERNET_OPTION_PROXY_PASSWORD, data, &size);
//	
//		data = new char [size];
//		res = function_ptr (NULL, INTERNET_OPTION_PROXY_PASSWORD, data, &size);
//		password = data;
//		delete [] data;
//	}
//}

} // namespace Adapters


