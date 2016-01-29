////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::OfflineConsultingData_i
//
// Реализация работы консультаций, доставляемых вручную.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

OfflineConsultingData_i::OfflineConsultingData_i (GCI::IO::Stream* xml_stream)
//#UC START# *44D1B6A7000F_44D1B6D00399_44D1B7A0000F_BASE_INIT*
: m_xml_stream (xml_stream)
//#UC END# *44D1B6A7000F_44D1B6D00399_44D1B7A0000F_BASE_INIT*
{
	//#UC START# *44D1B6A7000F_44D1B6D00399_44D1B7A0000F_BODY*
	//#UC END# *44D1B6A7000F_44D1B6D00399_44D1B7A0000F_BODY*
}

OfflineConsultingData_i::~OfflineConsultingData_i () {
	//#UC START# *44D1B7A0000F_DESTR_BODY*
	//#UC END# *44D1B7A0000F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from HCInterfaces::ConsultingData
// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
// переданный на обработку (при получении оценки, как полностью обработанный).
void OfflineConsultingData_i::data_received () const {
	//#UC START# *442BFEEF0399_44D1B7A0000F*
	return;
	//#UC END# *442BFEEF0399_44D1B7A0000F*
}

// implemented method from HCInterfaces::ConsultingData
// Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите).
GCI::IO::Stream* OfflineConsultingData_i::get_data () {
	//#UC START# *442BF015006D_44D1B7A0000F*
	return m_xml_stream._sretn ();
	//#UC END# *442BF015006D_44D1B7A0000F*
}
} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

