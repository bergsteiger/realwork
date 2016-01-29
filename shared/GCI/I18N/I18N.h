////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/I18N/I18N.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::I18N
//
// Интернационализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_H__
#define __SHARED_GCI_I18N_H__

#include "shared/Core/sys/std_inc.h"
#include <list>
//#UC START# *452CBF700271_CUSTOM_INCLUDE*
#define TR(str) (GCI::I18N::MessagesFactory::messages ().getw (str))
#define NOT_UNICODE_TR(str) (GCI::I18N::MessagesFactory::messages ().get (str))
//#UC END# *452CBF700271_CUSTOM_INCLUDE*

namespace GCI {
namespace I18N {

// Поддерживаемые виды кодировок
enum SupportedLocales {
	SL_UNKNOWN // локаль неизвестна
	, SL_RU_CP1251 // русская локаль для виндовой кодировки
	, SL_ENGLISH // английская локаль
	, SL_TATAR // татарская кодировка
};

// Не смогли прочитать файл со строками.
class BadFileFormat : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Не смогли прочитать файл, содержащий строки
class CantFindFile : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// список строковых параметров для шаблона интернационализации
typedef std::list < std::string > TemplateParamsList;

class LocaleOperations;
typedef ::Core::Var<LocaleOperations> LocaleOperations_var;
typedef ::Core::Var<const LocaleOperations> LocaleOperations_cvar;
// функции-помощники при работе с локализацией
class LocaleOperations
	: virtual public ::Core::IObject
{
public:
	// устанавливает текущую локаль.
	virtual void set_locale (SupportedLocales locale) = 0;

	// возвращает текущую локаль
	virtual SupportedLocales get_locale () const = 0;

	// возвращает значение локали по её текстовому представлению
	virtual SupportedLocales string_to_locale (const char* locale_text) const = 0;
};

/// factory interface for LocaleOperations
class LocaleOperationsFactory {
public:
	// возвращает глобальный экземпляр объекта
	static LocaleOperations& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Messages;
typedef ::Core::Var<Messages> Messages_var;
typedef ::Core::Var<const Messages> Messages_cvar;
// Работа со строками
class Messages
	: virtual public ::Core::IObject
{
public:
	// вычитать строки из файла
	virtual void open (const char* file, SupportedLocales locale) /*throw (BadFileFormat, CantFindFile)*/ = 0;

	// очистить все строки для заданного языка
	virtual void close (SupportedLocales locale) = 0;

	// получить локализованную строку в utf16
	virtual const std::wstring getw (const char* key, SupportedLocales locale) const = 0;

	// получить локализованную строку для текущей системной локали (используется значение LC_ALL!!!)
	virtual const std::wstring getw (const char* key) const = 0;

	// получить локализованную строку не в unicode
	virtual const std::string get (const char* key, SupportedLocales locale) const = 0;

	// получить локализованную строку  не в unicode для текущей системной локали (используется
	// значение LC_ALL!!!)
	virtual const std::string get (const char* key) const = 0;

	// получить локализованную шаблонную строку с подставленными параметрами не в unicode для текущей
	// системной локали (используется значение LC_ALL!!!)
	virtual const std::string get (const char* key, const TemplateParamsList& template_params) const = 0;
};

/// factory interface for Messages
class MessagesFactory {
public:
	// фабрика для получения объекта, реализующего интерфейс Messages
	static Messages& messages ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace I18N
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::I18N::LocaleOperations> {
	typedef GCI::I18N::LocaleOperationsFactory Factory;
};
template <>
struct TypeTraits <GCI::I18N::Messages> {
	typedef GCI::I18N::MessagesFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_I18N_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
