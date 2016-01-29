////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/SortedTypeConverter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::SortedTypeConverter
//
// сортированный конвертер типов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_SORTEDTYPECONVERTER_H__
#define __SHARED_CORE_DATA_SORTEDTYPECONVERTER_H__

#include "ace/ACE.h"
#include "shared/Core/data/TypeConverter.h"

//#UC START# *45CB0F1F00FA_CUSTOM_INCLUDES*
//#UC END# *45CB0F1F00FA_CUSTOM_INCLUDES*

namespace Core {

// сортированный конвертер типов
template <class Type1, class Type2, class Functor1 = std::less<Type1> , class Functor2 = std::less<Type2> >
class SortedTypeConverter :
	virtual public TypeConverter<Type1, Type2, Functor1, Functor2>
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~SortedTypeConverter ();


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

//#UC START# *45CB0F1F00FA*
protected:
	typedef std::vector<Type1> T1Array;
	typedef typename T1Array::iterator T1Iterator;
	typedef typename T1Array::const_iterator T1ConstIterator;

	typedef std::vector<Type2> T2Array;
	typedef typename T2Array::iterator T2Iterator;
	typedef typename T2Array::const_iterator T2ConstIterator;	

private:
	typedef std::vector<size_t> IndexArray;
	IndexArray m_index1;
	IndexArray m_index2;
//#UC END# *45CB0F1F00FA*
}; // class SortedTypeConverter

} // namespace Core

#include "shared/Core/data/SortedTypeConverter.i.h"

#endif //__SHARED_CORE_DATA_SORTEDTYPECONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

