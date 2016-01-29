////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/GenSupport/GenSupport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::GenSupport
//
// вспомогательные интерфейсы для генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORT_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "shared/WinGUI/Controls/Controls.h"

namespace GenSupport {

class GenerationNotStarted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Генерация была прервана пользователем
class GenerationCanceled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class GenerationAlreadyStarted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ProgessIndicatorService;
typedef ::Core::Var<ProgessIndicatorService> ProgessIndicatorService_var;
typedef ::Core::Var<const ProgessIndicatorService> ProgessIndicatorService_cvar;
// интерфейс для визуализации процесса, позволяет различным частям системы отображать процесс
// завершения длительнного процесса
class ProgessIndicatorService
	: virtual public WinGUI::ProgressIndicatorDelegate
{
public:
	// начало генерации - показывает прогресс индикатор
	virtual void start () /*throw (GenerationAlreadyStarted)*/ = 0;

	// событие завершения генерации
	virtual void end () /*throw (GenerationNotStarted)*/ = 0;

	// выполняет шаг прогресса. Если не был вызыван start, то вызывает его
	virtual void step () = 0;

	// инициирует шаг, передает сообщение описывающее шаг. Если не был вызыван start, то вызывает его
	virtual void step (const std::string& message) = 0;

	// возвращает true, если прогресс запущен, но еще не закончен
	virtual bool is_started () const = 0;

	// обновляет информацию в прогресс индикаторе
	virtual void update_message (const std::string& mess) = 0;
};

/// factory interface for ProgessIndicatorService
class ProgessIndicatorServiceFactory {
public:
	// возвращает кэшированный экземпляр
	static ProgessIndicatorService& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PageProxy;
typedef ::Core::Var<PageProxy> PageProxy_var;
typedef ::Core::Var<const PageProxy> PageProxy_cvar;
// прокси для сгенеренной страницы
class PageProxy
	: virtual public ::Core::IObject
{
public:
	// генерируемая часть текста страницы (без UC). Изменения данного атрибта реально будут
	// произведены только при операции commit.  При чтении атрибута используются данные транзакции
	// если читаем из тойже сессии, или персистентные в противном случае. Попытка конкурентной записи
	// приводит к исключению
	virtual const std::string& get_generated_text () const = 0;

	virtual void set_generated_text (const std::string& generated_text)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// перечисление лэйблов через запятую
	virtual const std::string& get_labels () const = 0;

	virtual void set_labels (const std::string& labels)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// r/o экземпляр страницы до не прокоммиченых изменений
	virtual ServerGate::GenerationContents::Page* get_page_before_changes () const = 0;

	virtual const std::string& get_guid () const = 0;

	virtual const std::string& get_path () const = 0;

	virtual void set_path (const std::string& path) = 0;

	// собственно объект, над которым сделана обертка
	virtual ServerGate::GenerationContents::Page* get_delegate () const = 0;

	// добавляет диаграмму в аттач
	virtual void add_diagram (
		const char* name
		, const ServerGate::GenerationContents::Diagram& d
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
	)*/ = 0;

	// добавляет или заменяет свойства элемента генерации
	virtual void add_property_map (
		const ServerGate::GenerationContents::PropertyMapEntryList& map
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
		, ServerGate::GenerationContents::ContentUpdateError
		, ServerGate::GenerationContents::PathNotValid
	)*/ = 0;

	// помечает страницу на удаление. Реальное удаление произайдет при коммите
	virtual void mark_for_remove () /*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// возвращает контрольную сумму для всех свойств элемента генерации (нужно для того, чтобы понять,
	// что значения или набор свойств изменились с прошлой генерации)
	virtual long long get_all_property_cheksum () const = 0;

	// по имени диаграммы возвращает ее хэш
	virtual char* get_diagram_hash (
		const char* name
	) const /*throw (
		ServerGate::GenerationContents::ReadOnlyContent
	)*/ = 0;

	// возвращает тру если страница была изменена
	virtual bool is_modified () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// возвращает тру если страница новая
	virtual bool is_new_page () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	virtual void rollback_all_changes () /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// сбрасывает все кэши прокси
	virtual void reset () = 0;
};

/// factory interface for PageProxy
class PageProxyFactory {
public:
	// возвращает экземпляр страницы
	static PageProxy& get (ServerGate::GenerationContents::ModelElementId_const page_guid)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class LogManager;
typedef ::Core::Var<LogManager> LogManager_var;
typedef ::Core::Var<const LogManager> LogManager_cvar;
// менеджер подсистемы логгирования
class LogManager
	: virtual public ::Core::IObject
{
public:
	// логгирование ошибки
	virtual void log_error (const std::string& message) const = 0;

	// логгирование предупреждения
	virtual void log_warning (const std::string& message) const = 0;

	// логгирование информационного сообщения
	virtual void log_info (const std::string& message) const = 0;

	// инициализация менеджера, может вызываться несколько раз
	virtual void init () const = 0;
};

/// factory interface for LogManager
class LogManagerFactory {
public:
	// возвращает экземпляр менеджера
	static LogManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// информация об ошибке
struct ErrorInfo {
	// текст ошибки
	std::string message;
	// алтернативное имя (если не указан дампер)
	std::string alternative_name;
	// дампер, в контексте которого случилась ошибка (может быть 0)
	const Base::Dumper* dumper;
};

#pragma pack (pop)

// список ошибок
typedef std::vector < ErrorInfo > ErrorInfoList;

class ErrorManager;
typedef ::Core::Var<ErrorManager> ErrorManager_var;
typedef ::Core::Var<const ErrorManager> ErrorManager_cvar;
// Интерфейс обеспечивает управление ошибками возникающими в процессе генерации, построения модели
// и т.д. При включенном режиме игнорирования ошибок, не должно выбрасываться никаких исключений.
// Все ошибки должны быть сохранены, чтобы клиент инетрфейса мог их впоследствии получить. Если
// режим игнорирования ошибок не включен, то при возникновении фатальной ошибки выбрасывается
// исключение FatalError
class ErrorManager
	: virtual public ::Core::IObject
{
public:
	// возвращает список ошибок
	virtual const ErrorInfoList& get_errors () const = 0;

	// добавляет информацию о случившейся ошибке
	virtual void error (const Base::Dumper* dumper, const std::string& message, const std::string& alter_name) = 0;

	// информация о фатальной ошибке, если не отключена реакция на ошибки - выбрасывается исключение
	virtual void fatal_error (
		const Base::Dumper* dumper
		, const std::string& message
		, const std::string& alter_name
	) /*throw (
		Base::FatalError
	)*/ = 0;

	// очищает список ошибок
	virtual void clear_errors () = 0;

	// фатальная ошибка при работе с элементом с идентификатором = uid
	virtual void fatal_error (const std::string& uid, const std::string& message, const std::string& alter_name) = 0;

	// очищает список ошибок, которые случились в контексте какого-то элемента
	virtual void clear_only_dumper_errors () = 0;
};

/// factory interface for ErrorManager
class ErrorManagerFactory {
public:
	// фабрика
	static ErrorManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// варианты старатегии залочки элементов при генерации
enum LockStrategy {
	LS_LOCK_ALL // Лочить всё, если можно - при выставленной опции, будем пытаться записать в модель всю нужную информацию (служебную, неслужебную).
	, LS_ASK // Справшивать, если кат не залочен - при необходимости записать что-то в модель и, если кат не залочен пользователем, показывается дилог с вопросом "Залочить пакет или нет"
	, LS_NO_LOCK // Ничего не лочить
};

#pragma pack (push, 1)

// настройки генерации, используемые в случае невозможности записать обязательный параметр
struct LockFailedOptions {
	// нужно ли задавть вопрос о продолжении работы
	bool need_ask;
	// нужно ли выбрасывать исключение
	bool need_fatal_error;
	LockFailedOptions () : need_ask(true), need_fatal_error(true) {
		//#UC START# *48F337A901FD_DEF_INIT_CTOR*
			//#UC END# *48F337A901FD_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

class Environment;
typedef ::Core::Var<Environment> Environment_var;
typedef ::Core::Var<const Environment> Environment_cvar;
// Параметры генерации - интерфейс используются для настройки параметров генерации (стратегии
// залочки, а также для отмены генерации)
class Environment
	: virtual public ::Core::IObject
{
public:
	// флаг, определяющий нужно ли подавлять использование юзер кода, записанного в модели - если флаг
	// - false - код из модели используется.
	virtual bool get_suppress_user_code () const = 0;

	virtual void set_suppress_user_code (bool suppress_user_code) = 0;

	// нужно ли перезаписать юзер код тем, что генериться с шаблона
	virtual bool get_rewrite_user_code () const = 0;

	virtual void set_rewrite_user_code (bool rewrite_user_code) = 0;

	// флаг отмены автоинкремента
	virtual bool get_disable_auto_count () const = 0;

	virtual void set_disable_auto_count (bool disable_auto_count) = 0;

	// флаг отмены пост-процессинга (команд, выполняемых после применения результатов генерации)
	virtual bool get_disable_post_processing () const = 0;

	virtual void set_disable_post_processing (bool disable_post_processing) = 0;

	// флаг отмены генерации
	virtual bool get_cancel_generation () const = 0;

	virtual void set_cancel_generation (bool cancel_generation) = 0;

	// нужно ли логгировать явные вызовы spell-генератора
	virtual bool get_enable_spell_explicit_call_logging () const = 0;

	virtual void set_enable_spell_explicit_call_logging (bool enable_spell_explicit_call_logging) = 0;

	// нужно ли ругаться при попытке вызывать функцию стереотипа на несуществующем элементе
	virtual bool get_scold_if_call_tpl_function_on_null () const = 0;

	virtual void set_scold_if_call_tpl_function_on_null (bool scold_if_call_tpl_function_on_null) = 0;

	// нужно ли подавлять ошибки, возникающие в процессе генерации
	virtual bool get_suppress_generation_errors () const = 0;

	virtual void set_suppress_generation_errors (bool suppress_generation_errors) = 0;

	// выбранная стратегия залочки (по-умолчанию LS_NO_LOCK)
	virtual LockStrategy get_lock_strategy () const = 0;

	virtual void set_lock_strategy (LockStrategy lock_strategy) = 0;

	// настройки генерации при невозможности записать обязательные параметры
	virtual const LockFailedOptions& get_lock_failed_options () const = 0;

	virtual void set_lock_failed_options (const LockFailedOptions& lock_failed_options) = 0;

	virtual void set_lock_failed_need_ask (bool value) = 0;

	virtual void set_lock_failed_need_fatal_error (bool value) = 0;
};

/// factory interface for Environment
class EnvironmentFactory {
public:
	// фабрика
	static Environment& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// вспомогательная структура, которая в конструкторе устанавливает флаг подавления ошибок в нужно
// значние, а в деструкторе сбрасывает его в false
struct AutoErrorSuppress {
	// предыдущее значение, которое должно быть восстановлено
	bool saved_value;

	~AutoErrorSuppress ();

	// need_error - если  false - ошибки будут подавляться
	AutoErrorSuppress (bool need_error);
};

#pragma pack (pop)

} // namespace GenSupport

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GenSupport::ProgessIndicatorService> {
	typedef GenSupport::ProgessIndicatorServiceFactory Factory;
};
template <>
struct TypeTraits <GenSupport::PageProxy> {
	typedef GenSupport::PageProxyFactory Factory;
};
template <>
struct TypeTraits <GenSupport::LogManager> {
	typedef GenSupport::LogManagerFactory Factory;
};
template <>
struct TypeTraits <GenSupport::ErrorManager> {
	typedef GenSupport::ErrorManagerFactory Factory;
};
template <>
struct TypeTraits <GenSupport::Environment> {
	typedef GenSupport::EnvironmentFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_GENSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
