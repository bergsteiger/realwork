////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableParser_i
// Заголовок реализации класса серванта для интерфеса XMLRuleParser
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLEPARSER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLEPARSER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

//#UC START# *45C7415B0280_CUSTOM_INCLUDES*
//#UC END# *45C7415B0280_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class VariableParser_i; // self forward Var
typedef ::Core::Var<VariableParser_i> VariableParser_i_var;
typedef ::Core::Var<const VariableParser_i> VariableParser_i_cvar;

class VariableParser_i_factory;

class VariableParser_i:
	virtual public IniConverter::XMLRuleParser
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (VariableParser_i)
	friend class VariableParser_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	VariableParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node);

	virtual ~VariableParser_i ();

//#UC START# *45C7415B0280*
//#UC END# *45C7415B0280*
}; // class VariableParser_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLEPARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
