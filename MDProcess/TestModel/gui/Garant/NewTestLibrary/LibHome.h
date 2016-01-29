////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/gui/Garant/NewTestLibrary/LibHome.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TestLibrary::Category>> TestModel::NewTestLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_NEWTESTLIBRARY_H__
#define __TESTMODEL_NEWTESTLIBRARY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace NewTestLibrary {

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
} // namespace NewTestLibrary


#endif //__TESTMODEL_NEWTESTLIBRARY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
