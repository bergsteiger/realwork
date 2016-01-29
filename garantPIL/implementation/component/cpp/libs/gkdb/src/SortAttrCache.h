//
// SortAttrCache.h : header file
//

#ifndef __SORT_ATTR_CACHE_H
#define __SORT_ATTR_CACHE_H

#include "shared/Core/sys/std_inc.h"
#include "base.h"

struct CompareByRel : public std::binary_function <RefwRele, RefwRele, bool> {
	bool operator () (const RefwRele& x, const RefwRele& y) const;
};

struct sort_cache_struct {
	struct InvalidKey : public std::exception {};

	static unsigned long DOCUMENT_INDEX_NOT_FOUND;

private:
	std::vector<long>	m_id_container;
	std::vector<short>	m_force_container;
	std::vector<long>	m_published_container;
	std::vector<long>	m_changed_container;
	std::vector<short>	m_status_container;
	std::vector<long>	m_number_container;
	std::vector<u_int64_t>	m_mask_container;

public:
	void add (const CommonAttribute& ca) {
		m_id_container.push_back (ca.m_id);
		m_force_container.push_back (ca.m_force);
		m_published_container.push_back (ca.m_published);
		m_changed_container.push_back (ca.m_changed);
		m_status_container.push_back (ca.m_status);
		m_mask_container.push_back (ca.mask);
		m_number_container.push_back (ca.m_number);
	}

	void reserve (unsigned long new_size) {
		m_id_container.reserve (new_size);
		m_force_container.reserve (new_size);
		m_published_container.reserve (new_size);
		m_changed_container.reserve (new_size);
		m_status_container.reserve (new_size);
		m_mask_container.reserve (new_size);
		m_number_container.reserve (new_size);
	}

	size_t size () const {
		return m_id_container.size ();
	}

	const std::vector<long>& get_id_container () const {
		return m_id_container;
	}

	unsigned long get_index (long key) const {
		std::pair<std::vector<long>::const_iterator, std::vector<long>::const_iterator> it 
			= std::equal_range (m_id_container.begin (), m_id_container.end (), key);
		if (it.first != it.second) {
			GDS_ASSERT (it.first + 1 == it.second);
			return static_cast<unsigned long> (std::distance (m_id_container.begin (), it.first));
		}
		throw sort_cache_struct::InvalidKey ();
	}

	unsigned long get_index_without_exception (long key) const {
		std::pair<std::vector<long>::const_iterator, std::vector<long>::const_iterator> it
			= std::equal_range (m_id_container.begin (), m_id_container.end (), key);
		if (it.first != it.second) {
			GDS_ASSERT (it.first + 1 == it.second);
			return static_cast<unsigned long> (std::distance (m_id_container.begin (), it.first));
		}
		return DOCUMENT_INDEX_NOT_FOUND;
	}

	long get_id (unsigned long index) const {
		return m_id_container[index];
	}

	short get_force (unsigned long index) const {
		return m_force_container[index];
	}

	long get_published (unsigned long index) const {
		return m_published_container[index];
	}

	long get_changed (unsigned long index) const {
		return m_changed_container[index];
	}

	short get_status (unsigned long index) const {
		return m_status_container[index];
	}

	u_int64_t get_mask (unsigned long index) const {
		return m_mask_container[index];
	}

	long get_number (unsigned long index) const {
		return m_number_container[index];
	}

	void reset () {
		m_id_container.clear ();
		m_force_container.clear ();
		m_published_container.clear ();
		m_changed_container.clear ();
		m_status_container.clear ();
		m_mask_container.clear ();
		m_number_container.clear ();
	}

	struct DataForFastSort {
		DataForFastSort (
			const std::vector<short>&	f
			, const std::vector<long>&	p
			, const std::vector<long>&	c
			, const std::vector<long>&	n
		) : force (f), published (p), changed (c), number (n) {}
			
		const std::vector<short>&	force;
		const std::vector<long>&	published;
		const std::vector<long>&	changed;
		const std::vector<long>&	number;
	};

	DataForFastSort get_data_for_fast_sort () const {
		return DataForFastSort (
			this->m_force_container
			, this->m_published_container
			, this->m_changed_container
			, this->m_number_container
		);
	}
};

struct sort_status_struct {
	struct InvalidKey : public std::exception {};
	static unsigned long DOCUMENT_INDEX_NOT_FOUND;

private:
	std::vector<long>	m_id_container;
	std::vector<short>	m_flags_container;

public:
	void add (const DSSAttribute& dssa) {
		m_id_container.push_back (dssa.m_id);
		m_flags_container.push_back (dssa.m_flags);
	}

	void reserve (unsigned long new_size) {
		m_id_container.reserve (new_size);
		m_flags_container.reserve (new_size);
	}

	size_t size () const {
		return m_id_container.size ();
	}

	unsigned long get_index (long key) const {
		std::pair<std::vector<long>::const_iterator, std::vector<long>::const_iterator> it
			= std::equal_range (m_id_container.begin (), m_id_container.end (), key);
		if (it.first != it.second) {
			GDS_ASSERT (it.first + 1 == it.second);
			return static_cast<unsigned long> (std::distance (m_id_container.begin (), it.first));
		}
		throw sort_status_struct::InvalidKey ();
	}

	unsigned long get_index_without_exception (long key) const {
		std::pair<std::vector<long>::const_iterator, std::vector<long>::const_iterator> it
			= std::equal_range (m_id_container.begin (), m_id_container.end (), key);
		if (it.first != it.second) {
			GDS_ASSERT (it.first + 1 == it.second);
			return static_cast<unsigned long> (std::distance (m_id_container.begin (), it.first));
		}
		return DOCUMENT_INDEX_NOT_FOUND;
	}

	long get_id (unsigned long index) const {
		return m_id_container[index];
	}

	short get_flags (unsigned long index) const {
		return m_flags_container[index];
	}

	void reset () {
		m_id_container.clear ();
		m_flags_container.clear ();
	}

	struct DataForFastFlags {
		DataForFastFlags (
			const std::vector<short>&	f
		) : flags (f) {}
			
		const std::vector<short>&	flags;
	};

	DataForFastFlags get_data_for_fast_flags () const {
		return DataForFastFlags (
			this->m_flags_container
		);
	}
};

typedef Core::Box <sort_cache_struct> ca_cache_box;
typedef Core::Box <sort_status_struct> status_cache_box;

class SortAttrCache {
	typedef ACE_Singleton <SortAttrCache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SortAttrCache, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	static SortAttrCache* instance () {
		return Singleton::instance ();
	}

public:
	void load (Base* base);
	void release ();

	status_cache_box get_exist_statuscache ();
	ca_cache_box get_exist_docinfocache ();

	const sort_cache_struct& get_doc_info () const;
	const sort_status_struct& get_status_cache () const;

	int compare (long id1, long id2);

private:
	Core::Mutex m_mutex;

	ca_cache_box m_ca_cache;
	status_cache_box m_status_cache;
};

#endif // __SORT_ATTR_CACHE_H
