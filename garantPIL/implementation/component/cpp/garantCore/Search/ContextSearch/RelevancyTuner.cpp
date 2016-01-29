////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/RelevancyTuner.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::RelevancyTuner
//
// Класс для изменения значения релевантности в списке найденных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/ContextSearch/RelevancyTuner.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const short RelevancyTuner::CODE_FACTOR = 20; // за CODE
const short RelevancyTuner::TYPE_FACTOR = 10; // за TYPE

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// добавка для типа
short RelevancyTuner::get_value (SearchAdapterLib::Adapter::TuneDocType type) {
	//#UC START# *554CE8A50003*
	switch (type) {
		case ContextSearch::Defs::dt_CODE:
			return CODE_FACTOR;
		case ContextSearch::Defs::dt_TYPE:
			return TYPE_FACTOR;
	}

	GDS_ASSERT (0);
	return 0;
	//#UC END# *554CE8A50003*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RelevancyTuner::RelevancyTuner (SearchAdapterLib::Adapter::IRelevancyInfo* collector)
//#UC START# *5400416D0009_BASE_INIT*
	: m_info_collector (collector)
//#UC END# *5400416D0009_BASE_INIT*
{
	//#UC START# *5400416D0009_BODY*
	//#UC END# *5400416D0009_BODY*
}

RelevancyTuner::~RelevancyTuner () {
	//#UC START# *533EB4BE00E2_DESTR_BODY*
	//#UC END# *533EB4BE00E2_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// выполнить
void RelevancyTuner::execute (
	RefwReleCollection* result
	, const SearchAdapterLib::Adapter::RelTuneData& data
	, SearchAdapterLib::Adapter::TuneDocType type
) const {
	//#UC START# *53836CCE02C4*
	if (result == 0 || result->ItemCount == 0) {
		return;
	}

	typedef fast_collection_iterator <SortedCollection, RefwRele, REL_COL_PAGE_SIZE> Iterator_;

	Iterator_ cur (result, 0);
	Iterator_ end (result, result->ItemCount);

	SearchAdapterLib::Adapter::RelTuneData::const_iterator it = data.begin (), it_end = data.end ();

	for (; cur != end && it != it_end;) {
		if (cur->DocId > (long) it->id) {
			++it;
		} else if (cur->DocId < (long) it->id) {
			++cur;
		} else {
			cur->Rele += it->rel;

			if (cur->Rele < 0) { 
				cur->Rele = 0; 
			}

			if (m_info_collector) {
				m_info_collector->add (it->id, type, it->rel);
			}

			++it;
			++cur;
		}
	}
	//#UC END# *53836CCE02C4*
}

// выполнить
void RelevancyTuner::execute (
	RefwReleCollection* result
	, const DocVector& data
	, SearchAdapterLib::Adapter::TuneDocType type
) const {
	//#UC START# *554CE500018A*
	if (result == 0 || result->ItemCount == 0) {
		return;
	}

	typedef fast_collection_iterator <SortedCollection, RefwRele, REL_COL_PAGE_SIZE> Iterator_;

	Iterator_ cur (result, 0);
	Iterator_ end (result, result->ItemCount);

	DocVector::const_iterator it = data.begin (), it_end = data.end ();

	for (; cur != end && it != it_end;) {
		if (cur->DocId > (long) *it) {
			++it;
		} else if (cur->DocId < (long) *it) {
			++cur;
		} else {
			short value = RelevancyTuner::get_value (type);
			cur->Rele += value;

			if (cur->Rele < 0) { 
				cur->Rele = 0; 
			}

			if (m_info_collector) {
				m_info_collector->add (*it, type, value);
			}

			++it;
			++cur;
		}
	}
	//#UC END# *554CE500018A*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

