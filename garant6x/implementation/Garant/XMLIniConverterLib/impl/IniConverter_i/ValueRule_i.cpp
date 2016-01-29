////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueRule_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ValueRule_i
//
// правило для указания значения параметра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

//#UC START# *45C0A62E0148_CUSTOM_INCLUDES*
#include "shared/Core/data/UnsortedTypeConverter.h"

#include "shared/XercesHelpers/wrappers/defines.h"
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"
//#UC END# *45C0A62E0148_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C0A62E0148*
class ValueTypeConverter : 
	public Core::UnsortedTypeConverter<const char*, ValueRule_i::ValueType, Core::ConstCharIsEqual> {
protected:
	void fill_array  () {
		this->add ("new", IniConverter_i::ValueRule_i::VT_NEW);
		this->add ("old", IniConverter_i::ValueRule_i::VT_OLD);
	}
};
//#UC END# *45C0A62E0148*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ValueRule_i::ValueRule_i (XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45BF29580280_45BF29B101E4_45C0A62E0148_BASE_INIT*
//#UC END# *45BF29580280_45BF29B101E4_45C0A62E0148_BASE_INIT*
{
	//#UC START# *45BF29580280_45BF29B101E4_45C0A62E0148_BODY*
	ValueTypeConverter converter;

	XercesHelpers::XMLStr state (rule_node.get_attribute ("value"));
	m_value = converter.get (state.in ());
	XercesHelpers::XMLStr name (rule_node.get_attribute ("name"));
	m_parameter_name = name.in ();
	//#UC END# *45BF29580280_45BF29B101E4_45C0A62E0148_BODY*
}

ValueRule_i::~ValueRule_i () {
	//#UC START# *45C0A62E0148_DESTR_BODY*
	//#UC END# *45C0A62E0148_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Rule
// Применить правило на заданных ини-файлах
void ValueRule_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF29EE03D8_45C0A62E0148*
	if (m_value == VT_NEW) {
		IniConverter::Parameter* old_parameter = old_file->get_cached_parameter (this->get_section_name (), m_parameter_name.c_str ());
		IniConverter::Parameter* new_parameter = new_file->get_cached_parameter (this->get_section_name (), m_parameter_name.c_str ());
		if (new_parameter && old_parameter) {
			old_parameter->set_value (new_parameter->get_value ());
		}
	}
	//#UC END# *45BF29EE03D8_45C0A62E0148*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

