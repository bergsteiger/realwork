////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/BaseReader.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::BaseReader
//
// Базовый класс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Readers/BaseReader.h"

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BaseReader::BaseReader (DBCore::Store* stream, DBCore::IIndex* index)
//#UC START# *4EB93D3A015E_BASE_INIT*
	: m_stream (stream), m_length (0), m_buffer (0), m_buffer_size (0), m_index (index) 
//#UC END# *4EB93D3A015E_BASE_INIT*
{
	//#UC START# *4EB93D3A015E_BODY*
	//#UC END# *4EB93D3A015E_BODY*
}

BaseReader::~BaseReader () {
	//#UC START# *4EB9233B0013_DESTR_BODY*
	if (m_buffer) {
		ACE_OS::free (m_buffer);
	}
	if (m_index && m_stream) { // закрываем стрим в случае если index не 0
		m_index->close_stream (m_stream);
		m_stream = 0;
	}
	//#UC END# *4EB9233B0013_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// дина порции данных
size_t BaseReader::get_length () const {
	//#UC START# *4EB95566031B*
	return m_length;
	//#UC END# *4EB95566031B*
}

// длина стрима
size_t BaseReader::get_stream_length () const {
	//#UC START# *4F2FEBDA03DA*
	return (size_t) m_stream->Length ();
	//#UC END# *4F2FEBDA03DA*
}

// текущая позиция в стриме
size_t BaseReader::get_tell () const {
	//#UC START# *509A72C802B9*
	return m_stream->Tell ();
	//#UC END# *509A72C802B9*
}

// чтение данных
char* BaseReader::read (size_t data_size, int pos) {
	//#UC START# *4EB93FB801E5*
	if (pos >= 0) {
		m_stream->Seek (pos);
	}

	if (m_buffer_size == 0) {
		m_buffer_size = std::min <size_t> (data_size, (size_t) m_stream->Length ());
		m_buffer = (char*) ACE_OS::malloc (m_buffer_size + sizeof (long));
	} else if (data_size > m_buffer_size) {
		m_buffer_size = data_size;
		m_buffer = (char*) ACE_OS::realloc (m_buffer, data_size + sizeof (long));
	}

	GDS_ASSERT (m_buffer);

	m_length = this->read (m_buffer, data_size);

	return m_buffer;
	//#UC END# *4EB93FB801E5*
}

// чтение данных
size_t BaseReader::read (char* buffer, size_t count) {
	//#UC START# *4EB940710021*
	long ret = m_stream->Read (buffer, (int) count);
	GDS_ASSERT (ret >= 0);
	return (size_t) ret;
	//#UC END# *4EB940710021*
}

// чтение данных
char* BaseReader::read_more () {
	//#UC START# *4EB93FEE02DA*
	m_length = this->read (m_buffer, m_length);
	return (m_length)? m_buffer : 0;
	//#UC END# *4EB93FEE02DA*
}

} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

