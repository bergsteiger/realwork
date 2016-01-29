//
// ServerConnect.h : header file
//

#ifndef __SERVER_CONNECT_H__
#define __SERVER_CONNECT_H__

#ifndef __AFXINET_H_
#include "afxinet.h"
#endif

#include "shared/Internet/Manage/ConnectManager.h"

struct InetException {
	static std::string what (CInternetException* ex) {
		std::string ret;

		if (ex) {
			if (ex->m_dwError == ERROR_INTERNET_TIMEOUT) {}

			char buf [1024];
			ex->GetErrorMessage (buf, sizeof (buf));
			ex->Delete ();
			ret = buf;
		}

		return ret;
	}
};

///////////////////////////////////////////////////////////////////////////////////////////

class Connection {
public:
	Connection (Internet::IConnection* obj);

	virtual ~Connection ();

public:
	bool open_request (const char* str_obj, const char* headers = 0);

	bool send_request ();

	bool execute_request (const std::string& str_obj);

	const std::string& get_err_msg () const {
		return m_err_msg;
	}

private:
	Internet::IConnection* m_connection;

	std::string m_err_msg;
};

#endif // #ifndef __SERVER_CONNECT_H__

