////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/SpansQuery.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::SpansQuery
//
// Спаны
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Search_i/SpansQuery.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"

namespace ContextSearch {
namespace Search_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SpansQuery::SpansQuery (const GCL::StrVector& spans, const Search::AlgorithmProperties& prop)
//#UC START# *520902E801FB_BASE_INIT*
//#UC END# *520902E801FB_BASE_INIT*
{
	//#UC START# *520902E801FB_BODY*
	for (GCL::StrVector::const_iterator it = spans.begin (); it != spans.end (); ++it) {
		m_data.push_back (SpanQuery (*it, prop));
	}
	//#UC END# *520902E801FB_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// очистить кэш спанов
void SpansQuery::clear () {
	//#UC START# *5238778D0277*
	std::for_each (m_data.begin (), m_data.end (), boost::bind (&SpanQuery::clear, _1));
	//#UC END# *5238778D0277*
}

// данные
SpansQuery::Spans& SpansQuery::get () {
	//#UC START# *526A693802D5*
	return m_data;
	//#UC END# *526A693802D5*
}

// вычислить значение для прогресс-индикатора
size_t SpansQuery::get_prog_value () {
	//#UC START# *528238CA03A5*
	for (Spans::iterator it = m_data.begin (); it != m_data.end (); ++it) {
		if (*it == DBComm::NULL_DOC_ID) {
			continue;
		} else {
			size_t val = it->get_prog_value ();

			if (val) {
				return val;
			}
		}
	}

	return 0;
	//#UC END# *528238CA03A5*
}

// поиск
bool SpansQuery::next (DBComm::DocId border, Search::DocIdPair& out) {
	//#UC START# *520903040374*
	DBComm::DocId doc_id, result = DBComm::INFINITE_DOC_ID;

	Spans::iterator it = m_data.begin (), it_end = m_data.end ();

	for (; it != it_end; ++it) {
		if (*it == DBComm::NULL_DOC_ID) {
			continue;
		} else {
			doc_id = it->get_next (border);

			if (doc_id != DBComm::NULL_DOC_ID && doc_id < result) {
				result = doc_id;
			}
		}
	}

	if (result == DBComm::INFINITE_DOC_ID) {
		return false;
	}

	if (result > out.max_id) {
		out.max_id = result;
	}

	if (result < out.min_id) {
		out.min_id = result;
	}

	return true;
	//#UC END# *520903040374*
}

// поиск документа
bool SpansQuery::search_doc (DBComm::DocId id) {
	//#UC START# *538C8F650156*
	bool ret = false;

	Spans::iterator it = m_data.begin (), it_end = m_data.end ();

	for (; it != it_end; ++it) {
		ret |= it->search_doc (id);
	}

	return ret;
	//#UC END# *538C8F650156*
}

} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

