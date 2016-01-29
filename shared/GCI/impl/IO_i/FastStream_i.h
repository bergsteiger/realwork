#ifndef __SHARED_GCI_IMPL_IO_FASTSTREAM_I_H__
#define __SHARED_GCI_IMPL_IO_FASTSTREAM_I_H__

#include <vector>

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"

namespace GCI { namespace IO_i {

class FastStream_i; // self forward Var
typedef ::Core::Var<FastStream_i> FastStream_i_var;
typedef ::Core::Var<const FastStream_i> FastStream_i_cvar;

class FastStream_i_factory;

class FastStream_i: virtual public GCI::IO::Stream, virtual public Core::RefCountObjectBase {
	SET_OBJECT_COUNTER (FastStream_i)
	friend class FastStream_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	FastStream_i ();
	FastStream_i (size_t reserved_size);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GCI::IO::Stream
	// Если возвращается true, дальнейшая работа с потоком невозможна
	virtual bool bad () const;

	// implemented method from GCI::IO::Stream
	// Чистит флаги потока
	virtual void clear ();

	// implemented method from GCI::IO::Stream
	// Копирует данные из одного потока в другой.
	virtual void copy_to (
		GCI::IO::Stream* dst
		, unsigned long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) /*throw (
		GCI::IO::OperationError
	)*/;

	// implemented method from GCI::IO::Stream
	// Функция возвращает true если достигнут конец потока.
	virtual bool eof () const;

	// implemented method from GCI::IO::Stream
	// Прочесть данные из потока, возвращает количество прочитанных байтов.
	virtual unsigned long read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/;

	// implemented method from GCI::IO::Stream
	// Переместить маркер потока. Возвращает число байт от начала потока.
	virtual unsigned long seek (
		long offset
		, unsigned long whence
	) /*throw (
		GCI::IO::OperationError
		, GCI::IO::NotImplemented
	)*/;

	// implemented method from GCI::IO::Stream
	// Записать данные в поток. Возвращает количество записанных байтов.
	virtual unsigned long write (const void* buffer, unsigned long size);

private:
	std::vector<unsigned char> m_data;
	size_t m_position;
}; // class FastStream_i

} } // namespaces


#endif //__SHARED_GCI_IMPL_IO_FASTSTREAM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
