#ifndef _GCL_WININET_
#define _GCL_WININET_

#include <string>
#include <stdexcept>

#include "ace/os_include/os_dlfcn.h"
#include "shared/Core/sys/Exception.h"

// [test]:
//#include "utils/WinInet.h"
//#include <iostream>
//int main (int argc, char* argv[]) {
//	
//	std::string host;
//	unsigned long port;
//
//	try {
//		GCL::WinInet inet;
//		inet.get_proxy_info (host, port);
//	} catch (GCL::WinInet::Error& e) {
//		std::cout << e.what ();
//	}
//
//	return 0;
//}
// :[test]
 

namespace Adapters {
	
class WinInet {
public:
	class LibraryLoadError : public Core::Exception {
		const char* what () const throw () {
			return "Can't load WinInet.dll";
		}
		const char* uid () const /*throw ()*/ {
			return "Adapters::WinInet::LibraryLoadError";
		}		
	};

	class FunctionLoadError : public Core::Exception {
		const char* what () const throw () {
			return "GetProcAddress for 'InternetQueryOptionA' fails";
		}
		const char* uid () const /*throw ()*/ {
			return "Adapters::WinInet::FunctionLoadError";
		}		
	};

	class ProxyError : public Core::Exception {
		const char* what () const throw () {
			return "Invalid proxy info format";
		}
		const char* uid () const /*throw ()*/ {
			return "Adapters::WinInet::ProxyError";
		}		
	};

public:
	WinInet ();
	~WinInet ();
	
	void get_proxy_info (std::string& host, unsigned short& port);
	//void get_proxy_auth_info (std::string& login,	std::string& password);
	
private:
	ACE_SHLIB_HANDLE m_handle;
};

} // namespace Adapters

#endif // _GCL_WININET_
