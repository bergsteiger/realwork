//
// DownloadProcess.h : header file
//

#ifndef __DOWNLOAD_PROCESS_H__
#define __DOWNLOAD_PROCESS_H__

#include "ace/Singleton.h"
#include <string>

#include "boost/lexical_cast.hpp"

/////////////////////////////////////////////////////////////////////////////
// ScriptManager utility class 

class ScriptManager {
public:
	ScriptManager () : m_is_auto (false), m_is_strong (false) {
	}

	ScriptManager (bool is_auto, bool is_strong, const char* login, const std::string& key) {
		this->init (is_auto, is_strong, login, key);
	}

public:
	void init (bool is_auto, bool is_strong, const char* login, const std::string& key) {
		GDS_ASSERT (login);

		m_login = login;
		m_is_auto = is_auto;
		m_is_strong = is_strong; 

		if (key.empty () == false) {
			m_personification_key = key;
		}
	}

	std::string get_authorization_script (const char* password) {
		GDS_ASSERT (password);

		std::string ret = "/delta/auth?login=";
		ret += m_login;
		ret += "&password=";
		ret += password;
		ret += "&key=";
		ret += m_personification_key;

		return ret;
	}

	std::string create_order (long id, const std::string& from, const std::string& to) {
		std::string ret = "/delta/order/create?complect_id=";
		ret += boost::lexical_cast <std::string> (id);
		ret += "&from_date=";
		ret += from;
		ret += "&to_date=";
		ret += to;
		ret += "&login=";
		ret += m_login;
		if (m_personification_key.size ()) {
			ret += "&key=";
			ret += m_personification_key;
		}

		if (m_is_strong && m_is_auto) {
			ret += "&strong=1";
		} else {
			ret += "&strong=0";
		}

		return ret;
	}

	std::string check_order (unsigned long id) {
		std::string ret = "/delta/order/check?order_id=";
		ret += boost::lexical_cast <std::string> (id);
		return ret;
	}

	std::string download_link (unsigned long id) {
		std::string ret = "/delta/order/download?order_id=";
		ret += boost::lexical_cast <std::string> (id);
		ret += "&login=";
		ret += m_login;
		return ret;
	}

	std::string successful_complete (unsigned long id) {
		std::string ret = "/delta/order/complete?event_id=";
		ret += boost::lexical_cast <std::string> (id);
		ret += "&login=";
		ret += m_login;
		return ret;
	}

private:
	bool m_is_auto;
	bool m_is_strong;

	std::string m_login;
	std::string m_personification_key;
};

typedef ACE_Singleton <ScriptManager, Core::NullMutex> ScriptManagerSingleton;

#endif // #ifndef __DOWNLOAD_PROCESS_H__
