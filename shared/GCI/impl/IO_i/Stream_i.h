////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/Stream_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::Stream_i
// Заголовок реализации класса серванта для интерфеса Stream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_STREAM_I_H__
#define __SHARED_GCI_IO_I_STREAM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"

//#UC START# *4427F7E9031C_CUSTOM_INCLUDES*
#include "shared/Core/mng/Aptr.h"
#include <iostream>
//#UC END# *4427F7E9031C_CUSTOM_INCLUDES*

namespace GCI {
namespace IO_i {

class Stream_i; // self forward Var
typedef ::Core::Var<Stream_i> Stream_i_var;
typedef ::Core::Var<const Stream_i> Stream_i_cvar;

class Stream_i_factory;

class Stream_i:
	virtual public IO::Stream
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Stream_i)
	friend class Stream_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Stream_i ();

	Stream_i (const char* path);

	virtual ~Stream_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IO::Stream
	// Если возвращается true, дальнейшая работа с потоком невозможна
	virtual bool bad () const;

	// implemented method from IO::Stream
	// Чистит флаги потока
	virtual void clear ();

	// implemented method from IO::Stream
	// Копирует данные из одного потока в другой.
	virtual void copy_to (
		IO::Stream* dst
		, unsigned long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) /*throw (
		IO::OperationError
	)*/;

	// implemented method from IO::Stream
	// Функция возвращает true если достигнут конец потока.
	virtual bool eof () const;

	// implemented method from IO::Stream
	// Прочесть данные из потока, возвращает количество прочитанных байтов.
	virtual unsigned long read (void* buffer, unsigned long size) /*throw (IO::OperationError)*/;

	// implemented method from IO::Stream
	// Переместить маркер потока. Возвращает число байт от начала потока.
	virtual unsigned long seek (long offset, unsigned long whence) /*throw (IO::OperationError, IO::NotImplemented)*/;

	// implemented method from IO::Stream
	// Записать данные в поток. Возвращает количество записанных байтов.
	virtual unsigned long write (const void* buffer, unsigned long size);

//#UC START# *4427F7E9031C*
private:
	Core::Aptr<std::iostream> m_stream;
//#UC END# *4427F7E9031C*
}; // class Stream_i

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_STREAM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
