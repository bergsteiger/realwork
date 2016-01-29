////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/RemoteBigFileAsStream.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::RemoteBigFileAsStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_REMOTEBIGFILEASSTREAM_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_REMOTEBIGFILEASSTREAM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"

//#UC START# *54E3400A01BE_CUSTOM_INCLUDES*
//#UC END# *54E3400A01BE_CUSTOM_INCLUDES*

namespace ArchiAdapterLib {
namespace GardocsImpl {

class RemoteBigFileAsStream;
typedef Core::Var<RemoteBigFileAsStream> RemoteBigFileAsStream_var;
typedef Core::Var<const RemoteBigFileAsStream> RemoteBigFileAsStream_cvar;

class RemoteBigFileAsStream :
	virtual public GCI::IO::Stream
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (RemoteBigFileAsStream)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RemoteBigFileAsStream (
		const ArchiGate::DocCardRemote::ByteBuffer& firstChunk
		, ArchiGate::DocCardRemote::BigFileIterator* next
		, unsigned long chunkSizeInBytes
	);

public:
	virtual ~RemoteBigFileAsStream ();


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

//#UC START# *54E3400A01BE*
	virtual void delete_obj ();

private:
	ArchiGate::DocCardRemote::BigFileIterator_var m_big_file_iterator;
	unsigned long m_chunk_size_in_bytes;
	ArchiGate::DocCardRemote::ByteBuffer m_first_chunk;
	bool m_is_bad;
//#UC END# *54E3400A01BE*
}; // class RemoteBigFileAsStream

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_REMOTEBIGFILEASSTREAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

