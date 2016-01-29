////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::DequoteParser_i
// Заголовк реализации фабрик интерфеса XMLRuleParser для серванта DequoteParser_i
//
// снять кавычки с заданного значения параметров.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTEPARSER_I_FCTR_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTEPARSER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

/// Interface-factory implementation for DequoteParser_i
class DequoteParser_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public IniConverter::XMLRuleParserAbstractFactory
{
public:
	DequoteParser_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IniConverter::XMLRuleParser* make (IniConverter::RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node);

};

typedef ::Core::Var<DequoteParser_i_factory> DequoteParser_i_factory_var;

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTEPARSER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

