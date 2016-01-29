////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/data/DynamicBitSet.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::DynamicBitSet
//
// Расширение стандартного бит-сета, имеет неограниченный размер.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/data/DynamicBitSet.h"

//#UC START# *44FFFD5902BF_CUSTOM_INCLUDES*
//#UC END# *44FFFD5902BF_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *44FFFD5902BF*
//#UC END# *44FFFD5902BF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создает бит-сет указанного размера (в битах)
DynamicBitSet::DynamicBitSet (unsigned long size)
//#UC START# *44FFFDAE0000_BASE_INIT*
//#UC END# *44FFFDAE0000_BASE_INIT*
{
	//#UC START# *44FFFDAE0000_BODY*
	this->resize(size);
	//#UC END# *44FFFDAE0000_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает значение бита по индексу
char DynamicBitSet::operator[] (unsigned long ind) const {
	//#UC START# *44FFFEA40196*
	unsigned long byte_ind = ind/8;		
	char bit = 1 << ind%8;               
	return bit & m_buf[byte_ind];
	//#UC END# *44FFFEA40196*
}

// устанавливает указанные бит в 0
void DynamicBitSet::reset (unsigned long ind) {
	//#UC START# *44FFFE3F01E4*
	unsigned long byte_ind = ind/8;
	char bit = 1 << ind%8;
	m_buf[byte_ind] &= ~bit;
	//#UC END# *44FFFE3F01E4*
}

// изменяет размер бит-сета
void DynamicBitSet::resize (unsigned long size) {
	//#UC START# *44FFFE1E03C8*
	m_size = size;
	unsigned long byte_size = m_size/8 + (m_size%8 ? 1 : 0);
	m_buf.resize(byte_size, 0);
	//#UC END# *44FFFE1E03C8*
}

// устанавливает указанные бит в 1
void DynamicBitSet::set (unsigned long ind) {
	//#UC START# *44FFFE6301C5*
	unsigned long byte_ind = ind/8;
	char bit = 1 << ind%8;
	m_buf[byte_ind] |= bit;
	//#UC END# *44FFFE6301C5*
}

// возвращает размер бит-сета (в битах)
unsigned long DynamicBitSet::size () const {
	//#UC START# *44FFFDFD036B*
	return m_size;
	//#UC END# *44FFFDFD036B*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

