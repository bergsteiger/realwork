//
// IndexData.cpp : implementation file
//
#include "ace/ACE.h"

#include "IndexData.h"

namespace EndtConvertor {

bool operator == (const SubDesc& x, const SubDesc& y) {
    return (x.Para == y.Para);
}

int subdesc_compare (const void *arg1, const void *arg2) {
	if (((SubDesc*)arg1)->Para == ((SubDesc*)arg2)->Para) {
		return 0;
	} else  if (((SubDesc*)arg1)->Para > ((SubDesc*)arg2)->Para) {
		return 1;
	}
	return -1;
}

bool SubDescsEx::is_sub (const long para, size_t &pos) {
	bool ret = false;
	if (m_data && m_size > 0) {
		for (; pos < m_size && para == m_data [pos].Para; ++pos) {
			if (!ret && m_data [pos].Sub > 0) {
				ret = true;
			}
		}
	}
	return ret;
}

bool SubDescsEx::not_cell (const long para) {
	return paras_with_cells.find (para) == paras_with_cells.end ();
}

void SubDescsEx::load (Base* base, const unsigned long obj_id) {
	long count;
	m_size = 0;

	SubDesc* tmp = (SubDesc*) base->LoadAttr (obj_id, IDD_SUBS, count);
	if (tmp) {
		count = count / sizeof (SubDesc);
		m_data = (SubDesc*) ACE_OS_Memory::calloc (count, sizeof (SubDesc));

		for (long i = 0; i < count; ++i) {
			m_data [m_size].Para = tmp [i].Para; 
			m_data [m_size].Sub  = tmp [i].Sub;
			++m_size;
		}
		gk_free (tmp); 
	}

	DocStruct* structs = (DocStruct*) base->LoadAttr (obj_id, IDD_DOCSTRUCT, count);
	if (structs) {
		count /= sizeof (DocStruct);
		for (long i = 0; i < count; ++i) {
			short evd_type = (short) ((structs [i].m_para_list_type >> 24) & 0xFF);
			if (evd_type == SUBDESCEX_BLOCK) {
				m_data = (SubDesc*) ACE_OS_Memory::realloc (m_data, (m_size+1) * sizeof (SubDesc));
				m_data [m_size].Para = structs [i].m_end_para + 1; //+1, потому что по просьбе ƒимы  
				m_data [m_size].Sub = structs [i].m_para_list_id;
				m_data [m_size].Sub *= -1;
				++m_size;
			} else if (evd_type == SUBDESCEX_CELL) {
				paras_with_cells.insert (structs [i].m_start_para);
			}
		}
		gk_free (structs);
	}

	if (m_size)
		ACE_OS::qsort ((void*)m_data, m_size, sizeof (SubDesc), subdesc_compare);
}

void ParaHeights::load (Base* base, const unsigned long obj_id) {
	long count, *tmp = (long*) base->LoadAttr (obj_id, IDD_PARAHEIGHTS, count), *ptr = tmp;

	if (tmp) {
		count = count / (sizeof (long) * 2);
		for (long i = 0; i < count; ++i) {
			long para = *ptr;
			ptr++;
			long height = *ptr;
			ptr++;
			map_para_height.insert (std::map<long,long>::value_type (para,height));
		}
		gk_free (tmp); 
	}
}

} // namespace

