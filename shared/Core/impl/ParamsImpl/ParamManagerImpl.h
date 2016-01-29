////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/ParamsImpl/ParamManagerImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::ParamsImpl::ParamManagerImpl
// Заголовок реализации класса серванта для интерфеса ParamManager
//
// реализация менеджера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_H__
#define __SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_H__

#include "ace/ACE.h"
#include <map>
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsCore/ParamsCore.h"

namespace Core {
namespace ParamsImpl {

class ParamManagerImpl; // self forward Var
typedef ::Core::Var<ParamManagerImpl> ParamManagerImpl_var;
typedef ::Core::Var<const ParamManagerImpl> ParamManagerImpl_cvar;

class ParamManagerImpl_factory;

// реализация менеджера
class ParamManagerImpl:
	virtual public ParamManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ParamManagerImpl)
	friend class ParamManagerImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// откуда прочитан параметр
	enum ReadFrom {
		COMMAND_LINE // из командной строки
		, REGISTRY // из реестра
		, CONFIG_FILE // из файла конфигурации
		, READ_ONLY_SECTION_IN_CONFIG_FILE // из RO секции файла настроек
		, TEMP // временная переменная
	};

	// информация о параметре
	struct KeyInfo {
		// значение параметра
		std::string data;
		// секция, в которой был найден параметр
		std::string section;
		// откуда парамтер прочитан
		ReadFrom from;

		// конструктор по-умолчанию
		KeyInfo ();

		// конструктор для инициализации полей
		KeyInfo (const std::string& value, ReadFrom fr, const std::string& sect);
	};

	// мапа хранящая инормацию о параметре
	typedef std::map < std::string, KeyInfo > ValuesMap;

	// блок констант для работы с ParamManager'ом
	static const char* RUN_PARAM; // имя ключа, используемого для указания того, что при завершении нужно выполнить какую-нить программу. P.S: совершенно не понятно почему этот параметр нужен ParamManager'у
	static const char* RUN_ARGS; // имя ключ для задания параметров запуска стороннего приложения, еоторое запускается при завершении работы. P.S: также совершненно не понятно какое это отношенеи имеет к ParamManager'у
	static const char* ADDITIONAL_CONFIG_SECTION_KEY; // ключ в настройках, значение по которому указывает на дополнительную секцию из которой нужно прочитать параметры.
	static const char* CONFIG_SECTION_KEY_TEMPLATE; // шаблон для формирования имени ключа, определяющего секцию в файле настроек.
	static const char* CONFIG_FILE_KEY; // ключ, по которому задается путь к файлу настроек
	static const char* REGISTRY_SECTION_KEY; // ключ по которому задаётся секция в реестре

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// если str - являеся переменной окружения, то она заменяется значением этой переменной окружения
	static void substitute_environment_variables (std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ParamManagerImpl ();

	ParamManagerImpl (const std::string& args);

	virtual ~ParamManagerImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// "заворчивает" строку в кавычки, если в ней есть пробелы
	virtual const std::string convert_string_to_in_quotes (const std::string& str) const;

	// возвращает значение по ключу в секции section конфигурационного файла
	virtual const std::string get_key_value (
		const std::string& file
		, const std::string& section
		, const std::string& key
	) const /*throw (
		DataNotCorrect
	)*/;

	// опряделяет задан ли параметр в правильном формате
	virtual bool is_recognized_param (std::string& key) const;

	// парсит командную строку, находит в ней пары ключ-значение и записывает в мапу
	virtual void parse_command_line (const ParamArgs& args);

	// парсит секцию section в конфигурационном файле, находит пары ключ-значение и записывает в мапу
	virtual void parse_config_file (const std::string& file, const std::string& section) /*throw (DataNotCorrect)*/;

	// парсит ветку реестра, по ключу subkey, находит пары ключ-значение и записывает в мапу
	virtual void parse_registry (const std::string& subkey) /*throw (DataNotCorrect)*/;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// хранилище параметров
	ValuesMap m_map;

	// список параметров для инициализации ORB'а
	ParamArgs m_orb_init_command_line;

	// список параметров для инициализации подсистемы Smart Backend
	ParamArgs m_sbe_init_command_line;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ParamManager
	// добавить hardcode параметр типа long, который будет записан, только если такого параметра нет
	virtual void add_hardcode_long (const char* key, long value);

	// implemented method from ParamManager
	// добавить hardcode параметр типа string, который будет записан, только если такого параметра нет
	virtual void add_hardcode_string (const char* key, const char* value);

	// implemented method from ParamManager
	// добавить hardcode параметр типа unsigned long, который будет записан, только если такого
	// параметра нет
	virtual void add_hardcode_ulong (const char* key, unsigned long value);

	// implemented method from ParamManager
	// Добавить временный параметр типа long - он не будет сохранён
	virtual void add_long (const char* key, long value);

	// implemented method from ParamManager
	// Добавить временный параметр типа string - он не будет сохранён
	virtual void add_string (const char* key, const char* value);

	// implemented method from ParamManager
	// Добавить временный параметр типа unsigned long - он не будет сохранён
	virtual void add_ulong (const char* key, unsigned long value);

	// implemented method from ParamManager
	// возвращает список параметров для инициализации ORB'а
	virtual ParamArgs* command_line_for_orb_init () /*throw (DataNotFound)*/;

	// implemented method from ParamManager
	// Возвращает список параметров для подсистемы SBE (Smart BackEnd)
	virtual ParamArgs* command_line_for_sbe_init ();

	// implemented method from ParamManager
	// получить значение параметра (key) в виде целого, default_value - значение по умолчанию
	// (возвращается в случае, если не найден параметр key)
	virtual long get_long (const char* key, long default_value = 0) const;

	// implemented method from ParamManager
	// получить значение параметра (key) в виде строки, default_value - значение по умолчанию
	// (возвращается в случае, если не найден параметр key)
	virtual const std::string get_string (const char* key, const char* default_value = "") const;

	// implemented method from ParamManager
	// получить значение параметра (key) в виде целого без знака, default_value - значение по
	// умолчанию (возвращается в случае, если не найден параметр key)
	virtual unsigned long get_ulong (const char* key, unsigned long default_value = 0) const;

	// implemented method from ParamManager
	// инициализация менеджера:
	// args - список параметров, переданных через командную строку
	// init_data -
	virtual int init (
		const ParamArgs& args
		, const ParamManagerInitData& init_data
	) /*throw (
		DataNotFound
		, DataNotCorrect
	)*/;

	// implemented method from ParamManager
	// возвращает true, если присутствует параметр key
	virtual bool is_exist (const char* key) const;

	// implemented method from ParamManager
	// добавляет параметр, он будет сохранён в реестре или в ini-файле
	virtual void set_long (const char* key, long value) /*throw (SaveDataFailed)*/;

	// implemented method from ParamManager
	// добавляет параметр, он будет сохранён в реестре или в ini-файле
	virtual void set_string (const char* key, const char* value) /*throw (SaveDataFailed)*/;

	// implemented method from ParamManager
	// добавляет параметр, он будет сохранён в реестре или в ini-файле
	virtual void set_ulong (const char* key, unsigned long value) /*throw (SaveDataFailed)*/;
}; // class ParamManagerImpl

} // namespace ParamsImpl
} // namespace Core


#endif //__SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
