////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/MSDNStreamWrapper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::MSDNStreamWrapper
//
// обёртка вокруг msdn-овского стрима
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/IO_i/MSDNStreamWrapper.h"

//#UC START# *476263570115_CUSTOM_INCLUDES*
//#UC END# *476263570115_CUSTOM_INCLUDES*

namespace GCI {
namespace IO_i {

//#UC START# *476263570115*
MSDNStreamWrapper::MSDNStreamWrapper (GCI::IO::IStream_tie* tie) : m_tie (tie) {
	m_tie->addref ();
}
//#UC END# *476263570115*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MSDNStreamWrapper::~MSDNStreamWrapper () {
	//#UC START# *476263570115_DESTR_BODY*
	m_tie->release ();
	//#UC END# *476263570115_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IO::Stream
// Если возвращается true, дальнейшая работа с потоком невозможна
bool MSDNStreamWrapper::bad () const {
	//#UC START# *443E262F007D_476263570115*
	return false;
	//#UC END# *443E262F007D_476263570115*
}

// implemented method from IO::Stream
// Чистит флаги потока
void MSDNStreamWrapper::clear () {
	//#UC START# *48BFB53E00B5_476263570115*
	GCI::IO::Stream_tie* tie = dynamic_cast<GCI::IO::Stream_tie*> (m_tie);
	GDS_ASSERT (tie && "we can't call clear at this object");
	GCI::IO::Stream* stream = dynamic_cast<GCI::IO::Stream*> (tie->m_impl);
	GDS_ASSERT (stream && "we can't call clear at this object");
	stream->clear ();
	//#UC END# *48BFB53E00B5_476263570115*
}

// implemented method from IO::Stream
// Копирует данные из одного потока в другой.
void MSDNStreamWrapper::copy_to (
	IO::Stream* dst
	, unsigned long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) /*throw (
	IO::OperationError
)*/ {
	//#UC START# *4423FCB4029F_476263570115*
	const int MAX_BUFFER_SIZE = 4*1024;
	char buffer[MAX_BUFFER_SIZE];
	while (!this->eof()) {
		unsigned long readed = this->read(buffer, MAX_BUFFER_SIZE);
		actually_read += readed;

		actually_written += dst->write(buffer, readed);
	}
	//#UC END# *4423FCB4029F_476263570115*
}

// implemented method from IO::Stream
// Функция возвращает true если достигнут конец потока.
bool MSDNStreamWrapper::eof () const {
	//#UC START# *4433789401B5_476263570115*
	GCI::IO::Stream_tie* tie = dynamic_cast<GCI::IO::Stream_tie*> (m_tie);
	GDS_ASSERT (tie && "we can't call eof at non Stream_tie object")
	return tie->m_impl->eof ();
	//#UC END# *4433789401B5_476263570115*
}

// implemented method from IO::Stream
// Прочесть данные из потока, возвращает количество прочитанных байтов.
unsigned long MSDNStreamWrapper::read (void* buffer, unsigned long size) /*throw (IO::OperationError)*/ {
	//#UC START# *4423FC9C0290_476263570115*
	unsigned long readed;
	unsigned long result = m_tie->read_4423FC9C0290 (buffer, size, readed);
	if ((result != 0) && (result != 1)) {
		throw IO::OperationError ();
	}
	return readed;
	//#UC END# *4423FC9C0290_476263570115*
}

// implemented method from IO::Stream
// Переместить маркер потока. Возвращает число байт от начала потока.
unsigned long MSDNStreamWrapper::seek (
	long offset
	, unsigned long whence
) /*throw (
	IO::OperationError
	, IO::NotImplemented
)*/ {
	//#UC START# *4423FCA9030D_476263570115*
	unsigned long long pos;
	switch (whence) {
		case GCI::IO::SSD_BEGIN:
		case GCI::IO::SSD_CURRENT:
		case GCI::IO::SSD_END:
			{
				unsigned long result = m_tie->seek_4423FCA9030D(offset, whence, pos);
				if (result != 0) {
					throw IO::OperationError ();
				}
				return static_cast <unsigned long> (pos);
			}
		default:
			GDS_ASSERT (false);
	}
	GDS_ASSERT (false); // not reached
	throw IO::OperationError ();
	//#UC END# *4423FCA9030D_476263570115*
}

// implemented method from IO::Stream
// Записать данные в поток. Возвращает количество записанных байтов.
unsigned long MSDNStreamWrapper::write (const void* buffer, unsigned long size) {
	//#UC START# *4423FCA20232_476263570115*
	unsigned long written;
	unsigned long result = m_tie->write_4423FCA20232 (buffer, size, written);
	if ((result != 0) && (result != 1)) {
		throw IO::OperationError ();
	}
	return written;
	GDS_ASSERT (false && "not realized yet");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4423FCA20232_476263570115*
}
} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

