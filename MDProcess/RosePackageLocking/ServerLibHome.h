////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/RosePackageLocking/ServerLibHome.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::RosePackageLocking
//
// ���������� � �������� ����������������� ������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_FCTR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace RosePackageLocking {

class ServerLibHomeFactory {
public:
	static Core::Root::LibHome& get ();
};

class ServerLibHomeImpl : virtual public Core::Root_i::StdLibHomeBase {
	SET_OBJECT_COUNTER (ServerLibHomeImpl)


private:
	friend class ServerLibHomeFactory;
	
	REFCOUNT_SINGLETON(ServerLibHomeImpl)
	
	ServerLibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
	
	void print_usage () const;
	
	bool check_params () const;
};
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
