////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PharmQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PharmQueryCard::PharmQueryCard ()
//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC801AF0352_BASE_INIT*
//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC801AF0352_BASE_INIT*
{
	//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC801AF0352_BODY*
	//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC801AF0352_BODY*
}

PharmQueryCard::~PharmQueryCard () {
	//#UC START# *4CC801AF0352_DESTR_BODY*
	//#UC END# *4CC801AF0352_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryCardInfo
const GCI::IO::Stream* PharmQueryCard::get_evd_card () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4CC7D7B703D0_4CC801AF0352_GET*
	return QueryCardHelper::get_evd_card (GblPilotQueryDef::QT_PHARM_SEARCH);
	//#UC END# *4CC7D7B703D0_4CC801AF0352_GET*
}

// implemented method from QueryCardInfo
// получить список существующих атрибутов для КЗ
AttributeList* PharmQueryCard::get_exist_attrs () const {
	//#UC START# *4CC973C702EE_4CC801AF0352*
	return QueryCardHelper::get_exist_attrs (GblPilotQueryDef::QT_PHARM_SEARCH);
	//#UC END# *4CC973C702EE_4CC801AF0352*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

