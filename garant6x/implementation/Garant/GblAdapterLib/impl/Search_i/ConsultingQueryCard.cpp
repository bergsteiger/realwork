////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::ConsultingQueryCard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingQueryCard::ConsultingQueryCard ()
//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC80186029D_BASE_INIT*
//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC80186029D_BASE_INIT*
{
	//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC80186029D_BODY*
	//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC80186029D_BODY*
}

ConsultingQueryCard::~ConsultingQueryCard () {
	//#UC START# *4CC80186029D_DESTR_BODY*
	//#UC END# *4CC80186029D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryCardInfo
const GCI::IO::Stream* ConsultingQueryCard::get_evd_card () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4CC7D7B703D0_4CC80186029D_GET*
	return QueryCardHelper::get_evd_card (GblPilotQueryDef::QT_HANDYCRAFT_CONSULT);
	//#UC END# *4CC7D7B703D0_4CC80186029D_GET*
}

// implemented method from QueryCardInfo
// получить список существующих атрибутов для КЗ
AttributeList* ConsultingQueryCard::get_exist_attrs () const {
	//#UC START# *4CC973C702EE_4CC80186029D*
	return QueryCardHelper::get_exist_attrs (GblPilotQueryDef::QT_HANDYCRAFT_CONSULT);
	//#UC END# *4CC973C702EE_4CC80186029D*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

