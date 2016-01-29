////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/DynamicBitSet.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::DynamicBitSet
//
// Расширение стандартного бит-сета, имеет неограниченный размер.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_DYNAMICBITSET_H__
#define __SHARED_CORE_DATA_DYNAMICBITSET_H__

#include "ace/ACE.h"
#include <vector>

//#UC START# *44FFFD5902BF_CUSTOM_INCLUDES*
#include "shared/Core/GDS/ObjectCounter.h"
//#UC END# *44FFFD5902BF_CUSTOM_INCLUDES*

namespace Core {

// Расширение стандартного бит-сета, имеет неограниченный размер.
class DynamicBitSet {
	SET_OBJECT_COUNTER (DynamicBitSet)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// Динамический буфер для хранения значения
	typedef std::vector < char > Buffer;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// создает бит-сет указанного размера (в битах)
	explicit DynamicBitSet (unsigned long size = 0);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвращает значение бита по индексу
	char operator[] (unsigned long ind) const;

	// устанавливает указанные бит в 0
	void reset (unsigned long ind);

	// изменяет размер бит-сета
	void resize (unsigned long size);

	// устанавливает указанные бит в 1
	void set (unsigned long ind);

	// возвращает размер бит-сета (в битах)
	unsigned long size () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Buffer m_buf;

	unsigned long m_size;

//#UC START# *44FFFD5902BF*
//#UC END# *44FFFD5902BF*
}; // class DynamicBitSet

} // namespace Core


#endif //__SHARED_CORE_DATA_DYNAMICBITSET_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

