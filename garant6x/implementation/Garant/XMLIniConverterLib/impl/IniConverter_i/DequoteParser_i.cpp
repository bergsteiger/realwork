////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::DequoteParser_i
//
// снять кавычки с заданного значения параметров.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DequoteParser_i::DequoteParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45C05FC300EA_45C05FFB02FD_45C1C8B60203_BASE_INIT*
//#UC END# *45C05FC300EA_45C05FFB02FD_45C1C8B60203_BASE_INIT*
{
	//#UC START# *45C05FC300EA_45C05FFB02FD_45C1C8B60203_BODY*
	this->init (manager, rule_node, "dequote");
	//#UC END# *45C05FC300EA_45C05FFB02FD_45C1C8B60203_BODY*
}

DequoteParser_i::~DequoteParser_i () {
	//#UC START# *45C1C8B60203_DESTR_BODY*
	//#UC END# *45C1C8B60203_DESTR_BODY*
}


} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

