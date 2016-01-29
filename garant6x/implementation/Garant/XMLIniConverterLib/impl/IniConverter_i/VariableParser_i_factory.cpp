////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableParser_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

VariableParser_i_factory::VariableParser_i_factory () {
}

void VariableParser_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IniConverter::XMLRuleParserFactoryManager::register_factory (this, priority);
}

const char* VariableParser_i_factory::key () const {
	return "variable";
}

IniConverter::XMLRuleParser* VariableParser_i_factory::make (
	IniConverter::RulesManager* manager
	, XercesHelpers::DOMNodeEx& rule_node
) {
	VariableParser_i_var ret = new VariableParser_i (manager, rule_node);
	return ret._retn ();
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

