////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/SectionStateRule_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::SectionStateRule_i
// Заголовок реализации класса серванта для интерфеса Rule
//
// правило для указания состояния секции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_SECTIONSTATERULE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_SECTIONSTATERULE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

//#UC START# *45BF2C0C038A_CUSTOM_INCLUDES*
//#UC END# *45BF2C0C038A_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class SectionStateRule_i; // self forward Var
typedef ::Core::Var<SectionStateRule_i> SectionStateRule_i_var;
typedef ::Core::Var<const SectionStateRule_i> SectionStateRule_i_cvar;

class SectionStateRule_i_factory;

// правило для указания состояния секции
class SectionStateRule_i:
	virtual public IniConverter::Rule
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SectionStateRule_i)
	friend class SectionStateRule_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SectionStateRule_i (XercesHelpers::DOMNodeEx& rule_node);

	virtual ~SectionStateRule_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_section_name;

	IniConverter::ParameterState m_state;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Rule
	// Применить правило на заданных ини-файлах
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

//#UC START# *45BF2C0C038A*
//#UC END# *45BF2C0C038A*
}; // class SectionStateRule_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_SECTIONSTATERULE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
