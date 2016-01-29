////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/Array.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::Array
//
// Класс-обертка для работы с C-массивами. Предоставляет интрефейс подобный контэйнерам stl. Может
// работать в 3-х режимах:
// 1. Просто работает с внешней переданной памятью, не удаляя её при разрушении объекта
// 2. Захватывает переданную внешнюю память и удаляет её при выходе (удаление выполняется спомощью
// аллокатора)
// 3. Объект сам создает массив заданного размера (выделение памяти выполняется с помощью
// аллокатора) и удаляет его при выходе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_ARRAY_H__
#define __SHARED_CORE_DATA_ARRAY_H__

#include "ace/ACE.h"

//#UC START# *4A0BB4CB0121_CUSTOM_INCLUDES*
#include <memory>
#include <vector>

//forward declaration
namespace Core {
	template <class T>
	struct ArrayNewDeleteAllocator {
		static inline T* construct (size_t len) {
			return new T[len];
		}
		static inline void destroy (T* t) {
			delete [] t;
		}
	};

	template <class T, class Allocator = Core::ArrayNewDeleteAllocator<T> >
	class Array;
} //namespace Core
//#UC END# *4A0BB4CB0121_CUSTOM_INCLUDES*

namespace Core {

// Класс-обертка для работы с C-массивами. Предоставляет интрефейс подобный контэйнерам stl. Может
// работать в 3-х режимах:
// 1. Просто работает с внешней переданной памятью, не удаляя её при разрушении объекта
// 2. Захватывает переданную внешнюю память и удаляет её при выходе (удаление выполняется спомощью
// аллокатора)
// 3. Объект сам создает массив заданного размера (выделение памяти выполняется с помощью
// аллокатора) и удаляет его при выходе
template <class T, class Allocator>
class Array {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	~Array ();


//#UC START# *4A0BB4CB0121*
public:
    // type definitions
    typedef T value_type;
    typedef T* iterator;
    typedef const T* const_iterator;
    typedef T& reference;
    typedef const T& const_reference;
    typedef std::size_t size_type;
    typedef std::ptrdiff_t difference_type;

    // reverse iterator support
    typedef std::reverse_iterator <iterator> reverse_iterator;
    typedef std::reverse_iterator <const_iterator> const_reverse_iterator;

//ctors
	Array (T* mem, size_type len, bool destroy = false);
	Array (size_type len);
	
	void assign (T* mem, size_type len, bool destroy = false);

// iterator support
    iterator begin ();
    const_iterator begin () const;
    iterator end ();
    const_iterator end () const;

    reverse_iterator rbegin ();
    const_reverse_iterator rbegin () const;
    reverse_iterator rend ();
    const_reverse_iterator rend () const;

    // operator[]
    reference operator [] (size_type i);
    const_reference operator [] (size_type i) const;
	
	reference at (size_type i);
    const_reference at (size_type i) const;

    // front() and back()
    reference front ();
    
    const_reference front () const;
    
    reference back ();
    
    const_reference back () const;

    // size is constant
    size_type size () const;
    bool empty () const;
    size_type max_size () const;

    // swap
    void swap (Array <T>& y);

private:
    // deprecate copy ctor & operator =
	template <class U, class AnotherAllocator>
	Array (const Array<U, AnotherAllocator>& rhs);

	template <class U, class AnotherAllocator>
    Array<T>& operator= (const Array<U, AnotherAllocator>& rhs);

private:
	T* m_elems_ptr;
	size_type m_number_of_elems;
	bool m_destroy;
//#UC END# *4A0BB4CB0121*
}; // class Array

} // namespace Core

#include "shared/Core/data/Array.i.h"

#endif //__SHARED_CORE_DATA_ARRAY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

