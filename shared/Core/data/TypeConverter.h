////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/TypeConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::TypeConverter
//
// Типы для конвертации из одного типа в другой. Используется в адаптере и для генерации/вычитки
// xml.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_TYPECONVERTER_H__
#define __SHARED_CORE_DATA_TYPECONVERTER_H__

#include "ace/ACE.h"
#include "shared/Core/data/TypeConverterException.h"

//#UC START# *45B4A32E0000_CUSTOM_INCLUDES*
#include <functional>
#include <vector>
#include <cstring>

namespace Core {
	// сравнение двух строк на ЭКВИВАЛЕНТНОСТЬ по их указателям (для сортировки)
	struct ConstCharComparator : public std::binary_function<const char*, const char*, bool> {		
		bool operator () (const char* arg1, const char* arg2) const {
			if (!arg1 && !arg2) {
				return false;
			}
			if (!arg1) {
				return true;
			}
			if (!arg2) {
				return false;
			}
			size_t len1 = std::strlen (arg1);
			size_t len2 = std::strlen (arg2);

			if (len1 < len2) {
				return true;
			} else if (len2 < len1) {
				return false;
			} else {
				return (std::strncmp (arg1, arg2, len1) < 0) ? true : false;
			}

			return false; // not reachable;
		}
	};

	// сравнение двух строк на равенство по их указателям
	struct ConstCharIsEqual : public std::unary_function<const char*, bool> {
		ConstCharIsEqual (const char* ptr) : m_ptr (ptr) {}
		
		bool operator () (const char* ptr) const {
			if (!ptr && !m_ptr) {
				return true;
			}
			if (!ptr || !m_ptr) {
				return false;
			}
			
			size_t len1 = std::strlen (ptr);
			size_t len2 = std::strlen (m_ptr);
			if (len1 != len2) {
				return false;
			}
			
			return (std::strncmp (ptr, m_ptr, len1) == 0) ? true : false;
		}

	private:
		const char* m_ptr;
	};
};
//#UC END# *45B4A32E0000_CUSTOM_INCLUDES*

namespace Core {

// Типы для конвертации из одного типа в другой. Используется в адаптере и для генерации/вычитки
// xml.
template <class Type1, class Type2, class Functor1, class Functor2>
class TypeConverter {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	TypeConverter ();

public:
	virtual ~TypeConverter ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получить значение по ключу
	virtual const Type2& get (const Type1& key) /*throw (ElementNotFound)*/;

	// получить значение по ключу
	virtual const Type1& get (const Type2& key) /*throw (ElementNotFound)*/;

protected:
	// добавляет пару соответствия
	virtual void add (const Type1& t1, const Type2& t2);

	// добавляет пару соответствия (другой порядок???)
	virtual void add (const Type2& t2, const Type1& t1);

private:
	// инициализация контейнера
	virtual void init ();


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// вывод содержимого контейнера (для тестовых целей)
	virtual void dump () const = 0;

protected:
	// функция заполняет контейнер элементами
	virtual void fill_array () = 0;

	// Операция выполняется после заполнения контейнера (например сортировка данных)
	virtual void post_init () = 0;

private:
	// внутрення реализация метода, конвертации типа
	virtual const Type1& get_t1 (const Type2& key) const = 0;

	// внутрення реализация метода, конвертации типа
	virtual const Type2& get_t2 (const Type1& key) const = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// была ли проведена инициализация контейнера
	bool m_inited;

//#UC START# *45B4A32E0000*
protected:
	typedef std::vector<Type1> T1Array;
	typedef typename T1Array::iterator T1Iterator;
	typedef typename T1Array::const_iterator T1ConstIterator;

	typedef std::vector<Type2> T2Array;
	typedef typename T2Array::iterator T2Iterator;
	typedef typename T2Array::const_iterator T2ConstIterator;
	
	T1Iterator t1begin () {
		return m_type1.begin ();
	}

	T1ConstIterator t1begin () const {
		return m_type1.begin ();
	}

	T2Iterator t2begin () {
		return m_type2.begin ();
	}

	T2ConstIterator t2begin () const {
		return m_type2.begin ();
	}

	T1Iterator t1end () {
		return m_type1.end ();
	}

	T1ConstIterator t1end () const {
		return m_type1.end ();
	}

	T2Iterator t2end () {
		return m_type2.end ();
	}
	
	T2ConstIterator t2end () const {
		return m_type2.end ();
	}
	
	const Type1& at_t1 (size_t num) const {
		return m_type1[num];
	}

	const Type2& at_t2 (size_t num) const {
		return m_type2[num];
	}

private:
	T1Array m_type1;
	T2Array m_type2;

//#UC END# *45B4A32E0000*
}; // class TypeConverter

} // namespace Core

#include "shared/Core/data/TypeConverter.i.h"

#endif //__SHARED_CORE_DATA_TYPECONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

