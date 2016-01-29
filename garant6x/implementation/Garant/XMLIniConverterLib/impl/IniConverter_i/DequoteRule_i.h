////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteRule_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::DequoteRule_i
// Заголовок реализации класса серванта для интерфеса Rule
//
// снять кавычки со значения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTERULE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTERULE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C1EA8D0109_CUSTOM_INCLUDES*
//#UC END# *45C1EA8D0109_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class DequoteRule_i; // self forward Var
typedef ::Core::Var<DequoteRule_i> DequoteRule_i_var;
typedef ::Core::Var<const DequoteRule_i> DequoteRule_i_cvar;

class DequoteRule_i_factory;

// снять кавычки со значения
class DequoteRule_i:
	virtual public IniConverter::Rule
	, virtual public ::Core::RefCountObjectBase
	, virtual public RuleWithSectionName
{
	SET_OBJECT_COUNTER (DequoteRule_i)
	friend class DequoteRule_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DequoteRule_i (XercesHelpers::DOMNodeEx& rule_node);

	virtual ~DequoteRule_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Rule
	// Применить правило на заданных ини-файлах
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

//#UC START# *45C1EA8D0109*
//#UC END# *45C1EA8D0109*
}; // class DequoteRule_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_DEQUOTERULE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
