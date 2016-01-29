////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Connection_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connection_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/LibHome.h"
#include "shared/Internet/impl/Inet_i/Connection_i.h"

//#UC START# *4AC07F28014A_CUSTOM_INCLUDES*
//#UC END# *4AC07F28014A_CUSTOM_INCLUDES*

namespace Internet {
namespace Inet_i {

//#UC START# *4AC07F28014A*
//#UC END# *4AC07F28014A*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const unsigned long Connection_i::BUF_SIZE = 1024; // размер буффера
const unsigned long Connection_i::REQUEST_TIME_OUT = (60 * 1000) * 180; // время, отведенное для передачи запроса, не связанного с передачей данных (180 мин)

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Connection_i::Connection_i (void* data, unsigned long flags)
//#UC START# *4ABCEA2901D2_4AC065EC0216_4AC07F28014A_BASE_INIT*
	: m_flags (flags)
//#UC END# *4ABCEA2901D2_4AC065EC0216_4AC07F28014A_BASE_INIT*
{
	//#UC START# *4ABCEA2901D2_4AC065EC0216_4AC07F28014A_BODY*
	m_connection = reinterpret_cast <CHttpConnection*> (data);
	//#UC END# *4ABCEA2901D2_4AC065EC0216_4AC07F28014A_BODY*
}

Connection_i::~Connection_i () {
	//#UC START# *4AC07F28014A_DESTR_BODY*
	this->close ();
	//#UC END# *4AC07F28014A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// закрыть объект CHttpFile и освободить все используемые им ресурсы
void Connection_i::close () {
	//#UC START# *4AC6068E033D*
	if (m_http_file.is_nil () == false) {
		m_http_file->Close ();
	}
	//#UC END# *4AC6068E033D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IConnection
// получить длину контента
unsigned long long Connection_i::get_content_length () {
	//#UC START# *4DCA7EB301CB_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);

	try {
		unsigned long long ret = 0;
		unsigned long ret_size = sizeof (ret);

		if (m_http_file->QueryInfo (
			(DWORD) (HTTP_QUERY_CONTENT_LENGTH | HTTP_QUERY_FLAG_NUMBER), &ret, &ret_size, 0)
		) {
			return ret;
		}
	} catch (CInternetException* ex) {
		throw ex;
	} catch (...) {
		throw ConnectException ();
	}

	return 0;
	//#UC END# *4DCA7EB301CB_4AC07F28014A*
}

// implemented method from IConnection
// получить ответ сервера на переданный ему запрос и заголовки самого запроса
void Connection_i::get_info (unsigned long level, std::string& value) {
	//#UC START# *4AC067C50276_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);

	value.clear ();

	try {
		char buf [BUF_SIZE];

		DWORD buf_len = sizeof (buf);

		if (m_http_file->QueryInfo ((DWORD) level, buf, &buf_len, 0)) {
			value = buf;
		} 
	} catch (CInternetException* ex) {
		throw ex;
	} catch (...) {
		throw ConnectException ();
	}
	//#UC END# *4AC067C50276_4AC07F28014A*
}

// implemented method from IConnection
// получить ответ сервера на переданный ему запрос в числовом виде
unsigned long Connection_i::get_info_number (unsigned long level) {
	//#UC START# *4AC0681E0156_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);

	try {
		unsigned long ret = 0, ret_size = sizeof (ret);

		if (m_http_file->QueryInfo ((DWORD) (level | HTTP_QUERY_FLAG_NUMBER), &ret, &ret_size, 0)) {
			return ret;
		}
	} catch (CInternetException* ex) {
		throw ex;
	} catch (...) {
		throw ConnectException ();
	}

	return 0;
	//#UC END# *4AC0681E0156_4AC07F28014A*
}

// implemented method from IConnection
// установить соединение с сервером
bool Connection_i::open_request (const char* str_obj, const char* headers) {
	//#UC START# *4AC066130232_4AC07F28014A*
	bool ret = false;

	GDS_ASSERT (m_connection);

	try {
		this->close ();

		m_http_file = m_connection->OpenRequest (
			CHttpConnection::HTTP_VERB_GET
			, (LPCTSTR) str_obj
			, NULL
			, 1
			, NULL
			, NULL
			, m_flags
		);

		if (m_http_file.is_nil () == false) {
			m_http_file->SetOption (INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT, REQUEST_TIME_OUT);

			if (headers) {
				m_http_file->AddRequestHeaders (headers);
			}

			ret = true;
		}
	} catch (CInternetException* ex) {
		throw ex;
	} catch (...) {
		throw ConnectException ();
	}

	return ret;
	//#UC END# *4AC066130232_4AC07F28014A*
}

// implemented method from IConnection
// чтение данных
unsigned int Connection_i::read (void* buffer, unsigned int count) {
	//#UC START# *4AC098820022_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);
	return (unsigned int) m_http_file->Read (buffer, (UINT) count);
	//#UC END# *4AC098820022_4AC07F28014A*
}

// implemented method from IConnection
// позиционирование в файле
unsigned long long Connection_i::seek (long long offset, unsigned int from) {
	//#UC START# *4AEF1F30024C_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);
	return ((unsigned long long) m_http_file->Seek ((LONGLONG) offset, (UINT) from));
	//#UC END# *4AEF1F30024C_4AC07F28014A*
}

// implemented method from IConnection
// передать подготовленный запрос на сервер WWW
bool Connection_i::send_request () {
	//#UC START# *4AC067910387_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);

	bool ret = false;

	try {
		ret = (m_http_file->SendRequest () == TRUE); 
	} catch (CInternetException* ex) {
		throw ex;
	} catch (...) {
		throw ConnectException ();
	}

	BOOL res = false; 

	DWORD status_code;

	try {
		res = m_http_file->QueryInfoStatusCode (status_code);
	} catch (CInternetException* ex) {
		throw ex;
	} catch (...) {
		throw ConnectException ();
	}

	if (res && status_code != HTTP_STATUS_OK) {
		if (status_code == HTTP_STATUS_BAD_REQUEST) { // invalid syntax
			throw IncorrectQuery ();
		} else if (status_code == HTTP_STATUS_DENIED) { // access denied
			throw AccessDenied ();
		} else if (status_code == HTTP_STATUS_NOT_FOUND) { // object not found
			throw ObjectNotFound ();
		} else if (status_code == HTTP_STATUS_BAD_METHOD) { // server not support
			throw ServerNotSupport ();
		} else if (status_code == HTTP_STATUS_SERVER_ERROR) { // internal server error
			throw ServerError ();
		} else if (status_code >= 400 && status_code < 500) { // query error
			throw QueryError ();
		} else if (status_code >= 500 && status_code < 600) { // server error
			throw ServerError ();
		}
	}
	
	return ret;
	//#UC END# *4AC067910387_4AC07F28014A*
}

// implemented method from IConnection
// установка параметров сеанса связи
void Connection_i::set_option (unsigned long option, unsigned long value) {
	//#UC START# *4ACAE76502F7_4AC07F28014A*
	GDS_ASSERT (m_http_file.is_nil () == false);
	m_http_file->SetOption ((DWORD) option, (DWORD) value);
	//#UC END# *4ACAE76502F7_4AC07F28014A*
}
} // namespace Inet_i
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

