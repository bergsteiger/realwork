////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RulesManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::RulesManager_i
// Заголовок реализации класса серванта для интерфеса RulesManager
//
// Реализация менеджера правил.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RULESMANAGER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RULESMANAGER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"

//#UC START# *45BF2C440138_CUSTOM_INCLUDES*
//#UC END# *45BF2C440138_CUSTOM_INCLUDES*

namespace XMLIniConverterLib {
namespace IniConverter_i {

class RulesManager_i; // self forward Var
typedef ::Core::Var<RulesManager_i> RulesManager_i_var;
typedef ::Core::Var<const RulesManager_i> RulesManager_i_cvar;

class RulesManager_i_factory;

// Реализация менеджера правил.
class RulesManager_i:
	virtual public IniConverter::RulesManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (RulesManager_i)
	friend class RulesManager_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <RulesManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RulesManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RulesManager_i ();

	virtual ~RulesManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void add_rule_section (XercesHelpers::DOMNodeEx& rule_section);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	RuleList m_rule_list;

	VariableTable m_variable_table;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::RulesManager
	// добавить новое правило
	virtual void add_rule (const IniConverter::Rule* rule);

	// implemented method from IniConverter::RulesManager
	// Применить список правил для получения конечного инишника.
	virtual void apply (IniConverter::IniFile* old_file, IniConverter::IniFile* new_file) const;

	// implemented method from IniConverter::RulesManager
	// получить значение переменной
	virtual const std::string& get_variable_value (
		const std::string& name
	) const /*throw (
		IniConverter::CantFindVariable
	)*/;

	// implemented method from IniConverter::RulesManager
	// инициализация менеджера xml-ными правилами
	virtual void init (const char* filename) /*throw (IniConverter::BadXMLFormat)*/;

	// implemented method from IniConverter::RulesManager
	// установить значение переменной
	virtual void set_variable (const std::string& name, const std::string& value);

//#UC START# *45BF2C440138*
//#UC END# *45BF2C440138*
}; // class RulesManager_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_RULESMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
