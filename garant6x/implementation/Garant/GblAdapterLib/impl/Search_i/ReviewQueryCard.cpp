////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::ReviewQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ReviewQueryCard::ReviewQueryCard ()
//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC801D501D1_BASE_INIT*
//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC801D501D1_BASE_INIT*
{
	//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC801D501D1_BODY*
	//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC801D501D1_BODY*
}

ReviewQueryCard::~ReviewQueryCard () {
	//#UC START# *4CC801D501D1_DESTR_BODY*
	//#UC END# *4CC801D501D1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryCardInfo
const GCI::IO::Stream* ReviewQueryCard::get_evd_card () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4CC7D7B703D0_4CC801D501D1_GET*
	return QueryCardHelper::get_evd_card (GblPilotQueryDef::QT_REVIEW);
	//#UC END# *4CC7D7B703D0_4CC801D501D1_GET*
}

// implemented method from QueryCardInfo
// получить список существующих атрибутов для КЗ
AttributeList* ReviewQueryCard::get_exist_attrs () const {
	//#UC START# *4CC973C702EE_4CC801D501D1*
	return QueryCardHelper::get_exist_attrs (GblPilotQueryDef::QT_REVIEW);
	//#UC END# *4CC973C702EE_4CC801D501D1*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

