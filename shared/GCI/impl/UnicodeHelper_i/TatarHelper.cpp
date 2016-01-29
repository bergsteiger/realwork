////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/TatarHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::TatarHelper
//
// Дополнительные преобразования для татарского языка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/UnicodeHelper_i/TatarHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TatarHelper::TatarHelper ()
//#UC START# *4869FDE10378_486A077002FA_486A06BF003B_BASE_INIT*
//#UC END# *4869FDE10378_486A077002FA_486A06BF003B_BASE_INIT*
{
	//#UC START# *4869FDE10378_486A077002FA_486A06BF003B_BODY*
		m_ru_to_ta [0x0402] = 0x04D8;
		m_ru_to_ta [0x0452] = 0x04D9;
		m_ru_to_ta [0x040C] = 0x0496;
		m_ru_to_ta [0x045C] = 0x0497;
		m_ru_to_ta [0x040B] = 0x04A2;
		m_ru_to_ta [0x045B] = 0x04A3;
		m_ru_to_ta [0x040A] = 0x04AE;
		m_ru_to_ta [0x045A] = 0x04AF;
		m_ru_to_ta [0x040F] = 0x04BA;
		m_ru_to_ta [0x045F] = 0x04BB;
		m_ru_to_ta [0x0409] = 0x04E8;
		m_ru_to_ta [0x0459] = 0x04E9;

		m_ta_to_ru [0x04D8] = 0x0402;
		m_ta_to_ru [0x04D9] = 0x0452;
		m_ta_to_ru [0x0496] = 0x040C;
		m_ta_to_ru [0x0497] = 0x045C;
		m_ta_to_ru [0x04A2] = 0x040B;
		m_ta_to_ru [0x04A3] = 0x045B;
		m_ta_to_ru [0x04AE] = 0x040A;
		m_ta_to_ru [0x04AF] = 0x045A;
		m_ta_to_ru [0x04BA] = 0x040F;
		m_ta_to_ru [0x04BB] = 0x045F;
		m_ta_to_ru [0x04E8] = 0x0409;
		m_ta_to_ru [0x04E9] = 0x0459;
	//#UC END# *4869FDE10378_486A077002FA_486A06BF003B_BODY*
}

TatarHelper::~TatarHelper () {
	//#UC START# *486A06BF003B_DESTR_BODY*
	//#UC END# *486A06BF003B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UnicodeHelper::ConverterHelper
// дополнительные (специфический для локали) преобразования
void TatarHelper::add_specific (wchar_t* buffer) const {
	//#UC START# *4869FE9D0252_486A06BF003B*
	for (size_t i = 0; buffer[i]; ++i) {
		WCharMap::const_iterator it = m_ru_to_ta.find (buffer[i]);
		if (it != m_ru_to_ta.end ()) {
			buffer [i] = it->second;
		}
	}
	//#UC END# *4869FE9D0252_486A06BF003B*
}

// implemented method from UnicodeHelper::ConverterHelper
// удаляет из Unicode-строки дополнителное, специфическое для локали преобразование
const std::wstring TatarHelper::remove_specific (const std::wstring& in) const {
	//#UC START# *486A03D2026B_486A06BF003B*
	std::wstring out;
	for (size_t i = 0; i < in.size (); ++i) {
		WCharMap::const_iterator it = m_ta_to_ru.find (in[i]);
		out += it == m_ta_to_ru.end () ? in [i] : it->second;
	}
	return out;
	//#UC END# *486A03D2026B_486A06BF003B*
}
} // namespace UnicodeHelper_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

