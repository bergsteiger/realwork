////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableRule_i
// Заголовк реализации фабрик интерфеса Rule для серванта VariableRule_i
//
// взять значение параметра из заданной переменной
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLERULE_I_FCTR_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLERULE_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i.h"

/// Servant-factory implementation for VariableRule_i
namespace XMLIniConverterLib {
namespace IniConverter_i {
	class VariableParser_i; //forward friend
} // namespace IniConverter_i
} // namespace XMLIniConverterLib


namespace XMLIniConverterLib {
namespace IniConverter_i {

class VariableRule_iServantFactory {
	friend class VariableParser_i;

	static VariableRule_i* make (XercesHelpers::DOMNodeEx& rule_node);
};

/// Interface-factory implementation for VariableRule_i
class VariableRule_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public IniConverter::RuleAbstractFactory
{
	friend class VariableRule_iServantFactory;

public:
	VariableRule_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static VariableRule_i_factory* s_instance;

	const char* key () const;

	IniConverter::Rule* make (XercesHelpers::DOMNodeEx& rule_node);

};

typedef ::Core::Var<VariableRule_i_factory> VariableRule_i_factory_var;

} // namespace IniConverter_i
} // namespace XMLIniConverterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter_i::VariableRule_i> {
	typedef XMLIniConverterLib::IniConverter_i::VariableRule_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLERULE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

