////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ChatLibrary/ServerLibHome.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::ChatLibrary
//
// библиотека обмена сообщениями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CHATLIBRARY_FCTR_H__
#define __SHARED_CHATLIBRARY_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace ChatLibrary {

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
} // namespace ChatLibrary


#endif //__SHARED_CHATLIBRARY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
