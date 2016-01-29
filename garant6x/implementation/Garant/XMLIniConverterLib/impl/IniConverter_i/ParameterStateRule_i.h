////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterStateRule_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::ParameterStateRule_i
// Заголовок реализации класса серванта для интерфеса Rule
//
// правило для указания состояния параметра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERSTATERULE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERSTATERULE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C0873301D4_CUSTOM_INCLUDES*
//#UC END# *45C0873301D4_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class ParameterStateRule_i; // self forward Var
typedef ::Core::Var<ParameterStateRule_i> ParameterStateRule_i_var;
typedef ::Core::Var<const ParameterStateRule_i> ParameterStateRule_i_cvar;

class ParameterStateRule_i_factory;

// правило для указания состояния параметра
class ParameterStateRule_i:
	virtual public IniConverter::Rule
	, virtual public ::Core::RefCountObjectBase
	, virtual public RuleWithSectionName
{
	SET_OBJECT_COUNTER (ParameterStateRule_i)
	friend class ParameterStateRule_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ParameterStateRule_i (XercesHelpers::DOMNodeEx& rule_node);

	virtual ~ParameterStateRule_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_parameter_name;

	IniConverter::ParameterState m_state;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Rule
	// Применить правило на заданных ини-файлах
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

//#UC START# *45C0873301D4*
//#UC END# *45C0873301D4*
}; // class ParameterStateRule_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETERSTATERULE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
