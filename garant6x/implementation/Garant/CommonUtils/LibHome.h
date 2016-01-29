////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/LibHome.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Library::Category>> garant6x::CommonUtils
//
// общий код
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_COMMONUTILS_H__
#define __GARANT6X_COMMONUTILS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace CommonUtils {

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
} // namespace CommonUtils


#endif //__GARANT6X_COMMONUTILS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
