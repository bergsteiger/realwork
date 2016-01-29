////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserFilter_i::UserFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_4608C7CF02CE_BASE_INIT*
: m_flags (0), m_group_uid (0xFFFFFFFF)
//#UC END# *45EEBB9B01F4_45F6A01A007D_4608C7CF02CE_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_4608C7CF02CE_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_4608C7CF02CE_BODY*
}

UserFilter_i::~UserFilter_i () {
	//#UC START# *4608C7CF02CE_DESTR_BODY*
	//#UC END# *4608C7CF02CE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UserFilter
unsigned long UserFilter_i::get_flags () const {
	//#UC START# *46260CD8002E_4608C7CF02CE_GET*
	return m_flags;
	//#UC END# *46260CD8002E_4608C7CF02CE_GET*
}

void UserFilter_i::set_flags (unsigned long flags) {
	//#UC START# *46260CD8002E_4608C7CF02CE_SET*
	m_flags = flags;
	//#UC END# *46260CD8002E_4608C7CF02CE_SET*
}

// implemented method from UserFilter
// идентификатор группы по которой необходимо осуществить фильтрацию
const Uid UserFilter_i::get_group_uid () const {
	//#UC START# *49DA00730310_4608C7CF02CE_GET*
	return m_group_uid;
	//#UC END# *49DA00730310_4608C7CF02CE_GET*
}

void UserFilter_i::set_group_uid (Uid group_uid) {
	//#UC START# *49DA00730310_4608C7CF02CE_SET*
	m_group_uid = group_uid;
	//#UC END# *49DA00730310_4608C7CF02CE_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

