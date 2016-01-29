////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/LibHome.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Library::Category>> shared::Internet
//
// Библиотека для работы с интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_H__
#define __SHARED_INTERNET_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace Internet {

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
} // namespace Internet


#endif //__SHARED_INTERNET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
