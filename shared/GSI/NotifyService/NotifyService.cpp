////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/NotifyService/NotifyService.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GSI::NotifyService
//
// Сервис для рассылки нотификаций между процессами, которые могут быть запущены на разных машинах.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/NotifyService/NotifyService.h"
#include "shared/GSI/NotifyService/NotifyServiceFactories.h"

namespace GSI {
namespace NotifyService {


const char* InternalError::uid () const /*throw ()*/ {
	return "C9A0D5BA-3097-4C8C-A252-0BD8EA52539E";
}

const char* InternalError::what () const throw () {
	//#UC START# *44A232E501A5_WHAT_IMPL*
	return "InternalError (Внутренняя ошибка, возникающая по вине сервиса.)";
	//#UC END# *44A232E501A5_WHAT_IMPL*
}


const char* NotInitialized::uid () const /*throw ()*/ {
	return "8C055EDE-D055-47ED-8E4E-54B0B9894F1D";
}

const char* NotInitialized::what () const throw () {
	//#UC START# *44F291A301AD_WHAT_IMPL*
	return "NotInitialized (Сервис не проинициализирован (не запущен))";
	//#UC END# *44F291A301AD_WHAT_IMPL*
}

// factory interface wrapper for Supplier
Supplier* SupplierFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SupplierFactoryManager::Singleton::instance ()->make ();
}


// oneway methods impl
struct SendCommonNotifyParams_ {
	Supplier_cvar self;
	const CORBA::Any notify;
	SendCommonNotifyParams_ (
		const Supplier* self_
		, const CORBA::Any& notify_
	) :
		self(Supplier::_duplicate(self_))
		, notify(notify_)
	{
	}
};

void Supplier::thr_send_common_notify_ (void* arg) {
	try {
		Core::Aptr<SendCommonNotifyParams_> arg_ (reinterpret_cast<SendCommonNotifyParams_*>(arg));
		arg_->self->send_common_notify_ (arg_->notify);
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute Supplier::send_common_notify oneway function"));
	} catch (...) {
		LOG_UEX (("while execute Supplier::send_common_notify oneway function"));
	}
}

struct SendPersonalNotifyParams_ {
	Supplier_cvar self;
	const CORBA::Any notify;
	const PersonalID prs_id;
	SendPersonalNotifyParams_ (
		const Supplier* self_
		, const CORBA::Any& notify_
		, PersonalID prs_id_
	) :
		self(Supplier::_duplicate(self_))
		, notify(notify_)
		, prs_id(prs_id_)
	{
	}
};

void Supplier::thr_send_personal_notify_ (void* arg) {
	try {
		Core::Aptr<SendPersonalNotifyParams_> arg_ (reinterpret_cast<SendPersonalNotifyParams_*>(arg));
		arg_->self->send_personal_notify_ (arg_->notify, arg_->prs_id);
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute Supplier::send_personal_notify oneway function"));
	} catch (...) {
		LOG_UEX (("while execute Supplier::send_personal_notify oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle Supplier::send_common_notify (const CORBA::Any& notify) const {
	Core::Aptr<SendCommonNotifyParams_> arg = new SendCommonNotifyParams_ (this, notify);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (Supplier::thr_send_common_notify_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}

/*oneway*/ Core::ThreadHandle Supplier::send_personal_notify (const CORBA::Any& notify, PersonalID prs_id) const {
	Core::Aptr<SendPersonalNotifyParams_> arg = new SendPersonalNotifyParams_ (this, notify, prs_id);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (Supplier::thr_send_personal_notify_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}
// factory interface wrapper for Manager
Manager& ManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace NotifyService
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

