////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/Invoker.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::Invoker
//
// Invoker
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Searcher_i/Invoker.h"

//#UC START# *54D0D4A000CB_CUSTOM_INCLUDES*
//#UC END# *54D0D4A000CB_CUSTOM_INCLUDES*

namespace Search {
namespace Searcher_i {

//#UC START# *54D0D4A000CB*
void Invoker::add (const std::string& key, const CallBack& call_back) {
	GUARD (m_mutex);
	m_data [key] = call_back;
}

void Invoker::add (const std::string& key, const CallBackBase& call_back) {
	GUARD (m_mutex);
	m_sp_data [key] = call_back;
}

bool Invoker::is_exist (const std::string& key, bool use_base) {
	if (use_base) {
		std::map <std::string, CallBackBase>::const_iterator it = m_sp_data.find (key);
		return (it != m_sp_data.end ());
	}

	std::map <std::string, CallBack>::const_iterator it = m_data.find (key);
	return (it != m_data.end ());
}

SortedCollection* Invoker::get (const QueryTag& tag, unsigned long doc_id) {
	std::map <std::string, CallBack>::const_iterator it = m_data.find (tag.key);
	if (it != m_data.end ()) {
		return (it->second) (tag.val, doc_id);
	}
	return 0;
}

SortedCollection* Invoker::get (SearchBase* base, const QueryTag& tag) {
	std::map <std::string, CallBackBase>::const_iterator it = m_sp_data.find (tag.key);
	if (it != m_sp_data.end ()) {
		return (it->second) (base, tag.val);
	}
	return 0;
}
//#UC END# *54D0D4A000CB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Invoker::Invoker ()
//#UC START# *54D0D64302B9_BASE_INIT*
//#UC END# *54D0D64302B9_BASE_INIT*
{
	//#UC START# *54D0D64302B9_BODY*
	//#UC END# *54D0D64302B9_BODY*
}


} // namespace Searcher_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

