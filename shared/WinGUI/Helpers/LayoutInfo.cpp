////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/LayoutInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::LayoutInfo
//
// Класс для хранения информации и опций о контроле. Позволяет определять какие опции установлены,
// а какие нет.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Helpers/LayoutInfo.h"
// by <<uses>> dependencies
#include "shared/WinGUI/Helpers/WinControlHelper.h"

//#UC START# *4652AEFF0128_CUSTOM_INCLUDES*
//#UC END# *4652AEFF0128_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *4652AEFF0128*
//#UC END# *4652AEFF0128*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// default конструктор
LayoutInfo::LayoutInfo ()
//#UC START# *4652B1AD0196_BASE_INIT*
//#UC END# *4652B1AD0196_BASE_INIT*
{
	//#UC START# *4652B1AD0196_BODY*
	reset ();
	//#UC END# *4652B1AD0196_BODY*
}

LayoutInfo::~LayoutInfo () {
	//#UC START# *4652AEFF0128_DESTR_BODY*
	//#UC END# *4652AEFF0128_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет свойство
bool LayoutInfo::add_option (OptionTypes opt, int value) {
	//#UC START# *4652B6DC003E*
	m_options[opt] = value;
	return true;
	//#UC END# *4652B6DC003E*
}

// возвращает знчение установленной опции
bool LayoutInfo::get_option (OptionTypes opt, int& value) const {
	//#UC START# *4652B74700AB*	
	Options::const_iterator it = m_options.find (opt);
	if (it == m_options.end ()) {
		return false;
	}
    value = it->second;

    return true;
	//#UC END# *4652B74700AB*
}

// true, если такая opt  установлена, иначе false
bool LayoutInfo::has_option (OptionTypes opt) const {
	//#UC START# *4652B753035B*
	return m_options.find (opt) != m_options.end ();
	//#UC END# *4652B753035B*
}

// ?????
const CRect& LayoutInfo::reference_rect () const {
	//#UC START# *47C4FC6101AF*
	return m_reference_rect;
	//#UC END# *47C4FC6101AF*
}

// ?????
CRect& LayoutInfo::reference_rect () {
	//#UC START# *47C4FCD40049*
	return m_reference_rect;
	//#UC END# *47C4FCD40049*
}

// очищает информацию о расположении
void LayoutInfo::reset () {
	//#UC START# *4652B69D00EA*
	m_precision = 3;

    // Reset the bitset flags.
    m_options.clear ();

    // Initialize the reference rect.
    m_reference_rect.SetRect(0,0,0,0);
	//#UC END# *4652B69D00EA*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

unsigned int LayoutInfo::get_precision () const {
	//#UC START# *4652B1D00290_GET_ACCESSOR*
	return m_precision;
	//#UC END# *4652B1D00290_GET_ACCESSOR*
}

void LayoutInfo::set_precision (unsigned int precision) {
	//#UC START# *4652B1D00290_SET_ACCESSOR*
	m_precision = precision;
	//#UC END# *4652B1D00290_SET_ACCESSOR*
}


} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

