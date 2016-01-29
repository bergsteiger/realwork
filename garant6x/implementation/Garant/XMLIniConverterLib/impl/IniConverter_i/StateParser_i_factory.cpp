////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::StateParser_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

StateParser_i_factory::StateParser_i_factory () {
}

void StateParser_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IniConverter::XMLRuleParserFactoryManager::register_factory (this, priority);
}

const char* StateParser_i_factory::key () const {
	return "state";
}

IniConverter::XMLRuleParser* StateParser_i_factory::make (
	IniConverter::RulesManager* manager
	, XercesHelpers::DOMNodeEx& rule_node
) {
	StateParser_i_var ret = new StateParser_i (manager, rule_node);
	return ret._retn ();
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

