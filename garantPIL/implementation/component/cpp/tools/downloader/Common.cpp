//
// Common.cpp : implementation file
//
#include "ace/ACE.h"

#include "shared/GCL/alg/cryptography.h"

#include "boost/lexical_cast.hpp"
#include <winsock.h>

#include "gardefs.h"
#include "Common.h"

/////////////////////////////////////////////////////////////////////////////////////

std::string CryptHelper::decode (const std::string& str) {
	if (str.empty ()) {
		return str;
	}

	GDS_ASSERT (str.size () < 1024);

	unsigned char buf [1024];

	int j = 0;

	for (unsigned i = 0; i < str.size (); i += 2) {
		int code = ('A' <= str [i] && 'F' >= str [i]) ? 16 * (str [i] - 65 + 10) : 16 * (str [i] - 48);
		code += ('A' <= str [i + 1] && 'F' >= str [i + 1]) ? (str [i + 1] - 65 + 10) : (str [i + 1] - 48);
		buf [j++] = code;
	}

	GCL::SimpleCrypto::Buffer buf_in ((void*) buf, j);
	GCL::SimpleCrypto::Buffer buf_out;
	GCL::SimpleCrypto cryp;

	cryp.decrypt (buf_in, buf_out);

	GDS_ASSERT (buf_out.m_len < 1024);

	char* ret_buf = (char*) malloc ((buf_out.m_len + 1) * sizeof (char));
	memcpy (ret_buf, buf_out.m_buf, buf_out.m_len);
	ret_buf [buf_out.m_len] = '\0';
	std::string ret = ret_buf;
	free (ret_buf);

	return ret;
}

std::string CryptHelper::encode (const std::string& str) {
	if (str.empty ()) {
		return str;
	}

	GCL::SimpleCrypto::Buffer buf_in ((void*) str.c_str (), str.size ());
	GCL::SimpleCrypto::Buffer buf_out;
	GCL::SimpleCrypto cryp;

	cryp.encrypt (buf_in, buf_out);

	GDS_ASSERT (buf_out.m_len * 2 < 2048);

	char buffer [2048];

	for (long i = 0; i < buf_out.m_len; i++) {
		unsigned int c = *(static_cast <unsigned char*> (buf_out.m_buf) + i);
		sprintf (buffer + i * 2, "%.2X\0", c);
	}

	std::string ret = buffer;
	return ret;
}

/////////////////////////////////////////////////////////////////////////////////////

static std::string make_mm_dd_yyyy (int day, int month, int year) {
	std::string ret;

	std::string str = boost::lexical_cast <std::string> (month);
	
	if (str.size () < 2) {
		ret += "0";
	}

	ret += str + "-";
	
	str = boost::lexical_cast <std::string> (day);

	if (str.size () < 2) {
		ret += "0";
	}

	ret += str + "-";
	ret += boost::lexical_cast <std::string> (year);
	return ret;
}

static std::string make_dd_mm_yyyy (int day, int month, int year) {
	std::string ret;

	std::string str = boost::lexical_cast <std::string> (day);
	
	if (str.size () < 2) {
		ret += "0";
	}

	ret += str + "-";
	
	str = boost::lexical_cast <std::string> (month);

	if (str.size () < 2) {
		ret += "0";
	}

	ret += str + "-";
	ret += boost::lexical_cast <std::string> (year);
	return ret;
}

static date plus_days (date val, short days) {
	time_t time_val;

	struct tm atm;
	struct tm *ptm;

	memset (&atm, 0, sizeof (atm));

	atm.tm_year = val.da_year - 1900;
	atm.tm_mday = val.da_day;
	atm.tm_mon  = val.da_mon - 1;

	time_val = mktime (&atm); 
	time_val += (long) days * 24l * 3600l;
	ptm = localtime (&time_val);

	if (ptm) {
		val.da_year = ptm->tm_year + 1900; 
		val.da_day = ptm->tm_mday; 
		val.da_mon = ptm->tm_mon + 1;	 
	}

	return val;
}

static long make_julian (int d, int m, int y) {
	if (m > 2) {
		m -= 3;
	} else {
		m += 9;
		y--;
	}

	y -= 1600;

	return ((long (y / 100) * 146097) / 4) + ((long (y % 100) * 1461) / 4) + (((153 * m) + 2) / 5) + d + 59;
}

static int day_of_week (int d, int m, int y) {
	return (int) ((make_julian (d, m, y) + 6) % 7) + 1;
}

void init_week (std::string& date_str, std::string& date_str_ok, short days) {
	int day, d, m, y;

	sscanf (date_str.c_str (), "%d-%d-%d", &m, &d, &y);
	day = day_of_week (d, m, y);

	while (day != 7) {
		date adate;
		adate.da_day = d;
		adate.da_mon = m;
		adate.da_year= y;
		adate = plus_days (adate, days);
		d = adate.da_day;
		m = adate.da_mon;
		y = adate.da_year;
		day = day_of_week (d, m, y);
	}

	date_str = make_mm_dd_yyyy (d, m, y);
	date_str_ok = make_dd_mm_yyyy (d, m, y);
}

/////////////////////////////////////////////////////////////////////////////////////

std::string get_windows_version () {
	std::string ret;

	OSVERSIONINFOEX osvi;
	BOOL bOsVersionInfoEx;

	// Try calling GetVersionEx using the OSVERSIONINFOEX structure.
	// If that fails, try using the OSVERSIONINFO structure.

	ZeroMemory (&osvi, sizeof (OSVERSIONINFOEX));
	osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFOEX);

	if (!(bOsVersionInfoEx = GetVersionEx ((OSVERSIONINFO *) &osvi))) {
		// If OSVERSIONINFOEX doesn't work, try OSVERSIONINFO.
		osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
		if (!GetVersionEx ((OSVERSIONINFO *) &osvi)) { 
			ret += "Unknown";
			return ret;
		}
	}

	switch (osvi.dwPlatformId) {
		case VER_PLATFORM_WIN32_NT:
			if (osvi.dwMajorVersion == 3) {
				if (osvi.dwMinorVersion == 51) {
					ret += "Microsoft Windows NT 3.51 ";
				} else if (osvi.dwMinorVersion == 5) {
					ret += "Microsoft Windows NT 3.5 ";
				}
			}

			if (osvi.dwMajorVersion == 4 && osvi.dwMinorVersion == 0) {
				ret += "Microsoft Windows NT 4.0 ";
			}

			if (osvi.dwMajorVersion == 5) {
				if (osvi.dwMinorVersion == 0) {
					ret += "Microsoft Windows 2000 ";
				} else if (osvi.dwMinorVersion == 1) {
					ret += "Microsoft Windows XP ";
				} else {
					ret += "Microsoft Windows ";
				}
			}

			if (osvi.dwMajorVersion == 6) {
				if (osvi.dwMinorVersion == 0) {
					ret += "Microsoft Windows Vista ";
				} else if (osvi.dwMinorVersion == 1) { 
					ret += "Microsoft Windows 7 ";
				} else if (osvi.dwMinorVersion == 2) {
					ret += "Microsoft Windows 8 ";
				} else if (osvi.dwMinorVersion == 3) {
					ret += "Microsoft Windows 8.1 ";
				} else {
					ret += "Microsoft Windows ";
				}
			}

			// Test for product type.

			if (osvi.wProductType == VER_NT_WORKSTATION) {
				ret += "Workstation / ";
			} else if (osvi.wProductType == VER_NT_SERVER) {
				ret += "Server / ";
			}

			// Display version, service pack (if any), and build number.

			char buffer [200]; 

			if (osvi.dwMajorVersion <= 4) {
				sprintf (
					buffer
					, "version %d.%d %s (Build %d)"
					, osvi.dwMajorVersion
					, osvi.dwMinorVersion
					, osvi.szCSDVersion
					, osvi.dwBuildNumber & 0xFFFF
				);
			} else { 
				sprintf (
					buffer
					, "%s (Build %d)"
					, osvi.szCSDVersion
					, osvi.dwBuildNumber & 0xFFFF
				);
			}

			ret += buffer; 
			ret += " ";
			break;

		case VER_PLATFORM_WIN32_WINDOWS:
			if (osvi.dwMajorVersion == 4) {
				if (osvi.dwMinorVersion == 0) {
					ret += "Microsoft Windows 95 ";
					if (osvi.szCSDVersion[1] == 'C') { 
						ret += "OSR2 ";
					}
				} 
				if (osvi.dwMinorVersion == 1 || osvi.dwMinorVersion == 10) {
					ret += "Microsoft Windows 98 ";
					if (osvi.szCSDVersion[1] == 'A') { 
						ret += "SE ";
					}
				} 
				if (osvi.dwMinorVersion == 90) {
					ret += "Microsoft Windows Me ";
				} 
			}
			break;

		case VER_PLATFORM_WIN32s:
			ret += "Microsoft Win32s ";
			break;
	}

	return ret; 
}

std::string get_last_error () {
	LPVOID msg_buf;

	DWORD flags = FORMAT_MESSAGE_ALLOCATE_BUFFER 
		| FORMAT_MESSAGE_FROM_SYSTEM 
		| FORMAT_MESSAGE_IGNORE_INSERTS;

	FormatMessage (flags, NULL, GetLastError (), 0, (LPTSTR) &msg_buf, 0, NULL);

	std::string ret = (const char*) msg_buf;

	LocalFree (msg_buf);

	size_t ret_size = ret.size ();

	if (ret_size && ret [ret_size - 1] == '\n') {
		ret = ret.substr (0, ret_size - 1);
	}

	return ret;
}

std::string get_user_agent () {
	std::string ret;

	HKEY reg_key;

	BYTE buffer [64];
	memset (buffer, 0, sizeof (buffer));
				
	DWORD type, data_size;
				
	LONG ret_code = RegOpenKeyEx (
		HKEY_CURRENT_USER
		, _T("Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings")
		, 0
		, KEY_READ
		, &reg_key
	);
				
	if (ret_code == ERROR_SUCCESS) {
		if (RegQueryValueEx (reg_key, "User Agent", NULL, &type, NULL, &data_size) == ERROR_SUCCESS) {
			if (RegQueryValueEx (reg_key, "User Agent", NULL, &type, (LPBYTE) buffer, &data_size) == ERROR_SUCCESS) {
				ret.assign ((const char*) buffer);
			}
			
			RegCloseKey (reg_key);
		}
	}

	if (ret.empty ()) {
		ret = AfxGetAppName ();
	}

	return ret;
}

// Определение локального IP адреса
std::string get_local_ip_addr () {
	std::string ret;

	WSADATA wsa_data;

	WORD version_requested = MAKEWORD (1, 1);
	
	if (WSAStartup (version_requested, &wsa_data) == 0) {
		char name [255];

		if (gethostname (name, sizeof (name)) == 0)	{
			PHOSTENT host_info = gethostbyname (name);

			if (host_info) {
				ret = inet_ntoa (*(struct in_addr *)*host_info->h_addr_list);
			}
		}

		WSACleanup ();
	} 

	return ret;
}

// Определение IP адреса хоста
std::string get_ip_addr (const char* host) {
	std::string ret;

	WSADATA wsa_data;

	struct in_addr iaddr;

	WORD version_requested = MAKEWORD (1, 1);
	
	if (WSAStartup (version_requested, &wsa_data) == 0) {
		iaddr.s_addr = inet_addr (host);

		if (iaddr.s_addr == INADDR_NONE) {
			PHOSTENT host_info = gethostbyname (host);

			if (host_info) {
				ret = inet_ntoa (*(struct in_addr *)*host_info->h_addr_list);
			} else {
				throw std::exception ();
			}
		} else { 
			ret = host;
		}

		WSACleanup ();
	}

	return ret;
}

// end of...
