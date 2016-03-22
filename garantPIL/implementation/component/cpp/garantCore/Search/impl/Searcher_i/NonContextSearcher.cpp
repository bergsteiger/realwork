////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/NonContextSearcher.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::NonContextSearcher
//
// Неконтекстный поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Searcher_i/NonContextSearcher.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "garantCore/Search/impl/Searcher_i/SearchHelper.h"
#include "shared/GCL/str/str_conv.h"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/split.hpp"

namespace Search {
namespace Searcher_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NonContextSearcher::NonContextSearcher (SearchBase* base)
//#UC START# *50BF7C9203D2_BASE_INIT*
	: StorageData (base)
	, m_base (base)
//#UC END# *50BF7C9203D2_BASE_INIT*
{
	//#UC START# *50BF7C9203D2_BODY*
	//#UC END# *50BF7C9203D2_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// поиск
SortedCollection* NonContextSearcher::find (const QueryTag& tag, unsigned long doc_id) {
	//#UC START# *50D1D25600B3*
	if (doc_id) {
		if (tag.key.at (0) == '!') {
			return m_base->get_virtualindex_doc (tag.key.c_str (), tag.val.c_str (), doc_id);
		} else {
			return m_base->get_realindex_doc (tag.key, tag.val, doc_id);
		}
	} 

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > key = SearchHelper::make_key (m_base, tag);

	if (key.is_nil () == false) {
		return StorageData::get (tag.key.c_str (), key.in ());
	} 

	GDS_ASSERT_MSG (false, ("%s: invalid index (%s) or key (%s)", GDS_CURRENT_FUNCTION, tag.key.c_str (), tag.val.c_str ()));
	return 0;
	//#UC END# *50D1D25600B3*
}

// поиск шаблона
SortedCollection* NonContextSearcher::find_pattern (const QueryTag& tag) {
	//#UC START# *50D1D2AF01AB*
	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > key = SearchHelper::make_key (m_base, tag);

	if (key.is_nil () == false) {
		std::string from (key.in (), strlen (key.in ()) - 1);

		GCL::to_upper (from);

		std::string to = from + "\xFF";

		GDS_ASSERT (GetDataType (tag.key.c_str ()) == SDT_DOCS);

		StorageData::add (tag.key.c_str (), from.c_str (), to.c_str ());
		return StorageData::_retn ();
	}

	GDS_ASSERT_MSG (false, ("%s: invalid index (%s) or key (%s)", GDS_CURRENT_FUNCTION, tag.key.c_str (), tag.val.c_str ()));
	return 0;
	//#UC END# *50D1D2AF01AB*
}

// поиск в диапазоне дат
SortedCollection* NonContextSearcher::find_range (const QueryTag& tag, unsigned long doc_id) {
	//#UC START# *50D1D28F00B8*
	std::string val = tag.val;
	val.erase (std::remove (val.begin (), val.end (), ' '), val.end ());

	std::vector <std::string> parts;
	boost::split (parts, val, boost::is_any_of (";"));

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > from, to;

	if (parts.size () == 2) {
		from = SearchHelper::make_date_key (parts [0]);
		to = SearchHelper::make_date_key (parts [1]);
	}

	if (from.is_nil () && to.is_nil ()) {
		GDS_ASSERT (0);
		return 0;
	}

	if (doc_id) {
		return m_base->get_realindex_doc (tag.key, val, doc_id);
	} 
	
	if (tag.key == "CalAll") {
		const char* names [] = {"CalIn", "CalAb", "CalCh", 0};
		std::for_each (names, names + 3, boost::bind (&StorageData::add, this, _1, from.in (), to.in ()));
	} else {
		StorageData::add (tag.key.c_str (), from.in (), to.in ());
	}

	return StorageData::_retn ();
	//#UC END# *50D1D28F00B8*
}

} // namespace Searcher_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

