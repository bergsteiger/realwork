////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/Array.i.h"
// генератор inline файлов реализации C++ (.i.h)
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

#include "ace/ACE.h"
// by <<uses>> dependencies
#include "shared/Core/sys/assert.h"

//#UC START# *4A0BB4CB0121_CUSTOM_INCLUDES*
//#UC END# *4A0BB4CB0121_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4A0BB4CB0121*
template <class T, class Allocator>
Array<T, Allocator>::Array (T* mem, size_type len, bool destr)
: m_elems_ptr (mem), m_number_of_elems (len), m_destroy (destr)
{
	GDS_ASSERT(mem != 0 && len > 0);
}

template <class T, class Allocator>
Array<T, Allocator>::Array (size_type len)
: m_elems_ptr (Allocator::construct (len)), m_number_of_elems (len), m_destroy (true)
{
	GDS_ASSERT(len > 0);
}

template <class T, class Allocator>
void Array<T, Allocator>::assign (T* mem, size_type len, bool destroy) {
	GDS_ASSERT(mem != 0 && len > 0);
	if (m_destroy && m_elems_ptr) {
		Allocator::destroy (m_elems_ptr);
	}
	m_elems_ptr = mem;
	m_number_of_elems = len;
	m_destroy = destroy;
}

// iterator support
template <class T, class Allocator>
typename Array<T, Allocator>::iterator Array<T, Allocator>::begin () {
	return m_elems_ptr; 
}


template <class T, class Allocator>
typename Array<T, Allocator>::const_iterator Array<T, Allocator>::begin () const {
	return m_elems_ptr;
}

template <class T, class Allocator>
typename Array<T, Allocator>::iterator Array<T, Allocator>::end () {
	return m_elems_ptr + m_number_of_elems;
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_iterator Array<T, Allocator>::end () const {
	return m_elems_ptr + m_number_of_elems;
}

template <class T, class Allocator>
typename Array<T, Allocator>::reverse_iterator Array<T, Allocator>::rbegin () {
	return reverse_iterator (end ());
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_reverse_iterator Array<T, Allocator>::rbegin () const {
    return const_reverse_iterator (end ());
}

template <class T, class Allocator>
typename Array<T, Allocator>::reverse_iterator Array<T, Allocator>::rend () {
	return reverse_iterator (begin ());
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_reverse_iterator Array<T, Allocator>::rend () const {
    return const_reverse_iterator (begin ());
}

// operator[]
template <class T, class Allocator>
typename Array<T, Allocator>::reference Array<T, Allocator>::operator [] (size_type i) { 
    return m_elems_ptr [i];
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_reference Array<T, Allocator>::operator [] (size_type i) const {
    return m_elems_ptr [i]; 
}

template <class T, class Allocator>
typename Array<T, Allocator>::reference Array<T, Allocator>::at (size_type i) {
	GDS_ASSERT (i < m_number_of_elems);
    return m_elems_ptr [i];
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_reference Array<T, Allocator>::at (size_type i) const {     
    GDS_ASSERT (i < m_number_of_elems);
    return m_elems_ptr [i]; 
}

// front() and back()
template <class T, class Allocator>
typename Array<T, Allocator>::reference Array<T, Allocator>::front () { 
    return m_elems_ptr [0]; 
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_reference Array<T, Allocator>::front () const {
    return m_elems_ptr [0];
}

template <class T, class Allocator>
typename Array<T, Allocator>::reference Array<T, Allocator>::back () { 
    return m_elems_ptr [m_number_of_elems-1]; 
}

template <class T, class Allocator>
typename Array<T, Allocator>::const_reference Array<T, Allocator>::back () const { 
    return m_elems_ptr [m_number_of_elems-1]; 
}

// size is constant
template <class T, class Allocator>
typename Array<T, Allocator>::size_type Array<T, Allocator>::size () const {
	return m_number_of_elems;
}

template <class T, class Allocator>
bool Array<T, Allocator>::empty () const {
	return m_number_of_elems == 0;
}

template <class T, class Allocator>
typename Array<T, Allocator>::size_type Array<T, Allocator>::max_size () const {
	return m_number_of_elems;
}

// swap (note: linear complexity)
template <class T, class Allocator>
void Array<T, Allocator>::swap (Array <T>& y) {
	std::swap (m_number_of_elems, y.m_number_of_elems);
	std::swap (m_elems_ptr, y.m_elems_ptr);
}

//#UC END# *4A0BB4CB0121*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class T, class Allocator>
Array<T, Allocator>::~Array () {
	//#UC START# *4A0BB4CB0121_DESTR_BODY*
	if (m_destroy) {
		Allocator::destroy (m_elems_ptr);
	}
	//#UC END# *4A0BB4CB0121_DESTR_BODY**cpp*
}


} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

