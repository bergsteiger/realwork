////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/MemRefStream_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::MemRefStream_i
//
// MemRefStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Readers/MemRefStream_i.h"

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MemRefStream_i::MemRefStream_i (const char* data, int length)
//#UC START# *515AD9FE0124_BASE_INIT*
	: m_ptr (data)
	, m_length (length)
	, m_pos (0)
//#UC END# *515AD9FE0124_BASE_INIT*
{
	//#UC START# *515AD9FE0124_BODY*
	//#UC END# *515AD9FE0124_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вычисление doc_id по заданной позиции в стриме
bool MemRefStream_i::get_id (size_t pos, DBCore::Ref_& ref, long& res) {
	//#UC START# *52E640C200B7*
	if (pos == 0) {
		// читаем doc_id и следущую позицию для вычисление длины
		const char* ptr = m_ptr;

		res = *(long*) (ptr);

		if ((long) ref.doc_id == res) {
			ref.pos = 0;
			ref.length = ((long*) ptr) [1];
			return true;
		} 
	} else {
		// читаем doc_id и окружение из позиций для вычисление длины
		const char* ptr = m_ptr + (pos - 4);

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
	//#UC END# *52E640C200B7*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IRefStream
// длина
unsigned long MemRefStream_i::get_length () const {
	//#UC START# *5126190F02FB_515AD387034C*
	return m_length;
	//#UC END# *5126190F02FB_515AD387034C*
}

// implemented method from DBCore::IRefStream
// прочитать следующую порцию данных
bool MemRefStream_i::get_next (DBCore::Ref_& ref, long border) {
	//#UC START# *512505930277_515AD387034C*
	if (m_pos >= m_length) {
		return false;
	}

	if (ref.doc_id) {
		for (; ; m_ptr += 8, m_pos += 8) {
			if (m_pos >= m_length) {
				return false;
			}

			ref.pos = *(long*) (m_ptr - 4);

			if (*(long*) m_ptr >= border) {
				break;
			}
		}
	} else {
		GDS_ASSERT (m_ptr);
	} 

	ref.doc_id = *(long*) m_ptr;
	ref.length = ((long*) m_ptr) [1] - ref.pos;

	m_ptr += 8;
	m_pos += 8;

	return true;
	//#UC END# *512505930277_515AD387034C*
}

// implemented method from DBCore::IRefStream
// текущая позиция
unsigned long MemRefStream_i::get_tell () const {
	//#UC START# *5126193E0054_515AD387034C*
	return m_pos;
	//#UC END# *5126193E0054_515AD387034C*
}

// implemented method from DBCore::IRefStream
// поиск заданного документа
bool MemRefStream_i::search (DBCore::Ref_& ref) {
	//#UC START# *51261FF002B3_515AD387034C*
	GDS_ASSERT (m_length);

	size_t stream_length = m_length;
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
	//#UC END# *51261FF002B3_515AD387034C*
}
} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

