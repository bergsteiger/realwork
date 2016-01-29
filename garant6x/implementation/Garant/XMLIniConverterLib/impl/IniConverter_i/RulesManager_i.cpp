////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RulesManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RulesManager_i
//
// Реализация менеджера правил.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RulesManager_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// by <<uses>> dependencies
#include "shared/XercesHelpers/wrappers/DocumentManager.h"

//#UC START# *45BF2C440138_CUSTOM_INCLUDES*
#include "xercesc/dom/DOMDocument.hpp"
#include "xercesc/dom/DOMElement.hpp"
#include "xercesc/dom/DOMNode.hpp"
#include "xercesc/dom/DOMNodeList.hpp"
//#UC END# *45BF2C440138_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

//#UC START# *45BF2C440138*
//#UC END# *45BF2C440138*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RulesManager_i::RulesManager_i ()
//#UC START# *45BF2A7B0196_45BF2ADD0399_45BF2C440138_BASE_INIT*
//#UC END# *45BF2A7B0196_45BF2ADD0399_45BF2C440138_BASE_INIT*
{
	//#UC START# *45BF2A7B0196_45BF2ADD0399_45BF2C440138_BODY*
	//#UC END# *45BF2A7B0196_45BF2ADD0399_45BF2C440138_BODY*
}

RulesManager_i::~RulesManager_i () {
	//#UC START# *45BF2C440138_DESTR_BODY*
	//#UC END# *45BF2C440138_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void RulesManager_i::add_rule_section (XercesHelpers::DOMNodeEx& rule_section) {
	//#UC START# *45BF32670196*
	XercesHelpers::XMLStr type_text (rule_section.get_attribute ("type"));
	IniConverter::XMLRuleParser_var parser = IniConverter::XMLRuleParserFactory::make (this, rule_section, type_text.in ());
	//#UC END# *45BF32670196*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IniConverter::RulesManager
// добавить новое правило
void RulesManager_i::add_rule (const IniConverter::Rule* rule) {
	//#UC START# *45C050F20222_45BF2C440138*
	m_rule_list.push_back (rule);
	//#UC END# *45C050F20222_45BF2C440138*
}

// implemented method from IniConverter::RulesManager
// Применить список правил для получения конечного инишника.
void RulesManager_i::apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const {
	//#UC START# *45BF2B36006D_45BF2C440138*
	for (RuleList::const_iterator it = m_rule_list.begin (); it != m_rule_list.end (); ++it) {
		(*it)->apply (old_file, new_file);
	}
	//#UC END# *45BF2B36006D_45BF2C440138*
}

// implemented method from IniConverter::RulesManager
// получить значение переменной
const std::string& RulesManager_i::get_variable_value (
	const std::string& name
) const /*throw (
	IniConverter::CantFindVariable
)*/ {
	//#UC START# *45C744A5009C_45BF2C440138*
	VariableTable::const_iterator it = m_variable_table.find (name);

	if (it != m_variable_table.end ()) {
		return it->second;
	}

	throw IniConverter::CantFindVariable ();
	//#UC END# *45C744A5009C_45BF2C440138*
}

// implemented method from IniConverter::RulesManager
// инициализация менеджера xml-ными правилами
void RulesManager_i::init (const char* filename) /*throw (IniConverter::BadXMLFormat)*/ {
	//#UC START# *45BF5B070203_45BF2C440138*
	XercesHelpers::DocumentManager doc_manager;
	XERCES_CPP_NAMESPACE::DOMElement* root;
	try {
		XERCES_CPP_NAMESPACE::DOMDocument* doc = doc_manager.get_doc (filename);
		root = doc->getDocumentElement ();
	} catch (...)  {
		std::cerr <<  GDS_CURRENT_FUNCTION << "can't create DOM tree from file " << filename << std::endl;
		throw IniConverter::BadXMLFormat ();
	}

	XercesHelpers::DOMNodeEx root_node (root);

	XERCES_CPP_NAMESPACE::DOMNodeList* rules_list = root_node.get_elements_by_tag_name ("rule");
	XMLSize_t rules_list_length = rules_list->getLength ();

	for (XMLSize_t i = 0; i < rules_list_length; ++i) {
		XercesHelpers::DOMNodeEx rule_section (rules_list->item (i));
		this->add_rule_section (rule_section);
	}
	//#UC END# *45BF5B070203_45BF2C440138*
}

// implemented method from IniConverter::RulesManager
// установить значение переменной
void RulesManager_i::set_variable (const std::string& name, const std::string& value) {
	//#UC START# *45C744C20196_45BF2C440138*
	m_variable_table[name] = value;
	//#UC END# *45C744C20196_45BF2C440138*
}
} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

