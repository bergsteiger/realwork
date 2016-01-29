////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/LibHome.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::CoreSrv
//
// Клиент-серверное ядро, набор базовых вспомогательных функциий и типов для работы с CORBA, а так
// же клиент-сервная часть фреймворка GCM2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_H__
#define __SHARED_CORESRV_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeBase.h"

namespace CoreSrv {

class LibHomeFactory {
public:
	static CoreSrv::Root::CorbaLibHome& get ();
};

class LibHomeImpl : virtual public CoreSrv::Root_i::CorbaLibHomeBase {
	SET_OBJECT_COUNTER (LibHomeImpl)

	PortableInterceptor::ORBInitializer* get_orb_initializer () const;

	class ORBInitializer: virtual public PortableInterceptor::ORBInitializer {
		void pre_init(PortableInterceptor::ORBInitInfo_ptr info) throw (CORBA::SystemException);

		void post_init(PortableInterceptor::ORBInitInfo_ptr info) throw (CORBA::SystemException);
	};

	friend class ORBInitializer;



private:
	void publish_all_servers_factories () const;

private:
	friend class LibHomeFactory;
	
	REFCOUNT_SINGLETON(LibHomeImpl)
	
	LibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
};

class CurrentSlotAccessor {
public:
	static PortableInterceptor::SlotId get_current_token_slot_id ();

private:
	friend class LibHomeImpl;
	static void set_current_token_slot_id (PortableInterceptor::SlotId allocated_slot);
	static PortableInterceptor::SlotId s_current_token_slot_id;
}; //CurrentSlotAccessor

} // namespace CoreSrv


#endif //__SHARED_CORESRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
