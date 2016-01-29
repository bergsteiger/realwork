////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewServerLibrary/ServerLibHome.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> TestModel::NewServerLibrary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_NEWSERVERLIBRARY_FCTR_H__
#define __TESTMODEL_NEWSERVERLIBRARY_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace NewServerLibrary {

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
} // namespace NewServerLibrary


#endif //__TESTMODEL_NEWSERVERLIBRARY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
