//
// VirtualIndexesCache.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/smart_ptr/scoped_array.hpp"

#include "VirtualIndexesCache.h"

namespace {

struct KeySorter {
	bool operator () (const std::string& lhs, const KeyWithSegments& rhs) {
		return lhs < rhs.first;
	}

	bool operator () (const KeyWithSegments& lhs, const std::string& rhs) {
		return lhs.first < rhs;
	}

	bool operator () (const KeyWithSegments& lhs, const KeyWithSegments& rhs) {
		return lhs.first < rhs.first;
	}
};

struct StringRefSorter {
	bool operator () (const boost::string_ref& lhs, const KeyWithSegments& rhs) {
		return lhs < rhs.first;
	}

	bool operator () (const KeyWithSegments& lhs, const boost::string_ref& rhs) {
		return lhs.first < rhs;
	}

	bool operator () (const KeyWithSegments& lhs, const KeyWithSegments& rhs) {
		return lhs.first < rhs.first;
	}
};

KeysWithSegments::const_iterator find (const KeysWithSegments& data, const boost::string_ref& key) {
	KeysWithSegments::const_iterator it = std::lower_bound (data.begin (), data.end (), key, StringRefSorter ());
	if ((it == data.end ()) || (it->first != key)) {
		return data.end ();
	}
	return it;
}

}

const std::vector <short>* VirtualIndexesCache::segs (
	const boost::string_ref& key, const boost::string_ref& value
) {
	IndexToKeysWithSegments::const_iterator it = m_index_name_map_key_segs.find (key.to_string ());

	if (it != m_index_name_map_key_segs.end ()) {
		KeysWithSegments::const_iterator syn_it = find (it->second, value);
		if (syn_it != it->second.end ()) {
			return &syn_it->second;
		}
	}

	return 0; /* nullptr */
}

void VirtualIndexesCache::load_virtual_indexes (Base* base) {
	Index* index = base->FindIndex ("Aux");

	Stream* str = index->Open (AUX_SEGMENT_INDEXES);

	if (str) {
		long size = str->Length ();
		char *data = new char [size], *ptr = data;
		str->Read (data, size);
		index->Close (str);

		while (ptr - data < size) {
			char *key = ptr;
			ptr += strlen (ptr) + 1;
			m_index_segs_for_index.insert (std::map<std::string,std::string>::value_type (key, ptr));
			ptr += strlen (ptr) + 1;
		}
		delete []data;
	}

	str = index->Open (AUX_INDEXES_SYNS);

	if (str) {
		long size = str->Length ();
		m_virtual_index_data.resize (size);
		char* data_begin = size ? &m_virtual_index_data [0] : 0;
		str->Read (data_begin, size);
		index->Close (str);

		this->load_keys_for_segments (base);

		boost::string_ref index_name;
		std::map<boost::string_ref, std::vector<boost::string_ref> > map_node_children;

		for (const char* str_it = data_begin; str_it - data_begin < size; str_it += strlen (str_it) + 1) {
			if (!strlen (str_it)) {
				if (index_name.size () && index_name[0] == '!' && map_node_children.size ()) {
					for (std::map<boost::string_ref, std::vector<boost::string_ref> >::const_iterator map_it = map_node_children.begin (); map_it != map_node_children.end (); ++map_it) {
						boost::string_ref key = map_it->first;
						vector_of_syns syns;
						syns.reserve (map_it->second.size ());
						for (std::vector<boost::string_ref>::const_iterator vec_it = map_it->second.begin (); vec_it != map_it->second.end (); ++vec_it) {
							syns.push_back (boost::make_tuple (index_name, *vec_it, this->segs (index_name, *vec_it)));
						}
						std::pair<boost::string_ref, vector_of_syns> apair (key, syns);
						m_virtual_index_name_keys.find (index_name)->second.push_back (apair);
					}
				}
				map_node_children.clear ();
				index_name = boost::string_ref ();
				continue;
			}
			if (str_it[0] == '[') {
				index_name = boost::string_ref (str_it + 1, strlen (str_it) - 2);
				m_virtual_index_name_keys.insert (virtualindex_names_container::value_type (index_name, key_syns ()));
			} else if (index_name.size ()) {
				if (strchr (str_it, '=')) {
					const char* after_eq_sign = strchr (str_it, '=') + 1;
					const char* after_or = after_eq_sign;
					vector_of_syns syns;

					while (after_or) {
						const char* next_after_or = strchr (after_or, '|');
						const char* after_colon = strchr (after_or, ':') + 1;
						boost::string_ref key = boost::string_ref (after_or, after_colon - after_or - 1);
						boost::string_ref value = boost::string_ref (after_colon, next_after_or ? next_after_or - after_colon : strlen (after_colon));
						syns.push_back (boost::make_tuple (key, value, this->segs (key, value)));
						after_or = next_after_or ? next_after_or + 1 : 0;
					}

					size_t key_size = after_eq_sign - str_it - 1;
					m_virtual_index_name_keys [index_name].push_back (std::make_pair (boost::string_ref (str_it, key_size), syns));

					if (index_name[0] == '!') {
						// в виртуальных индексах могут быть папки, их надо обработать
						const char* backslash = strchr (str_it, '\\');
						while (backslash && (backslash < after_eq_sign)) {
							map_node_children[boost::string_ref (str_it,  backslash - str_it)].push_back (boost::string_ref (str_it, key_size));
							backslash = strchr (backslash + 1, '\\');
						}
					}
				}
			}
		}
	}
}

void VirtualIndexesCache::load_keys_for_segments (Base* base) {
	Index* index = base->FindIndex ("Aux");

	std::map <std::string, std::string>::const_iterator it = m_index_segs_for_index.begin ();

	for (; it != m_index_segs_for_index.end (); ++it) {
		KeysWithSegments map_key_segs;

		Stream* str = index->Open (it->second.c_str ());

		if (str) {
			long size = str->Length ();
			boost::scoped_array <char> data (new char [size]);
			char* ptr = data.get ();
			str->Read (data.get (), size);
			index->Close (str);

			while (ptr - data.get () < size) {
				std::string key (ptr);
				ptr += key.size () + 1;
				short* short_ptr = (short*) ptr;
				short count = *short_ptr;
				++short_ptr;
				std::vector<short> segs (short_ptr, short_ptr + count);
				map_key_segs.push_back (std::make_pair (key, segs));
				ptr = (char*) (short_ptr + count);
			}
		}

		std::sort (map_key_segs.begin (), map_key_segs.end (), KeySorter ());
		m_index_name_map_key_segs [it->first].swap (map_key_segs);
	}
}

void VirtualIndexesCache::load (Base* base) {
	RWRITE_GUARD (m_mutex);

	if (m_virtual_index_name_keys.empty ()) {
		this->load_virtual_indexes (base);
	}
	if (m_index_name_map_key_segs.empty ()) {
		this->load_keys_for_segments (base);
	}
}

void VirtualIndexesCache::release () {
	RWRITE_GUARD (m_mutex);

	virtualindex_vector ().swap (m_virtual_index_data);
	m_virtual_index_name_keys.clear ();
	m_index_name_map_key_segs.clear ();
}