////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/UnsortedTypeConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::UnsortedTypeConverter
//
// несортированный конвертер типов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_UNSORTEDTYPECONVERTER_H__
#define __SHARED_CORE_DATA_UNSORTEDTYPECONVERTER_H__

#include "ace/ACE.h"
#include "shared/Core/data/TypeConverter.h"

//#UC START# *45CB0B3F029F_CUSTOM_INCLUDES*
namespace Core {
	// функтор сравнения для несортированных контейнеров типов
	template<typename Type>
	struct IsEqualForTypeConverter : public std::unary_function<Type, bool> {
		IsEqualForTypeConverter (const Type& key) : m_key (key) {}
		
		bool operator () (const Type& key) const {
			return key == m_key;
		}
		
	private:
		Type m_key;
	};
};
//#UC END# *45CB0B3F029F_CUSTOM_INCLUDES*

namespace Core {

// несортированный конвертер типов
template <class Type1, class Type2, class Functor1 = IsEqualForTypeConverter<Type1> , class Functor2 = IsEqualForTypeConverter<Type2> >
class UnsortedTypeConverter :
	virtual public TypeConverter<Type1, Type2, Functor1, Functor2>
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~UnsortedTypeConverter ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from TypeConverter
	// вывод содержимого контейнера (для тестовых целей)
	virtual void dump () const;
protected:

	// implemented method from TypeConverter
	// Операция выполняется после заполнения контейнера (например сортировка данных)
	virtual void post_init ();
private:

	// implemented method from TypeConverter
	// внутрення реализация метода, конвертации типа
	virtual const Type1& get_t1 (const Type2& key) const;

	// implemented method from TypeConverter
	// внутрення реализация метода, конвертации типа
	virtual const Type2& get_t2 (const Type1& key) const;

//#UC START# *45CB0B3F029F*
protected:
	typedef std::vector<Type1> T1Array;
	typedef typename T1Array::const_iterator T1ConstIterator;

	typedef std::vector<Type2> T2Array;
	typedef typename T2Array::const_iterator T2ConstIterator;	
//#UC END# *45CB0B3F029F*
}; // class UnsortedTypeConverter

} // namespace Core

#include "shared/Core/data/UnsortedTypeConverter.i.h"

#endif //__SHARED_CORE_DATA_UNSORTEDTYPECONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

