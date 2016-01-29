////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Params/Params.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Params
//
// пакет для работы с параметрами приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMS_H__
#define __SHARED_CORE_PARAMS_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/ParamsCore/ParamsCore.h"

namespace Core {

#pragma pack (push, 1)

// Структура для инициализации менеджера
struct ParamManagerInitData {
	// Имя приложения
	const char* application_name;
	// ключ реестра, который соответсвует данному приложению
	const char* registry_subkey;
};

#pragma pack (pop)

class ParamManager;
typedef ::Core::Var<ParamManager> ParamManager_var;
typedef ::Core::Var<const ParamManager> ParamManager_cvar;
// менеджер для работы с параметрами приложения, переданными через командную строку, ini-файл или
// реестр
class ParamManager
	: virtual public ::Core::IObject
{
public:
	// инициализация менеджера:
	// args - список параметров, переданных через командную строку
	// init_data -
	virtual int init (
		const ParamArgs& args
		, const ParamManagerInitData& init_data
	) /*throw (
		DataNotFound
		, DataNotCorrect
	)*/ = 0;

	// получить значение параметра (key) в виде строки, default_value - значение по умолчанию
	// (возвращается в случае, если не найден параметр key)
	virtual const std::string get_string (const char* key, const char* default_value = "") const = 0;

	// добавляет параметр, он будет сохранён в реестре или в ini-файле
	virtual void set_string (const char* key, const char* value) /*throw (SaveDataFailed)*/ = 0;

	// получить значение параметра (key) в виде целого, default_value - значение по умолчанию
	// (возвращается в случае, если не найден параметр key)
	virtual long get_long (const char* key, long default_value = 0) const = 0;

	// добавляет параметр, он будет сохранён в реестре или в ini-файле
	virtual void set_long (const char* key, long value) /*throw (SaveDataFailed)*/ = 0;

	// получить значение параметра (key) в виде целого без знака, default_value - значение по
	// умолчанию (возвращается в случае, если не найден параметр key)
	virtual unsigned long get_ulong (const char* key, unsigned long default_value = 0) const = 0;

	// добавляет параметр, он будет сохранён в реестре или в ini-файле
	virtual void set_ulong (const char* key, unsigned long value) /*throw (SaveDataFailed)*/ = 0;

	// возвращает true, если присутствует параметр key
	virtual bool is_exist (const char* key) const = 0;

	// Добавить временный параметр типа string - он не будет сохранён
	virtual void add_string (const char* key, const char* value) = 0;

	// Добавить временный параметр типа long - он не будет сохранён
	virtual void add_long (const char* key, long value) = 0;

	// Добавить временный параметр типа unsigned long - он не будет сохранён
	virtual void add_ulong (const char* key, unsigned long value) = 0;

	// добавить hardcode параметр типа string, который будет записан, только если такого параметра нет
	virtual void add_hardcode_string (const char* key, const char* value) = 0;

	// добавить hardcode параметр типа long, который будет записан, только если такого параметра нет
	virtual void add_hardcode_long (const char* key, long value) = 0;

	// добавить hardcode параметр типа unsigned long, который будет записан, только если такого
	// параметра нет
	virtual void add_hardcode_ulong (const char* key, unsigned long value) = 0;

	// возвращает список параметров для инициализации ORB'а
	virtual ParamArgs* command_line_for_orb_init () /*throw (DataNotFound)*/ = 0;

	// Возвращает список параметров для подсистемы SBE (Smart BackEnd)
	virtual ParamArgs* command_line_for_sbe_init () = 0;
};

/// factory interface for ParamManager
class ParamManagerFactory {
public:
	// получить менеджер
	static ParamManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// args - список параметров, разделённых пробелом
	// Фабрика возвращает экземпляр ParamManager'а, при этом разбирается список параметров (args), как
	// параметры командной строки.
	static ParamManager* make (const std::string& args)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Core

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Core::ParamManager> {
	typedef Core::ParamManagerFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORE_PARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
