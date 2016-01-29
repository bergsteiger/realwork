////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/LoadList_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::LoadList_i
//
// Реализация интерфейса IFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Filters_i/LoadList_i.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"

//#UC START# *52FA456D02C7_CUSTOM_INCLUDES*
//#UC END# *52FA456D02C7_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *52FA456D02C7*
//#UC END# *52FA456D02C7*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const int LoadList_i::ItemCount = 16384; // количество элементов

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadList_i::LoadList_i (Index* index, const char* key, MergeOp op)
//#UC START# *52FA549C0336_BASE_INIT*
	: m_item_size (0)
	, m_index (index)
	, m_op (op)
//#UC END# *52FA549C0336_BASE_INIT*
{
	//#UC START# *52FA549C0336_BODY*
	m_store = m_index->Index::OpenN (key, 0);

	long data_type = GetDataType (m_index);

	if (data_type == SDT_DOCS) {
		m_item_size = sizeof (long);
	} else if (data_type == SDT_REFS) {
		m_item_size = sizeof (Ref);
	} else {
		GDS_ASSERT (0);
	}

	this->reset ();
	//#UC END# *52FA549C0336_BODY*
}

LoadList_i::~LoadList_i () {
	//#UC START# *52FA456D02C7_DESTR_BODY*
	if (m_store) {
		m_index->Close (m_store);
	}
	//#UC END# *52FA456D02C7_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// загрузка
bool LoadList_i::load () {
	//#UC START# *52FB722B03B3*
	if (m_total >= (size_t) m_store->Length ()) {
		m_stop = true;
		return false;
	}

	const int BUF_SIZE = m_item_size * ItemCount;

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buf = new char [BUF_SIZE + 1];
	long len = m_store->Read (buf.inout (), BUF_SIZE);

	GDS_ASSERT (len >= 0);

	size_t size = (size_t) len;

	m_total += size;
	m_data.resize (size / m_item_size);

	SearchAdapterLib::Adapter::LongVector::iterator it = m_data.begin (), it_end = m_data.end ();

	for (const char* ptr = buf.ptr (); it != it_end; ++it, ptr += m_item_size) {
		*it = *(long*) ptr;
	}

	m_last_id = m_data.back ();
	return true;
	//#UC END# *52FB722B03B3*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextSearch::Defs::IFilter
// check
bool LoadList_i::check (ContextSearch::Defs::DocId val) {
	//#UC START# *52F0DBCD0015_52FA456D02C7*
	while (val > m_last_id) {
		if (this->load () == false) {
			break;
		}
	}

	if (m_op == so_AND) {
		return std::binary_search (m_data.begin (), m_data.end (), (long) val);
	} else if (m_op == so_NOT) {
		return !std::binary_search (m_data.begin (), m_data.end (), (long) val);
	}

	return true;
	//#UC END# *52F0DBCD0015_52FA456D02C7*
}

// implemented method from ContextSearch::Defs::IFilter
// check
bool LoadList_i::check () const {
	//#UC START# *54C79CD80220_52FA456D02C7*
	if (m_op == so_AND) {
		return !m_stop;
	}
	return true;
	//#UC END# *54C79CD80220_52FA456D02C7*
}

// implemented method from ContextSearch::Defs::IFilter
// создать дубликат
ContextSearch::Defs::IFilter* LoadList_i::duplicate () {
	//#UC START# *55AE33BF00FA_52FA456D02C7*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *55AE33BF00FA_52FA456D02C7*
}

// implemented method from ContextSearch::Defs::IFilter
// logic op
char LoadList_i::get_op () const {
	//#UC START# *5346BB1D01FE_52FA456D02C7*
	return m_op;
	//#UC END# *5346BB1D01FE_52FA456D02C7*
}

// implemented method from ContextSearch::Defs::IFilter
// size
size_t LoadList_i::get_size () const {
	//#UC START# *530C97AC02C4_52FA456D02C7*
	return (m_store == 0)? 0 : m_store->Length () / m_item_size;
	//#UC END# *530C97AC02C4_52FA456D02C7*
}

// implemented method from ContextSearch::Defs::IFilter
// reset
void LoadList_i::reset () {
	//#UC START# *52FC982D009E_52FA456D02C7*
	m_stop = false;
	m_total = 0;
	m_last_id = 0;

	if (m_store) {
		m_store->Seek (0);
	}
	//#UC END# *52FC982D009E_52FA456D02C7*
}

// implemented method from ContextSearch::Defs::IFilter
// type
const char* LoadList_i::type () const {
	//#UC START# *52FCA10A026E_52FA456D02C7*
	return "LoadList";
	//#UC END# *52FCA10A026E_52FA456D02C7*
}
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

