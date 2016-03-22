////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/Stream_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::Stream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/IO_i/Stream_i.h"

//#UC START# *4427F7E9031C_CUSTOM_INCLUDES*
#include <cstdio>
#include <string>
#include <sstream>
#include <fstream>
//#UC END# *4427F7E9031C_CUSTOM_INCLUDES*

namespace GCI {
namespace IO_i {

//#UC START# *4427F7E9031C*
//#UC END# *4427F7E9031C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Stream_i::Stream_i ()
//#UC START# *4423FB5903D8_442807A00138_4427F7E9031C_BASE_INIT*
//#UC END# *4423FB5903D8_442807A00138_4427F7E9031C_BASE_INIT*
{
	//#UC START# *4423FB5903D8_442807A00138_4427F7E9031C_BODY*
	m_stream = new std::stringstream ();
	//#UC END# *4423FB5903D8_442807A00138_4427F7E9031C_BODY*
}

Stream_i::Stream_i (const char* path)
//#UC START# *4423FB5903D8_44312A6F0128_4427F7E9031C_BASE_INIT*
//#UC END# *4423FB5903D8_44312A6F0128_4427F7E9031C_BASE_INIT*
{
	//#UC START# *4423FB5903D8_44312A6F0128_4427F7E9031C_BODY*
	// TODO Create temporary file if path == 0?
	if (path && ACE_OS::strlen (path)) {
		std::FILE* file = std::fopen (path, "a");
		if (file == NULL) {
			LOG_E (("Stream_i: can't create stream based on filename %s", path));
			// TODO Throw exception
		}
#pragma warning(suppress: 6387)
		if (std::fclose (file)) {
			LOG_W (("Stream_i: error while closing file %s", path));
		}
		m_stream = new std::fstream (path, std::ios_base::out | std::ios_base::in | std::ios_base::binary);
	} else {
		m_stream = new std::stringstream ();
	}
	// TODO Throw exception
	if (this->bad ()) {
		LOG_E (("Stream_i: can't create stream based on filename %s", path));
	}
	//#UC END# *4423FB5903D8_44312A6F0128_4427F7E9031C_BODY*
}

Stream_i::~Stream_i () {
	//#UC START# *4427F7E9031C_DESTR_BODY*
	//#UC END# *4427F7E9031C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IO::Stream
// Если возвращается true, дальнейшая работа с потоком невозможна
bool Stream_i::bad () const {
	//#UC START# *443E262F007D_4427F7E9031C*
	return m_stream->bad ();
	//#UC END# *443E262F007D_4427F7E9031C*
}

// implemented method from IO::Stream
// Чистит флаги потока
void Stream_i::clear () {
	//#UC START# *48BFB53E00B5_4427F7E9031C*
	m_stream->clear ();
	//#UC END# *48BFB53E00B5_4427F7E9031C*
}

// implemented method from IO::Stream
// Копирует данные из одного потока в другой.
void Stream_i::copy_to (
	IO::Stream* dst
	, unsigned long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) /*throw (
	IO::OperationError
)*/ {
	//#UC START# *4423FCB4029F_4427F7E9031C*
	actually_read = 0;
	actually_written = 0;

	const unsigned long block_size = 512;
	char buffer[block_size];
	unsigned long count; // Number of bytes to receive
	unsigned long received;// Number of received bytes
	for (bool eof = this->eof (); (actually_read < size) && !eof; eof = this->eof ()) {
		if (this->bad () || dst->bad ()) {
			throw IO::OperationError ();
		}
		count = static_cast<unsigned long> ((size < (actually_read + block_size)) ? size - actually_read : block_size);
		received = this->read (buffer, count);
		actually_read += received;
		if (received) {
			actually_written += dst->write (buffer, received);
		}
		GDS_ASSERT (actually_written <= actually_read);
	}
	//#UC END# *4423FCB4029F_4427F7E9031C*
}

// implemented method from IO::Stream
// Функция возвращает true если достигнут конец потока.
bool Stream_i::eof () const {
	//#UC START# *4433789401B5_4427F7E9031C*
	return m_stream->eof ();
	//#UC END# *4433789401B5_4427F7E9031C*
}

// implemented method from IO::Stream
// Прочесть данные из потока, возвращает количество прочитанных байтов.
unsigned long Stream_i::read (void* buffer, unsigned long size) /*throw (IO::OperationError)*/ {
	//#UC START# *4423FC9C0290_4427F7E9031C*
	std::stringbuf::pos_type position_before = m_stream->rdbuf ()->pubseekoff (0, std::ios_base::cur, std::ios_base::in);
	if (position_before < 0) {
		position_before = 0;
	}
	m_stream->read (reinterpret_cast<char*>(buffer), size);
	std::stringbuf::pos_type position_after = 0;
	if (m_stream->eof ()) {
		position_after = m_stream->rdbuf ()->pubseekoff (0, std::ios_base::end, std::ios_base::in);
	} else {
		position_after = m_stream->rdbuf ()->pubseekoff (0, std::ios_base::cur, std::ios_base::in);
	}
	return static_cast<unsigned long> (position_after - position_before);
	//#UC END# *4423FC9C0290_4427F7E9031C*
}

// implemented method from IO::Stream
// Переместить маркер потока. Возвращает число байт от начала потока.
unsigned long Stream_i::seek (long offset, unsigned long whence) /*throw (IO::OperationError, IO::NotImplemented)*/ {
	//#UC START# *4423FCA9030D_4427F7E9031C*
	std::ios_base::seekdir direction;
	switch (whence) {
		case 0:
			direction = std::ios_base::beg;
			break;
		case 1:
			direction = std::ios_base::cur;
			break;
		case 2:
			direction = std::ios_base::end;
			break;
		default:
			GDS_ASSERT (false);
			direction = std::ios_base::beg;
			break;
	}

	//unsigned long result = static_cast<unsigned long> (m_stream->rdbuf ()->pubseekoff (offset, direction));
	m_stream->std::istream::seekg (offset, direction);
	std::istream::pos_type result = m_stream->std::istream::tellg ();
	if (result < 0) {
		throw IO::OperationError ();
	}

	return static_cast<unsigned long> (result);
	//return result;
	//#UC END# *4423FCA9030D_4427F7E9031C*
}

// implemented method from IO::Stream
// Записать данные в поток. Возвращает количество записанных байтов.
unsigned long Stream_i::write (const void* buffer, unsigned long size) {
	//#UC START# *4423FCA20232_4427F7E9031C*
	std::stringbuf::pos_type position_before = m_stream->rdbuf ()->pubseekoff (0, std::ios_base::cur, std::ios_base::out);
	if (position_before < 0) {
		position_before = 0;
	}
	m_stream->write (reinterpret_cast<const char*>(buffer), size);
	std::stringbuf::pos_type position_after = m_stream->rdbuf ()->pubseekoff (0, std::ios_base::cur, std::ios_base::out);
	return static_cast<unsigned long> (position_after - position_before);
	//#UC END# *4423FCA20232_4427F7E9031C*
}
} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

