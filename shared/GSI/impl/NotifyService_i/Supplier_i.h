////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/Supplier_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GSI::NotifyService_i::Supplier_i
// Заголовок реализации класса серванта для интерфеса Supplier
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_SUPPLIER_I_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_SUPPLIER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/NotifyService/NotifyService.h"

namespace GSI {
namespace NotifyService_i {

class Supplier_i; // self forward Var
typedef ::Core::Var<Supplier_i> Supplier_i_var;
typedef ::Core::Var<const Supplier_i> Supplier_i_cvar;

class Supplier_i_factory;

class Supplier_i:
	virtual public NotifyService::Supplier
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Supplier_i)
	friend class Supplier_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Supplier_i ();

	virtual ~Supplier_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NotifyService::Supplier
	// Послать обычное сообщение, которое будет получено всем получателям.
	virtual void send_common_notify_ (
		const CORBA::Any& notify
	) const /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/;

	// implemented method from NotifyService::Supplier
	// Послать персональное сообщение, которое будет получено только получателем, который при подписке
	// на сообщения указал заданный prs_id
	virtual void send_personal_notify_ (
		const CORBA::Any& notify
		, NotifyService::PersonalID prs_id
	) const /*throw (
		NotifyService::InternalError
		, NotifyService::NotInitialized
	)*/;
}; // class Supplier_i

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_SUPPLIER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
