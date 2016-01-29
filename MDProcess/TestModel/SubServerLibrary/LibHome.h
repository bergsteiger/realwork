////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/SubServerLibrary/LibHome.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::SubServerLibrary
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_SUBSERVERLIBRARY_H__
#define __TESTMODEL_SUBSERVERLIBRARY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeBase.h"

namespace SubServerLibrary {

class LibHomeFactory {
public:
	static CoreSrv::Root::CorbaLibHome& get ();
};

class LibHomeImpl : virtual public CoreSrv::Root_i::CorbaLibHomeBase {
	SET_OBJECT_COUNTER (LibHomeImpl)


private:
	void publish_all_servers_factories () const;

private:
	friend class LibHomeFactory;
	
	REFCOUNT_SINGLETON(LibHomeImpl)
	
	LibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
};
} // namespace SubServerLibrary


#endif //__TESTMODEL_SUBSERVERLIBRARY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
