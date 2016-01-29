////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueParser_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ValueParser_i
// Заголовок реализации класса серванта для интерфеса XMLRuleParser
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VALUEPARSER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VALUEPARSER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterParser.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

class ValueParser_i; // self forward Var
typedef ::Core::Var<ValueParser_i> ValueParser_i_var;
typedef ::Core::Var<const ValueParser_i> ValueParser_i_cvar;

class ValueParser_i_factory;

class ValueParser_i:
	virtual public IniConverter::XMLRuleParser
	, virtual public ::Core::RefCountObjectBase
	, virtual public ParameterParser
{
	SET_OBJECT_COUNTER (ValueParser_i)
	friend class ValueParser_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ValueParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node);

	virtual ~ValueParser_i ();
}; // class ValueParser_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VALUEPARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
