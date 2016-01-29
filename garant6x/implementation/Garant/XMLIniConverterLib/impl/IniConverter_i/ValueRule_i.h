////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueRule_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ValueRule_i
// Заголовок реализации класса серванта для интерфеса Rule
//
// правило для указания значения параметра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VALUERULE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VALUERULE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C0A62E0148_CUSTOM_INCLUDES*
//#UC END# *45C0A62E0148_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class ValueRule_i; // self forward Var
typedef ::Core::Var<ValueRule_i> ValueRule_i_var;
typedef ::Core::Var<const ValueRule_i> ValueRule_i_cvar;

class ValueRule_i_factory;

// правило для указания значения параметра
class ValueRule_i:
	virtual public IniConverter::Rule
	, virtual public ::Core::RefCountObjectBase
	, virtual public RuleWithSectionName
{
	SET_OBJECT_COUNTER (ValueRule_i)
	friend class ValueRule_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	enum ValueType {
		VT_OLD // берём значение из старого инишника
		, VT_NEW // берём значение из нового инишника
		, VT_VAR // берём значение из заданной переменной
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ValueRule_i (XercesHelpers::DOMNodeEx& rule_node);

	virtual ~ValueRule_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_parameter_name;

	ValueType m_value;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Rule
	// Применить правило на заданных ини-файлах
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

//#UC START# *45C0A62E0148*
//#UC END# *45C0A62E0148*
}; // class ValueRule_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VALUERULE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
