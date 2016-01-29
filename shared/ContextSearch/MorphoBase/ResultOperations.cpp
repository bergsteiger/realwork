////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/ResultOperations.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::ResultOperations
//
// Операции с векторами релевантных документов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/ResultOperations.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "boost/bind.hpp"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// пересечение двух контейнеров с результатами поисков
Search::RelevancyDocuments* ResultOperations::intersection (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y) {
	//#UC START# *4BAB5A4000A0*
	Core::Aptr <Search::RelevancyDocuments> ret = new Search::RelevancyDocuments (
		std::min (x.size (), y.size ())
	);

	Search::RelevancyDocuments::iterator it = std::set_intersection (
		x.begin (), x.end (), y.begin (), y.end (), ret->begin ()
	);

	ret->erase (it, ret->end ());

	Search::RelevancyDocuments::const_iterator find_it = y.begin (), find_end = y.end ();

	for (it = ret->begin (); it != ret->end (); ++it) {
		find_it = std::lower_bound (find_it, find_end, *it);

		if (find_it != find_end) {
			it->info.relevancy_value += find_it->info.relevancy_value;

			if ((it->info.position & ContextSearch::POS_TEXT) <= ContextSearch::DOC_BEGIN_WORD) {
				it->info.position = find_it->info.position;
			}
		}
	}

	return ret._retn ();
	//#UC END# *4BAB5A4000A0*
}

// мердж двух контейнеров с результатами поисков
Search::RelevancyDocuments* ResultOperations::merge (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y) {
	//#UC START# *4BAB5A0202BE*
	Core::Aptr <Search::RelevancyDocuments> ret = new Search::RelevancyDocuments (x.size () + y.size ());

	std::merge (x.begin (), x.end (), y.begin (), y.end (), ret->begin ());

	Defs::Position pos, next_pos;
	Defs::RelevancyType value, next_value;

	Search::RelevancyDocuments::iterator it = ret->begin (), it_end = ret->end (), it_next;

	for (; it != it_end; ++it) {
		it_next = it + 1;

		if (it_next != it_end && it->doc_id == it_next->doc_id) {
			value = it->info.relevancy_value;
			next_value = it_next->info.relevancy_value;

			pos = it->info.position & POS_TEXT;
			next_pos = it_next->info.position & POS_TEXT;

			if (value < next_value || (value == next_value && pos > next_pos)) {
				it->doc_id = 0;
			} else {
				it_next->doc_id = 0;
			}

			++it;
		}
	}

	it = std::remove_if (ret->begin (), ret->end ()
		, boost::bind (std::equal_to <DBComm::DocId> ()
		, boost::bind (&Defs::RelevancyDocInfo::doc_id, _1), 0)
	);

	ret->erase (it, ret->end ());

	return ret._retn ();
	//#UC END# *4BAB5A0202BE*
}

// объединение двух контейнеров с результатами поисков
Search::RelevancyDocuments* ResultOperations::union_ (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y) {
	//#UC START# *4BAB596A01E7*
	Core::Aptr <Search::RelevancyDocuments> ret = new Search::RelevancyDocuments (x.size () + y.size ());

	std::set_union (x.begin (), x.end (), y.begin (), y.end (), ret->begin ());

	return ret._retn ();
	//#UC END# *4BAB596A01E7*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

