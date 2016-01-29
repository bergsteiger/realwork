////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Parameter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::Parameter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Parameter_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// by <<uses>> dependencies
#include <algorithm>

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Parameter_i::Parameter_i (
	const char* name
	, const char* value
	, IniConverter::ParameterState state
	, const char* delimiter
)
//#UC START# *455B0CA90203_455B0CC0036B_455B368B01A5_BASE_INIT*
: m_name (name), m_value (value), m_state (state), m_delimiter (delimiter)
//#UC END# *455B0CA90203_455B0CC0036B_455B368B01A5_BASE_INIT*
{
	//#UC START# *455B0CA90203_455B0CC0036B_455B368B01A5_BODY*
	//#UC END# *455B0CA90203_455B0CC0036B_455B368B01A5_BODY*
}

Parameter_i::~Parameter_i () {
	//#UC START# *455B368B01A5_DESTR_BODY*
	//#UC END# *455B368B01A5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Parameter
// добавить закомментированное значение
void Parameter_i::add_commented_value (const std::string& value) {
	//#UC START# *45C9BC220232_455B368B01A5*
	IniConverter::ValuesList::iterator it = std::find (
		m_commented_values.begin ()
		, m_commented_values.end ()
		, value
	);
	if (it == m_commented_values.end ()) {
		m_commented_values.push_back (value);
	}
	//#UC END# *45C9BC220232_455B368B01A5*
}

// implemented method from IniConverter::Parameter
// закомментированные значения параметра
const IniConverter::ValuesList& Parameter_i::get_commented_values () const {
	//#UC START# *45C9BAE50119_455B368B01A5_GET*
	return m_commented_values;
	//#UC END# *45C9BAE50119_455B368B01A5_GET*
}

// implemented method from IniConverter::Parameter
// разделитель, по умолчанию знак равно
const char* Parameter_i::get_delimiter () const {
	//#UC START# *455B13AE006D_455B368B01A5_GET*
	return m_delimiter.c_str ();
	//#UC END# *455B13AE006D_455B368B01A5_GET*
}

// implemented method from IniConverter::Parameter
// имя параметра
const std::string& Parameter_i::get_name () const {
	//#UC START# *455B13670222_455B368B01A5_GET*
	return m_name;
	//#UC END# *455B13670222_455B368B01A5_GET*
}

// implemented method from IniConverter::Parameter
// вывод информации в отладочных целях
void Parameter_i::print (std::ostream& stream) const {
	//#UC START# *45825AAE0232_455B368B01A5*
	GDS_ASSERT (m_state != IniConverter::PS_OLD);
	GDS_ASSERT (m_state != IniConverter::PS_NEW);

	if (m_state == IniConverter::PS_COMMENTED) {
		stream << IniConverter::COMMENT_STRING;
	}
	if (m_state != IniConverter::PS_REMOVED) {
		stream << m_name  << m_delimiter << m_value << std::endl;
	}
	for (
		IniConverter::ValuesList::const_iterator it = m_commented_values.begin ()
		; it != m_commented_values.end ()
		; ++it
	) {
		stream << IniConverter::COMMENT_STRING << m_name  << m_delimiter << *it << std::endl;
	}
	//#UC END# *45825AAE0232_455B368B01A5*
}

// implemented method from IniConverter::Parameter
// состояние парметра
IniConverter::ParameterState Parameter_i::get_state () const {
	//#UC START# *455B1379004E_455B368B01A5_GET*
	return m_state;
	//#UC END# *455B1379004E_455B368B01A5_GET*
}

void Parameter_i::set_state (IniConverter::ParameterState state) {
	//#UC START# *455B1379004E_455B368B01A5_SET*
	m_state = state;
	//#UC END# *455B1379004E_455B368B01A5_SET*
}

// implemented method from IniConverter::Parameter
// значение параметра
const std::string& Parameter_i::get_value () const {
	//#UC START# *455B134301B5_455B368B01A5_GET*
	return m_value;
	//#UC END# *455B134301B5_455B368B01A5_GET*
}

void Parameter_i::set_value (const std::string& value) {
	//#UC START# *455B134301B5_455B368B01A5_SET*
	m_value = value;
	//#UC END# *455B134301B5_455B368B01A5_SET*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

