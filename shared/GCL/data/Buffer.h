////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/Buffer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::data::Buffer
//
// класс для работы с линейным буфером данных, неограниченной длинны, внутри организован как
// страничный вектор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_BUFFER_H__
#define __SHARED_GCL_DATA_BUFFER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450135270167_USER_INCLUDES*
#include <map>
#include "shared/GCL/meta/select.h"
//#UC END# *450135270167_USER_INCLUDES*

namespace GCL {

//#UC START# *450135270167_USER_DEFINITION*
#define GCL_BUFFER_PAGE_SIZE (65536)

class NullGuard {
public:
	NullGuard (Core::NullMutex& nm) {
	}
};

template <bool use_guard>
class BufferBase {
public:
	typedef typename GCL::Templates::select<use_guard, Core::RWMutex, Core::NullMutex>::Type BufferMutex;
	typedef typename GCL::Templates::select<use_guard, Core::ReadGuard, NullGuard>::Type BufferReadGuard;
	typedef typename GCL::Templates::select<use_guard, Core::WriteGuard, NullGuard>::Type BufferWriteGuard;

public:
	BufferBase() {
	}

	~BufferBase() {
		this->clean();
	}

	void clean () {
		BufferWriteGuard _local_bg (m_mutex);
		for (typename PageMap::iterator it = m_pages.begin(); it != m_pages.end(); ++it) {
			delete (*it);
		}
		m_pages.clear();
	}

	int read (void* buf, unsigned from, unsigned count) {		
		BufferReadGuard _local_bg (m_mutex);
		size_t len = length_i ();		
		
		if (from > len) {
			return 0;
		}

		size_t real_count = count;
		if (from + count > len) {
			real_count = len - from;
		}
		size_t first_page = from / GCL_BUFFER_PAGE_SIZE;
		size_t last_page = (from+real_count) / GCL_BUFFER_PAGE_SIZE;
		size_t first_offset = from % GCL_BUFFER_PAGE_SIZE;
		size_t last_offset = (from+real_count) % GCL_BUFFER_PAGE_SIZE;

		if ( first_page == last_page ) {
			memcpy ( (char*)buf, m_pages[first_page]->buf+first_offset, last_offset - first_offset);
		} else {
			size_t buf_offset = 0;
			size_t page = first_page;

			// first page
			memcpy ( (char*)buf+buf_offset, m_pages[page++]->buf+first_offset, GCL_BUFFER_PAGE_SIZE - first_offset);
			buf_offset += GCL_BUFFER_PAGE_SIZE - first_offset;

			// all middle pages
			for ( ; page < last_page; page++ ) {
				memcpy ( (char*)buf+buf_offset, m_pages[page]->buf, GCL_BUFFER_PAGE_SIZE );
				buf_offset += GCL_BUFFER_PAGE_SIZE;
			};

			// last page
			if (last_offset) {
				memcpy ( (char*)buf+buf_offset, m_pages[last_page]->buf, last_offset );
			}
		}

		return static_cast<int> (real_count);
	}

	void append (const void* buf, unsigned count) {
		BufferWriteGuard _local_bg (m_mutex);
		if (0 == m_pages.size ()) {
			this->add_page ();
		}
		size_t page = m_pages.size () - 1;
		
		unsigned buf_offset = 0;
		
		while (count) {
			unsigned move_count = GCL_BUFFER_PAGE_SIZE - m_pages[page]->len < count 
				? GCL_BUFFER_PAGE_SIZE - m_pages[page]->len : count;
			
			try {
				memcpy ( m_pages[page]->buf+m_pages[page]->len, (char*)buf + buf_offset, move_count);
			} catch (...) {
				//LOG_UEX (( "GCL::Buffer::append (%M)" ));
			}

			m_pages[page]->len += move_count;
			buf_offset += move_count;
			count -= move_count;

			if (count) {
				this->add_page ();
			}
			page++;
		}
	}

	unsigned length () {
		BufferReadGuard _local_bg (m_mutex);
		return static_cast<unsigned> (length_i ());
	}

protected:
	void add_page () {
		MemPage* page = new MemPage;
		m_pages.push_back (page);
	}

private:
	size_t length_i () {

		if (m_pages.empty ()) {
			return 0;
		}

		size_t page_count = m_pages.size ();
		return  (page_count - 1) * GCL_BUFFER_PAGE_SIZE + m_pages[page_count - 1]->len;		
	}

protected:
	struct MemPage {
		unsigned char* buf;
		unsigned len;
		MemPage () {
			buf = new unsigned char [GCL_BUFFER_PAGE_SIZE];
			len = 0;
		}
		~MemPage () {
			delete [] buf;
		}
	};

	typedef std::vector <MemPage*> PageMap;
	PageMap m_pages;
	
	BufferMutex m_mutex;

};

typedef BufferBase<true> Buffer;

template<bool is_guard>
class BufferExBase {
public:
	BufferExBase () : m_position (0) {
	}
	
	void clean () {
		m_buffer.clean ();
	}

	int read (void* buf, unsigned count) {
		assert (m_position < this->length ());
		assert (m_position + count <= this->length ());

		int readed = m_buffer.read (buf, m_position, count);
		m_position += readed;
		assert (readed == count);
		return readed;
	}

	void append(const void* buf, unsigned count) {
		m_buffer.append (buf, count);
	}

	unsigned length () {
		return m_buffer.length ();
	}
	
	void seek (unsigned position) {
		assert (position < this->length ());
		m_position = position;
	}

	bool is_end_position () {
		return m_position >= this->length ();
	}
	
private:
	BufferBase<is_guard> m_buffer;
	unsigned m_position;
};

typedef BufferExBase<false> BufferEx;

//#UC END# *450135270167_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_DATA_BUFFER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
