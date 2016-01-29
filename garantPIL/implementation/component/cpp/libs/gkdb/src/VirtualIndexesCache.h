//
// VirtualIndexesCache.h : header file
//

#ifndef __VIRTUAL_INDEXES_CACHE_H
#define __VIRTUAL_INDEXES_CACHE_H

#include "shared/Core/sys/std_inc.h"

#include "boost/utility/string_ref.hpp"
#include "boost/tuple/tuple.hpp"

#include "base.h"

typedef std::pair <std::string, std::vector <short> > KeyWithSegments;
typedef std::vector <KeyWithSegments> KeysWithSegments;

typedef	boost::tuple <boost::string_ref, boost::string_ref, const std::vector <short>*> syns_data;
typedef	std::vector <syns_data> vector_of_syns;
typedef	std::vector <std::pair<boost::string_ref, vector_of_syns> > key_syns;
typedef std::map <boost::string_ref, key_syns> virtualindex_names_container;

class VirtualIndexesCache {
	typedef ACE_Singleton <VirtualIndexesCache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <VirtualIndexesCache, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	static VirtualIndexesCache* instance () {
		return Singleton::instance ();
	}

public:
	void load (Base* base);
	void release ();

	const virtualindex_names_container& get_virtual_index_name_keys () const {
		return m_virtual_index_name_keys;
	}

private:
	void load_virtual_indexes (Base* base);
	void load_keys_for_segments (Base* base);

	const std::vector <short>* segs (const boost::string_ref& key, const boost::string_ref& value);

private:
	typedef std::vector <char> virtualindex_vector;
	typedef std::map <std::string, KeysWithSegments> IndexToKeysWithSegments;

	Core::Mutex m_mutex;

	IndexToKeysWithSegments m_index_name_map_key_segs;

	virtualindex_vector m_virtual_index_data;
	virtualindex_names_container m_virtual_index_name_keys;

	std::map <std::string, std::string> m_index_segs_for_index;
};

#endif // __VIRTUAL_INDEXES_CACHE_H
