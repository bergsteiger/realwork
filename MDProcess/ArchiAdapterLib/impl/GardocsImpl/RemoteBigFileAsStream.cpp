////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/RemoteBigFileAsStream.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::RemoteBigFileAsStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/RemoteBigFileAsStream.h"
// by <<uses>> dependencies
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

//#UC START# *54E3400A01BE_CUSTOM_INCLUDES*
//#UC END# *54E3400A01BE_CUSTOM_INCLUDES*

namespace ArchiAdapterLib {
namespace GardocsImpl {

//#UC START# *54E3400A01BE*
void RemoteBigFileAsStream::delete_obj () {
	m_big_file_iterator->destroy();
	m_is_bad = true;
}
//#UC END# *54E3400A01BE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoteBigFileAsStream::RemoteBigFileAsStream (
	const ArchiGate::DocCardRemote::ByteBuffer& firstChunk
	, ArchiGate::DocCardRemote::BigFileIterator* next
	, unsigned long chunkSizeInBytes
)
//#UC START# *54E3409702CF_BASE_INIT*
//#UC END# *54E3409702CF_BASE_INIT*
{
	//#UC START# *54E3409702CF_BODY*
	LOG_D(("RemoteBigFileAsStream::ctor - START"));

	m_first_chunk = firstChunk;

	m_big_file_iterator = ArchiGate::DocCardRemote::BigFileIterator::_duplicate(next);
	m_chunk_size_in_bytes = chunkSizeInBytes;
	m_is_bad = false;
	//#UC END# *54E3409702CF_BODY*
}

RemoteBigFileAsStream::~RemoteBigFileAsStream () {
	//#UC START# *54E3400A01BE_DESTR_BODY*
	//#UC END# *54E3400A01BE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GCI::IO::Stream
// Если возвращается true, дальнейшая работа с потоком невозможна
bool RemoteBigFileAsStream::bad () const {
	//#UC START# *443E262F007D_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	return m_is_bad;
	//#UC END# *443E262F007D_54E3400A01BE*
}

// implemented method from GCI::IO::Stream
// Чистит флаги потока
void RemoteBigFileAsStream::clear () {
	//#UC START# *48BFB53E00B5_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *48BFB53E00B5_54E3400A01BE*
}

// implemented method from GCI::IO::Stream
// Копирует данные из одного потока в другой.
void RemoteBigFileAsStream::copy_to (
	GCI::IO::Stream* dst
	, unsigned long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) /*throw (
	GCI::IO::OperationError
)*/ {
	//#UC START# *4423FCB4029F_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));

	actually_read = 0;
	actually_written = 0;	
	
	actually_written += dst->write (m_first_chunk.get_buffer(), m_first_chunk.length());
	actually_read += m_first_chunk.length();

	GDS_ASSERT (actually_written <= actually_read);

	while (true) {
		ArchiGate::DocCardRemote::ByteBuffer_var block = m_big_file_iterator->next (m_chunk_size_in_bytes);
		const CORBA::Octet* buf = block->get_buffer();
		unsigned long received = block->length();

		if (received == 0) {
			break;
		}

		actually_read += received;
		actually_written += dst->write (buf, received);

		GDS_ASSERT (actually_written <= actually_read);
	}

	LOG_D(("%s - FINISH", GDS_CURRENT_FUNCTION));
	//#UC END# *4423FCB4029F_54E3400A01BE*
}

// implemented method from GCI::IO::Stream
// Функция возвращает true если достигнут конец потока.
bool RemoteBigFileAsStream::eof () const {
	//#UC START# *4433789401B5_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4433789401B5_54E3400A01BE*
}

// implemented method from GCI::IO::Stream
// Прочесть данные из потока, возвращает количество прочитанных байтов.
unsigned long RemoteBigFileAsStream::read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/ {
	//#UC START# *4423FC9C0290_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4423FC9C0290_54E3400A01BE*
}

// implemented method from GCI::IO::Stream
// Переместить маркер потока. Возвращает число байт от начала потока.
unsigned long RemoteBigFileAsStream::seek (
	long offset
	, unsigned long whence
) /*throw (
	GCI::IO::OperationError
	, GCI::IO::NotImplemented
)*/ {
	//#UC START# *4423FCA9030D_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4423FCA9030D_54E3400A01BE*
}

// implemented method from GCI::IO::Stream
// Записать данные в поток. Возвращает количество записанных байтов.
unsigned long RemoteBigFileAsStream::write (const void* buffer, unsigned long size) {
	//#UC START# *4423FCA20232_54E3400A01BE*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4423FCA20232_54E3400A01BE*
}
} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

