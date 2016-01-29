////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteRule_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::DequoteRule_i
//
// снять кавычки со значения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

//#UC START# *45C1EA8D0109_CUSTOM_INCLUDES*
#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C1EA8D0109_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C1EA8D0109*
//#UC END# *45C1EA8D0109*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DequoteRule_i::DequoteRule_i (XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45BF29580280_45BF29B101E4_45C1EA8D0109_BASE_INIT*
//#UC END# *45BF29580280_45BF29B101E4_45C1EA8D0109_BASE_INIT*
{
	//#UC START# *45BF29580280_45BF29B101E4_45C1EA8D0109_BODY*
	XercesHelpers::XMLStr name (rule_node.get_attribute ("name"));
	m_name = name.in ();
	//#UC END# *45BF29580280_45BF29B101E4_45C1EA8D0109_BODY*
}

DequoteRule_i::~DequoteRule_i () {
	//#UC START# *45C1EA8D0109_DESTR_BODY*
	//#UC END# *45C1EA8D0109_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Rule
// Применить правило на заданных ини-файлах
void DequoteRule_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF29EE03D8_45C1EA8D0109*
	IniConverter::Parameter* parameter = old_file->get_cached_parameter (this->get_section_name (), m_name.c_str ());
	if (parameter) {
		const std::string& value = parameter->get_value ();
		if ((value[0] == '"') && (value[value.size () - 1] == '"')) {
			parameter->set_value (value.substr (1, value.size () - 2));
		}
	}
	//#UC END# *45BF29EE03D8_45C1EA8D0109*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

