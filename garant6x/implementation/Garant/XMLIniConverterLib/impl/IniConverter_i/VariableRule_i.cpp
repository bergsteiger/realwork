////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableRule_i
//
// взять значение параметра из заданной переменной
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

//#UC START# *45C7419D02FD_CUSTOM_INCLUDES*
//#UC END# *45C7419D02FD_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C7419D02FD*
//#UC END# *45C7419D02FD*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

VariableRule_i::VariableRule_i (XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45BF29580280_45BF29B101E4_45C7419D02FD_BASE_INIT*
//#UC END# *45BF29580280_45BF29B101E4_45C7419D02FD_BASE_INIT*
{
	//#UC START# *45BF29580280_45BF29B101E4_45C7419D02FD_BODY*
	XercesHelpers::XMLStr name (rule_node.get_attribute ("name"));
	m_parameter_name = name.in ();
	XercesHelpers::XMLStr variable (rule_node.get_attribute ("variable"));
	m_variable_name = variable.in ();
	//#UC END# *45BF29580280_45BF29B101E4_45C7419D02FD_BODY*
}

VariableRule_i::~VariableRule_i () {
	//#UC START# *45C7419D02FD_DESTR_BODY*
	//#UC END# *45C7419D02FD_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

const std::string& VariableRule_i::get_variable_name () const {
	//#UC START# *45C74D2701E4*
	return m_variable_name;
	//#UC END# *45C74D2701E4*
}

void VariableRule_i::set_variable_value (const std::string& value) {
	//#UC START# *45C74D4C0213*
	m_variable_value = value;
	//#UC END# *45C74D4C0213*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Rule
// Применить правило на заданных ини-файлах
void VariableRule_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF29EE03D8_45C7419D02FD*
	IniConverter::Parameter* old_parameter = old_file->get_cached_parameter (this->get_section_name (), m_parameter_name.c_str ());
	if (old_parameter) {
		old_parameter->set_value (m_variable_value);
	}
	//#UC END# *45BF29EE03D8_45C7419D02FD*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

