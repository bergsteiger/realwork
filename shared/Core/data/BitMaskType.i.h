////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/shared/Core/data/BitMaskType.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::BitMaskType
//
// Ѕазовый класс реализации типа битовой маски. »спользуетс€ при генерации конкретного типа по
// шаблону с модели.
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

namespace Core {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <typename _BaseType, typename _TargetType>
BitMaskType<_BaseType, _TargetType>::BitMaskType (_BaseType value)
//#UC START# *45F00B92018F_BASE_INIT*
	: m_value (value)
//#UC END# *45F00B92018F_BASE_INIT**cpp*
{
	//#UC START# *45F00B92018F_BODY*
	//#UC END# *45F00B92018F_BODY**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// провер€ет не равенство двух значений
template <typename _BaseType, typename _TargetType>
bool BitMaskType<_BaseType, _TargetType>::operator != (_TargetType c) const {
	//#UC START# *45F00E9403D1*
	return m_value != c.m_value;
	//#UC END# *45F00E9403D1**cpp*
}

// проводит логическое умножение с переданным значением
template <typename _BaseType, typename _TargetType>
_TargetType BitMaskType<_BaseType, _TargetType>::operator & (_TargetType c) const {
	//#UC START# *45F00E9A02A8*
	return m_value & c.m_value;
	//#UC END# *45F00E9A02A8**cpp*
}

// провер€ет равенство двух значений
template <typename _BaseType, typename _TargetType>
bool BitMaskType<_BaseType, _TargetType>::operator == (_TargetType c) const {
	//#UC START# *45F00BB701CD*
	return m_value == c.m_value;
	//#UC END# *45F00BB701CD**cpp*
}

// проводит логическое сложение с переданным значением
template <typename _BaseType, typename _TargetType>
_TargetType BitMaskType<_BaseType, _TargetType>::operator | (_TargetType c) const {
	//#UC START# *45F00BD60008*
	return m_value | c.m_value;
	//#UC END# *45F00BD60008**cpp*
}

// проводит логическое вычитание переданного значени€
template <typename _BaseType, typename _TargetType>
_TargetType BitMaskType<_BaseType, _TargetType>::operator ~ () const {
	//#UC START# *45F00E9F0008*
	return ~m_value;
	//#UC END# *45F00E9F0008**cpp*
}

// провер€ет что переданное значение битово не меньше текущего (т.к. все биты установленные в
// передапнном установленн и в текущем)
template <typename _BaseType, typename _TargetType>
bool BitMaskType<_BaseType, _TargetType>::test (_TargetType c) const {
	//#UC START# *45F06DE000A4*
	return (m_value & c.m_value) == c.m_value;
	//#UC END# *45F06DE000A4**cpp*
}

// возвращает значение маски как целое число
template <typename _BaseType, typename _TargetType>
_BaseType BitMaskType<_BaseType, _TargetType>::value () const {
	//#UC START# *45F00CA802F6*
	return m_value;
	//#UC END# *45F00CA802F6**cpp*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

