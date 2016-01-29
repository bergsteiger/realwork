////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::XMLIniConverterLib::IniConverter
//
// интерфейсы для конвертации ini-файлов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"
#include <ostream>

namespace XMLIniConverterLib {
namespace IniConverter {

// возможные состояния параметра
enum ParameterState {
	PS_EXIST // параметр есть в файле
	, PS_REMOVED // параметр удалён из настроек
	, PS_COMMENTED // параметр закомментирован
	, PS_OLD // состояние такое же, как в старом инишнике
	, PS_NEW // состояние такое же, как в новом инишнике
};

// список строк
typedef std::vector < std::string > ValuesList;

class Parameter;
typedef ::Core::Var<Parameter> Parameter_var;
typedef ::Core::Var<const Parameter> Parameter_cvar;
// интерфейс для работы с параметром ини-файла
class Parameter
	: virtual public ::Core::IObject
{
public:
	// значение параметра
	virtual const std::string& get_value () const = 0;

	virtual void set_value (const std::string& value) = 0;

	// имя параметра
	virtual const std::string& get_name () const = 0;

	// разделитель, по умолчанию знак равно
	virtual const char* get_delimiter () const = 0;

	// состояние парметра
	virtual ParameterState get_state () const = 0;

	virtual void set_state (ParameterState state) = 0;

	// закомментированные значения параметра
	virtual const ValuesList& get_commented_values () const = 0;

	// вывод информации в отладочных целях
	virtual void print (std::ostream& stream) const = 0;

	// добавить закомментированное значение
	virtual void add_commented_value (const std::string& value) = 0;
};

/// factory interface for Parameter
class ParameterFactory {
public:
	// фабрика
	static Parameter* make (const char* name, const char* value, ParameterState state, const char* delimiter)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Section;
typedef ::Core::Var<Section> Section_var;
typedef ::Core::Var<const Section> Section_cvar;
// интерфейс работы с секцией ини-файла
class Section
	: virtual public ::Core::IObject
{
public:
	// имя секции
	virtual const std::string& get_name () const = 0;

	// состояние секции
	virtual ParameterState get_state () const = 0;

	// добавить параметр в секцию
	virtual void add_parameter (Parameter* parameter) = 0;

	// удалить параметр из секции
	virtual void delete_parameter (const char* name) = 0;

	// получить параметр в заданной секции
	virtual Parameter* get_cached_parameter (const char* name) = 0;

	// объеденить содержимое 2-ух секций (та, на которой зовётся операция имеет приоритет, её
	// содержимое добавляется в аргумент)
	virtual void merge (Section* section) = 0;

	// вывод информации в отладочных целях
	virtual void print (std::ostream& stream) const = 0;
};

/// factory interface for Section
class SectionFactory {
public:
	// фабрика
	static Section* make (const char* name)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// фабрика для xml-ной секции
	static Section* make (const char* name, ParameterState state)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class IniFile;
typedef ::Core::Var<IniFile> IniFile_var;
typedef ::Core::Var<const IniFile> IniFile_cvar;
// Интерфейс для работы с ини-файлом
class IniFile
	: virtual public ::Core::IObject
{
public:
	// добавить секцию в инишник
	virtual void add_section (Section* section) = 0;

	// получить секцию по имени
	virtual Section* get_cached_section (const char* name) = 0;

	// получить параметр по секции и имени
	virtual Parameter* get_cached_parameter (const char* section_name, const char* parameter_name) = 0;

	// удалить секцию из инишника
	virtual void delete_section (const char* name) = 0;

	// объеденить содержимое 2-ух инишников (тот, на котором зовётся операция имеет приоритет, его
	// содержимое добавляется в аргумент)
	virtual void merge (IniFile* inifile) = 0;

	// устанавливает комментарий к файлу (только в том случае, если он ещё не установлен)
	virtual void set_comment (const std::string& comment) = 0;

	// вывод инифайла в поток
	virtual void print (std::ostream& stream) const = 0;
};

/// factory interface for IniFile
class IniFileFactory {
public:
	// фабрика
	static IniFile* make (const char* filename)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Плохой формат XML
class BadXMLFormat : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// не задано значение переменной
class CantFindVariable : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Rule;
typedef ::Core::Var<Rule> Rule_var;
typedef ::Core::Var<const Rule> Rule_cvar;
// Правило, вычитанное из xml
class Rule
	: virtual public ::Core::IObject
{
public:
	// Применить правило на заданных ини-файлах
	virtual void apply (IniFile* old_file, IniFile* new_file) const = 0;
};

/// factory interface for Rule
class RuleFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	// создать правило
	static Rule* make (XercesHelpers::DOMNodeEx& rule_node, const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class RulesManager;
typedef ::Core::Var<RulesManager> RulesManager_var;
typedef ::Core::Var<const RulesManager> RulesManager_cvar;
// менеджер правил. Вычитывает их из файла и применяет в определённом порядке.
class RulesManager
	: virtual public ::Core::IObject
{
public:
	// инициализация менеджера xml-ными правилами
	virtual void init (const char* filename) /*throw (BadXMLFormat)*/ = 0;

	// Применить список правил для получения конечного инишника.
	virtual void apply (IniFile* old_file, IniFile* new_file) const = 0;

	// добавить новое правило
	virtual void add_rule (const Rule* rule) = 0;

	// установить значение переменной
	virtual void set_variable (const std::string& name, const std::string& value) = 0;

	// получить значение переменной
	virtual const std::string& get_variable_value (const std::string& name) const /*throw (CantFindVariable)*/ = 0;
};

/// factory interface for RulesManager
class RulesManagerFactory {
public:
	// создать менеджер правил
	static RulesManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Константы с именами переменных
static const std::string UPDATE_PATH = "update_path"; // путь к дельте. Используется  в старом иниконвертере, перенесён в новый для совместимости
static const char COMMENT_CHAR = ';'; // символ комментария
static const char* COMMENT_STRING = ";"; // строка с символом комментария

class XMLRuleParser;
typedef ::Core::Var<XMLRuleParser> XMLRuleParser_var;
typedef ::Core::Var<const XMLRuleParser> XMLRuleParser_cvar;
// разборщик правил из xml
class XMLRuleParser
	: virtual public ::Core::IObject
{
};

/// factory interface for XMLRuleParser
class XMLRuleParserFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	// создать правила посекции из xml
	static XMLRuleParser* make (RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node, const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Ошибка при чтении файла
class FileReadingError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace IniConverter
} // namespace XMLIniConverterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::Parameter> {
	typedef XMLIniConverterLib::IniConverter::ParameterFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::Section> {
	typedef XMLIniConverterLib::IniConverter::SectionFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::IniFile> {
	typedef XMLIniConverterLib::IniConverter::IniFileFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::Rule> {
	typedef XMLIniConverterLib::IniConverter::RuleFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::RulesManager> {
	typedef XMLIniConverterLib::IniConverter::RulesManagerFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::XMLRuleParser> {
	typedef XMLIniConverterLib::IniConverter::XMLRuleParserFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
