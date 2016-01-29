////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingData_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingData_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingData_i.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingData_i::ConsultingData_i (
	GCI::IO::Stream* xml_stream
	, const GblConsultingDef::ConsultationID& consultation_id
)
//#UC START# *44D1B68701B5_44D1B6C0004E_443A4E4F00EA_BASE_INIT*
: m_xml_stream (xml_stream), m_consultation_id (consultation_id)
//#UC END# *44D1B68701B5_44D1B6C0004E_443A4E4F00EA_BASE_INIT*
{
	//#UC START# *44D1B68701B5_44D1B6C0004E_443A4E4F00EA_BODY*
	//#UC END# *44D1B68701B5_44D1B6C0004E_443A4E4F00EA_BODY*
}

ConsultingData_i::~ConsultingData_i () {
	//#UC START# *443A4E4F00EA_DESTR_BODY*
	//#UC END# *443A4E4F00EA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить идентификатор консультации
const GblConsultingDef::ConsultationID& ConsultingData_i::get_cached_consultation_id () const {
	//#UC START# *443A528C0399*
	return m_consultation_id;
	//#UC END# *443A528C0399*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from HCInterfaces::ConsultingData
// Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите).
GCI::IO::Stream* ConsultingData_i::get_data () {
	//#UC START# *442BF015006D_443A4E4F00EA*
	return m_xml_stream._sretn ();
	//#UC END# *442BF015006D_443A4E4F00EA*
}
} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

