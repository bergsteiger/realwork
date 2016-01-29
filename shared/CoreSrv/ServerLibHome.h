////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/ServerLibHome.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::CoreSrv
//
// Клиент-серверное ядро, набор базовых вспомогательных функциий и типов для работы с CORBA, а так
// же клиент-сервная часть фреймворка GCM2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_FCTR_H__
#define __SHARED_CORESRV_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace CoreSrv {

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
} // namespace CoreSrv


#endif //__SHARED_CORESRV_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
