////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/NotifyService/NotifyService.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GSI::NotifyService
//
// Сервис для рассылки нотификаций между процессами, которые могут быть запущены на разных машинах.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_H__
#define __SHARED_GSI_NOTIFYSERVICE_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GSI {
namespace NotifyService {

class Consumer;
typedef ::Core::Var<Consumer> Consumer_var;
typedef ::Core::Var<const Consumer> Consumer_cvar;
// интерфейс получателя сообщений. Подписку/отписку на сообщения нужно делать внутри реализации. В
// текущей реализации сервиса для этих целей необходимо просто отнаследоваться от реализации
// Consumer_i.
class Consumer
	: virtual public ::Core::IObject
{
public:
	// Для получения сообщений реализация перекрывает этот метод.
	virtual void fire_event (const CORBA::Any& event) = 0;
};

// В сервисе предусмотрена возможность послать сообщение только определенному получателю, который
// идентифицируется через PersonalID. Что бы получатель мог получать сообщения, предназаначенные
// только ему, он должен при подписке для приема сообщений указать свой PersonalID.
typedef long PersonalID;

// Внутренняя ошибка, возникающая по вине сервиса.
class InternalError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Сервис не проинициализирован (не запущен)
class NotInitialized : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Supplier;
typedef ::Core::Var<Supplier> Supplier_var;
typedef ::Core::Var<const Supplier> Supplier_cvar;
// Интерфейс для посылки сообщений.
class Supplier
	: virtual public ::Core::IObject
{
public:
	// Послать обычное сообщение, которое будет получено всем получателям.
	/*oneway*/ Core::ThreadHandle send_common_notify (
		const CORBA::Any& notify
	) const /*throw (
		InternalError
		, NotInitialized
	)*/;

	// Послать персональное сообщение, которое будет получено только получателем, который при подписке
	// на сообщения указал заданный prs_id
	/*oneway*/ Core::ThreadHandle send_personal_notify (
		const CORBA::Any& notify
		, PersonalID prs_id
	) const /*throw (
		InternalError
		, NotInitialized
	)*/;

// oneway methods impl
private:
	static void thr_send_common_notify_ (void* arg);

	static void thr_send_personal_notify_ (void* arg);

protected:
	virtual void send_common_notify_ (const CORBA::Any& notify) const = 0;

	virtual void send_personal_notify_ (const CORBA::Any& notify, PersonalID prs_id) const = 0;
};

/// factory interface for Supplier
class SupplierFactory {
public:
	// фабричный метод
	static Supplier* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Manager;
typedef ::Core::Var<Manager> Manager_var;
typedef ::Core::Var<const Manager> Manager_cvar;
// Сервис Сообщений. Позволяет организовать межпроцессорный обмен сообщениями. Текущая реализация
// использует CORBA::TAO::Real Event Service, и существует в единственном экземпляре на приложение.
class Manager
	: virtual public ::Core::IObject
{
public:
	// остановка сервиса
	virtual void done () /*throw (InternalError, NotInitialized)*/ = 0;

	// запуск сервиса
	virtual void init () /*throw (InternalError, NotInitialized)*/ = 0;
};

/// factory interface for Manager
class ManagerFactory {
public:
	// фабричный метод
	static Manager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace NotifyService
} // namespace GSI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GSI::NotifyService::Supplier> {
	typedef GSI::NotifyService::SupplierFactory Factory;
};
template <>
struct TypeTraits <GSI::NotifyService::Manager> {
	typedef GSI::NotifyService::ManagerFactory Factory;
};
} // namespace Core


#endif //__SHARED_GSI_NOTIFYSERVICE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
