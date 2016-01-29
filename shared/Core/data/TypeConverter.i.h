////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/TypeConverter.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::TypeConverter
//
// Типы для конвертации из одного типа в другой. Используется в адаптере и для генерации/вычитки
// xml.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

//#UC START# *45B4A32E0000_CUSTOM_INCLUDES*
//#UC END# *45B4A32E0000_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45B4A32E0000*
//#UC END# *45B4A32E0000*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
template <class Type1, class Type2, class Functor1, class Functor2>
TypeConverter<Type1, Type2, Functor1, Functor2>::TypeConverter ()
//#UC START# *45CAFBAC00DA_BASE_INIT*
: m_inited (false)
//#UC END# *45CAFBAC00DA_BASE_INIT**cpp*
{
	//#UC START# *45CAFBAC00DA_BODY*
	//#UC END# *45CAFBAC00DA_BODY**cpp*
}

template <class Type1, class Type2, class Functor1, class Functor2>
TypeConverter<Type1, Type2, Functor1, Functor2>::~TypeConverter () {
	//#UC START# *45B4A32E0000_DESTR_BODY*
	//#UC END# *45B4A32E0000_DESTR_BODY**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет пару соответствия
template <class Type1, class Type2, class Functor1, class Functor2>
void TypeConverter<Type1, Type2, Functor1, Functor2>::add (const Type1& t1, const Type2& t2) {
	//#UC START# *45CB08D600EA*
	m_type1.push_back (t1);
	m_type2.push_back (t2);
	//#UC END# *45CB08D600EA**cpp*
}

// добавляет пару соответствия (другой порядок???)
template <class Type1, class Type2, class Functor1, class Functor2>
void TypeConverter<Type1, Type2, Functor1, Functor2>::add (const Type2& t2, const Type1& t1) {
	//#UC START# *45CB08F903D8*
	this->add (t1, t2);
	//#UC END# *45CB08F903D8**cpp*
}

// получить значение по ключу
template <class Type1, class Type2, class Functor1, class Functor2>
const Type2& TypeConverter<Type1, Type2, Functor1, Functor2>::get (const Type1& key) /*throw (ElementNotFound)*/ {
	//#UC START# *45CAF5C202EE*
		this->init ();
		
		return this->get_t2 (key);
	//#UC END# *45CAF5C202EE**cpp*
}

// получить значение по ключу
template <class Type1, class Type2, class Functor1, class Functor2>
const Type1& TypeConverter<Type1, Type2, Functor1, Functor2>::get (const Type2& key) /*throw (ElementNotFound)*/ {
	//#UC START# *45CAF5D20000*
		this->init ();
		
		return this->get_t1 (key);
	//#UC END# *45CAF5D20000**cpp*
}

// инициализация контейнера
template <class Type1, class Type2, class Functor1, class Functor2>
void TypeConverter<Type1, Type2, Functor1, Functor2>::init () {
	//#UC START# *45CB078C03B9*
		if (m_inited) {
			return;
		}
		
		this->fill_array ();
		this->post_init ();
		
		m_inited = true;
	//#UC END# *45CB078C03B9**cpp*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

