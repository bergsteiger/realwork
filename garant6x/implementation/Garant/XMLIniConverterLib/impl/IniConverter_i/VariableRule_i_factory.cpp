////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableRule_i
//
// взять значение параметра из заданной переменной
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

VariableRule_i_factory* VariableRule_i_factory::s_instance = 0;

VariableRule_i_factory::VariableRule_i_factory () {
}

void VariableRule_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IniConverter::RuleFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* VariableRule_i_factory::key () const {
	return "variable";
}

IniConverter::Rule* VariableRule_i_factory::make (XercesHelpers::DOMNodeEx& rule_node) {
	VariableRule_i_var ret = new VariableRule_i (rule_node);
	return ret._retn ();
}

VariableRule_i* VariableRule_iServantFactory::make (XercesHelpers::DOMNodeEx& rule_node) {
	if (VariableRule_i_factory::s_instance) {
		return dynamic_cast<VariableRule_i*>(VariableRule_i_factory::s_instance->make (rule_node));
	} else {
		throw Core::Root::NoActiveFactory ("XMLIniConverterLib::IniConverter_i::VariableRule_i_factory");
	}
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

