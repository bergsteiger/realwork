////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/MDPSupport/MDPSupport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::MDPSupport
//
// интерфейсы для  работы с сервером залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_MDPSUPPORT_H__
#define __MDPROCESS_MDAMODEL_MDPSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"

namespace MDPSupport {

class CatLocker;
typedef ::Core::Var<CatLocker> CatLocker_var;
typedef ::Core::Var<const CatLocker> CatLocker_cvar;
// интерфейс для залочки катов
class CatLocker
	: virtual public ::Core::IObject
{
public:
	// статус залочки пакета
	virtual RosePackageLocking::RosePackageLockingServer::LockStatus get_lock_status () const = 0;

	// Лочит пакет для можификации. Возвращает false если пакет уже кем-то залочен.
	virtual bool modify () = 0;

	// Разлочивает пакет. Возвращает false в случие ошибки.
	virtual bool commit () = 0;

	// Откатывает изменения.
	virtual bool rollback () = 0;

	// возвращает false, если пакет находится под управлением сервера залочек.
	virtual bool has_lock_status () const = 0;
};

/// factory interface for CatLocker
class CatLockerFactory {
public:
	// создает объект CatLocker для ката из cat
	static CatLocker* make (IRoseCategoryPtr cat)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class MDPFacade;
typedef ::Core::Var<MDPFacade> MDPFacade_var;
typedef ::Core::Var<const MDPFacade> MDPFacade_cvar;
// интерфейс-обертка для доступа к серверу залочек
class MDPFacade
	: virtual public ::Core::IObject
{
public:
	// начало сеанса работы с сервером залочек
	virtual bool login () = 0;

	// окончание сеанса работы с сервером залочек
	virtual void logout () = 0;

	// возвращает false если сервер залочек недоступен
	virtual bool is_server_exist () const = 0;

	// показывает блок диалога со списком  залоченных пакетов
	virtual void show_locked () const = 0;

	// синхронизирует модель (model) на сервере - получает статусы залочек пакетов с сервера
	virtual bool sync (IRoseModelPtr model) = 0;

	// "закрывает" модель после синхронизации. Выполняется при закрытии модели.
	virtual bool unsync (IRoseModelPtr model) = 0;
};

/// factory interface for MDPFacade
class MDPFacadeFactory {
public:
	// возвращает кэшированный объект MDPFacade
	static MDPFacade& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// данные о том кто залочил
struct LockInfo {
	// имя, залочевшего пакет
	std::string lock_owner_name;
	// время залочки/разлочки пакета
	std::string lock_time;
	// статус залочки
	RosePackageLocking::RosePackageLockingServer::LockStatus status;

	// контсруктор раз
	LockInfo (
		RosePackageLocking::RosePackageLockingServer::LockStatus s
		, const std::string& owner
		, const std::string& time
	);

	// пустой конструктор
	LockInfo ();
};

#pragma pack (pop)

// статусы залочек - что бы не ходить на сервер каждый раз. Отображает гуид пакета на юзера его
// залочевшего
typedef std::map < std::string, LockInfo > CatsLockStatus;

// информауция о залочке отсутствует
class LockInfoNotExists : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class CatLockerFacade;
typedef ::Core::Var<CatLockerFacade> CatLockerFacade_var;
typedef ::Core::Var<const CatLockerFacade> CatLockerFacade_cvar;
// интерфейс обертки для cat-локера, возвращающая адекватные результаты при любых состояних объекта
// cat. Такие состояния: сервер залочек недоступен, пакет еще не под управлением сервера и т.д.
class CatLockerFacade
	: virtual public ::Core::IObject
{
public:
	// возвращает true если кат можно менять
	virtual bool can_change () const = 0;

	// возвращает true, если кат можно залочить
	virtual bool can_lock () const = 0;

	// возвращает true, если кат можно отлочить
	virtual bool can_commit () const = 0;

	// возвращает true, если изменения в кат можно удачно откатить
	virtual bool can_rollback () const = 0;

	// начать модификацию элемента
	virtual bool try_change () = 0;

	// модфикация окончена удачно, принять изменения. Если модификация была не удачной,  то в
	// деструкторе CatLockerFacade изменения будут откатаны.
	virtual void do_change () = 0;
};

/// factory interface for CatLockerFacade
class CatLockerFacadeFactory {
public:
	// создает объект класса по параметру-категории
	static CatLockerFacade* make (IRoseCategoryPtr cat)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создает объект класса по параметру-элементу, предварительно пытаестя найти для него
	// родительскую категорию
	static CatLockerFacade* make (IRoseElementPtr elem)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class CatsContainer;
typedef ::Core::Var<CatsContainer> CatsContainer_var;
typedef ::Core::Var<const CatsContainer> CatsContainer_cvar;
// Контейнер катов с их состоянием залочек
class CatsContainer
	: virtual public ::Core::IObject
{
public:
	// статусы залочек
	virtual const CatsLockStatus& get_cats_lock_status () const = 0;

	// получить кат по его гуиду
	virtual IRoseCategoryPtr get_cat_by_guid (const char* guid) const = 0;

	// регистрирует интерфейс для комовского маршалинга, нужно для вывзова из не майн потока, в
	// котором обрабатываются вызовы от сервера залочек
	virtual void register_for_com_marshal (IRoseModelPtr model) = 0;

	// unregister для интерфейс
	virtual void unregister_for_com_marshal (IRoseModelPtr model) = 0;

	// очищает список залочек
	virtual void clear_lock_status () = 0;

	// возвращает объект подписчик (несмотря на то, что метод не кэшированный - реальный  объект
	// возвращается всегда один и тот же)
	virtual RosePackageLocking::RosePackageLockingServer::LocksListener* get_listener () = 0;

	// записывает информацию о залочке
	virtual void write_info (const std::string& key, const LockInfo& info) = 0;

	// получить информацию о залочке
	virtual const LockInfo& get_info (const std::string& key) const /*throw (LockInfoNotExists)*/ = 0;

	// возвращает true, если есть информация о залочке
	virtual bool is_info_exists (const std::string& key) const = 0;
};

/// factory interface for CatsContainer
class CatsContainerFactory {
public:
	// возвращает экземпляр
	static CatsContainer& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace MDPSupport

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <MDPSupport::CatLocker> {
	typedef MDPSupport::CatLockerFactory Factory;
};
template <>
struct TypeTraits <MDPSupport::MDPFacade> {
	typedef MDPSupport::MDPFacadeFactory Factory;
};
template <>
struct TypeTraits <MDPSupport::CatLockerFacade> {
	typedef MDPSupport::CatLockerFacadeFactory Factory;
};
template <>
struct TypeTraits <MDPSupport::CatsContainer> {
	typedef MDPSupport::CatsContainerFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_MDPSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
