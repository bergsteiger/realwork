////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/PoolMemoryManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::PoolMemoryManager
//
// менеджер пула памяти (для сокращения дефрагментации памяти и кол-во циклов new/delete)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_POOLMEMORYMANAGER_H__
#define __SHARED_CORE_MNG_POOLMEMORYMANAGER_H__

#include "ace/ACE.h"
#include "shared/Core/data/DynamicBitSet.h"
#include "shared/Core/mng/Var.h"

//#UC START# *450015550261_USER_INCLUDES*

#include <assert.h>
#include <memory>
#include <vector>

/*!
	PoolMemoryManager - темплейтный менеджер памяти для работы с большими массивами маленьких объектов. 
	Убирает дефрагментацию памяти. Аналогично boost::object_pool, но по предварительным 
	тестам быстрее и экономичнее.

Example of usage:
	#include "shared/Core/mng/PoolMemoryManager.h"

	int main (...) {
		...
	}
	...

	class MyClass {
		...
	public:		
		void* operator new (size_t cs);
		void operator delete (void* p);
	};

	typedef PoolMemoryManager<MyClass> MyClassPool;
	
	void* MyClass::operator new (size_t cs) {
		return MyClassPool::instance()->malloc(cs);
	}
	void MyClass::operator delete (void* p) {
		MyClassPool::instance()->free(p);
	}
	...
*/

//#UC END# *450015550261_USER_INCLUDES*

namespace Core {

//#UC START# *450015550261_USER_DEFINITION*
struct DestroyableMemoryPool {
	virtual void destroy () = 0;
};

class PoolMemoryOwner {	
	typedef std::vector<DestroyableMemoryPool*> PoolMemories;

public:
	void add_memories (DestroyableMemoryPool* object) {
		this->memories.push_back (object);
	}

	~PoolMemoryOwner () {
		for (PoolMemories::iterator it = memories.begin (); it != memories.end (); ++it) {
			(*it)->destroy ();
		}
	}

private:
	PoolMemories memories;
};

typedef ACE_Singleton <PoolMemoryOwner, ACE_SYNCH_RECURSIVE_MUTEX> PoolMemoryOwnerSingleton;

#define DEFAULT_PAGE_K_SIZE 4

template <class TYPE_, unsigned long page_k_size=0> /* page_k_size=0 - use DEFAULT_PAGE_K_SIZE */
class PoolMemoryManager: public DestroyableMemoryPool {
public:
	typedef ACE_Unmanaged_Singleton <
				PoolMemoryManager<TYPE_, page_k_size>
				, ACE_SYNCH_RECURSIVE_MUTEX
			> PoolMemoryManagerSingleton;

	virtual void destroy () {
		PoolMemoryManagerSingleton::close ();
	}

private:
	class PagedMem {
		typedef std::vector <TYPE_*> Pages;
		enum { NOT_FOUND = 0xFFFFFFFF };
	public:
		PagedMem (unsigned long page_size): m_page_size(page_size) {
		}
		void init (unsigned long page_size) {
			m_page_size = page_size;
		}

		virtual ~PagedMem () {
			for (typename Pages::iterator it = m_pages.begin(); it != m_pages.end(); it++) { // GARANT_TYPENAME
				::free (*it);
			}
		}

		inline void* operator [] (unsigned long index) {
			return m_pages[index/m_page_size] + index%m_page_size;
		}

		inline unsigned long index_i (const void* p) const {
			for (typename Pages::const_iterator it = m_pages.begin(); it != m_pages.end(); it++) { // GARANT_TYPENAME
				if (p >= *it && p < *it + m_page_size) {
					return std::distance (m_pages.begin(), it) * m_page_size + ((TYPE_*)p - *it);
				}
			}
			return NOT_FOUND;
		}

		inline unsigned long index (const void* p) const {
			unsigned long i = index_i (p);
			if (i == NOT_FOUND) {
				throw;
			}
			return i;
		}

		void resize (unsigned long size) {
			unsigned long page_num = size/m_page_size + (size%m_page_size ? 1 : 0);
			if (page_num > m_pages.size()) {
				for (unsigned i = m_pages.size(); i < page_num; i++) {
					m_pages.push_back ((TYPE_*)::malloc (m_page_size*sizeof(TYPE_)));
				}
			} else if (page_num < m_pages.size()) {
				for (unsigned i = page_num; i < m_pages.size(); i++) {
					::free(m_pages.back());
					m_pages.pop_back();
				}
			}
		}
		void remove_page_by_point (void* p) {
			for (typename Pages::const_iterator it = m_pages.begin(); it != m_pages.end(); it++) { // GARANT_TYPENAME
				if (p >= *it && p < *it + m_page_size) {
					::free (*it);
					m_pages.erase(it);
					return;
				}
			}
			throw;
		}

		inline bool is_from (void* p) {
			return index_i (p) == NOT_FOUND ? false : true;
		}
		 
	private:
		unsigned long m_page_size;
		Pages m_pages;
	};

	class BitMap {
	public:
		BitMap (unsigned long size = 0): m_map(size), m_current(0), m_last_free(0), m_free_count(0) {
		}
		inline void unmark (unsigned long ind) {
			m_map.reset(ind);			
			m_free_count++;
			m_last_free = ind;
		}
		inline void mark (unsigned long ind) {
			m_free_count--;
			m_map.set(ind);
		}
		void resize (unsigned long size) {
			m_free_count += (size - m_map.size());
			m_map.resize(size);
		}
		unsigned long find_unmark_chain(unsigned long count) {
			unsigned long need_place = count;
			unsigned long prev_cur = m_current;
			while (need_place && m_current < m_map.size()) {
				if (!m_map[m_current++]) {
					--need_place;
				} else {
					need_place = count;
				}
			}
			if (!need_place) {
				return m_current - count;
			}

			if (m_free_count) {
				if (count == 1 && !m_map[m_last_free]) {
					m_current = m_last_free + 1;
					return m_last_free;
				}

				need_place = count;
				m_current = 0;
				while (need_place && m_current < prev_cur) {
					if (!m_map[m_current++]) {
						--need_place;
					} else {
						need_place = count;
					}
				}
				if (!need_place) {
					return m_current - count;
				}
			}
			
			return m_map.size();		
		}
	private:
		DynamicBitSet m_map;
		unsigned long m_current;
		unsigned long m_free_count;
		unsigned long m_last_free;
	};
public:  
	PoolMemoryManager (unsigned long step_size = 0) : m_step_size(step_size), m_size(0), m_buf(step_size) {
		if (!m_step_size) {
			m_step_size = (page_k_size*1024)/sizeof(TYPE_);
			if (!m_step_size) {
				m_step_size = (DEFAULT_PAGE_K_SIZE*1024)/sizeof(TYPE_);
			}
			m_buf.init (m_step_size);
		}

		PoolMemoryOwnerSingleton::instance ()->add_memories (this);
	}

	void* malloc (size_t cs) {
#if 1
		unsigned long count = cs/sizeof(TYPE_);
		// only for single object allocation
		assert (count == 1);

		unsigned long ind = m_marks.find_unmark_chain(count);
		if (ind >= m_size) {
		   this->resize (count);                              
		}
		m_marks.mark(ind);
		return m_buf[ind];
#else
		return ::malloc (cs);
#endif
	}
	void free (void* p) {
#if 1
		unsigned long ind = m_buf.index(p);
		m_marks.unmark(ind);
#else
		::free (p);
#endif
	}

	bool is_from (void* p) {
		return m_buf.is_from (p);
	}

protected:
	void resize (unsigned long min_count) {
		m_size += m_step_size * (1 + min_count/m_step_size);

		m_marks.resize(m_size);
        m_buf.resize(m_size);
	}

private:
	BitMap m_marks;
	PagedMem m_buf;
	unsigned long m_size;
	unsigned long m_step_size;
};

//#UC END# *450015550261_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_POOLMEMORYMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
