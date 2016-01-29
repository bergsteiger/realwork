////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterStateRule_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ParameterStateRule_i
//
// правило для указания состояния параметра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterStateRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

//#UC START# *45C0873301D4_CUSTOM_INCLUDES*
#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C0873301D4_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C0873301D4*
//#UC END# *45C0873301D4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ParameterStateRule_i::ParameterStateRule_i (XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45BF29580280_45BF29B101E4_45C0873301D4_BASE_INIT*
//#UC END# *45BF29580280_45BF29B101E4_45C0873301D4_BASE_INIT*
{
	//#UC START# *45BF29580280_45BF29B101E4_45C0873301D4_BODY*
	XercesHelpers::XMLStr state (rule_node.get_attribute ("state"));
	m_state = IniConverter::PSConverterSingleton::instance ()->get (state.in ());
	XercesHelpers::XMLStr name (rule_node.get_attribute ("name"));
	m_parameter_name = name.in ();
	//#UC END# *45BF29580280_45BF29B101E4_45C0873301D4_BODY*
}

ParameterStateRule_i::~ParameterStateRule_i () {
	//#UC START# *45C0873301D4_DESTR_BODY*
	//#UC END# *45C0873301D4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Rule
// Применить правило на заданных ини-файлах
void ParameterStateRule_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF29EE03D8_45C0873301D4*
	if (m_state == IniConverter::PS_REMOVED) {
		IniConverter::Section* old_section = old_file->get_cached_section (this->get_section_name ());
		IniConverter::Section* new_section = new_file->get_cached_section (this->get_section_name ());
		if (old_section) {
			old_section->delete_parameter (m_parameter_name.c_str ());
		}
		if (new_section) {
			new_section->delete_parameter (m_parameter_name.c_str ());
		}

		return;
	}

	IniConverter::Parameter* old_parameter = old_file->get_cached_parameter (this->get_section_name (), m_parameter_name.c_str ());
	IniConverter::Parameter* new_parameter = new_file->get_cached_parameter (this->get_section_name (), m_parameter_name.c_str ());
	if (old_parameter && (m_state == IniConverter::PS_NEW)) {
		GDS_ASSERT (new_parameter);
		// paranoia
		if (new_parameter) {
			old_parameter->set_state (new_parameter->get_state ());
		}
	} else if (
		old_parameter 
		&& (m_state != IniConverter::PS_NEW)
		&& (m_state != IniConverter::PS_OLD)
	) {
		old_parameter->set_state (m_state);
	} else {
		IniConverter::Parameter* new_parameter = new_file->get_cached_parameter (this->get_section_name (), m_parameter_name.c_str ());
		GDS_ASSERT (new_parameter);
		// paranoia
		if (
			new_parameter
			&& (m_state != IniConverter::PS_NEW)
			&& (m_state != IniConverter::PS_OLD)
		) {
			new_parameter->set_state (m_state);
		}
	}
	//#UC END# *45BF29EE03D8_45C0873301D4*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

