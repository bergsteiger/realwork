
#ifndef __INDEX_DATA_H
#define __INDEX_DATA_H

#include "base.h"

namespace EndtConvertor {

	bool operator == (const SubDesc& x, const SubDesc& y);

	class ParaHeights {
	public:
		ParaHeights () {
		}

		void load (Base* base, unsigned long obj_id);

		long get_para_height (long para) const {
			std::map <long, long>::const_iterator it = map_para_height.find (para);
			return (it == map_para_height.end ())? 0 : it->second;
		}

	private:
		std::map <long, long> map_para_height;
	};

	struct SubDescsEx {
	public:
		SubDescsEx () : m_data (0), m_size (0) {
		}

		~SubDescsEx () {
			if (m_data) { 
				ACE_OS_Memory::free (m_data);
				m_data = 0;
			}
		}

		bool is_sub (const long para, size_t &pos);
		bool not_cell (const long para);

		void load (Base* base, const unsigned long obj_id);

	private:
		SubDesc* m_data;
		size_t m_size;
		std::set<long> paras_with_cells;
	};

} // namespace

#endif // !defined(__INDEX_DATA_H)
