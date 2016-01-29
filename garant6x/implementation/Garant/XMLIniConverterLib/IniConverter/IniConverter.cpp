////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::XMLIniConverterLib::IniConverter
//
// интерфейсы для конвертации ini-файлов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"

namespace XMLIniConverterLib {
namespace IniConverter {

// factory interface wrapper for Parameter
Parameter* ParameterFactory::make (
	const char* name
	, const char* value
	, ParameterState state
	, const char* delimiter
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ParameterFactoryManager::Singleton::instance ()->make (name, value, state, delimiter);
}

// factory interface wrapper for Section
Section* SectionFactory::make (
	const char* name
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SectionFactoryManager::Singleton::instance ()->make (name);
}

Section* SectionFactory::make (
	const char* name
	, ParameterState state
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SectionFactoryManager::Singleton::instance ()->make (name, state);
}

// factory interface wrapper for IniFile
IniFile* IniFileFactory::make (
	const char* filename
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IniFileFactoryManager::Singleton::instance ()->make (filename);
}


const char* BadXMLFormat::uid () const /*throw ()*/ {
	return "60C04682-B9FE-4C90-A2D3-1A396D19E39F";
}

const char* BadXMLFormat::what () const throw () {
	//#UC START# *4582712F0251_WHAT_IMPL*
	return "BadXMLFormat (Плохой формат XML)";
	//#UC END# *4582712F0251_WHAT_IMPL*
}


const char* CantFindVariable::uid () const /*throw ()*/ {
	return "F66181B3-CF30-4326-B753-D87FDD0B36E8";
}

const char* CantFindVariable::what () const throw () {
	//#UC START# *45C752190399_WHAT_IMPL*
	return "CantFindVariable (не задано значение переменной)";
	//#UC END# *45C752190399_WHAT_IMPL*
}

// factory interface wrapper for Rule
Rule* RuleFactory::make (
	XercesHelpers::DOMNodeEx& rule_node
	, const char* key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return RuleFactoryManager::Singleton::instance ()->make (rule_node, key);
}


RuleFactory::KeySet* RuleFactory::keys () {
	return RuleFactoryManager::keys ();
}

// factory interface wrapper for RulesManager
RulesManager* RulesManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return RulesManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for XMLRuleParser
XMLRuleParser* XMLRuleParserFactory::make (
	RulesManager* manager
	, XercesHelpers::DOMNodeEx& rule_node
	, const char* key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return XMLRuleParserFactoryManager::Singleton::instance ()->make (manager, rule_node, key);
}


XMLRuleParserFactory::KeySet* XMLRuleParserFactory::keys () {
	return XMLRuleParserFactoryManager::keys ();
}


const char* FileReadingError::uid () const /*throw ()*/ {
	return "45E20299-6CED-4105-82A1-0E55A39A4DDB";
}

const char* FileReadingError::what () const throw () {
	//#UC START# *45CC6CB4009C_WHAT_IMPL*
	return "FileReadingError (Ошибка при чтении файла)";
	//#UC END# *45CC6CB4009C_WHAT_IMPL*
}

} // namespace IniConverter
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

