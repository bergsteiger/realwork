////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/Inet/Inet.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Internet::Inet
//
// Интерфейсы и типы для работы с интернет.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Inet/Inet.h"
#include "shared/Internet/Inet/InetFactories.h"

namespace Internet {

ProxyInfo::ProxyInfo (const ProxyInfo& copy) 
//#UC START# *4AC053B70040_COPY_CTOR_BASE_INIT*
//#UC END# *4AC053B70040_COPY_CTOR_BASE_INIT*
{
	//#UC START# *4AC053B70040_COPY_CTOR*
	host = copy.host;
	port = copy.port;
	login = copy.login;
	password = copy.password;
	is_authentication = copy.is_authentication;
	//#UC END# *4AC053B70040_COPY_CTOR*
}

ProxyInfo& ProxyInfo::operator = (const ProxyInfo& copy) {
	//#UC START# *4AC053B70040_ASSIGN_OP*
	host = copy.host;
	port = copy.port;
	login = copy.login;
	password = copy.password;
	is_authentication = copy.is_authentication;
	//#UC END# *4AC053B70040_ASSIGN_OP*
	return *this;
}
// factory interface wrapper for IConnection
IConnection* IConnectionFactory::make (
	void* data
	, unsigned long flags
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IConnectionFactoryManager::Singleton::instance ()->make (data, flags);
}

InternetAccessInfo::InternetAccessInfo (const InternetAccessInfo& copy) 
//#UC START# *4ABCE82801C2_COPY_CTOR_BASE_INIT*
//#UC END# *4ABCE82801C2_COPY_CTOR_BASE_INIT*
{
	//#UC START# *4ABCE82801C2_COPY_CTOR*
	access_type = copy.access_type;
	open_query_flags = copy.open_query_flags;
	proxy_info = copy.proxy_info;
	//#UC END# *4ABCE82801C2_COPY_CTOR*
}

InternetAccessInfo& InternetAccessInfo::operator = (const InternetAccessInfo& copy) {
	//#UC START# *4ABCE82801C2_ASSIGN_OP*
	access_type = copy.access_type;
	open_query_flags = copy.open_query_flags;
	proxy_info = copy.proxy_info;
	//#UC END# *4ABCE82801C2_ASSIGN_OP*
	return *this;
}

const char* ConnectionFailed::uid () const /*throw ()*/ {
	return "6C8F09CF-9A97-417C-A2A5-80870E7D5F8A";
}

const char* ConnectionFailed::what () const throw () {
	//#UC START# *4AC0531B0065_WHAT_IMPL*
	return "ConnectionFailed ()";
	//#UC END# *4AC0531B0065_WHAT_IMPL*
}


const char* ParseURLException::uid () const /*throw ()*/ {
	return "019A8E55-04D3-4750-8D2F-A4E1EBC0841F";
}

const char* ParseURLException::what () const throw () {
	//#UC START# *4AC053380086_WHAT_IMPL*
	return "ParseURLException ()";
	//#UC END# *4AC053380086_WHAT_IMPL*
}

// factory interface wrapper for IConnect
IConnect* IConnectFactory::make (
	const InternetAccessInfo& info
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IConnectFactoryManager::Singleton::instance ()->make (info);
}


const char* ConnectException::uid () const /*throw ()*/ {
	return "011F0AC0-B81F-4D0F-A2BA-5E271DEE4567";
}

const char* ConnectException::what () const throw () {
	//#UC START# *4AC0534B0341_WHAT_IMPL*
	return "ConnectException ()";
	//#UC END# *4AC0534B0341_WHAT_IMPL*
}


const char* IncorrectQuery::uid () const /*throw ()*/ {
	return "10C8BDC4-A263-4708-A8CE-CC158600BD26";
}

const char* IncorrectQuery::what () const throw () {
	//#UC START# *4AC1F558022D_WHAT_IMPL*
	return "IncorrectQuery (Некорректный запрос)";
	//#UC END# *4AC1F558022D_WHAT_IMPL*
}


const char* AccessDenied::uid () const /*throw ()*/ {
	return "5C97C3D7-2C53-492A-883F-045AEE8A7472";
}

const char* AccessDenied::what () const throw () {
	//#UC START# *4AC1F590024E_WHAT_IMPL*
	return "AccessDenied (Доступ запрещен)";
	//#UC END# *4AC1F590024E_WHAT_IMPL*
}


const char* ObjectNotFound::uid () const /*throw ()*/ {
	return "496ED633-56BD-4476-86D0-BF85A8ED7A4A";
}

const char* ObjectNotFound::what () const throw () {
	//#UC START# *4AC1F653035D_WHAT_IMPL*
	return "ObjectNotFound (Объект не найден)";
	//#UC END# *4AC1F653035D_WHAT_IMPL*
}


const char* ServerNotSupport::uid () const /*throw ()*/ {
	return "6C367BDB-74AF-4219-BD5D-C8BD5F02DADC";
}

const char* ServerNotSupport::what () const throw () {
	//#UC START# *4AC1F6920228_WHAT_IMPL*
	return "ServerNotSupport (Не поддерживается сервером)";
	//#UC END# *4AC1F6920228_WHAT_IMPL*
}


const char* QueryError::uid () const /*throw ()*/ {
	return "32F07EDE-8404-4464-9AB3-A571F24DFDA2";
}

const char* QueryError::what () const throw () {
	//#UC START# *4AC1F7B6035E_WHAT_IMPL*
	return "QueryError (Ошибка запроса)";
	//#UC END# *4AC1F7B6035E_WHAT_IMPL*
}


const char* ServerError::uid () const /*throw ()*/ {
	return "B93959FE-41F2-41AF-9BBA-79DF2CC07A36";
}

const char* ServerError::what () const throw () {
	//#UC START# *4AC1F7D101EA_WHAT_IMPL*
	return "ServerError (Ошибка сервера)";
	//#UC END# *4AC1F7D101EA_WHAT_IMPL*
}

} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

