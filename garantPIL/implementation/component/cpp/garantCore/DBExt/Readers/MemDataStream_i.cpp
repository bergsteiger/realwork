////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/MemDataStream_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::MemDataStream_i
//
// MemDataStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Readers/MemDataStream_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MemDataStream_i::MemDataStream_i (const char* data, int length, Def::Type type, bool has_form)
//#UC START# *515AF29A0315_BASE_INIT*
	: m_data (data)
	, m_length (length)
	, m_type (type)
	, m_has_block (false)
	, m_has_form (has_form)
//#UC END# *515AF29A0315_BASE_INIT*
{
	//#UC START# *515AF29A0315_BODY*
	GDS_ASSERT (length > 0)
	//#UC END# *515AF29A0315_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IDataStream
// получить данные
void MemDataStream_i::get (DBCore::ULongVector& data, const DBCore::Ref_& ref, const DBCore::ExtrPair& extr) {
	//#UC START# *512503AD023F_515AF262020C*
	GDS_ASSERT (ref.pos + ref.length <= m_length);

	m_has_block = false;

	const char* ptr = m_data + ref.pos;
	long cur = 0, pre = 0, at_cur, pos, flags;

	do {
		cur = *(long*) ptr;

		if (cur & Def::IS_3_BYTES) {
			at_cur = (((cur & 0xff0000) >> 2) | (cur & 0x3fff));
			ptr += 3;
		} else {
			at_cur = cur & 0x3fff;
			ptr += 2;
		}

		pos = (at_cur + pre) >> 2;
		flags = ((at_cur + pre) & 3) << 20;

		pre += at_cur & 0x3ffffc;

		if (m_has_form) {
			++ptr;
		} 

		if (m_type == Def::dt_Text) {
			if (pos <= ContextSearch::DOC_BEGIN_WORD) {
				continue;
			}
		} else if (m_type == Def::dt_Title) {
			if (pos > ContextSearch::DOC_BEGIN_WORD) {
				break;
			}
		}

		if (flags == ContextSearch::POS_INVISIBLE_BLOCK) {
			m_has_block = true;
		} else if (extr.max > 0) {
			if (extr.min > pos) {
				continue;
			} else if (extr.max < pos) {
				break;
			}
		}

		data.push_back (flags + pos);
	} while ((cur & Def::END_PORTION) == 0);
	//#UC END# *512503AD023F_515AF262020C*
}

// implemented method from DBCore::IDataStream
// найдена блочная позиция
bool MemDataStream_i::has_block () const {
	//#UC START# *51261E54004B_515AF262020C*
	return m_has_block;
	//#UC END# *51261E54004B_515AF262020C*
}
} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

