////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_H__
#define __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "ace/Task.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// Типы объектов на контроле.
enum ControlledItemType {
	CIT_DOCUMENT // Документ
	, CIT_LIST // Список.
	, CIT_QUERY // Запрос.
};

// Битовые значения статуса изменений.
static const unsigned long CS_DELETED = 32; // Документ удален.
static const unsigned long CS_ACTIVE = 16; // Документ вступил в действие
static const unsigned long CS_CHANGED = 8; // Документ изменен
static const unsigned long CS_ABOLISHED = 4; // Документ утратил силу
static const unsigned long CS_REGISTERED = 2; // Документ зарегистрирован в Минюсте РФ
static const unsigned long CS_NOT_REGISTERED = 1; // Документу отказано в регистрации в Минюсте РФ
static const unsigned long CS_NONE = 0; // Документ не изменился

class ControlledChangeNotifier;
typedef ::Core::Var<ControlledChangeNotifier> ControlledChangeNotifier_var;
typedef ::Core::Var<const ControlledChangeNotifier> ControlledChangeNotifier_cvar;
// Интерфейс который должен быть реализован со стороны оболочки, для нотификации ее об изменении
// контролируемых объектов.
class ControlledChangeNotifier
	: virtual public ::Core::IObject
{
public:
	// сообщает о том что контролируемые объекты изменились.
	virtual void fire () const = 0;
};

class Controllable;
typedef ::Core::Var<Controllable> Controllable_var;
typedef ::Core::Var<const Controllable> Controllable_cvar;
// Интерфейс, который должна реализовывать сущность которую можно ставить "на контроль". Реализация
// должны быть выполнена, так что бы доступ к методам определяемым этим интерфейсам не приводила к
// загрузки данных самой сущности. Для функционирования всех мотодов достаточно знать лишь
// идентификатор сущности на сервере, с помощью которого осуществляется вся работа с серверным
// интерфейсом ControlManager.
class Controllable
	: virtual public ::Core::IObject
{
public:
	// Возвращает true, если разрешена постановка на контроль
	virtual const bool get_can_set_to_control () const = 0;

	// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
	// приводит к добавлению сущности на контроль, в false соответственно к снятию.
	virtual bool get_controlled () const = 0;

	virtual void set_controlled (bool controlled) = 0;

	// Возврящает текущее значение статуса изменений.
	virtual unsigned long get_control_status () = 0;

	// Сравнение объектов на контроле.
	virtual bool is_same_controllable (const Controllable* other) = 0;

	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	// Получить объект на контроле.
	virtual Core::IObject* open () = 0;

	// Сбрасывает статус изменений в ноль.
	virtual void reset_control_status () = 0;

	// Название объекта на контроле.
	virtual const GCI::IO::String& get_short_name () const = 0;
	virtual GCI::IO::String& get_short_name () = 0;

	virtual ControlledItemType get_type () const = 0;
};

// Список объектов папок, стоящих на контроле.
typedef std::vector < Controllable_var > ControlledObjects;

// Объект не на контроле.
class NotUnderControl : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Объект уже на контроле.
class AlreadyControlled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ControlManager;
typedef ::Core::Var<ControlManager> ControlManager_var;
typedef ::Core::Var<const ControlManager> ControlManager_cvar;
// Менеджер объектов на контроле.
class ControlManager
	: virtual public ::Core::IObject
{
public:
	virtual void set_controlled_change_notifier (ControlledChangeNotifier* controlled_change_notifier) = 0;

	virtual const CatalogBase* get_changed_doc () const = 0;
	virtual CatalogBase* get_changed_doc () = 0;

	// Обновить статусы объектов на контроле.
	virtual void update_status (bool force = false) = 0;

	virtual bool get_under_control_status (const GCD::PID& pid, unsigned long& status) = 0;

	virtual void add (const GCD::PID& pid) = 0;

	virtual void remove (const GCD::PID& pid) = 0;

	virtual void reset_control_status (const GCD::PID& pid) = 0;

	virtual void refresh_control_status () = 0;

	virtual ACE_THR_FUNC_RETURN do_update_status () = 0;

	virtual ControlledObjects* get_controlled_objects () const = 0;
};

/// factory interface for ControlManager
class ControlManagerFactory {
public:
	static ControlManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ControlManager> {
	typedef GblAdapterLib::ControlManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_UNDERCONTROL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
