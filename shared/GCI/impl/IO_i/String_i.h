////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/String_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::String_i
// Заголовок реализации класса серванта для интерфеса String
//
// Реализация интерфейса строки.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_STRING_I_H__
#define __SHARED_GCI_IO_I_STRING_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"

namespace GCI {
namespace IO_i {

class String_i; // self forward Var
typedef ::Core::Var<String_i> String_i_var;
typedef ::Core::Var<const String_i> String_i_cvar;

class String_i_factory;

// Реализация интерфейса строки.
class String_i:
	virtual public IO::String
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (String_i)
	friend class String_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	String_i (const char* str);

	String_i (const char* str, short code_page);

	String_i (char* str, short code_page);

	String_i (unsigned long maximum);

	virtual ~String_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// инициализирует объект переданным значением строки
	virtual void init (const char* str);

	virtual void init (const char* str, size_t size);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned long m_max;

	short m_page;

	char* m_string;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IO::String
	// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
	virtual const char* add (const char* str);

	// implemented method from IO::String
	// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
	virtual const char* add (const IO::String* str);

	// implemented method from IO::String
	// кодовая страница
	virtual short get_code_page () const;

	virtual void set_code_page (short code_page);

	// implemented method from IO::String
	// указатель на начало аллоцированного буфера (строки)
	virtual const char* get_data () const;

	// implemented method from IO::String
	// возвращает новую строку равную объединению текущей и переданной
	virtual char* join (const char* str) const;

	// implemented method from IO::String
	// возвращает новую строку равную объединению текущей и переданной
	virtual char* join (const IO::String* str) const;

	// implemented method from IO::String
	// длинна текстовой строки
	virtual unsigned long get_length () const;

	// implemented method from IO::String
	// размер аллоцированого буфера, для хранения текстовой строки
	virtual unsigned long get_maximum () const;

	virtual void set_maximum (unsigned long maximum);

	// implemented method from IO::String
	// Захватывает переданную строку. Если аргумент, задающий длину, меньше чем strlen(str) + 1, то
	// длина строки принимается равной длине строки + 1. Память под передаваемый аргумент str ДОЛЖНА
	// БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[].
	virtual void reset (char* str, unsigned long maximum);

	// implemented method from IO::String
	// устанавливает значение строки равное переданному (переданная строка копируеться)
	virtual void reset (const char* str);

	// implemented method from IO::String
	// возвращает бинарную копию строки
	virtual IO::String* strdup () const;
}; // class String_i

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_STRING_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
