////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/IO/IO.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_H__
#define __SHARED_GCI_IO_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace IO {

// Во время выполнения операции copy_to один из потоков, участвовавших в операции перешёл в
// некорректное состояние.
class OperationError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// функция не реализована
class NotImplemented : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class String;
typedef ::Core::Var<String> String_var;
typedef ::Core::Var<const String> String_cvar;
// Интерфейс для работы со строками. Предпочтительно использовать именно этот тип для работы со
// всеми строковыми данными.
class String
	: virtual public ::Core::IObject
{
public:
	// длинна текстовой строки
	virtual unsigned long get_length () const = 0;

	// размер аллоцированого буфера, для хранения текстовой строки
	virtual unsigned long get_maximum () const = 0;

	virtual void set_maximum (unsigned long maximum) = 0;

	// указатель на начало аллоцированного буфера (строки)
	virtual const char* get_data () const = 0;

	// кодовая страница
	virtual short get_code_page () const = 0;

	virtual void set_code_page (short code_page) = 0;

	// Захватывает переданную строку. Если аргумент, задающий длину, меньше чем strlen(str) + 1, то
	// длина строки принимается равной длине строки + 1. Память под передаваемый аргумент str ДОЛЖНА
	// БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[].
	virtual void reset (char* str, unsigned long maximum) = 0;

	// устанавливает значение строки равное переданному (переданная строка копируеться)
	virtual void reset (const char* str) = 0;

	// возвращает бинарную копию строки
	virtual String* strdup () const = 0;

	// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
	virtual const char* add (const char* str) = 0;

	// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
	virtual const char* add (const String* str) = 0;

	// возвращает новую строку равную объединению текущей и переданной
	virtual char* join (const char* str) const = 0;

	// возвращает новую строку равную объединению текущей и переданной
	virtual char* join (const String* str) const = 0;
};

/// factory interface for String
class StringFactory {
public:
	// фабрика, копирует строку
	static String* make (const char* str)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// фабрика, копирует строку
	static String* create (const char* str, short code_page)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// Захватывает переданную строку. Память под передаваемый аргумент str ДОЛЖНА БЫТЬ ВЫДЕЛЕНА
	// оператором new[], так как в деструкторе вызывается оператор delete[].
	static String* take (char* str, short code_page)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// создает пустую строку, с преалоцированным буфером указанного размера
	static String* alloc (unsigned long maximum)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// точка от которой считается смещение. Константы должны совпадать по значению с MSDN-овскими
enum StreamSeekDirection {
	SSD_BEGIN // смещение относительно начала потока
	, SSD_CURRENT // смещение относительнотекущей позиции в потоке
	, SSD_END // смещение относительно конца потока
};

class Stream;
typedef ::Core::Var<Stream> Stream_var;
typedef ::Core::Var<const Stream> Stream_cvar;
// Интерфейс для работы с потоком
class Stream
	: virtual public ::Core::IObject
{
public:
	// Прочесть данные из потока, возвращает количество прочитанных байтов.
	virtual unsigned long read (void* buffer, unsigned long size) /*throw (OperationError)*/ = 0;

	// Записать данные в поток. Возвращает количество записанных байтов.
	virtual unsigned long write (const void* buffer, unsigned long size) = 0;

	// Переместить маркер потока. Возвращает число байт от начала потока.
	virtual unsigned long seek (long offset, unsigned long whence) /*throw (OperationError, NotImplemented)*/ = 0;

	// Копирует данные из одного потока в другой.
	virtual void copy_to (
		Stream* dst
		, unsigned long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) /*throw (
		OperationError
	)*/ = 0;

	// Функция возвращает true если достигнут конец потока.
	virtual bool eof () const = 0;

	// Если возвращается true, дальнейшая работа с потоком невозможна
	virtual bool bad () const = 0;

	// Чистит флаги потока
	virtual void clear () = 0;
};

/// factory interface for Stream
class StreamFactory {
public:
	// Создает пустой поток
	static Stream* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// Создает поток связанный с файлом
	static Stream* make (const char* path)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// для универсальной передачи времени между разными языками, платформами.
struct DateTimeBox {
	// день в месяце (1-31)
	short day;
	// месяц в году (1-12)
	short mounth;
	// год
	short year;
	// час (0-23)
	short hour;
	// минута в часе (0-59)
	short minute;
	// секунда в минуте (0-59)
	short second;
	// миллисекунды (0-999)
	short millisecond;
};

#pragma pack (pop)

class BinaryString;
typedef ::Core::Var<BinaryString> BinaryString_var;
typedef ::Core::Var<const BinaryString> BinaryString_cvar;
// строка в которой могут быть нулевые символы
class BinaryString
	: virtual public String
{
};

/// factory interface for BinaryString
class BinaryStringFactory {
public:
	// фабрика, копирует строку заданного размера
	static BinaryString* make (const void* buffer, size_t size)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace IO
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::IO::String> {
	typedef GCI::IO::StringFactory Factory;
};
template <>
struct TypeTraits <GCI::IO::Stream> {
	typedef GCI::IO::StreamFactory Factory;
};
template <>
struct TypeTraits <GCI::IO::BinaryString> {
	typedef GCI::IO::BinaryStringFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_IO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
