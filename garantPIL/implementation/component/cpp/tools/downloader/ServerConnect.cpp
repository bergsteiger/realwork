//
// ServerConnect.cpp: implementation file
//

#include "stdafx.h"

#include "resource.h"

#include "LogFile.h"
#include "ServerConnect.h"

Connection::Connection (Internet::IConnection* obj) : m_connection (obj) {
}

Connection::~Connection () {
}

bool Connection::open_request (const char* str_obj, const char* headers) {
	GDS_ASSERT (m_connection);

	bool ret = false;

	m_err_msg.clear ();

	try {
		ret = m_connection->open_request (str_obj, headers);

		if (ret == false) {
			CString str;
			str.Format (IDS_ERROR_HTTP_ERROR);
			DLOG->out_t (str);
		}
	} catch (CInternetException* ex) {
		m_err_msg = InetException::what (ex);
	} catch (Internet::ConnectException& ex) {
		m_err_msg = ex.what ();
	} catch (...) {
		m_err_msg = "unknown exception";
	}

	if (m_err_msg.empty () == false) {
		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, m_err_msg.c_str ());
	}

	return ret;
}

bool Connection::send_request () {
	GDS_ASSERT (m_connection);

	bool ret = false;

	m_err_msg.clear ();

	try {
		ret = m_connection->send_request ();

		if (ret == false) {
			CString str;
			str.Format (IDS_ERROR_HTTP_ERROR);
			DLOG->out_t (str);
		}
	} catch (CInternetException* ex) {
		m_err_msg = InetException::what (ex);
	} catch (Internet::ConnectException& ex) {
		m_err_msg = ex.what ();
	} catch (Internet::IncorrectQuery& ex) {
		m_err_msg = ex.what ();
	} catch (Internet::AccessDenied& ex) {
		m_err_msg = ex.what ();
	} catch (Internet::ObjectNotFound& ex) {
		m_err_msg = ex.what ();
	} catch (Internet::ServerNotSupport& ex) {
		m_err_msg = ex.what ();
	} catch (Internet::QueryError& ex) {
		m_err_msg = ex.what ();
	} catch (Internet::ServerError& ex) {
		m_err_msg = ex.what ();
	} catch (...) {
		m_err_msg = "unknown exception";
	}

	if (m_err_msg.empty () == false) {
		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, m_err_msg.c_str ());
	}

	return ret;
}

bool Connection::execute_request (const std::string& str_obj) {
	return (this->open_request (str_obj.c_str ()) && this->send_request ());
}

// end of...
