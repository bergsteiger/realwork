////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/PositionsReader.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::PositionsReader
//
// Ридер позиций документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PositionsReader::PositionsReader (
	DBCore::Store* stream
	, unsigned char form
	, Def::Type type
	, bool has_form
	, DBCore::IIndex* index
)
//#UC START# *4EB943250344_BASE_INIT*
	: BaseReader (stream, index)
	, m_form (form)
	, m_type (type)
	, m_has_block (false)
	, m_has_form (has_form)
//#UC END# *4EB943250344_BASE_INIT*
{
	//#UC START# *4EB943250344_BODY*
	m_stream_length = (size_t) stream->Length ();
	//#UC END# *4EB943250344_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IDataStream
// получить данные
void PositionsReader::get (DBCore::ULongVector& data, const DBCore::Ref_& ref, const DBCore::ExtrPair& extr) {
	//#UC START# *512503AD023F_4EB9286D026A*
	GDS_ASSERT (ref.pos < m_stream_length);

	m_has_block = false;

	char* ptr = BaseReader::read (ref.length, (int) ref.pos);

	GDS_ASSERT (ref.length == BaseReader::get_length ());

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
			if (m_form != 255 && m_form != (unsigned char)(*ptr)) {
				++ptr;
				continue;
			}
			++ptr;
		} else if (m_form != 255 && m_form) {
			continue;
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
	//#UC END# *512503AD023F_4EB9286D026A*
}

// implemented method from DBCore::IDataStream
// найдена блочная позиция
bool PositionsReader::has_block () const {
	//#UC START# *51261E54004B_4EB9286D026A*
	return m_has_block;
	//#UC END# *51261E54004B_4EB9286D026A*
}
} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

