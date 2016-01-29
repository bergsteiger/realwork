////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::Notification_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Notification_i::Notification_i ()
//#UC START# *45EEDEA001A4_45F9572B01FC_45F9576503E0_BASE_INIT*
//#UC END# *45EEDEA001A4_45F9572B01FC_45F9576503E0_BASE_INIT*
{
	//#UC START# *45EEDEA001A4_45F9572B01FC_45F9576503E0_BODY*
	//#UC END# *45EEDEA001A4_45F9572B01FC_45F9576503E0_BODY*
}

Notification_i::~Notification_i () {
	//#UC START# *45F9576503E0_DESTR_BODY*
	//#UC END# *45F9576503E0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Notification
const Variant& Notification_i::get_data () const {
	//#UC START# *45EEDEA001A6_45F9576503E0_GET*
	return *m_data.ptr ();
	//#UC END# *45EEDEA001A6_45F9576503E0_GET*
}

Variant& Notification_i::get_data () {
	return const_cast<Variant&>(((const Notification_i*)this)->get_data ());
}

// implemented method from Notification
NotifyType Notification_i::get_id () const {
	//#UC START# *45EEDEA001A5_45F9576503E0_GET*
	return m_type;
	//#UC END# *45EEDEA001A5_45F9576503E0_GET*
}

// implemented method from Notification
void Notification_i::set_data (Variant* data) {
	//#UC START# *4614D130038E_45F9576503E0*
	m_data = Variant::_duplicate (data);
	//#UC END# *4614D130038E_45F9576503E0*
}

// implemented method from Notification
void Notification_i::set_type (NotifyType type) {
	//#UC START# *4614D11B00EE_45F9576503E0*
	m_type = type;
	//#UC END# *4614D11B00EE_45F9576503E0*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

