////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/SortedTypeConverter.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::SortedTypeConverter
//
// сортированный конвертер типов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

//#UC START# *45CB0F1F00FA_CUSTOM_INCLUDES*
#include <algorithm>
#include <iterator>
#ifdef _DEBUG
#include <iostream>
#endif // _DEBUG
//#UC END# *45CB0F1F00FA_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45CB0F1F00FA*
//#UC END# *45CB0F1F00FA*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class Type1, class Type2, class Functor1, class Functor2>
SortedTypeConverter<Type1, Type2, Functor1, Functor2>::~SortedTypeConverter () {
	//#UC START# *45CB0F1F00FA_DESTR_BODY*
	//#UC END# *45CB0F1F00FA_DESTR_BODY**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// вывод содержимого контейнера (для тестовых целей)
template <class Type1, class Type2, class Functor1, class Functor2>
void SortedTypeConverter<Type1, Type2, Functor1, Functor2>::dump () const {
	//#UC START# *45CAF04A03B9_45CB0F1F00FA*
#ifdef _DEBUG
	std::cout << "Sorted array" << std::endl;
	
	size_t size = std::distance (this->t1begin (), this->t1end ());		
	std::cout << "Type1 array:" << std::endl;
	for (size_t i = 0; i < size; ++i) {
		std::cout << "for element: <" << this->at_t1 (i)
				<< "> pair is: " << this->at_t2 (m_index1[i]) << std::endl;
	}
	std::cout << "Type2 array:" << std::endl;
	for (size_t i = 0; i < size; ++i) {
			std::cout << "for element: <" << this->at_t2 (i)
				<< "> pair is: " << this->at_t1 (m_index2[i]) << std::endl;
	}
#endif // _DEBUG
	//#UC END# *45CAF04A03B9_45CB0F1F00FA**cpp*
}

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// внутрення реализация метода, конвертации типа
template <class Type1, class Type2, class Functor1, class Functor2>
const Type1& SortedTypeConverter<Type1, Type2, Functor1, Functor2>::get_t1 (const Type2& key) const {
	//#UC START# *45CAFBFA002E_45CB0F1F00FA*
	T2ConstIterator begin = this->t2begin ();
	T2ConstIterator end = this->t2end ();

	T2ConstIterator result = std::lower_bound (begin, end, key, Functor2 ());
	if (result != end) {
		size_t num = std::distance (begin, result);
		return this->at_t1 (m_index2[num]);
	}

	throw ElementNotFound ();
	//#UC END# *45CAFBFA002E_45CB0F1F00FA**cpp*
}

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// внутрення реализация метода, конвертации типа
template <class Type1, class Type2, class Functor1, class Functor2>
const Type2& SortedTypeConverter<Type1, Type2, Functor1, Functor2>::get_t2 (const Type1& key) const {
	//#UC START# *45CAFC2303D8_45CB0F1F00FA*
	T1ConstIterator begin = this->t1begin ();
	T1ConstIterator end = this->t1end ();

	T1ConstIterator result = std::lower_bound (begin, end, key, Functor1 ());

	if (result != end) {
		size_t num = std::distance (begin, result);
		return this->at_t2 (m_index1[num]);
	}

	throw ElementNotFound ();
	//#UC END# *45CAFC2303D8_45CB0F1F00FA**cpp*
}

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// Операция выполняется после заполнения контейнера (например сортировка данных)
template <class Type1, class Type2, class Functor1, class Functor2>
void SortedTypeConverter<Type1, Type2, Functor1, Functor2>::post_init () {
	//#UC START# *45CAF3550251_45CB0F1F00FA*
	T1Iterator begin1 = this->t1begin ();
	T1Iterator end1 = this->t1end ();
	T2Iterator begin2 = this->t2begin ();
	T2Iterator end2 = this->t2end ();
	size_t count = std::distance (begin1, end1);
	
	m_index1.reserve (count);
	m_index2.reserve (count);

	std::vector<Type1> old1;
	std::vector<Type2> old2;
	old1.reserve (count);
	old2.reserve (count);
	std::copy (begin1, end1, old1.begin ());
	std::copy (begin2, end2, old2.begin ());

	std::sort<T1Iterator, Functor1> (begin1, end1, Functor1 ());
	std::sort<T2Iterator, Functor2> (begin2, end2, Functor2 ());
	for (size_t i = 0; i < count; ++i) {
		T1Iterator it1 = std::lower_bound (begin1, end1, old1[i], Functor1 ());
		T2Iterator it2 = std::lower_bound (begin2, end2, old2[i], Functor2 ());

		size_t index1 = std::distance (begin1, it1);
		size_t index2 = std::distance (begin2, it2);

		m_index1[index1] = index2;
		m_index2[index2] = index1;
	}
	//#UC END# *45CAF3550251_45CB0F1F00FA**cpp*
}
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

