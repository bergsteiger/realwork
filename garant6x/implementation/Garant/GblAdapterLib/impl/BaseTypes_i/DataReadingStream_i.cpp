////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::DataReadingStream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DataReadingStream_i::DataReadingStream_i (GslDataPipe::DataReading* data_reading)
//#UC START# *462CC3EF03A9_462CD373032C_462CBA00032C_BASE_INIT*
: m_data_reading (GslDataPipe::DataReading::_duplicate (data_reading)), m_position (0)
//#UC END# *462CC3EF03A9_462CD373032C_462CBA00032C_BASE_INIT*
{
	//#UC START# *462CC3EF03A9_462CD373032C_462CBA00032C_BODY*
	//#UC END# *462CC3EF03A9_462CD373032C_462CBA00032C_BODY*
}

DataReadingStream_i::~DataReadingStream_i () {
	//#UC START# *462CBA00032C_DESTR_BODY*
	try {
		ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_data_reading.in ());
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *462CBA00032C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GCI::IO::Stream
// Если возвращается true, дальнейшая работа с потоком невозможна
bool DataReadingStream_i::bad () const {
	//#UC START# *443E262F007D_462CBA00032C*
	return false;
	//#UC END# *443E262F007D_462CBA00032C*
}

// implemented method from GCI::IO::Stream
// Чистит флаги потока
void DataReadingStream_i::clear () {
	//#UC START# *48BFB53E00B5_462CBA00032C*
	return;
	//#UC END# *48BFB53E00B5_462CBA00032C*
}

// implemented method from GCI::IO::Stream
// Копирует данные из одного потока в другой.
void DataReadingStream_i::copy_to (
	GCI::IO::Stream* dst
	, unsigned long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) /*throw (
	GCI::IO::OperationError
)*/ {
	//#UC START# *4423FCB4029F_462CBA00032C*
	try {
		if (!dst) {
			LOG_E (("%s: bad arguments. stream is 0.", GDS_CURRENT_FUNCTION));
			throw GCI::IO::OperationError ();
		}
		actually_read = 0;
		actually_written = 0;
		const GCD::SequenceIndex CHUNK_SIZE = 0xffff;

		while (size > 0) {
			unsigned long long load_len = std::min<unsigned long long> (CHUNK_SIZE, size);
			GslDataPipe::PipeData_var pipe_data = m_data_reading->get_data (GCD::SequenceIndex (load_len));
			actually_read += pipe_data->length ();
			size -= pipe_data->length ();
			unsigned long result = dst->write (pipe_data->get_buffer (), pipe_data->length ());
			actually_written += result;
		}
	} catch (GCD::CanNotFindData&) {
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		throw GCI::IO::OperationError ();
	}	
	//#UC END# *4423FCB4029F_462CBA00032C*
}

// implemented method from GCI::IO::Stream
// Функция возвращает true если достигнут конец потока.
bool DataReadingStream_i::eof () const {
	//#UC START# *4433789401B5_462CBA00032C*
	return false;
	//#UC END# *4433789401B5_462CBA00032C*
}

// implemented method from GCI::IO::Stream
// Прочесть данные из потока, возвращает количество прочитанных байтов.
unsigned long DataReadingStream_i::read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/ {
	//#UC START# *4423FC9C0290_462CBA00032C*
	LOG_D (("START - %s", GDS_CURRENT_FUNCTION));
	Core::GDS::StopWatch sw ("DataReadingStream_i::read");

	try {
		if (size == 0) {
			return 0;
		} else {
			try {
				/*Core::Aptr<Core::GDS::StopWatchEx> sw;
				if (m_position==0) {
					sw = new Core::GDS::StopWatchEx ("DataReadingStream_i::read(first)", "DataReadingStream_i::read(first)");
				} else {
					sw = new Core::GDS::StopWatchEx ("DataReadingStream_i::read(next)", "DataReadingStream_i::read(next)");
				}*/

				GslDataPipe::PipeData_var pipe_data = m_data_reading->get_data (size);
				unsigned long result = pipe_data->length ();
				m_position += result;
				ACE_OS_String::memcpy (buffer, pipe_data->get_buffer (), result);

				return result;
			} catch (GCD::CanNotFindData&) {
				LOG_D (("%s: catch GCD::CanNotFindData", GDS_CURRENT_FUNCTION));
				return 0;
			}
		}
	} catch (...) {
		throw GCI::IO::OperationError ();
	}
	//#UC END# *4423FC9C0290_462CBA00032C*
}

// implemented method from GCI::IO::Stream
// Переместить маркер потока. Возвращает число байт от начала потока.
unsigned long DataReadingStream_i::seek (
	long offset
	, unsigned long whence
) /*throw (
	GCI::IO::OperationError
	, GCI::IO::NotImplemented
)*/ {
	//#UC START# *4423FCA9030D_462CBA00032C*
	// если просят текущее положение или сдвиг на начало потока, когда мы там стоим
	// возвращаем позицию
	if (!offset && (whence == GCI::IO::SSD_CURRENT)) {
		return m_position;
	} 
	if (!offset && (whence == GCI::IO::SSD_BEGIN) && !m_position) {
		return m_position;
	}

	throw GCI::IO::NotImplemented ();
	//#UC END# *4423FCA9030D_462CBA00032C*
}

// implemented method from GCI::IO::Stream
// Записать данные в поток. Возвращает количество записанных байтов.
unsigned long DataReadingStream_i::write (const void* buffer, unsigned long size) {
	//#UC START# *4423FCA20232_462CBA00032C*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4423FCA20232_462CBA00032C*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

