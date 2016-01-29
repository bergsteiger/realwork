////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/StreamReader.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::StreamReader
//
// StreamReader
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Readers/StreamReader.h"

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const size_t StreamReader::BUFFER_SIZE = 0x10000; // размер буффера данных для чтения документов

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StreamReader::StreamReader (DBCore::Store* stream, DBCore::IIndex* index)
//#UC START# *4EB94332035D_BASE_INIT*
	: BaseReader (stream, index)
	, m_tail (0)
//#UC END# *4EB94332035D_BASE_INIT*
{
	//#UC START# *4EB94332035D_BODY*
	//#UC END# *4EB94332035D_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вычисление doc_id по заданной позиции в стриме
bool StreamReader::get_id (size_t pos, DBCore::Ref_& ref, long& res) {
	//#UC START# *4F2FECDF0254*
	if (pos == 0) {
		// читаем doc_id и следущую позицию для вычисление длины
		char* ptr = BaseReader::read (8, 0);

		res = *(long*) (ptr);

		if ((long) ref.doc_id == res) {
			ref.pos = 0;
			ref.length = ((long*) ptr) [1];
			return true;
		} 
	} else {
		// читаем doc_id и окружение из позиций для вычисление длины
		char* ptr = BaseReader::read (12, (int) pos - 4);

		res = *(long*) (ptr + 4);

		if ((long) ref.doc_id == res) {
			ref.pos = *(long*) ptr;
			ptr += 4;
			ref.length = ((long*) ptr) [1] - ref.pos;
			return true;
		}
	}

	GDS_ASSERT (res >= 0);
	return false;
	//#UC END# *4F2FECDF0254*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IRefStream
// длина
unsigned long StreamReader::get_length () const {
	//#UC START# *5126190F02FB_4EB928A102FE*
	return BaseReader::get_stream_length ();
	//#UC END# *5126190F02FB_4EB928A102FE*
}

// implemented method from DBCore::IRefStream
// прочитать следующую порцию данных
bool StreamReader::get_next (DBCore::Ref_& ref, long border) {
	//#UC START# *512505930277_4EB928A102FE*
	if (ref.doc_id) {
		for (; ; m_ptr += 8, m_tail -= 8) {
			ref.pos = *(long*) (m_ptr - 4);

			if (m_tail == 0) {
				m_ptr = BaseReader::read_more ();
				m_tail = BaseReader::get_length ();

				if (m_ptr == 0) {
					return false;
				}
			}

			if (*(long*) m_ptr >= border) {
				break;
			}
		}
	} else {
		GDS_ASSERT (m_tail == 0);

		m_ptr = BaseReader::read (BUFFER_SIZE, -1);
		m_tail = BaseReader::get_length ();

		GDS_ASSERT (m_ptr);
	} 

	ref.doc_id = *(long*) m_ptr;
	ref.length = ((long*) m_ptr) [1] - ref.pos;

	m_ptr += 8;
	m_tail -= 8;

	return true;
	//#UC END# *512505930277_4EB928A102FE*
}

// implemented method from DBCore::IRefStream
// текущая позиция
unsigned long StreamReader::get_tell () const {
	//#UC START# *5126193E0054_4EB928A102FE*
	return (BaseReader::get_tell () - m_tail);
	//#UC END# *5126193E0054_4EB928A102FE*
}

// implemented method from DBCore::IRefStream
// поиск заданного документа
bool StreamReader::search (DBCore::Ref_& ref) {
	//#UC START# *51261FF002B3_4EB928A102FE*
	size_t stream_length = BaseReader::get_stream_length ();

	GDS_ASSERT (stream_length);

	size_t width = 8, num = stream_length / width;
	size_t half, mid, lo = 0, hi = stream_length - width;

	long res;

	while (lo <= hi) {
		if ((half = num / 2) != 0) {
			mid = lo + (num & 1 ? half : (half - 1)) * width;

			if (this->get_id (mid, ref, res)) {
				return true;
			} else if (ref.doc_id < (unsigned long) res) {
				hi = mid - width;
				num = num & 1 ? half : half - 1;
			} else {
				lo = mid + width;
				num = half;
			}
		} else if (num) {
			return this->get_id (lo, ref, res);
		} else {
			break;
		}
	}

	return false;
	//#UC END# *51261FF002B3_4EB928A102FE*
}
} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

