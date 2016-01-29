////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/data/DynamicBitSet.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::data::DynamicBitSet
//
// ���������� ������������ ���-����, ����� �������������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ���������� ������������ ���-����, ����� �������������� ������.
class DynamicBitSet {
	SET_OBJECT_COUNTER (DynamicBitSet)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ������������ ����� ��� �������� ��������
	typedef std::vector < char > Buffer;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ������� ���-��� ���������� ������� (� �����)
	explicit DynamicBitSet (unsigned long size = 0);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� �������� ���� �� �������
	char operator[] (unsigned long ind) const;

	// ������������� ��������� ��� � 0
	void reset (unsigned long ind);

	// �������� ������ ���-����
	void resize (unsigned long size);

	// ������������� ��������� ��� � 1
	void set (unsigned long ind);

	// ���������� ������ ���-���� (� �����)
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

