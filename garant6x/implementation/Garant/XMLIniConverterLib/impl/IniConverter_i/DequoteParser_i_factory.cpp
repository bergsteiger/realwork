////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::DequoteParser_i
//
// ����� ������� � ��������� �������� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

DequoteParser_i_factory::DequoteParser_i_factory () {
}

void DequoteParser_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IniConverter::XMLRuleParserFactoryManager::register_factory (this, priority);
}

const char* DequoteParser_i_factory::key () const {
	return "dequote";
}

IniConverter::XMLRuleParser* DequoteParser_i_factory::make (
	IniConverter::RulesManager* manager
	, XercesHelpers::DOMNodeEx& rule_node
) {
	DequoteParser_i_var ret = new DequoteParser_i (manager, rule_node);
	return ret._retn ();
}

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

