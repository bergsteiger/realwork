////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/DirectMap.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::DirectMap
//
// быстрая мапа для сортированных последовательностей больших объемов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_DIRECTMAP_H__
#define __SHARED_GCL_DATA_DIRECTMAP_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *44FEC13E0149_CUSTOM_INCLUDES*
#include <vector>
//#UC END# *44FEC13E0149_CUSTOM_INCLUDES*

namespace GCL {

// быстрая мапа для сортированных последовательностей больших объемов
template <class _Key, class _Data>
class DirectMap {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~DirectMap ();


//#UC START# *44FEC13E0149*
public:
	class InvalidKey : public std::exception {
	};
	class UnsortedKey : public std::exception {
	};

protected:
	struct Node {
		_Key key;
		_Data data;
	};

	typedef std::vector<Node> NodeBuff;

	class NodeCache {
		struct Item {
			Item(const Node* n = 0) : node (n), access_value(2) {
			}

			const Node* node;
			mutable unsigned short access_value;
		};
		typedef std::vector<Item> CacheBuf;

	public:
		NodeCache (size_t size) : m_last (size), m_size(size) {
			m_last_node = 0;
		}
		
		void clear () {
			m_last_node = 0;
			m_last = m_size;
			m_remove_ind = 0;
			m_cache_buf.clear();
		}

		inline const Node* find (const _Key& key) const {
			if (m_last_node && m_last_node->key == key) {
				return m_last_node;
			} else {
				return 0;
			}

			if (m_last < m_cache_buf.size() && m_cache_buf[m_last].node->key == key) {
				return m_cache_buf[m_last].node;
			} 
			
			m_remove_ind = 0;
			const Node* ret = 0;

			for (size_t i = 0; i < m_cache_buf.size(); i++) {
				if (m_cache_buf[i].node->key == key) {
					ret = m_cache_buf[i].node;
					m_last = i;
					m_cache_buf[i].access_value += 2;
					break;
				} else {
					if (m_cache_buf[i].access_value > m_size) {
						m_cache_buf[i].access_value -= 2;
					} else if (m_cache_buf[i].access_value) {
						--m_cache_buf[i].access_value;
					}

					if (m_cache_buf[m_remove_ind].access_value > m_cache_buf[i].access_value) {
						m_remove_ind = i;
					}
				}
			}

			return ret;
		}
		inline void add (const Node* node) {
			m_last_node = node;
			return;

			if (m_cache_buf.size() < m_size) {
				m_cache_buf.push_back (Item(node));
				m_last = m_cache_buf.size() - 1;
			} else {
				m_cache_buf[m_remove_ind].node = node;
				m_cache_buf[m_remove_ind].access_value = 2;
				m_last = m_remove_ind;
			}
		}
	private:
		mutable const Node* m_last_node;

		mutable size_t m_last;
		mutable size_t m_remove_ind;
		size_t m_size;
		CacheBuf m_cache_buf;
	};
public:
	DirectMap (size_t resize_step = 1, size_t init_size = 0/*, bool use_cache = 0*/) 
		: m_cache(10)
		, m_resize_step(resize_step)
		, m_count(0)
//		, m_use_cache(use_cache)
	{
		m_last = 0;
		if (init_size) {
			this->resize_buff (init_size);
		}
		//m_ps_count = 0;
		//m_bs_count = 0;
	}

	unsigned long size () const {
		return m_count;
	}

	void clear () {
		m_last = 0;
		//m_ps_count = 0;
		//m_bs_count = 0;
		m_count = 0;
		m_buff.clear();
		m_cache.clear();
	}

	void reserve (unsigned long size) {
		this->resize_buff (size);
	}

	inline void add (const _Key& key, const _Data& data) {
		if (m_count && m_buff[m_count-1].key > key) {
			throw UnsortedKey();
		}
		if (m_count >= m_buff.size()) {
			this->resize_buff (m_buff.size() + m_resize_step);			
		}

		m_buff[m_count].key = key;
		m_buff[m_count].data = data;
		m_count++;
	}
	const _Data& operator [] (const _Key& key) const {
		//const Node* ret = m_use_cache ? this->p_search(key) : this->bin_search(key);
		const Node* ret = this->bin_search(key);
		if (!ret) {
			throw InvalidKey();
		}
		return ret->data;
	}
	_Data& operator [] (const _Key& key) {
		//const Node* ret = m_use_cache ? this->p_search(key) : this->bin_search(key);
		const Node* ret = this->bin_search(key);
		if (!ret) {
			throw InvalidKey();
		}
		return const_cast<_Data&>(ret->data);
	}
	bool find (const _Key& key) const {
		return this->bin_search(key) != 0;
	}
	unsigned long index (const _Key& key) const
	throw (InvalidKey) 
	{
		const Node* f = this->bin_search(key);
		if (!f) {
			throw InvalidKey ();
		}
		return f - &m_buff.front();
	}
	const _Key key (unsigned long ind) const {
		GDS_ASSERT (ind <= this->size ());
		return m_buff[ind].key;
	}

	const _Data& data (unsigned long ind) const {
		GDS_ASSERT (ind <= this->size ());
		return m_buff[ind].data;
	}

	void save_to_disk () {
		if (!this->size ()) {
			return;
		}
		FILE* out = mpcxc_fopen ("t:\\etalon.lst", "wb"); // GARANT_XXX

		fwrite (&m_count, 1, sizeof(unsigned long), out);
		fwrite (&m_buff[0], m_count, sizeof(Node), out);
		
		fclose (out);
	}

	void load_from_disk () {
		FILE* in = mpcxc_fopen ("t:\\etalon.lst", "rb");
		fread (&m_count, 1, sizeof(unsigned long), in);
		if (!m_count) {
			return;
		}

		this->resize_buff (m_count);

		if (fread (&m_buff[0], sizeof(Node), m_count, in) != m_count) {
			assert (0);
		}
		fclose (in);
	}

protected:
	struct NodeFinder {
		bool operator () (const Node& lhs, const _Key& key) {
			return lhs.key < key;
		}

		bool operator () (const _Key& key, const Node& rhs) {
			return key < rhs.key;
		}

		// for debug version of Microsoft STL
		bool operator () (const Node& lhs, const Node& rhs) {
			return lhs.key < rhs.key;
		}
	};

	const Node* bin_search (const _Key& key) const {
		const Node* ret = m_cache.find(key);				
		if (ret) {
			return ret;
		}
		typedef typename NodeBuff::const_iterator NodeIterator;
		typedef std::pair<NodeIterator,NodeIterator> NodeIteratorPair;
		NodeIteratorPair it_pair = std::equal_range (m_buff.begin (), m_buff.end (), key, NodeFinder ());
		if (it_pair.first == it_pair.second) {
			return 0;
		}
		GDS_ASSERT (std::distance (it_pair.first, it_pair.second) == 1);
		m_cache.add (&*it_pair.first);

		return &*it_pair.first;
	}


protected:
	void resize_buff (size_t count) {
		m_buff.resize(count);	
		m_cache.clear ();
	}

protected:
	unsigned long m_count;
	size_t m_resize_step;
	NodeBuff m_buff;
	mutable NodeCache m_cache;
	//bool m_use_cache;

	mutable const Node* m_last;
	//mutable unsigned long m_bs_count;
	//mutable unsigned long m_ps_count;
//#UC END# *44FEC13E0149*
}; // class DirectMap

} // namespace GCL

#include "shared/GCL/data/DirectMap.i.h"

#endif //__SHARED_GCL_DATA_DIRECTMAP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

