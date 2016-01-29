////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameParser_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RenameParser_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameParser_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RenameParser_i::RenameParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node)
//#UC START# *45C05FC300EA_45C05FFB02FD_45C0CD4A035B_BASE_INIT*
//#UC END# *45C05FC300EA_45C05FFB02FD_45C0CD4A035B_BASE_INIT*
{
	//#UC START# *45C05FC300EA_45C05FFB02FD_45C0CD4A035B_BODY*
	this->init (manager, rule_node, "rename");
	//#UC END# *45C05FC300EA_45C05FFB02FD_45C0CD4A035B_BODY*
}

RenameParser_i::~RenameParser_i () {
	//#UC START# *45C0CD4A035B_DESTR_BODY*
	//#UC END# *45C0CD4A035B_DESTR_BODY*
}


} // namespace IniConverter_i
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

