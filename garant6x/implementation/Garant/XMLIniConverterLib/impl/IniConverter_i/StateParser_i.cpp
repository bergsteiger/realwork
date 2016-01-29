////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::StateParser_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C060F402FD_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMNodeList.hpp"

#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C060F402FD_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C060F402FD*
//#UC END# *45C060F402FD*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StateParser_i::StateParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45C05FC300EA_45C05FFB02FD_45C060F402FD_BASE_INIT*
//#UC END# *45C05FC300EA_45C05FFB02FD_45C060F402FD_BASE_INIT*
{
	//#UC START# *45C05FC300EA_45C05FFB02FD_45C060F402FD_BODY*
	XERCES_CPP_NAMESPACE::DOMNodeList* section_list = rule_node.get_elements_by_tag_name ("section");
	XMLSize_t section_list_length = section_list->getLength ();

	IniConverter::Rule_var rule;
	for (XMLSize_t i = 0; i < section_list_length; ++i) {
		XercesHelpers::DOMNodeEx section_node (section_list->item (i));
		XercesHelpers::XMLStr state_text (section_node.get_attribute ("state"));
		if (std::strlen (state_text.in ())) {
			rule = IniConverter::RuleFactory::make (section_node, "section_state");
			manager->add_rule (rule._retn ());
		} else {
			XercesHelpers::XMLStr section_name_text (section_node.get_attribute ("name"));
			XERCES_CPP_NAMESPACE::DOMNodeList* parameter_list = section_node.get_elements_by_tag_name ("parameter");
			XMLSize_t parameter_list_length = parameter_list->getLength ();
			for (XMLSize_t i = 0; i < parameter_list_length; ++i) {
				XercesHelpers::DOMNodeEx parameter_node (parameter_list->item (i));
				rule = IniConverter::RuleFactory::make (parameter_node, "parameter_state");
				RuleWithSectionName* rule_i = dynamic_cast<RuleWithSectionName*> (rule.ptr ());
				GDS_ASSERT (rule_i);
				rule_i->set_section_name (section_name_text.in ());
				manager->add_rule (rule._retn ());
			}
		}
	}
	//#UC END# *45C05FC300EA_45C05FFB02FD_45C060F402FD_BODY*
}

StateParser_i::~StateParser_i () {
	//#UC START# *45C060F402FD_DESTR_BODY*
	//#UC END# *45C060F402FD_DESTR_BODY*
}


} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

