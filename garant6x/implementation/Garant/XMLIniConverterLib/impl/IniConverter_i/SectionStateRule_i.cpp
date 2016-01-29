////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/SectionStateRule_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::SectionStateRule_i
//
// правило для указания состояния секции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/SectionStateRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

//#UC START# *45BF2C0C038A_CUSTOM_INCLUDES*
#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45BF2C0C038A_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45BF2C0C038A*
//#UC END# *45BF2C0C038A*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SectionStateRule_i::SectionStateRule_i (XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45BF29580280_45BF29B101E4_45BF2C0C038A_BASE_INIT*
//#UC END# *45BF29580280_45BF29B101E4_45BF2C0C038A_BASE_INIT*
{
	//#UC START# *45BF29580280_45BF29B101E4_45BF2C0C038A_BODY*
	XercesHelpers::XMLStr state (rule_node.get_attribute ("state"));
	m_state = IniConverter::PSConverterSingleton::instance ()->get (state.in ());
	XercesHelpers::XMLStr name (rule_node.get_attribute ("name"));
	m_section_name = name.in ();
	//#UC END# *45BF29580280_45BF29B101E4_45BF2C0C038A_BODY*
}

SectionStateRule_i::~SectionStateRule_i () {
	//#UC START# *45BF2C0C038A_DESTR_BODY*
	//#UC END# *45BF2C0C038A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::Rule
// Применить правило на заданных ини-файлах
void SectionStateRule_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF29EE03D8_45BF2C0C038A*
	if (m_state == IniConverter::PS_REMOVED) {
		old_file->delete_section (m_section_name.c_str ());
		new_file->delete_section (m_section_name.c_str ());
	}
	//#UC END# *45BF29EE03D8_45BF2C0C038A*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

