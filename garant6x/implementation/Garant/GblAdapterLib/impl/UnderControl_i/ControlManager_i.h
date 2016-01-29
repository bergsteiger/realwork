////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UnderControl_i::ControlManager_i
// Заголовок реализации класса серванта для интерфеса ControlManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_I_CONTROLMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_I_CONTROLMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Task.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garantServer/src/Business/GblUnderControl/GblUnderControlDefC.h"

namespace GblAdapterLib {

class ControlManager_i; // self forward Var
typedef ::Core::Var<ControlManager_i> ControlManager_i_var;
typedef ::Core::Var<const ControlManager_i> ControlManager_i_cvar;

class ControlManager_i_factory;

class ControlManager_i:
	virtual public ControlManager
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (ControlManager_i)
	friend class ControlManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	static ACE_THR_FUNC_RETURN async_update_status (void* param);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ControlManager_i ();

	virtual ~ControlManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual const GblUnderControlDef::UnderControlObjectList& get_cached_pilot_controlled_object () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ControlledChangeNotifier_var m_control_notifier;

	mutable Core::Mutex m_controlled_objects_mutex;

	bool m_force_for_update_status;

	mutable GblUnderControlDef::UnderControlObjectList_var m_pilot_controlled_objects;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from ControlManager
	virtual void add (const GCD::PID& pid);

	// implemented method from ControlManager
	virtual const CatalogBase* get_changed_doc () const;
	virtual CatalogBase* get_changed_doc ();

	// implemented method from ControlManager
	virtual void set_controlled_change_notifier (ControlledChangeNotifier* controlled_change_notifier);

	// implemented method from ControlManager
	virtual ACE_THR_FUNC_RETURN do_update_status ();

	// implemented method from ControlManager
	virtual ControlledObjects* get_controlled_objects () const;

	// implemented method from ControlManager
	virtual bool get_under_control_status (const GCD::PID& pid, unsigned long& status);

	// implemented method from ControlManager
	virtual void refresh_control_status ();

	// implemented method from ControlManager
	virtual void remove (const GCD::PID& pid);

	// implemented method from ControlManager
	virtual void reset_control_status (const GCD::PID& pid);

	// implemented method from ControlManager
	// Обновить статусы объектов на контроле.
	virtual void update_status (bool force = false);
}; // class ControlManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_UNDERCONTROL_I_CONTROLMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
