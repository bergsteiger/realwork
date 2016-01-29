//
// SortAttrCache.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/smart_ptr/scoped_array.hpp"

#include "pack.h"
#include "SortAttrCache.h"

unsigned long sort_cache_struct::DOCUMENT_INDEX_NOT_FOUND = std::numeric_limits <unsigned long>::max ();
unsigned long sort_status_struct::DOCUMENT_INDEX_NOT_FOUND = std::numeric_limits <unsigned long>::max ();

bool CompareByRel::operator () (const RefwRele& x, const RefwRele& y) const {
	return (x.Rele == y.Rele)? SortAttrCache::instance ()->compare (x.DocId, y.DocId) < 0 : x.Rele > y.Rele;
}

template <typename Type, typename Data>
static void load_attr_data (Base* base, BTKEY len_key, BTKEY key, long sz, Data& data) {
	Index* index = base->FindIndex ("Aux");

	Stream* str = index->Open (len_key);

	long count = 0;

	if (str) {
		str->Read (&count, sizeof (long));
		index->Close (str);
	}

	data.reset ();
	data.reserve (count);

	str = index->Open (key);

	if (str) {
		boost::scoped_array <char> unpacked_buffer (new char [sz * sizeof (Type)]);

		while (count) {
			long small_count = std::min <long> (count, sz), packed_size;

			str->Read (&packed_size, sizeof (long));

			boost::scoped_array <char> buffer (new char [packed_size]);
			str->Read (buffer.get (), packed_size);
			G_UNZIP (buffer.get (), packed_size, unpacked_buffer.get (), small_count * sizeof (Type));

			Type* ptr = reinterpret_cast <Type*> (unpacked_buffer.get ());

			for (long i = 0; i < small_count; i++, ptr++) {
				data.add (*ptr);
			}

			count -= small_count;					
		}

		index->Close (str);
	}
}

void SortAttrCache::load (Base* base) {
	GUARD (m_mutex);

	if (m_ca_cache.is_nil ()) {
		load_attr_data <CommonAttribute, sort_cache_struct> (
			base, "InfL", "Inf7", 3096, *m_ca_cache
		);
	}

	if (m_status_cache.is_nil ()) {
		load_attr_data <DSSAttribute, sort_status_struct> (
			base, AUX_DSS_FLAGS_LENGTH, AUX_DSS_FLAGS, 4096, *m_status_cache
		);
	}
}

void SortAttrCache::release () {
	GUARD (m_mutex);

	m_ca_cache.reset ();
	m_status_cache.reset ();
}

status_cache_box SortAttrCache::get_exist_statuscache () {
	return m_status_cache;
}

ca_cache_box SortAttrCache::get_exist_docinfocache () {
	return m_ca_cache;
}

const sort_cache_struct& SortAttrCache::get_doc_info () const {
	return *m_ca_cache;
}

const sort_status_struct& SortAttrCache::get_status_cache () const {
	return *m_status_cache;
}

int SortAttrCache::compare (long id1, long id2) {
	unsigned long index1 = m_ca_cache->get_index (id1);
	unsigned long index2 = m_ca_cache->get_index (id2);

	int ret = m_ca_cache->get_force (index1) - m_ca_cache->get_force (index2);

	if (!ret) {
		ret = m_ca_cache->get_published (index2) - m_ca_cache->get_published (index1);

		if (!ret) {
			ret = m_ca_cache->get_changed (index2) - m_ca_cache->get_changed (index1);

			if (!ret) {
				ret = m_ca_cache->get_number (index1) - m_ca_cache->get_number (index2);

				if (!ret) {
					ret = id1 - id2;
				}
			}
		}
	}

	return ret;
}

