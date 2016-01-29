//
// Ping.h: interface for the CPing class.
//

#ifndef __PING_H
#define __PING_H

#include "stdafx.h"

#include "Ipexport.h"

class CPing {
public:
	CPing ();

	~CPing ();

	bool ping (const char* host);

	unsigned int init ();

private:
	// ICMP.DLL export function pointers

	HANDLE (WINAPI *icmp_create_file ) ();
	BOOL   (WINAPI *icmp_close_handle) (HANDLE);
	DWORD  (WINAPI *icmp_send_echo   ) (HANDLE, DWORD, LPVOID, WORD, PIP_OPTION_INFORMATION, LPVOID, DWORD, DWORD);

private:
	HANDLE m_handle; // ICMP.DLL file handle
	bool m_is_init;  // if it doesn't construct properly, it won't be valid
};

#endif // !defined(__PING_H)
