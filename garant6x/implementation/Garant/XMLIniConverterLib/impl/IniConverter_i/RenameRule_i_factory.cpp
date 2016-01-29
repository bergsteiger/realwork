////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RenameRule_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

RenameRule_i_factory::RenameRule_i_factory () {
}

void RenameRule_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IniConverter::RuleFactoryManager::register_factory (this, priority);
}

const char* RenameRule_i_factory::key () const {
	return "rename";
}

IniConverter::Rule* RenameRule_i_factory::make (XercesHelpers::DOMNodeEx& rule_node) {
	RenameRule_i_var ret = new RenameRule_i (rule_node);
	return ret._retn ();
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

