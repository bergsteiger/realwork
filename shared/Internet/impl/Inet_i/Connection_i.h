////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Internet/impl/Inet_i/Connection_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connection_i
// ��������� ���������� ������ �������� ��� ��������� IConnection
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_I_CONNECTION_I_H__
#define __SHARED_INTERNET_INET_I_CONNECTION_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Inet/Inet.h"

//#UC START# *4AC07F28014A_CUSTOM_INCLUDES*
#ifndef __AFXINET_H_
#include "afxinet.h"
#endif
//#UC END# *4AC07F28014A_CUSTOM_INCLUDES*

namespace Internet {
namespace Inet_i {

class Connection_i; // self forward Var
typedef ::Core::Var<Connection_i> Connection_i_var;
typedef ::Core::Var<const Connection_i> Connection_i_cvar;

class Connection_i_factory;

class Connection_i:
	virtual public IConnection
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Connection_i)
	friend class Connection_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���������
	static const unsigned long BUF_SIZE; // ������ �������
	static const unsigned long REQUEST_TIME_OUT; // �����, ���������� ��� �������� �������, �� ���������� � ��������� ������ (180 ���)

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Connection_i (void* data, unsigned long flags);

	virtual ~Connection_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ������ CHttpFile � ���������� ��� ������������ �� �������
	void close ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CHttpConnection* m_connection;

	unsigned long m_flags;

	Core::Box<CHttpFile> m_http_file;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IConnection
	// �������� ����� ��������
	virtual unsigned long long get_content_length ();

	// implemented method from IConnection
	// �������� ����� ������� �� ���������� ��� ������ � ��������� ������ �������
	virtual void get_info (unsigned long level, std::string& value);

	// implemented method from IConnection
	// �������� ����� ������� �� ���������� ��� ������ � �������� ����
	virtual unsigned long get_info_number (unsigned long level);

	// implemented method from IConnection
	// ���������� ���������� � ��������
	virtual bool open_request (const char* str_obj, const char* headers);

	// implemented method from IConnection
	// ������ ������
	virtual unsigned int read (void* buffer, unsigned int count);

	// implemented method from IConnection
	// ���������������� � �����
	virtual unsigned long long seek (long long offset, unsigned int from);

	// implemented method from IConnection
	// �������� �������������� ������ �� ������ WWW
	virtual bool send_request ();

	// implemented method from IConnection
	// ��������� ���������� ������ �����
	virtual void set_option (unsigned long option, unsigned long value);

//#UC START# *4AC07F28014A*
//#UC END# *4AC07F28014A*
}; // class Connection_i

} // namespace Inet_i
} // namespace Internet


#endif //__SHARED_INTERNET_INET_I_CONNECTION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
