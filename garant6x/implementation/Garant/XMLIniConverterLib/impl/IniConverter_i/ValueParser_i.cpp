////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueParser_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ValueParser_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ValueParser_i::ValueParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45C05FC300EA_45C05FFB02FD_45C0C73902DE_BASE_INIT*
//#UC END# *45C05FC300EA_45C05FFB02FD_45C0C73902DE_BASE_INIT*
{
	//#UC START# *45C05FC300EA_45C05FFB02FD_45C0C73902DE_BODY*
	this->init (manager, rule_node, "value");
	//#UC END# *45C05FC300EA_45C05FFB02FD_45C0C73902DE_BODY*
}

ValueParser_i::~ValueParser_i () {
	//#UC START# *45C0C73902DE_DESTR_BODY*
	//#UC END# *45C0C73902DE_DESTR_BODY*
}


} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

