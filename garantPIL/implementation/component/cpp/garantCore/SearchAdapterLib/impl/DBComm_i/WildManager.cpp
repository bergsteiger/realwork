////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/WildManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::WildManager
//
// Менеджер для поиска всех форм слова, указанного с '*'
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/WildManager.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"

namespace SearchAdapterLib {
namespace DBComm_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

WildManager::WildManager (DBCore::IBase* base, const GCL::StrVector& request)
//#UC START# *4ED4899D0086_BASE_INIT*
//#UC END# *4ED4899D0086_BASE_INIT*
{
	//#UC START# *4ED4899D0086_BODY*
	DBCore::IIndex_var index = base->make ("NFContxt");

	m_wilds.resize (request.size ());

	for (size_t i = 0; i < m_wilds.size (); ++i) {
		if (m_wilds [i].init (request [i], index.in ())) {
			m_best_wild = i;
		}
	}
	//#UC END# *4ED4899D0086_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// получить запрос
void WildManager::get_request (std::string& out) {
	//#UC START# *4ED48BF6001F*
	out.clear ();

	for (Wilds::const_iterator it = m_wilds.begin (); it != m_wilds.end (); ++it) {
		if (out.size ()) {
			out += ' ';
		}
		out += it->key ();
	}
	//#UC END# *4ED48BF6001F*
}

// перейти к следующему
bool WildManager::next (int& set_value) {
	//#UC START# *4ED48BA502DF*
	set_value = -1;

	std::vector <WildIterator>::iterator it = std::find_if (
		m_wilds.begin (), m_wilds.end (), boost::bind (&WildIterator::is_best, _1)
	);

	if (it != m_wilds.end ()) {
		it->next ();

		if (it != m_wilds.begin ()) {
			std::for_each (m_wilds.begin (), it - 1, boost::bind (&WildIterator::rewind, _1));
		}

		if (std::distance (m_wilds.begin (), it) == m_best_wild) {
			set_value = (it->get_count () * 100) / it->get_max_count ();
		}
	}

	return (it != m_wilds.end ());
	//#UC END# *4ED48BA502DF*
}

} // namespace DBComm_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

