////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/CacheMap.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::CacheMap
//
// менеджер кеша для членов данных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_CACHEMAP_H__
#define __SHARED_CORE_MNG_CACHEMAP_H__

#include "ace/ACE.h"
#include "shared/Core/sys/synch.h"

//#UC START# *4500154A03C8_USER_INCLUDES*
#include <map>
#include <deque>
//#UC END# *4500154A03C8_USER_INCLUDES*

namespace Core {

//#UC START# *4500154A03C8_USER_DEFINITION*

template <class _Key, class _Data, class _Loader>
class CacheMap {
public:
	typedef std::map<_Key, _Data> Cache;

	CacheMap () : m_cached_it (m_map.end ()) {
	}

	const _Data& get_value (const _Key& key) const {
		GUARD (m_mutex);

		if (m_cached_it == m_map.end () || m_cached_it->first != key) {
			m_cached_it = m_map.find (key);
			if (m_cached_it == m_map.end ()) {
				m_cached_it = m_map.insert (typename Cache::value_type (key, _Loader::load_value (key))).first;
			}
		}
		assert (m_cached_it->first == key);
		return m_cached_it->second;
	}

	void invalidate (const _Key& key) {
		GUARD (m_mutex);

		if (m_cached_it != m_map.end () && m_cached_it->first == key) {
			m_cached_it = m_map.end ();
		}
		m_map.erase (key);
	}

private:
	mutable Core::Mutex m_mutex;

	mutable Cache m_map;
	mutable typename Cache::iterator m_cached_it;
};
//#UC END# *4500154A03C8_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_CACHEMAP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
