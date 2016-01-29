////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterParser.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ParameterParser
//
// парсер с простейшим поведением - вычитать правило, установить ему имя секции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterParser.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C1E0BA0232_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMNodeList.hpp"

#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C1E0BA0232_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45C1E0BA0232*
//#UC END# *45C1E0BA0232*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ParameterParser::~ParameterParser () {
	//#UC START# *45C1E0BA0232_DESTR_BODY*
	//#UC END# *45C1E0BA0232_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void ParameterParser::init (
	IniConverter::RulesManager* manager
	, XercesHelpers::DOMNodeEx& rule_node
	, const char* key
) {
	//#UC START# *45C1E15C03D8*
	XERCES_CPP_NAMESPACE::DOMNodeList* section_list = rule_node.get_elements_by_tag_name ("section");
	XMLSize_t section_list_length = section_list->getLength ();

	IniConverter::Rule_var rule;
	for (XMLSize_t i = 0; i < section_list_length; ++i) {
		XercesHelpers::DOMNodeEx section_node (section_list->item (i));
		XercesHelpers::XMLStr section_name_text (section_node.get_attribute ("name"));
		XERCES_CPP_NAMESPACE::DOMNodeList* parameter_list = section_node.get_elements_by_tag_name ("parameter");
		XMLSize_t parameter_list_length = parameter_list->getLength ();
		for (XMLSize_t i = 0; i < parameter_list_length; ++i) {
			XercesHelpers::DOMNodeEx parameter_node (parameter_list->item (i));
			try {
				rule = IniConverter::RuleFactory::make (parameter_node, key);
			} catch (Core::ElementNotFound&) {
				std::cerr << "can't create rule type " << key << " (TypeConverter::ElementNotFound)" << std::endl;
			}
			RuleWithSectionName* rule_i = dynamic_cast<RuleWithSectionName*> (rule.ptr ());
			GDS_ASSERT (rule_i);
			rule_i->set_section_name (section_name_text.in ());
			manager->add_rule (rule._retn ());
		}
	}
	//#UC END# *45C1E15C03D8*
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

