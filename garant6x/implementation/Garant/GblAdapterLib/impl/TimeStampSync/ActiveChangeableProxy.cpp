////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::ActiveChangeableProxy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Core/TimeStampSyncC.h"

//#UC START# *4614E05A0222_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/TimeStampSyncInterface/TimeStampSyncInterface.h"
//#UC END# *4614E05A0222_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace TimeStampSync {

//#UC START# *4614E05A0222*
ActiveChangeableProxy::ActiveChangeableProxy (
	const ::TimeStampSync::TimeStampObjectID& id
	, ActiveChangeable* active_changeable
)	: m_active_changeable (active_changeable) {
	TimeStampObjectManager::instance ()->register_object (id, this);
}

void ActiveChangeableProxy::update_cache (const CORBA::Any* hint) {
	GUARD (m_mutex);
	if (m_active_changeable) {
		// preservative is need to prevent delete ActiveChangeable 
		// object itself inside 'update_cache' operation
		Core::Var<ActiveChangeable> preservative (Core::IObject::_duplicate (m_active_changeable)); 
		m_active_changeable->update_cache (*hint);
	}
}

void ActiveChangeableProxy::acquire_update_mutex () {
	GUARD (m_mutex);
	if (m_active_changeable) {
		Core::Var<ActiveChangeable> preservative (Core::IObject::_duplicate (m_active_changeable)); 
		m_active_changeable->acquire_update_mutex ();
	}
}

void ActiveChangeableProxy::release_update_mutex () {
	GUARD (m_mutex);
	if (m_active_changeable) {
		Core::Var<ActiveChangeable> preservative (Core::IObject::_duplicate (m_active_changeable)); 
		m_active_changeable->release_update_mutex ();
	}
}

void ActiveChangeableProxy::disable () {
	{
		GUARD (m_mutex);
		m_active_changeable = 0;
	}
	TimeStampObjectManager::instance ()->unregister_object (this);
}
//#UC END# *4614E05A0222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ActiveChangeableProxy::~ActiveChangeableProxy () {
	//#UC START# *4614E05A0222_DESTR_BODY*
	if (m_active_changeable) {
		GDS_ASSERT_MSG (false, ("%s: destroying enabled proxy!", GDS_CURRENT_FUNCTION));
		this->disable ();
	}
	//#UC END# *4614E05A0222_DESTR_BODY*
}


} // namespace TimeStampSync
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

