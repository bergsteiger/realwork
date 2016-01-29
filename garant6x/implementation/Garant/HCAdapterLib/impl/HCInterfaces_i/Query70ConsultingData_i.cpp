////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::Query70ConsultingData_i
//
// Реализация интерфейса запроса для СК сентября 2007 года (ф1 версии 7.0).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/Query70ConsultingData_i.h"

//#UC START# *46BB2250035B_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/HCAdapter/HCAdapter.h"
//#UC END# *46BB2250035B_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

//#UC START# *46BB2250035B*
//#UC END# *46BB2250035B*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Query70ConsultingData_i::Query70ConsultingData_i (
	GCI::IO::Stream* xml_stream
	, const GblConsultingDef::ConsultationID& consultation_id
) :
	ConsultingData_i(
		xml_stream
		, consultation_id
	)
//#UC START# *44D1B68701B5_44D1B6C0004E_46BB2250035B_BASE_INIT*
//#UC END# *44D1B68701B5_44D1B6C0004E_46BB2250035B_BASE_INIT*
{
	//#UC START# *44D1B68701B5_44D1B6C0004E_46BB2250035B_BODY*
	//#UC END# *44D1B68701B5_44D1B6C0004E_46BB2250035B_BODY*
}

Query70ConsultingData_i::~Query70ConsultingData_i () {
	//#UC START# *46BB2250035B_DESTR_BODY*
	//#UC END# *46BB2250035B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from HCInterfaces::ConsultingData
// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
// переданный на обработку (при получении оценки, как полностью обработанный).
void Query70ConsultingData_i::data_received () const {
	//#UC START# *442BFEEF0399_46BB2250035B*
	try {
		HCInterfaces::BusinessLogicLifeCycle_var life_cycle (HCInterfaces::BusinessLogicLifeCycleFactory::make ());
		life_cycle->get_consultation_manager70 ().request_received (this->get_cached_consultation_id ());
	} catch (GblConsulting::InvalidConsultationID&) {
		LOG_E (("QueryConsultingData_i::data_received: bad consultation id"));
	}
	//#UC END# *442BFEEF0399_46BB2250035B*
}
} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

