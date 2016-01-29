////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterStateRule_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ParameterStateRule_i
// Заголовк реализации фабрик интерфеса Rule для серванта ParameterStateRule_i
//
// правило для указания состояния параметра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERSTATERULE_I_FCTR_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERSTATERULE_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

/// Interface-factory implementation for ParameterStateRule_i
class ParameterStateRule_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public IniConverter::RuleAbstractFactory
{
public:
	ParameterStateRule_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IniConverter::Rule* make (XercesHelpers::DOMNodeEx& rule_node);

};

typedef ::Core::Var<ParameterStateRule_i_factory> ParameterStateRule_i_factory_var;

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERSTATERULE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

