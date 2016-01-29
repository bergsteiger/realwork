//
// Iterator for simple collection of fixed-sized items based of list of pages
//

#ifndef _collection_iterator_h
#define _collection_iterator_h

#include "boost/iterator/iterator_facade.hpp"

#include "shared/Core/sys/assert.h"
#include "shared/GCL/alg/iterable.h"

template<typename Collection, typename Element>
class collection_iterator : public boost::iterator_facade <
	collection_iterator<Collection, Element>
	, Element
	, boost::random_access_traversal_tag
> {

public:
	collection_iterator () : m_index (0), m_coll (0) {
	}

	collection_iterator (Collection* col, size_t index)	: m_coll (col), m_index (index) {}

	std::ptrdiff_t get_index () const {
		return m_index;
	}

private:
	friend class boost::iterator_core_access;

	void increment () {
		++m_index;
	}

	void decrement () {
		--m_index;
	}

	void advance (std::ptrdiff_t delta) {
		m_index += delta;
	}

	std::ptrdiff_t distance_to (const collection_iterator<Collection, Element>& other) const {
		return other.m_index - m_index;
	}

	bool equal (const collection_iterator<Collection, Element>& other) const {
		return (other.m_coll == m_coll) && (other.m_index == m_index);
	}

	Element& dereference () {
		return this->dereference_i ();
	}

	// boost требует неконстантной ссылки :(
    Element& dereference ()  const {
		return this->dereference_i ();
	}

    Element& dereference_i () const {
		GDS_ASSERT (m_index < m_coll->ItemCount);

		std::ptrdiff_t index = m_index;
		size_t page;
		for (page = 0; index >= m_coll->Count [page]; ++page) {
				index -= m_coll->Count [page];
		}

		const void* data = index * m_coll->ItemSize + (char *) m_coll->Pages [page];
		const Element* const_element = (const Element*) data;
		Element* element = const_cast<Element*> (const_element);

		return *element;
    }


	Collection* m_coll;
	std::ptrdiff_t m_index;
};


// Это хакнутый итератор, который позволяет избавиться от тормозной функции GetItem.
// Он рассчитывает на то, что все страницы одинакового размера и заполнены без дырок,
// а количество элементов в странице - степень двойки
// Т.е. его можно использовать при сценарии работы, когда коллекцию заполнили данными,
// а потом с ней надо что-то поделать, не удаляя элементов.
// Использовать его можно только на свой страх и риск, когда это действительно нужно.

template<size_t count>
struct ShiftCounter {
	enum {
		value = ShiftCounter<(count >> 1)>::value + 1
	};
};

template<>
struct ShiftCounter<0> {
	enum {
		value = 0
	};
};

template<typename Collection, typename Element, std::ptrdiff_t elements_in_page>
class fast_collection_iterator : public boost::iterator_facade <
	fast_collection_iterator<Collection, Element, elements_in_page>
	, Element
	, boost::random_access_traversal_tag
> {

public:
	fast_collection_iterator () : m_index (0), m_coll (0) {
		// зачем-то используется в stl от microsoft:
		//	for (_FwdIt _Firstb; (_Firstb = _First) != _Last && ++_First != _Last; )

		//GDS_ASSERT (false);
	}

	fast_collection_iterator (Collection* col, size_t index) : m_coll (col), m_index (index) {
#ifdef _DEBUG
		GDS_ASSERT (elements_in_page == m_coll->PageSize);

#if defined (_MSC_VER) && (_MSC_VER >= 1800) //MSVC++ 12.0 _MSC_VER == 1800 (Visual Studio 2013)
		static_assert (!(elements_in_page & (elements_in_page - 1))
			, "FAST_ITERATOR_CAN_BE_USED_ONLY_WITH_COLLECTION_WHERE_PAGE_SIZE_IS_POWER_OF_TWO");
#else
		LOKI_STATIC_CHECK(!(elements_in_page & (elements_in_page - 1))
			, FAST_ITERATOR_CAN_BE_USED_ONLY_WITH_COLLECTION_WHERE_PAGE_SIZE_IS_POWER_OF_TWO);
#endif
		
#endif
	}

	std::ptrdiff_t get_index () const {
		return m_index;
	}

private:
	friend class boost::iterator_core_access;

	void increment () {
		++m_index;
	}

	void decrement () {
		--m_index;
	}

	void advance (std::ptrdiff_t delta) {
		m_index += delta;
	}

	std::ptrdiff_t distance_to (const fast_collection_iterator<Collection, Element, elements_in_page>& other) const {
		return other.m_index - m_index;
	}

	bool equal (const fast_collection_iterator<Collection, Element, elements_in_page>& other) const {
		return (other.m_coll == m_coll) && (other.m_index == m_index);
	}

	Element& dereference () {
		return const_cast<Element&> (this->get_item ());
	}

	// boost требует неконстантной ссылки :(
	Element& dereference () const {
		return get_item ();
	}

	Element& get_item () const {
#ifdef _DEBUG
		GDS_ASSERT (m_index < m_coll->ItemCount);
#endif

		return *(reinterpret_cast<Element*> ((m_index & m_flag) * m_coll->ItemSize + (char *) m_coll->Pages [m_index >> m_shift]));
	}

	Collection* m_coll;
	std::ptrdiff_t m_index;

	enum {
		m_flag = elements_in_page - 1
	};
	enum {
		m_shift = ShiftCounter<elements_in_page>::value - 1
	};
};

template<class Collection, class Element>
GCL::Iterable<collection_iterator<Collection, Element> > make_iterable_collection (Collection& collection) {
	return GCL::make_iterable (
		collection_iterator<Collection, Element> (&collection, 0)
		, collection_iterator<Collection, Element> (&collection, collection.ItemCount)
	);
}

template<class Collection, class Element, size_t page_size>
GCL::Iterable<fast_collection_iterator<Collection, Element, page_size> > make_fast_iterable_collection (Collection& collection) {
	return GCL::make_iterable (
		fast_collection_iterator<Collection, Element, page_size> (&collection, 0)
		, fast_collection_iterator<Collection, Element, page_size> (&collection, collection.ItemCount)
	);
}

#endif
