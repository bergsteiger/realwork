////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/SubServerLibrary/ServerLibHome.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::SubServerLibrary
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_SUBSERVERLIBRARY_FCTR_H__
#define __TESTMODEL_SUBSERVERLIBRARY_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace SubServerLibrary {

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
};
} // namespace SubServerLibrary


#endif //__TESTMODEL_SUBSERVERLIBRARY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
