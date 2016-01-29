////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::MarkConsultingData70_i
//
// оценка для СК версии 7.0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i.h"

//#UC START# *46DD5C5201F4_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/HCAdapter/HCAdapter.h"
//#UC END# *46DD5C5201F4_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

//#UC START# *46DD5C5201F4*
//#UC END# *46DD5C5201F4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MarkConsultingData70_i::MarkConsultingData70_i (
	GCI::IO::Stream* xml_stream
	, const GblConsultingDef::ConsultationID& consultation_id
) :
	ConsultingData_i(
		xml_stream
		, consultation_id
	)
//#UC START# *44D1B68701B5_44D1B6C0004E_46DD5C5201F4_BASE_INIT*
//#UC END# *44D1B68701B5_44D1B6C0004E_46DD5C5201F4_BASE_INIT*
{
	//#UC START# *44D1B68701B5_44D1B6C0004E_46DD5C5201F4_BODY*
	//#UC END# *44D1B68701B5_44D1B6C0004E_46DD5C5201F4_BODY*
}

MarkConsultingData70_i::~MarkConsultingData70_i () {
	//#UC START# *46DD5C5201F4_DESTR_BODY*
	//#UC END# *46DD5C5201F4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from HCInterfaces::ConsultingData
// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
// переданный на обработку (при получении оценки, как полностью обработанный).
void MarkConsultingData70_i::data_received () const {
	//#UC START# *442BFEEF0399_46DD5C5201F4*
	try {
		HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
		life_cycle->get_consultation_manager70 ().estimation_received (this->get_cached_consultation_id ());
	} catch (GblConsulting::InvalidConsultationID&) {
		LOG_E (("%s: bad consultation id", GDS_CURRENT_FUNCTION));
	}
	//#UC END# *442BFEEF0399_46DD5C5201F4*
}
} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

