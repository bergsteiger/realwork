////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterParser.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ParameterParser
//
// парсер с простейшим поведением - вычитать правило, установить ему имя секции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERPARSER_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERPARSER_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"

//#UC START# *45C1E0BA0232_CUSTOM_INCLUDES*
//#UC END# *45C1E0BA0232_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

// парсер с простейшим поведением - вычитать правило, установить ему имя секции
class ParameterParser {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ParameterParser ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	virtual void init (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node, const char* key);


//#UC START# *45C1E0BA0232*
//#UC END# *45C1E0BA0232*
}; // class ParameterParser

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERPARSER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

