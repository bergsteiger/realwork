////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/Invoker.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::Invoker
//
// Invoker
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_INVOKER_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_INVOKER_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"

//#UC START# *54D0D4A000CB_CUSTOM_INCLUDES*
#include "garantCore/Search/Facade/Facade.h"
//#UC END# *54D0D4A000CB_CUSTOM_INCLUDES*

namespace Search {
namespace Searcher_i {

// Invoker
class Invoker {

	// singleton declaration
	typedef ACE_Singleton <Invoker, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Invoker, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static Invoker* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Invoker ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Mutex m_mutex;

//#UC START# *54D0D4A000CB*
public:
	void add (const std::string& key, const CallBack& call_back);
	void add (const std::string& key, const CallBackBase& call_back);

	bool is_exist (const std::string& key, bool use_base);

	SortedCollection* get (const QueryTag& tag, unsigned long doc_id);
	SortedCollection* get (SearchBase* base, const QueryTag& tag);

private:
	std::map <std::string, CallBack> m_data;
	std::map <std::string, CallBackBase> m_sp_data;
//#UC END# *54D0D4A000CB*
}; // class Invoker

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_INVOKER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

