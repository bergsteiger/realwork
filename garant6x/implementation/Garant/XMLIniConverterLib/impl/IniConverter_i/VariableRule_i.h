////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::VariableRule_i
// Заголовок реализации класса серванта для интерфеса Rule
//
// взять значение параметра из заданной переменной
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLERULE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLERULE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C7419D02FD_CUSTOM_INCLUDES*
#include "shared/XercesHelpers/wrappers/defines.h"
//#UC END# *45C7419D02FD_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class VariableRule_i; // self forward Var
typedef ::Core::Var<VariableRule_i> VariableRule_i_var;
typedef ::Core::Var<const VariableRule_i> VariableRule_i_cvar;

class VariableRule_i_factory;

// взять значение параметра из заданной переменной
class VariableRule_i:
	virtual public IniConverter::Rule
	, virtual public ::Core::RefCountObjectBase
	, virtual public RuleWithSectionName
{
	SET_OBJECT_COUNTER (VariableRule_i)
	friend class VariableRule_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	VariableRule_i (XercesHelpers::DOMNodeEx& rule_node);

	virtual ~VariableRule_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual const std::string& get_variable_name () const;

	virtual void set_variable_value (const std::string& value);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_parameter_name;

	std::string m_variable_name;

	std::string m_variable_value;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Rule
	// Применить правило на заданных ини-файлах
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

//#UC START# *45C7419D02FD*
//#UC END# *45C7419D02FD*
}; // class VariableRule_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_VARIABLERULE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
