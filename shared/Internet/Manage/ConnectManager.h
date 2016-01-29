////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Internet/Manage/ConnectManager.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Internet::Manage::ConnectManager
//
// �������� ��� �������� � ���������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_MANAGE_CONNECTMANAGER_H__
#define __SHARED_INTERNET_MANAGE_CONNECTMANAGER_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/Internet/Inet/Inet.h"

namespace Internet {

// �������� ��� �������� � ���������� �����������
class ConnectManager {
	SET_OBJECT_COUNTER (ConnectManager)

	// singleton declaration
	typedef ACE_Singleton <ConnectManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConnectManager, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ConnectManager* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConnectManager ();

	virtual ~ConnectManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������� ��������� ��������
	IConnect* get_connect ();

	// �������������
	void init (const InternetAccessInfo& info, bool is_reconnect);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IConnect_var m_connect;
}; // class ConnectManager

} // namespace Internet


#endif //__SHARED_INTERNET_MANAGE_CONNECTMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

