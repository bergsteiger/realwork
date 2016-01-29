////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/InitList_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::InitList_i
//
// Реализация интерфейса IFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Filters_i/InitList_i.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/doccol.h"
#include "boost/lambda/lambda.hpp"

//#UC START# *52F0E0B5016E_CUSTOM_INCLUDES*
//#UC END# *52F0E0B5016E_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *52F0E0B5016E*
template <typename Item>
class GreaterEqual {
public:
	GreaterEqual (long val) : m_val (val) { }

	bool operator () (const Item& val) const {
		return val.DocId >= m_val;
	}
private:
	long m_val;
};

template <typename Item, std::ptrdiff_t page_size>
static bool is_contentment (SortedCollection* data, long val, MergeOp op, size_t& pos) {
	typedef fast_collection_iterator <Collection, Item, page_size> Iterator_;

	Iterator_ beg (data, pos), end (data, data->ItemCount);
	Iterator_ it = std::find_if (beg, end, GreaterEqual <Item> (val));

	pos += std::distance (beg, it);

	if (op == so_AND) {
		return (it != end && it->DocId == val);
	} else if (op == so_NOT) {
		return (it == end || it->DocId != val);
	}

	return (op == so_NOT);
}
//#UC END# *52F0E0B5016E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InitList_i::InitList_i (SortedCollection* in, MergeOp op)
//#UC START# *52F0E97902F5_BASE_INIT*
	: m_pos (0)
	, m_data (in)
	, m_op (op)
//#UC END# *52F0E97902F5_BASE_INIT*
{
	//#UC START# *52F0E97902F5_BODY*
	m_type = m_data->Tag ();
	//#UC END# *52F0E97902F5_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextSearch::Defs::IFilter
// check
bool InitList_i::check (ContextSearch::Defs::DocId val) {
	//#UC START# *52F0DBCD0015_52F0E0B5016E*
	if (m_pos < (size_t) m_data->ItemCount) {
		if (m_type == OT_DOCCOLLECTION) {
			typedef fast_collection_iterator <Collection, long, DOC_PAGE_SIZE> Iterator_;
			Iterator_ beg (m_data, m_pos), end (m_data, m_data->ItemCount);
			Iterator_ it = std::find_if (beg, end, boost::lambda::_1 >= (long) val);
			m_pos += std::distance (beg, it);

			if (m_op == so_AND) {
				return (it != end && *it == val);
			} else if (m_op == so_NOT) {
				return (it == end || *it != val);
			}
		} else if (m_type == OT_REFCOLLECTION || m_type == OT_PARASCOLLECTION) {
			return is_contentment <Ref, REF_PAGE_SIZE> (m_data, (long) val, m_op, m_pos);
		} else if (m_type == OT_RELECOLLECTION || m_type == OT_RELESUBCOLLECTION) {
			return is_contentment <RefwRele, REL_COL_PAGE_SIZE> (m_data, (long) val, m_op, m_pos);
		} else if (m_type == OT_CORRREFS_COLLECTION) {
			return is_contentment <CorrRef, CORRREFS_PAGE_SIZE> (m_data, (long) val, m_op, m_pos);
		} else if (m_type == OT_REFWEIGHTCOLLECTION) {
			return is_contentment <RefwWeight, REF_PAGE_SIZE> (m_data, (long) val, m_op, m_pos);
		} else {
			GDS_ASSERT (0);
			return true;
		}
	}

	return (m_op == so_NOT);
	//#UC END# *52F0DBCD0015_52F0E0B5016E*
}

// implemented method from ContextSearch::Defs::IFilter
// check
bool InitList_i::check () const {
	//#UC START# *54C79CD80220_52F0E0B5016E*
	if (m_op == so_AND) {
		return m_pos < (size_t) m_data->ItemCount;
	} 
	return true;
	//#UC END# *54C79CD80220_52F0E0B5016E*
}

// implemented method from ContextSearch::Defs::IFilter
// создать дубликат
ContextSearch::Defs::IFilter* InitList_i::duplicate () {
	//#UC START# *55AE33BF00FA_52F0E0B5016E*
	return new InitList_i (m_data, m_op);
	//#UC END# *55AE33BF00FA_52F0E0B5016E*
}

// implemented method from ContextSearch::Defs::IFilter
// logic op
char InitList_i::get_op () const {
	//#UC START# *5346BB1D01FE_52F0E0B5016E*
	return m_op;
	//#UC END# *5346BB1D01FE_52F0E0B5016E*
}

// implemented method from ContextSearch::Defs::IFilter
// size
size_t InitList_i::get_size () const {
	//#UC START# *530C97AC02C4_52F0E0B5016E*
	return (size_t) m_data->ItemCount;
	//#UC END# *530C97AC02C4_52F0E0B5016E*
}

// implemented method from ContextSearch::Defs::IFilter
// reset
void InitList_i::reset () {
	//#UC START# *52FC982D009E_52F0E0B5016E*
	m_pos = 0;
	//#UC END# *52FC982D009E_52F0E0B5016E*
}

// implemented method from ContextSearch::Defs::IFilter
// type
const char* InitList_i::type () const {
	//#UC START# *52FCA10A026E_52F0E0B5016E*
	return "InitList";
	//#UC END# *52FCA10A026E_52F0E0B5016E*
}
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

