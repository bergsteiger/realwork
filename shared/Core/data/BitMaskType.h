////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/data/BitMaskType.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::BitMaskType
//
// ������� ����� ���������� ���� ������� �����. ������������ ��� ��������� ����������� ���� ��
// ������� � ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_DATA_BITMASKTYPE_H__
#define __SHARED_CORE_DATA_BITMASKTYPE_H__

#include "ace/ACE.h"

namespace Core {

// ������� ����� ���������� ���� ������� �����. ������������ ��� ��������� ����������� ���� ��
// ������� � ������.
template <typename _BaseType, typename _TargetType>
class BitMaskType {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit BitMaskType (_BaseType value);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� �� ��������� ���� ��������
	bool operator != (_TargetType c) const;

	// �������� ���������� ��������� � ���������� ���������
	_TargetType operator & (_TargetType c) const;

	// ��������� ��������� ���� ��������
	bool operator == (_TargetType c) const;

	// �������� ���������� �������� � ���������� ���������
	_TargetType operator | (_TargetType c) const;

	// �������� ���������� ��������� ����������� ��������
	_TargetType operator ~ () const;

	// ��������� ��� ���������� �������� ������ �� ������ �������� (�.�. ��� ���� ������������� �
	// ����������� ����������� � � �������)
	bool test (_TargetType c) const;

	// ���������� �������� ����� ��� ����� �����
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

