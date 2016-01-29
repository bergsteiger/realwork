////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/Messages_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::Messages_i
// Заголовок реализации класса серванта для интерфеса Messages
//
// Реализация работы с локализованными строками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_MESSAGES_I_H__
#define __SHARED_GCI_I18N_I_MESSAGES_I_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/impl/I18N_i/I18N_i.h"

//#UC START# *452CCF1602FD_CUSTOM_INCLUDES*
//#UC END# *452CCF1602FD_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

class Messages_i; // self forward Var
typedef ::Core::Var<Messages_i> Messages_i_var;
typedef ::Core::Var<const Messages_i> Messages_i_cvar;

class Messages_i_factory;

// Реализация работы с локализованными строками
class Messages_i:
	virtual public I18N::Messages
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Messages_i)
	friend class Messages_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// Ключ - локаль, значение - строка на языке этой локали
	typedef std::map < I18N::SupportedLocales, const std::wstring > L10NStrings;

	// Ключ - строка, значение - пары локаль-строка.
	typedef std::map < std::string, L10NStrings > I18NStrings;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// перевод строки utf в заданную локаль
	static const std::string utf_to_locale (const char* utf_string, I18N::SupportedLocales locale);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~Messages_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// вернуть текущую локаль
	virtual I18N::SupportedLocales get_current_locale () const;

	// вычитать из буфера строку
	virtual const char* get_string (const CharBuffer& buffer, size_t offset, size_t& length) const;

	// вычитать из буфера 4-ёх байтовое бесзнаковое целое
	virtual unsigned long get_uint32 (const CharBuffer& buffer, size_t offset) const;

	// поиск пути для перевода по установленной локали
	virtual const char* locale_to_path (I18N::SupportedLocales locale) const;

	// разобрать файл с переводами
	virtual void read_file (const CharBuffer& buffer, I18N::SupportedLocales locale);

	// разобрать таблицу сообщений
	virtual void read_messages (const CharBuffer& buffer, I18N::SupportedLocales locale);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	I18N::SupportedLocales m_default_locale;

	EndianType m_endian;

	I18NStrings m_string_table;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from I18N::Messages
	// очистить все строки для заданного языка
	virtual void close (I18N::SupportedLocales locale);

	// implemented method from I18N::Messages
	// получить локализованную строку не в unicode
	virtual const std::string get (const char* key, I18N::SupportedLocales locale) const;

	// implemented method from I18N::Messages
	// получить локализованную строку  не в unicode для текущей системной локали (используется
	// значение LC_ALL!!!)
	virtual const std::string get (const char* key) const;

	// implemented method from I18N::Messages
	// получить локализованную шаблонную строку с подставленными параметрами не в unicode для текущей
	// системной локали (используется значение LC_ALL!!!)
	virtual const std::string get (const char* key, const I18N::TemplateParamsList& template_params) const;

	// implemented method from I18N::Messages
	// получить локализованную строку в utf16
	virtual const std::wstring getw (const char* key, I18N::SupportedLocales locale) const;

	// implemented method from I18N::Messages
	// получить локализованную строку для текущей системной локали (используется значение LC_ALL!!!)
	virtual const std::wstring getw (const char* key) const;

	// implemented method from I18N::Messages
	// вычитать строки из файла
	virtual void open (
		const char* file
		, I18N::SupportedLocales locale
	) /*throw (
		I18N::BadFileFormat
		, I18N::CantFindFile
	)*/;

//#UC START# *452CCF1602FD*
public:
	void dump () const; // for test
//#UC END# *452CCF1602FD*
}; // class Messages_i

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_MESSAGES_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
