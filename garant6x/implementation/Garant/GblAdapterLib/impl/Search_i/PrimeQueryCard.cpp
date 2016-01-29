////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PrimeQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrimeQueryCard::PrimeQueryCard ()
//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC7EA9502C3_BASE_INIT*
//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC7EA9502C3_BASE_INIT*
{
	//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC7EA9502C3_BODY*
	//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC7EA9502C3_BODY*
}

PrimeQueryCard::~PrimeQueryCard () {
	//#UC START# *4CC7EA9502C3_DESTR_BODY*
	//#UC END# *4CC7EA9502C3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryCardInfo
const GCI::IO::Stream* PrimeQueryCard::get_evd_card () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4CC7D7B703D0_4CC7EA9502C3_GET*
	return QueryCardHelper::get_evd_card (GblPilotQueryDef::QT_MAIL_LIST);
	//#UC END# *4CC7D7B703D0_4CC7EA9502C3_GET*
}

// implemented method from QueryCardInfo
// получить список существующих атрибутов для КЗ
AttributeList* PrimeQueryCard::get_exist_attrs () const {
	//#UC START# *4CC973C702EE_4CC7EA9502C3*
	return QueryCardHelper::get_exist_attrs (GblPilotQueryDef::QT_MAIL_LIST);
	//#UC END# *4CC973C702EE_4CC7EA9502C3*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

