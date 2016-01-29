#include "shared/GCI/impl/IO_i/FastStream_i.h"

namespace GCI { namespace IO_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FastStream_i::FastStream_i () : m_position (0) {
	m_data.reserve (1000);
}

FastStream_i::FastStream_i (size_t reserved_size) : m_position (0) {
	m_data.reserve (reserved_size);
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GCI::IO::Stream
// Если возвращается true, дальнейшая работа с потоком невозможна
bool FastStream_i::bad () const {
	return false;
}

// implemented method from GCI::IO::Stream
// Чистит флаги потока
void FastStream_i::clear () {
	std::vector<unsigned char> tmp;
	m_data.swap (tmp);
	m_data.reserve (1000);
	m_position = 0;
}

// implemented method from GCI::IO::Stream
// Копирует данные из одного потока в другой.
void FastStream_i::copy_to (
	GCI::IO::Stream* dst
	, unsigned long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) /*throw (GCI::IO::OperationError)*/ {
	size_t data_size = m_data.size ();
	if (!data_size) {
		actually_read = 0;
		actually_written = 0;
		return;
	}

	if (m_position + size > data_size) {
		size = static_cast<unsigned long> (data_size - m_position);
	}

	actually_written = dst->write (&m_data[m_position], size);
	GDS_ASSERT (actually_written <= size);
	m_position += static_cast<size_t> (actually_written);
	GDS_ASSERT (m_position <= size);
	actually_read = actually_written;
}

// implemented method from GCI::IO::Stream
// Функция возвращает true если достигнут конец потока.
bool FastStream_i::eof () const {
	return m_position == m_data.size ();
}

// implemented method from GCI::IO::Stream
// Прочесть данные из потока, возвращает количество прочитанных байтов.
unsigned long FastStream_i::read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/ {
	size_t data_size = m_data.size ();
	if (!data_size || (m_position == data_size)) {
		return 0;
	}

	if (m_position + size > data_size) {
		size = static_cast<unsigned long> (data_size - m_position);
	}

	ACE_OS::memcpy (buffer, &m_data[m_position], size);
	m_position += size;
	GDS_ASSERT (m_position >= size);

	return size;
}

// implemented method from GCI::IO::Stream
// Переместить маркер потока. Возвращает число байт от начала потока.
unsigned long FastStream_i::seek (long offset, unsigned long whence) /*throw (GCI::IO::OperationError, GCI::IO::NotImplemented)*/ {
	size_t data_size = m_data.size ();

	switch (whence) {
		case GCI::IO::SSD_BEGIN:
			if (offset < 0) {
				m_position = 0;
			} else {
				m_position = (offset > static_cast<long> (data_size)) ? data_size : offset;
			}
			break;
		case GCI::IO::SSD_CURRENT:
			if (-offset > static_cast<long> (m_position)) {
				m_position = 0;
			} else {
				m_position += offset;
				if (m_position > data_size) {
					m_position = data_size;
				}
			}
			break;
		case GCI::IO::SSD_END:
			if (offset > 0) {
				m_position = data_size;
			} else if (-offset > static_cast<long> (data_size)) {
				m_position = 0;
			} else {
				m_position = data_size + offset;
			}
			break;
		default:
			GDS_ASSERT (false);
	}

	return static_cast<unsigned long> (m_position);
}

// implemented method from GCI::IO::Stream
// Записать данные в поток. Возвращает количество записанных байтов.
unsigned long FastStream_i::write (const void* buffer, unsigned long size) {
	// пишем только в конец
	// если нужно будет писать в серединку, лучше написать ещё одну реализацию не на векторе
	if (m_position != m_data.size ()) {
		return 0;
	}

	unsigned char* char_buffer = (unsigned char*) buffer;
	m_data.insert (m_data.end (), char_buffer, char_buffer + size);
	m_position += size;
	return size;
}

} } // namespaces
