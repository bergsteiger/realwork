////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/MSDNStreamWrapper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::MSDNStreamWrapper
// Заголовок реализации класса серванта для интерфеса Stream
//
// обёртка вокруг msdn-овского стрима
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_MSDNSTREAMWRAPPER_H__
#define __SHARED_GCI_IO_I_MSDNSTREAMWRAPPER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"

//#UC START# *476263570115_CUSTOM_INCLUDES*
#include "shared/GCI/IO/IO_tie.h"
//#UC END# *476263570115_CUSTOM_INCLUDES*

namespace GCI {
namespace IO_i {

class MSDNStreamWrapper; // self forward Var
typedef ::Core::Var<MSDNStreamWrapper> MSDNStreamWrapper_var;
typedef ::Core::Var<const MSDNStreamWrapper> MSDNStreamWrapper_cvar;

class MSDNStreamWrapper_factory;

// обёртка вокруг msdn-овского стрима
class MSDNStreamWrapper:
	virtual public IO::Stream
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MSDNStreamWrapper)
	friend class MSDNStreamWrapper_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~MSDNStreamWrapper ();

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

//#UC START# *476263570115*
public:
	MSDNStreamWrapper (GCI::IO::IStream_tie* tie);

private:
	GCI::IO::IStream_tie* m_tie;
//#UC END# *476263570115*
}; // class MSDNStreamWrapper

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_MSDNSTREAMWRAPPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
