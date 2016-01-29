////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::StateParser_i
// Заголовок реализации класса серванта для интерфеса XMLRuleParser
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_STATEPARSER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_STATEPARSER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

//#UC START# *45C060F402FD_CUSTOM_INCLUDES*
//#UC END# *45C060F402FD_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class StateParser_i; // self forward Var
typedef ::Core::Var<StateParser_i> StateParser_i_var;
typedef ::Core::Var<const StateParser_i> StateParser_i_cvar;

class StateParser_i_factory;

class StateParser_i:
	virtual public IniConverter::XMLRuleParser
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StateParser_i)
	friend class StateParser_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StateParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node);

	virtual ~StateParser_i ();

//#UC START# *45C060F402FD*
//#UC END# *45C060F402FD*
}; // class StateParser_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_STATEPARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
