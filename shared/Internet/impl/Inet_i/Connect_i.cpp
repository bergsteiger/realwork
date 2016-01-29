////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/Connect_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connect_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/LibHome.h"
#include "shared/Internet/impl/Inet_i/Connect_i.h"
// by <<uses>> dependencies
#include "shared/Internet/impl/Inet_i/Utility.h"

namespace Internet {
namespace Inet_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const size_t Connect_i::ATTEMPT_CONNECTION = 5; // число попыток для определения наличия подключения к интернет

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Connect_i::Connect_i (const InternetAccessInfo& info)
//#UC START# *4ABCE7A60385_4ABCE98F01AF_4ABCF0B3006A_BASE_INIT*
	: m_connect_counter (0)
	, m_info (info)
//#UC END# *4ABCE7A60385_4ABCE98F01AF_4ABCF0B3006A_BASE_INIT*
{
	//#UC START# *4ABCE7A60385_4ABCE98F01AF_4ABCF0B3006A_BODY*
	//#UC END# *4ABCE7A60385_4ABCE98F01AF_4ABCF0B3006A_BODY*
}

Connect_i::~Connect_i () {
	//#UC START# *4ABCF0B3006A_DESTR_BODY*
	this->close ();
	//#UC END# *4ABCF0B3006A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// закрыть соединение
void Connect_i::close () {
	//#UC START# *4AC06BFA02AB*
	if (m_connection.is_nil () == false) { 
		m_connection->Close (); 
	}
	if (m_session.is_nil () == false) { 
		m_session->Close (); 
	}
	//#UC END# *4AC06BFA02AB*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IConnect
// установить соединение с заданным хостом
void Connect_i::execute (const std::string& host_name, const std::string& user_agent) {
	//#UC START# *4ABCE942002E_4ABCF0B3006A*
	if (m_connect_counter) {
		return; // если соединение установлено, то ничего не делаем
	}

	if (Utility::has_internet_connection_ex (ATTEMPT_CONNECTION) == false) {
		throw ConnectionFailed ();
	}

	std::string proxy_name;

	if (m_info.access_type == INTERNET_OPEN_TYPE_PROXY) {
		proxy_name = m_info.proxy_info.host;
		proxy_name += ":";
		proxy_name += m_info.proxy_info.port;

		if (m_info.proxy_info.is_authentication) { // авторизация на прокси
			INTERNET_PROXY_INFO proxy_info;

			proxy_info.dwAccessType = INTERNET_OPEN_TYPE_PROXY;
			proxy_info.lpszProxy = proxy_name.c_str ();
			proxy_info.lpszProxyBypass = "";

			HRESULT res;
			res = ::UrlMkSetSessionOption (INTERNET_OPTION_PROXY, &proxy_info, sizeof (INTERNET_PROXY_INFO), 0);
		}
	} 

	INTERNET_PORT internet_port;

	try {
		DWORD service_type;
		CString str_server, str_obj;
		std::string str_URL = std::string ("http://") + host_name;
		BOOL is_parse = AfxParseURL (str_URL.c_str (), service_type, str_server, str_obj, internet_port);
	} catch (...) {
		throw ParseURLException ();
	}

	const char* proxy_name_str = (proxy_name.empty ())? NULL : proxy_name.c_str ();

	m_session = new InternetSession (user_agent.c_str (), m_info.access_type, proxy_name_str); 

	//if (m_session->EnableStatusCallback (TRUE)) {}

	m_connection = m_session->GetHttpConnection (host_name.c_str (), internet_port, 0, 0);

	if (m_info.access_type == INTERNET_OPEN_TYPE_PROXY && m_info.proxy_info.is_authentication) {
		const std::string& login = m_info.proxy_info.login;
		m_connection->SetOption (INTERNET_OPTION_PROXY_USERNAME, (LPVOID) login.c_str (), (DWORD) login.size ());
		const std::string& password = m_info.proxy_info.password;
		m_connection->SetOption (INTERNET_OPTION_PROXY_PASSWORD, (LPVOID) password.c_str (), (DWORD) password.size ());
	}

	++m_connect_counter;
	//#UC END# *4ABCE942002E_4ABCF0B3006A*
}

// implemented method from IConnect
// возвращаем установленное соединение
IConnection* Connect_i::get_connection () {
	//#UC START# *4ABCEA600216_4ABCF0B3006A*
	GDS_ASSERT (m_session.is_nil () == false && m_connection.is_nil () == false);

	if (Utility::has_internet_connection_ex (ATTEMPT_CONNECTION) == false) {
		throw ConnectionFailed ();
	}

	IConnection_var ret;

	try {
		ret = IConnectionFactory::make (reinterpret_cast <void*> (m_connection.in ()), m_info.open_query_flags);
	} catch (...) {
		throw ConnectException ();
	}

	return ret._retn ();
	//#UC END# *4ABCEA600216_4ABCF0B3006A*
}

// implemented method from IConnect
// изменить настройки (с закрытием текущего соединения)
void Connect_i::reset (const InternetAccessInfo& info) {
	//#UC START# *4AC5D8C2000C_4ABCF0B3006A*
	this->close ();

	m_connect_counter = 0;
	m_info = info;
	//#UC END# *4AC5D8C2000C_4ABCF0B3006A*
}
} // namespace Inet_i
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

