////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/Inet/Inet.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Internet::Inet
//
// Интерфейсы и типы для работы с интернет.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_H__
#define __SHARED_INTERNET_INET_H__

#include "shared/Core/sys/std_inc.h"

namespace Internet {

#pragma pack (push, 1)

// Инфо о прокси
struct ProxyInfo {
	// имя хоста
	std::string host;
	// порт
	std::string port;
	// логин
	std::string login;
	// пароль
	std::string password;
	// авторизация на прокси
	bool is_authentication;
	ProxyInfo () : is_authentication(false) {
		//#UC START# *4AC053B70040_DEF_INIT_CTOR*
		//#UC END# *4AC053B70040_DEF_INIT_CTOR**cpp*
	}

	ProxyInfo (const ProxyInfo& copy);

	ProxyInfo& operator = (const ProxyInfo& copy);
};

#pragma pack (pop)

class IConnection;
typedef ::Core::Var<IConnection> IConnection_var;
typedef ::Core::Var<const IConnection> IConnection_cvar;
// Интерфейс определяющий соединение
class IConnection
	: virtual public ::Core::IObject
{
public:
	// установить соединение с сервером
	virtual bool open_request (const char* str_obj, const char* headers) = 0;

	// передать подготовленный запрос на сервер WWW
	virtual bool send_request () = 0;

	// получить ответ сервера на переданный ему запрос и заголовки самого запроса
	virtual void get_info (unsigned long level, std::string& value) = 0;

	// получить ответ сервера на переданный ему запрос в числовом виде
	virtual unsigned long get_info_number (unsigned long level) = 0;

	// чтение данных
	virtual unsigned int read (void* buffer, unsigned int count) = 0;

	// установка параметров сеанса связи
	virtual void set_option (unsigned long option, unsigned long value) = 0;

	// позиционирование в файле
	virtual unsigned long long seek (long long offset, unsigned int from) = 0;

	// получить длину контента
	virtual unsigned long long get_content_length () = 0;
};

/// factory interface for IConnection
class IConnectionFactory {
public:
	// фабрика
	static IConnection* make (void* data, unsigned long flags)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// Настройки доступа в интернет
struct InternetAccessInfo {
	// тип доступа к интернет
	unsigned long access_type;
	// флаги для управления загрузкой файлов из сети или из кэша
	unsigned long open_query_flags;
	// настройки прокси
	ProxyInfo proxy_info;
	InternetAccessInfo () : access_type(0), open_query_flags(0) {
		//#UC START# *4ABCE82801C2_DEF_INIT_CTOR*
		//#UC END# *4ABCE82801C2_DEF_INIT_CTOR**cpp*
	}

	InternetAccessInfo (const InternetAccessInfo& copy);

	InternetAccessInfo& operator = (const InternetAccessInfo& copy);
};

#pragma pack (pop)

// Отсутсвует соединение с интернет
class ConnectionFailed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Исключение при распарсивании URL
class ParseURLException : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class IConnect;
typedef ::Core::Var<IConnect> IConnect_var;
typedef ::Core::Var<const IConnect> IConnect_cvar;
// Интерфейс для коннекта с определенным хостом
class IConnect
	: virtual public ::Core::IObject
{
public:
	// установить соединение с заданным хостом
	virtual void execute (const std::string& host_name, const std::string& user_agent) = 0;

	// возвращаем установленное соединение
	virtual IConnection* get_connection () = 0;

	// изменить настройки (с закрытием текущего соединения)
	virtual void reset (const InternetAccessInfo& info) = 0;
};

/// factory interface for IConnect
class IConnectFactory {
public:
	// фабрика
	static IConnect* make (const InternetAccessInfo& info)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Исключение при попытке коннекта
class ConnectException : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Некорректный запрос
class IncorrectQuery : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Доступ запрещен
class AccessDenied : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Объект не найден
class ObjectNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Не поддерживается сервером
class ServerNotSupport : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Ошибка запроса
class QueryError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Ошибка сервера
class ServerError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace Internet

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Internet::IConnection> {
	typedef Internet::IConnectionFactory Factory;
};
template <>
struct TypeTraits <Internet::IConnect> {
	typedef Internet::IConnectFactory Factory;
};
} // namespace Core


#endif //__SHARED_INTERNET_INET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
