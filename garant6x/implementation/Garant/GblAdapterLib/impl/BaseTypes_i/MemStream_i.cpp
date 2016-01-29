////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::MemStream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i.h"

//#UC START# *4627347F01F4_CUSTOM_INCLUDES*
#include "garantServer/src/Global/Core/Common/AssemblyInfo.h"

namespace GblAdapterLib {
	typedef Core::PoolMemoryManager<MemStream_i, (sizeof (MemStream_i)*5000) / 1024>::PoolMemoryManagerSingleton MemStreamPool;
}
//#UC END# *4627347F01F4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4627347F01F4*
void* MemStream_i::operator new (size_t cs) {              
	return MemStreamPool::instance()->malloc(cs);
}

void MemStream_i::operator delete (void* p) {
	MemStreamPool::instance()->free(p);
}


std::string MemStream_i::dump_hex () const {
	std::string str;
	char buf [5];
	for (size_t i = 0; i < m_len; ++i) {
		sprintf (buf, "%02X ", m_buf [i]);
		str += buf;
	}
	return str;
}

std::string MemStream_i::dump_ascii () const {
	std::string str;
	char buf [5];
	for (size_t i = 0; i < m_len; ++i) {
		if (m_buf [i] < 0x20) {
			sprintf (buf, "{%X}", m_buf [i]);
			str += buf;
		}	else {
			str += m_buf [i];
		}
	}
	return str;
}

//#UC END# *4627347F01F4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MemStream_i::MemStream_i (const OctetSeq& data, bool with_copy)
//#UC START# *462CC762006D_462CC895029F_4627347F01F4_BASE_INIT*
: m_len (data.length ()), m_pos (0), m_buf (0), m_without_copy (false)
//#UC END# *462CC762006D_462CC895029F_4627347F01F4_BASE_INIT*
{
	//#UC START# *462CC762006D_462CC895029F_4627347F01F4_BODY*
	//LOG_D (("%s: len=%d", GDS_CURRENT_FUNCTION, m_len));
	if (with_copy) {
		copy (data);
	} else {
		if (GCM_IS_ASSEMBLY_NETWORK) {
			// это клиентский адаптер - забираем владение буфером у заглушки (в заглушку буфер приехал из сети)
			m_buf = const_cast<OctetSeq&>(data).get_buffer (1); // to avoid memory copy
			m_without_copy = true;
		} else {
			// это десктоп - обязательно копируем буфер (иначе разломаем память в "серверном" дереве)
			copy (data);
		}
	}
	//#UC END# *462CC762006D_462CC895029F_4627347F01F4_BODY*
}

MemStream_i::~MemStream_i () {
	//#UC START# *4627347F01F4_DESTR_BODY*
	free_buffer (m_buf, m_without_copy ? 0xFFFFFFFF : (unsigned)m_len);
	//#UC END# *4627347F01F4_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void MemStream_i::copy (const OctetSeq& data) {
	//#UC START# *462734F30280*
	m_without_copy = false;
	m_buf = alloc_buffer (data.length ());
	ACE_OS::memcpy (m_buf, data.get_buffer (), data.length ());
	m_len = data.length ();
	m_pos = 0;
	//#UC END# *462734F30280*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GCI::IO::Stream
// Если возвращается true, дальнейшая работа с потоком невозможна
bool MemStream_i::bad () const {
	//#UC START# *443E262F007D_4627347F01F4*
	return false;
	//#UC END# *443E262F007D_4627347F01F4*
}

// implemented method from GCI::IO::Stream
// Чистит флаги потока
void MemStream_i::clear () {
	//#UC START# *48BFB53E00B5_4627347F01F4*
	return;
	//#UC END# *48BFB53E00B5_4627347F01F4*
}

// implemented method from GCI::IO::Stream
// Копирует данные из одного потока в другой.
void MemStream_i::copy_to (
	GCI::IO::Stream* dst
	, unsigned long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) /*throw (
	GCI::IO::OperationError
)*/ {
	//#UC START# *4423FCB4029F_4627347F01F4*
	GDS_ASSERT (false);
	return;
	//#UC END# *4423FCB4029F_4627347F01F4*
}

// implemented method from GCI::IO::Stream
// Функция возвращает true если достигнут конец потока.
bool MemStream_i::eof () const {
	//#UC START# *4433789401B5_4627347F01F4*
	return false;
	//#UC END# *4433789401B5_4627347F01F4*
}

// implemented method from GCI::IO::Stream
// Прочесть данные из потока, возвращает количество прочитанных байтов.
unsigned long MemStream_i::read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/ {
	//#UC START# *4423FC9C0290_4627347F01F4*
	if (m_len < m_pos) {
		buffer = 0;
		return 0;
	}
	if (m_len < (m_pos + size)) {
		size = static_cast<unsigned long> (m_len - m_pos);			
	}
	ACE_OS::memcpy (buffer, m_buf + m_pos, size);

	m_pos += size;
	return size;
	//#UC END# *4423FC9C0290_4627347F01F4*
}

// implemented method from GCI::IO::Stream
// Переместить маркер потока. Возвращает число байт от начала потока.
unsigned long MemStream_i::seek (
	long offset
	, unsigned long whence
) /*throw (
	GCI::IO::OperationError
	, GCI::IO::NotImplemented
)*/ {
	//#UC START# *4423FCA9030D_4627347F01F4*
	long pos = m_pos;
	switch (whence) {
		case 0:
			pos = offset;
			break;
		case 1:
			pos += offset;
			break;
		case 2:
			pos = m_len + offset;
			break;
		default:
			GDS_ASSERT (false);
	}
	if (pos < 0) {
		GDS_ASSERT (false);
		return m_pos;
	}
	if (static_cast<unsigned> (pos) > m_len) {
		throw GCI::IO::OperationError ();
	}

	m_pos = pos;
	return m_pos;
	//#UC END# *4423FCA9030D_4627347F01F4*
}

// implemented method from GCI::IO::Stream
// Записать данные в поток. Возвращает количество записанных байтов.
unsigned long MemStream_i::write (const void* buffer, unsigned long size) {
	//#UC START# *4423FCA20232_4627347F01F4*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4423FCA20232_4627347F01F4*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

