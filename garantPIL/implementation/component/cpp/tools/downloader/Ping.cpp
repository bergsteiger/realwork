//
// Ping.cpp, implementation file
//

#include "stdafx.h"

#include <winsock.h>

#include "resource.h"
#include "Ping.h"

class WSAInit {
public:
	WSAInit () : m_is_init (true) {
		WORD version_requested = MAKEWORD (1, 1);

		WSADATA wsa_data;

		if (WSAStartup (version_requested, &wsa_data)) { // init WinSock
			m_is_init = false;
		} else if (version_requested != wsa_data.wVersion) {  // check WinSock version
			m_is_init = false; // WinSock not support
		}
	}

	~WSAInit () {
		if (m_is_init) {
			WSACleanup ();
		}
	}

	inline bool is_init () const {
		return m_is_init;
	}

private:
	bool m_is_init;
};

/////////////////////////////////////////////////////////////////////////////

CPing::CPing () 
	: m_handle (0)
	, m_is_init (false) 
	, icmp_send_echo (0)
	, icmp_create_file (0)
	, icmp_close_handle (0)
{
	m_handle = LoadLibrary ("ICMP.DLL");
}

CPing::~CPing () {
	if (m_handle) {
		FreeLibrary ((HMODULE) m_handle);
	}
}

unsigned int CPing::init () {
	if (m_handle == 0) {
		return IDS_ERROR_NOT_LOAD_DLL;
	}

	// Retrieve ICMP function pointers

	icmp_create_file = (HANDLE (WINAPI*) ())
		GetProcAddress ((HMODULE) m_handle, "IcmpCreateFile");

	icmp_close_handle = (BOOL (WINAPI*) (HANDLE))
		GetProcAddress ((HMODULE) m_handle, "IcmpCloseHandle");

	icmp_send_echo = (DWORD (WINAPI*) (HANDLE, DWORD, LPVOID, WORD, PIP_OPTION_INFORMATION, LPVOID, DWORD, DWORD))
		GetProcAddress ((HMODULE) m_handle, "IcmpSendEcho");

	if (icmp_create_file == 0 || icmp_close_handle == 0 || icmp_send_echo == 0) { // check all the function pointers
		return IDS_ERROR_LOAD_DLL;
	}

	m_is_init = true;
	return 0;
}

bool CPing::ping (const char* host) {

	WSAInit wsa_init;

	if (wsa_init.is_init () == false || m_is_init == false) {
		return false;
	}

	struct in_addr iaDest;  // internet address structure

	LPHOSTENT host_ent = 0; // pointer to host entry structure

    // Use inet_addr () to determine if we're dealing with a name or an address

    iaDest.s_addr = inet_addr (host);

    if (iaDest.s_addr == INADDR_NONE) {
		host_ent = gethostbyname (host);
	} else {
        host_ent = gethostbyaddr ((const char*) &iaDest, sizeof (struct in_addr), AF_INET);
	}
	
	if (host_ent == 0) {
		return false;
	}
	
	IPAddr* dest_addr = (IPAddr*) (*host_ent->h_addr_list); // copy the IP address
	HANDLE file_handle = icmp_create_file (); // get an ICMP echo request handle        

	// Set some reasonable default values

	IP_OPTION_INFORMATION ip_info;

	ip_info.Ttl = 255;
	ip_info.Tos = 0;
	ip_info.Flags = 0;
	ip_info.OptionsSize = 0;
	ip_info.OptionsData = NULL;

	ICMP_ECHO_REPLY icmp_echo;	// ICMP echo reply buffer

	icmp_echo.Status = 0;

	// Request an ICMP echo

	icmp_send_echo (
		file_handle		// handle from IcmpCreateFile ()
		, *dest_addr	// destination IP address
		, NULL			// pointer to buffer to send
		, 0				// size of buffer in bytes
		, &ip_info 		// request options
		, &icmp_echo	// reply buffer
		, sizeof (struct icmp_echo_reply)
		, 1000  		// time to wait in milliseconds
	);

	iaDest.s_addr = icmp_echo.Address;

	if (icmp_echo.Status) { 
		return false; 
	}

	icmp_close_handle (file_handle); // close the echo request file handle

	return true;
}

// end of..
