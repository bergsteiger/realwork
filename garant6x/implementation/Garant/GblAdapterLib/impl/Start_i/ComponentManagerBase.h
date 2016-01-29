////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/ComponentManagerBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::ComponentManagerBase
// Заголовок реализации класса серванта для интерфеса ComponentManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_I_COMPONENTMANAGERBASE_H__
#define __GARANT6X_GBLADAPTERLIB_START_I_COMPONENTMANAGERBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "tao/ORB_Core.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ServerFacade.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"

//#UC START# *474D69D80059_CUSTOM_INCLUDES*
//#UC END# *474D69D80059_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ComponentManagerBase; // self forward Var
typedef ::Core::Var<ComponentManagerBase> ComponentManagerBase_var;
typedef ::Core::Var<const ComponentManagerBase> ComponentManagerBase_cvar;

class ComponentManagerBase:
	virtual public ComponentManager
	, virtual public ::Core::RefCountObjectBase
	, virtual public GCM::GCMSimpleServer
{
	SET_OBJECT_COUNTER (ComponentManagerBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ComponentManagerBase ();

	virtual ~ComponentManagerBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	virtual void execute ();

	virtual CORBA::Object* get_server_interface (const char* name) const;

	virtual ServerFacade* make_server_facade ();

	virtual void pre_orb_run ();

	virtual void run () = 0;

	virtual void smart_backend_init () const = 0;

	virtual void timestamp_init (GblPilot::FunctionMng* function_manager) const = 0;

	virtual void wait_for_finalize ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable NotifyManager_var m_notify_manager;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ComponentManager
	virtual void start () /*throw (StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting)*/;

	// implemented method from ComponentManager
	virtual void stop ();

//#UC START# *474D69D80059*
//#UC END# *474D69D80059*
}; // class ComponentManagerBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_I_COMPONENTMANAGERBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
