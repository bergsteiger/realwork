//
// Cache.h : header file
//

#ifndef __MORPHO_CACHE_H__
#define __MORPHO_CACHE_H__

#include "shared/Morpho/Facade/Factory.h"

namespace Morpho {

class Cache {
	typedef ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Cache, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	static Cache* instance () {
		return Singleton::instance ();
	}

protected:
	Cache () {
		m_cache = Factory::make ();
	}

public:
	void load (DBCore::IBase* base) {
		m_cache->load (base);
	}

	void release () {
		m_cache->clear ();
	}

	Def::ICache* get (DBCore::IBase* base) {
		m_cache->load (base);
		return m_cache.in ();
	}

	Def::ICache* get () {
		return m_cache.in ();
	}

private:
	Def::ICache_var m_cache;
};

static void load_cache (DBCore::IBase* base) {
	Cache::instance ()->load (base);
}

static void release_cache () {
	Cache::instance ()->release ();
}

static Def::ICache* get_cache (DBCore::IBase* base) {
	return Cache::instance ()->get (base);
}

static Def::ICache* get_cache () {
	return Cache::instance ()->get ();
}

} // namespace Morpho

#endif // __MORPHO_CACHE_H__
