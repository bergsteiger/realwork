////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Internet/impl/Inet_i/Connect_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Internet::Inet_i::Connect_i
// ��������� ���������� ������ �������� ��� ��������� IConnect
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_I_CONNECT_I_H__
#define __SHARED_INTERNET_INET_I_CONNECT_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Internet/Inet/Inet.h"
#include "shared/Internet/impl/Inet_i/InternetSession.h"

namespace Internet {
namespace Inet_i {

class Connect_i; // self forward Var
typedef ::Core::Var<Connect_i> Connect_i_var;
typedef ::Core::Var<const Connect_i> Connect_i_cvar;

class Connect_i_factory;

class Connect_i:
	virtual public IConnect
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Connect_i)
	friend class Connect_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���������
	static const size_t ATTEMPT_CONNECTION; // ����� ������� ��� ����������� ������� ����������� � ��������

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Connect_i (const InternetAccessInfo& info);

	virtual ~Connect_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ����������
	void close ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	size_t m_connect_counter;

	Core::Box<CHttpConnection> m_connection;

	InternetAccessInfo m_info;

	Core::Box<InternetSession> m_session;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IConnect
	// ���������� ���������� � �������� ������
	virtual void execute (const std::string& host_name, const std::string& user_agent);

	// implemented method from IConnect
	// ���������� ������������� ����������
	virtual IConnection* get_connection ();

	// implemented method from IConnect
	// �������� ��������� (� ��������� �������� ����������)
	virtual void reset (const InternetAccessInfo& info);
}; // class Connect_i

} // namespace Inet_i
} // namespace Internet


#endif //__SHARED_INTERNET_INET_I_CONNECT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
