////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Root/Root.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Root
//
// Пакет интерфейсов фремворка GCM2 (не сетевая часть)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_H__
#define __SHARED_CORE_ROOT_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/mt/mt.h"

namespace Core {
namespace Root {

// Идентификаторы текущего статуса выполонения
enum ExecutorStatus {
	ES_ERROR // Ошибка при выполнении Исполнителя
	, ES_EXIT_REQUESTED // Испольнитель уведомляет менеджера о необходимости завершить процесс
	, ES_FINISHED // Выполнение исполнителя успешно завершено
	, ES_EXECUTABLE // Исполнитель готов к запуску или уже запущен и находится в работе
	, ES_IDLE // Исполнитель завершил работу и находится в состоянии ожидания.
};

// неверные параметры инициализации приложения (недостаточно данных или не корректные значения)
class InvalidParams : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class LibHome;
typedef ::Core::Var<LibHome> LibHome_var;
typedef ::Core::Var<const LibHome> LibHome_cvar;
// Дом билиотеки - основной объект инициализации и управления. Создается для любой библиотеки,
// выполняет ее инициализацию и деинициализацию. Управляется из единого Менеджера. Все управление
// происходит строго синхронно, на основе зависимостей между библиотеками.
class LibHome
	: virtual public ::Core::IObject
{
public:
	// Текущий агригированный статус всех исполнителей библиотеки
	virtual ExecutorStatus get_executors_status () const = 0;

	// Запрашивает приложение о выходе
	virtual void exit_request () = 0;
};

// Внутрення ошибка инициализации менеджера библиотек (например отсутствие доступа к внешним
// ресурсам)
class HomeManagerInitError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ThreadInitializer;
typedef ::Core::Var<ThreadInitializer> ThreadInitializer_var;
typedef ::Core::Var<const ThreadInitializer> ThreadInitializer_cvar;
// Callback интерфейс для пользовательской инициализации\финализации запускаемых в системе потоков
class ThreadInitializer
	: virtual public ::Core::IObject
{
public:
	// вызывается при завершении потока
	virtual void thread_finalize () = 0;

	// Вызывается при создании потока
	virtual void thread_init () = 0;
};

class Executor;
typedef ::Core::Var<Executor> Executor_var;
typedef ::Core::Var<const Executor> Executor_cvar;
// Объектт-поток. Исполнимый кдасс объектов, которые будут автоматически и асинхронно запузщенны на
// выполнение после успешной инициализации приложения.
class Executor
	: virtual public ::Core::IObject
{
public:
	// текущий статус исполнителя
	virtual ExecutorStatus get_current_status () const = 0;

	// поток выполнения бизнес логики исполнителя, вызывается фреймворком
	/*oneway*/ Core::ThreadHandle execute ();

// oneway methods impl
private:
	static void thr_execute_ (void* arg);

protected:
	virtual void execute_ () = 0;
};

#pragma pack (push, 1)

// данные с информацией о текущей конфигурации
struct Info {
	// тип сборки debug\release
	bool debug;
	// есть ли использование CORBA (линковка c TAO)
	bool use_corba;
	// является ли исполнимый модуль основным сервером (со встроенными COS)
	bool server_side;
};

#pragma pack (pop)

class Configuration;
typedef ::Core::Var<Configuration> Configuration_var;
typedef ::Core::Var<const Configuration> Configuration_cvar;
// Интерфейс для доступа к текущей конфигурации исполнимого модуля. Данные основываются на
// статических переменных сборки и на параметрах инициализации приложения
class Configuration
	: virtual public ::Core::IObject
{
public:
	// данные конфигруации
	virtual const Info& get_info () const = 0;
};

/// factory interface for Configuration
class ConfigurationFactory {
public:
	// возвращает синглетон интерфейса
	static const Configuration& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Тип определяющий приоритет при регистрации фабрик сервантов, реализующих один интерфейс.
typedef unsigned short FactoryPriority;

// Method is generated but not implemented
class MDAGenNotImplemented : public ::Core::Exception {
public:
	MDAGenNotImplemented (const std::string& method);

	virtual ~MDAGenNotImplemented () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// собственно имя метода
	std::string m_method;
};

// Группа исключений связанных с работой фремворка фабрик
class FactoryEx : public ::Core::Exception {
};

// Class attributes accessed by cached functiuon was not initialized
class CachedAttrUninitialized : public ::Core::Exception {
public:
	CachedAttrUninitialized (const std::string& attr_name);

	virtual ~CachedAttrUninitialized () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// имя атрибута
	std::string m_attr_name;
};

// No one servant was registers in factory
class NoActiveFactory : public FactoryEx {
public:
	NoActiveFactory (const std::string& factory_name);

	virtual ~NoActiveFactory () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// имя фабрики
	std::string m_factory_name;
};

// Just one servant can registers in one factory
class DuplicatedFactoryKey : public FactoryEx {
public:
	DuplicatedFactoryKey (const std::string& factory_name, const std::string& key_name);

	virtual ~DuplicatedFactoryKey () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// имя фабрики
	std::string m_factory_name;
	// ключ фабрики
	std::string m_key_name;
};

// No one servant was registers in factory
class UnknownFactoryKey : public FactoryEx {
public:
	UnknownFactoryKey (const std::string& factory_name, const std::string& key_name);

	virtual ~UnknownFactoryKey () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// имя фабрики
	std::string m_factory_name;
	// ключ фабрики
	std::string m_key_name;
};

class LibHomeManager;
typedef ::Core::Var<LibHomeManager> LibHomeManager_var;
typedef ::Core::Var<const LibHomeManager> LibHomeManager_cvar;
// Менеджер библитечных Домов.
class LibHomeManager
	: virtual public ::Core::IObject
{
public:
	// запуск фремворка на исполнение. Инициализирует все билиотеки и запускает их исполнителей.
	virtual void execute () /*throw (InvalidParams, HomeManagerInitError)*/ = 0;

	// ждет завершения всех исполнителей (и их дочерних потоков), возвращает 0, если работа была
	// завершена без ошибок (ни один из исполнителей не выставил статус ES_ERROR)
	virtual int wait_all () const = 0;

	// регистрирует билиотеку в менеджере
	virtual void registrate_lib_home (LibHome* lib) = 0;

	// останавливает работу фреймворка и освобождает все занятые ресурсы (особождение ресоров
	// зарегистрированных библиотек осуществляется в порядке, обратном их регистрации!)
	virtual void finalize () = 0;

	// регистрирует пользовательский инициализатор потока
	virtual void registrate_thread_initializer (ThreadInitializer* ti) = 0;

	// Выполняет инициализацию текущего потока посредствам запуска зарегистрированных инициализаторов
	virtual void init_thread () const = 0;

	// Выполняет де-инициализацию текущего потока посредствам запуска зарегистрированных
	// инициализаторов
	virtual void finalize_thread () const = 0;

	// выводит описание параметров для всех зарегистрированных домов библиотек
	virtual void print_usage () const = 0;

	// для каждого зарегистрированного дома библиотеки выполняет проверку параметров, возвращает true,
	// если все проверки прошли успешно.
	virtual bool check_params () const = 0;
};

/// factory interface for LibHomeManager
class LibHomeManagerFactory {
public:
	// Возвращает системного менеджера библиотек
	static LibHomeManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Несоответствие версии клиента и ДЛЛ
class WrongVersion : public ::Core::Exception {
public:
	WrongVersion (unsigned long client_version, unsigned long dll_version);

	virtual ~WrongVersion () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// версия клиента
	unsigned long m_client_version;
	// версия Длл
	unsigned long m_dll_version;
};

// Cоздание объекта по комбинации значений параметров-ключей фабрики невозможно.
class ImpossibleConversion : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Нельзя повторно использовать уже "уничтоженный" менеджер фабрик. Возникает при поытке обратится
// к менеджеру фабрик, который уже был уничтожен.
class FactoryManagerWasDestroyed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возникает при попытке вызвать неконстантный метод на констонтом объекте
class ConstViolation : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace Root
} // namespace Core

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Core::Root::Configuration> {
	typedef Core::Root::ConfigurationFactory Factory;
};
template <>
struct TypeTraits <Core::Root::LibHomeManager> {
	typedef Core::Root::LibHomeManagerFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORE_ROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
