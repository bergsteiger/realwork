////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/Security/LibHome.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Library::Category>> MDProcess::Security
//
// нужно для реализаци базовых интерфейсов аутентификации из шареда
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SECURITY_H__
#define __MDPROCESS_SECURITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace Security {

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
} // namespace Security


#endif //__MDPROCESS_SECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
