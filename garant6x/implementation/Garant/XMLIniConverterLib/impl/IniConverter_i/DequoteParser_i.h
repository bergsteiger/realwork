////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::DequoteParser_i
// Заголовок реализации класса серванта для интерфеса XMLRuleParser
//
// снять кавычки с заданного значения параметров.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTEPARSER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTEPARSER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterParser.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

class DequoteParser_i; // self forward Var
typedef ::Core::Var<DequoteParser_i> DequoteParser_i_var;
typedef ::Core::Var<const DequoteParser_i> DequoteParser_i_cvar;

class DequoteParser_i_factory;

// снять кавычки с заданного значения параметров.
class DequoteParser_i:
	virtual public IniConverter::XMLRuleParser
	, virtual public ::Core::RefCountObjectBase
	, virtual public ParameterParser
{
	SET_OBJECT_COUNTER (DequoteParser_i)
	friend class DequoteParser_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DequoteParser_i (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node);

	virtual ~DequoteParser_i ();
}; // class DequoteParser_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTEPARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
