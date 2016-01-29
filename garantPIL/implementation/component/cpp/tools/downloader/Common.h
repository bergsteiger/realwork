//
// Common.h : header file
//

#if !defined __COMMON_H
#define __COMMON_H

#include <string>

class CryptHelper {
public:
	static std::string decode (const std::string& key);
	static std::string encode (const std::string& str);
};

void init_week (std::string& date_str, std::string& date_str_ok, short days);

std::string get_windows_version ();
std::string get_last_error ();
std::string get_user_agent ();
std::string get_local_ip_addr ();
std::string get_ip_addr (const char* host);

#endif // !defined __COMMON_H

