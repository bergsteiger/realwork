////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RenameRule_i
// Заголовок реализации класса серванта для интерфеса Rule
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RENAMERULE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RENAMERULE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RuleWithSectionName.h"

//#UC START# *45C0CD8803C8_CUSTOM_INCLUDES*
//#UC END# *45C0CD8803C8_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class RenameRule_i; // self forward Var
typedef ::Core::Var<RenameRule_i> RenameRule_i_var;
typedef ::Core::Var<const RenameRule_i> RenameRule_i_cvar;

class RenameRule_i_factory;

class RenameRule_i:
	virtual public IniConverter::Rule
	, virtual public ::Core::RefCountObjectBase
	, virtual public RuleWithSectionName
{
	SET_OBJECT_COUNTER (RenameRule_i)
	friend class RenameRule_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RenameRule_i (XercesHelpers::DOMNodeEx& rule_node);

	virtual ~RenameRule_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_new_name;

	std::string m_old_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Rule
	// Применить правило на заданных ини-файлах
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

//#UC START# *45C0CD8803C8*
//#UC END# *45C0CD8803C8*
}; // class RenameRule_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RENAMERULE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
