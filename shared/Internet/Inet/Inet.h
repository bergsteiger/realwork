////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Internet/Inet/Inet.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Internet::Inet
//
// ���������� � ���� ��� ������ � ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_H__
#define __SHARED_INTERNET_INET_H__

#include "shared/Core/sys/std_inc.h"

namespace Internet {

#pragma pack (push, 1)

// ���� � ������
struct ProxyInfo {
	// ��� �����
	std::string host;
	// ����
	std::string port;
	// �����
	std::string login;
	// ������
	std::string password;
	// ����������� �� ������
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
// ��������� ������������ ����������
class IConnection
	: virtual public ::Core::IObject
{
public:
	// ���������� ���������� � ��������
	virtual bool open_request (const char* str_obj, const char* headers) = 0;

	// �������� �������������� ������ �� ������ WWW
	virtual bool send_request () = 0;

	// �������� ����� ������� �� ���������� ��� ������ � ��������� ������ �������
	virtual void get_info (unsigned long level, std::string& value) = 0;

	// �������� ����� ������� �� ���������� ��� ������ � �������� ����
	virtual unsigned long get_info_number (unsigned long level) = 0;

	// ������ ������
	virtual unsigned int read (void* buffer, unsigned int count) = 0;

	// ��������� ���������� ������ �����
	virtual void set_option (unsigned long option, unsigned long value) = 0;

	// ���������������� � �����
	virtual unsigned long long seek (long long offset, unsigned int from) = 0;

	// �������� ����� ��������
	virtual unsigned long long get_content_length () = 0;
};

/// factory interface for IConnection
class IConnectionFactory {
public:
	// �������
	static IConnection* make (void* data, unsigned long flags)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ��������� ������� � ��������
struct InternetAccessInfo {
	// ��� ������� � ��������
	unsigned long access_type;
	// ����� ��� ���������� ��������� ������ �� ���� ��� �� ����
	unsigned long open_query_flags;
	// ��������� ������
	ProxyInfo proxy_info;
	InternetAccessInfo () : access_type(0), open_query_flags(0) {
		//#UC START# *4ABCE82801C2_DEF_INIT_CTOR*
		//#UC END# *4ABCE82801C2_DEF_INIT_CTOR**cpp*
	}

	InternetAccessInfo (const InternetAccessInfo& copy);

	InternetAccessInfo& operator = (const InternetAccessInfo& copy);
};

#pragma pack (pop)

// ���������� ���������� � ��������
class ConnectionFailed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� ��� ������������� URL
class ParseURLException : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class IConnect;
typedef ::Core::Var<IConnect> IConnect_var;
typedef ::Core::Var<const IConnect> IConnect_cvar;
// ��������� ��� �������� � ������������ ������
class IConnect
	: virtual public ::Core::IObject
{
public:
	// ���������� ���������� � �������� ������
	virtual void execute (const std::string& host_name, const std::string& user_agent) = 0;

	// ���������� ������������� ����������
	virtual IConnection* get_connection () = 0;

	// �������� ��������� (� ��������� �������� ����������)
	virtual void reset (const InternetAccessInfo& info) = 0;
};

/// factory interface for IConnect
class IConnectFactory {
public:
	// �������
	static IConnect* make (const InternetAccessInfo& info)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ���������� ��� ������� ��������
class ConnectException : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ������
class IncorrectQuery : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��������
class AccessDenied : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �� ������
class ObjectNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� �������������� ��������
class ServerNotSupport : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������
class QueryError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������
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
