////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::ActiveChangeableBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableBase.h"

//#UC START# *4614EBAD0222_CUSTOM_INCLUDES*
//#UC END# *4614EBAD0222_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace TimeStampSync {

//#UC START# *4614EBAD0222*
void ActiveChangeableBase::register_object (const ::TimeStampSync::TimeStampObjectID& id) {
	m_proxy = new ActiveChangeableProxy (id, const_cast<ActiveChangeableBase*> (this));
}

void ActiveChangeableBase::unregister_object () {
	if (!m_proxy.is_nil ()) {
		m_proxy->disable ();
		m_proxy = 0;
	}
}

bool ActiveChangeableBase::is_registered () {
	return !m_proxy.is_nil ();
}
//#UC END# *4614EBAD0222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ActiveChangeableBase::~ActiveChangeableBase () {
	//#UC START# *4614EBAD0222_DESTR_BODY*
	GDS_ASSERT (m_proxy.is_nil ());
	//#UC END# *4614EBAD0222_DESTR_BODY*
}


} // namespace TimeStampSync
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

