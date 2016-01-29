////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/gui/Garant/SubTestLibrary/LibHome.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<TestLibrary::Category>> TestModel::SubTestLibrary
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_SUBTESTLIBRARY_H__
#define __TESTMODEL_SUBTESTLIBRARY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace SubTestLibrary {

class LibHomeFactory {
public:
	static Core::Root::LibHome& get ();
};

class LibHomeImpl : virtual public Core::Root_i::StdLibHomeBase {
	SET_OBJECT_COUNTER (LibHomeImpl)


private:
	friend class LibHomeFactory;
	
	REFCOUNT_SINGLETON(LibHomeImpl)
	
	LibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
};
} // namespace SubTestLibrary


#endif //__TESTMODEL_SUBTESTLIBRARY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
