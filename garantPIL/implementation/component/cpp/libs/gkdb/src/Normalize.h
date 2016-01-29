//
// Normalize.h : header file
//

#ifndef __NORMALIZE_FOR_TOOLS_H
#define __NORMALIZE_FOR_TOOLS_H

#include "shared/Morpho/Facade/Factory.h"
#include "DBComm.h"

class Normalizer {
public:
	Normalizer () {
	}

	virtual ~Normalizer () {
	}

public:
	Morpho::Def::INormalizer* get_ptr (Base* base) {
		GUARD (m_mutex);

		if (m_normalizer.is_nil ()) {
			GDS_ASSERT (base);

			DBCore::IBase_var obj = DBCore::DBFactory::make (base);

			Morpho::Def::ICache_var cache = Morpho::Factory::make ();
			cache->load (obj.in (), true);

			m_normalizer = Morpho::Factory::make (cache.in ());
		}

		return m_normalizer.in ();
	}

	void release () {
		GUARD (m_mutex);
		m_normalizer.release ();
	}

private:
	Core::Mutex m_mutex;
	Morpho::Def::INormalizer_var m_normalizer;
};

typedef ACE_Singleton <Normalizer, ACE_SYNCH_RECURSIVE_MUTEX> NormalizerSingleton;

struct Lemmatize {
	static short execute (char* form, NContxtIndex* index) {
		short ret = -1;

		try {
			Morpho::Def::INormalizer* obj = NormalizerSingleton::instance ()->get_ptr (index->base);
			ret = (short)(obj->lemmatize (form, index->buff_Norm) & 0x7f);
		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}

		return ret;
	}
};

#endif // __NORMALIZE_FOR_TOOLS_H