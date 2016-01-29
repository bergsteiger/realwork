////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableParser_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i_factory.h"

//#UC START# *45C7415B0280_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMNodeList.hpp"

#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C7415B0280_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C7415B0280*
//#UC END# *45C7415B0280*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

VariableParser_i::VariableParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45C05FC300EA_45C05FFB02FD_45C7415B0280_BASE_INIT*
//#UC END# *45C05FC300EA_45C05FFB02FD_45C7415B0280_BASE_INIT*
{
	//#UC START# *45C05FC300EA_45C05FFB02FD_45C7415B0280_BODY*
	XERCES_CPP_NAMESPACE::DOMNodeList* section_list = rule_node.get_elements_by_tag_name ("section");
	XMLSize_t section_list_length = section_list->getLength ();

	Core::Var<VariableRule_i> rule;
	for (XMLSize_t i = 0; i < section_list_length; ++i) {
		XercesHelpers::DOMNodeEx section_node (section_list->item (i));
		XercesHelpers::XMLStr section_name_text (section_node.get_attribute ("name"));
		XERCES_CPP_NAMESPACE::DOMNodeList* parameter_list = section_node.get_elements_by_tag_name ("parameter");
		XMLSize_t parameter_list_length = parameter_list->getLength ();
		for (XMLSize_t i = 0; i < parameter_list_length; ++i) {
			XercesHelpers::DOMNodeEx parameter_node (parameter_list->item (i));
			rule = VariableRule_iServantFactory::make (parameter_node);
			rule->set_section_name (section_name_text.in ());
			try {
				rule->set_variable_value (
					manager->get_variable_value (rule->get_variable_name ())
				);
				manager->add_rule (rule._retn ());
			} catch (IniConverter::CantFindVariable&) {
				std::cerr << "Can't find variable " <<  rule->get_variable_name () << " for rule" << std::endl;
			}
		}
	}
	//#UC END# *45C05FC300EA_45C05FFB02FD_45C7415B0280_BODY*
}

VariableParser_i::~VariableParser_i () {
	//#UC START# *45C7415B0280_DESTR_BODY*
	//#UC END# *45C7415B0280_DESTR_BODY*
}


} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

