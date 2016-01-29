////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/UnsortedTypeConverter.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::UnsortedTypeConverter
//
// несортированный конвертер типов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

//#UC START# *45CB0B3F029F_CUSTOM_INCLUDES*
#include <algorithm>
#include <iterator>
#ifdef _DEBUG
#include <iostream>
#endif // _DEBUG
//#UC END# *45CB0B3F029F_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45CB0B3F029F*
//#UC END# *45CB0B3F029F*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class Type1, class Type2, class Functor1, class Functor2>
UnsortedTypeConverter<Type1, Type2, Functor1, Functor2>::~UnsortedTypeConverter () {
	//#UC START# *45CB0B3F029F_DESTR_BODY*
	//#UC END# *45CB0B3F029F_DESTR_BODY**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// вывод содержимого контейнера (для тестовых целей)
template <class Type1, class Type2, class Functor1, class Functor2>
void UnsortedTypeConverter<Type1, Type2, Functor1, Functor2>::dump () const {
	//#UC START# *45CAF04A03B9_45CB0B3F029F*
#ifdef _DEBUG
		size_t size = std::distance (this->t1begin (), this->t1end ());
	
		std::cout << "Unsorted array" << std::endl << "Pairs is:" << std::endl;		
		for (size_t i = 0; i < size; ++i) {
			std::cout << "for element: <" << this->at_t1 (i)
				<< "> pair is: " << this->at_t2 (i) << std::endl;
		}
#endif // _DEBUG
	//#UC END# *45CAF04A03B9_45CB0B3F029F**cpp*
}

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// внутрення реализация метода, конвертации типа
template <class Type1, class Type2, class Functor1, class Functor2>
const Type1& UnsortedTypeConverter<Type1, Type2, Functor1, Functor2>::get_t1 (const Type2& key) const {
	//#UC START# *45CAFBFA002E_45CB0B3F029F*
	T2ConstIterator begin = this->t2begin ();
	T2ConstIterator end = this->t2end ();

	T2ConstIterator result = std::find_if (begin, end, Functor2 (key));

	if (result != end) {
		return this->at_t1 (std::distance (begin, result));
	}

	throw ElementNotFound ();
	//#UC END# *45CAFBFA002E_45CB0B3F029F**cpp*
}

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// внутрення реализация метода, конвертации типа
template <class Type1, class Type2, class Functor1, class Functor2>
const Type2& UnsortedTypeConverter<Type1, Type2, Functor1, Functor2>::get_t2 (const Type1& key) const {
	//#UC START# *45CAFC2303D8_45CB0B3F029F*
	T1ConstIterator begin = this->t1begin ();
	T1ConstIterator end = this->t1end ();

	T1ConstIterator result = std::find_if (begin, end, Functor1 (key));

	if (result != end) {
		return this->at_t2 (std::distance (begin, result));
	}

	throw ElementNotFound ();
	//#UC END# *45CAFC2303D8_45CB0B3F029F**cpp*
}

// implemented method from TypeConverter<Type1, Type2, Functor1, Functor2>
// Операция выполняется после заполнения контейнера (например сортировка данных)
template <class Type1, class Type2, class Functor1, class Functor2>
void UnsortedTypeConverter<Type1, Type2, Functor1, Functor2>::post_init () {
	//#UC START# *45CAF3550251_45CB0B3F029F*
	//#UC END# *45CAF3550251_45CB0B3F029F**cpp*
}
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

