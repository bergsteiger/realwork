////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/Core/data/BitMaskType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::BitMaskType
//
// Ѕазовый класс реализации типа битовой маски. »спользуетс€ при генерации конкретного типа по
// шаблону с модели.
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_BITMASKTYPE_H__
#define __SHARED_CORE_DATA_BITMASKTYPE_H__

#include "ace/ACE.h"

namespace Core {

// Ѕазовый класс реализации типа битовой маски. »спользуетс€ при генерации конкретного типа по
// шаблону с модели.
template <typename _BaseType, typename _TargetType>
class BitMaskType {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit BitMaskType (_BaseType value);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// провер€ет не равенство двух значений
	bool operator != (_TargetType c) const;

	// проводит логическое умножение с переданным значением
	_TargetType operator & (_TargetType c) const;

	// провер€ет равенство двух значений
	bool operator == (_TargetType c) const;

	// проводит логическое сложение с переданным значением
	_TargetType operator | (_TargetType c) const;

	// проводит логическое вычитание переданного значени€
	_TargetType operator ~ () const;

	// провер€ет что переданное значение битово не меньше текущего (т.к. все биты установленные в
	// передапнном установленн и в текущем)
	bool test (_TargetType c) const;

	// возвращает значение маски как целое число
	_BaseType value () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	_BaseType m_value;
}; // class BitMaskType

} // namespace Core

#include "shared/Core/data/BitMaskType.i.h"

#endif //__SHARED_CORE_DATA_BITMASKTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

