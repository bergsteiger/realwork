////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/sys/RefCountObjectBase.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::RefCountObjectBase
//
// �����-������� ��� ���������� �������� ������ �� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/RefCountObjectBase.h"

//#UC START# *45003674031C_CUSTOM_INCLUDES*
//#UC END# *45003674031C_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *45003674031C*
//#UC END# *45003674031C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������, ��� �������� ������� ������� ������ ��������������� � 1
RefCountObjectBase::RefCountObjectBase ()
//#UC START# *4774C9F40398_BASE_INIT*
: m_counter (1)
//#UC END# *4774C9F40398_BASE_INIT*
{
	//#UC START# *4774C9F40398_BODY*
	//#UC END# *4774C9F40398_BODY*
}

RefCountObjectBase::~RefCountObjectBase () {
	//#UC START# *45003674031C_DESTR_BODY*
	//#UC END# *45003674031C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ��������� ������� ������
unsigned long RefCountObjectBase::addref () const {
	//#UC START# *4774C8E802C5*
	return ++m_counter;
	//#UC END# *4774C8E802C5*
}

// ����� ��� ����������� ������� (����������, ����� ������� ������ �� ������� ����� ����)
void RefCountObjectBase::delete_obj () {
	//#UC START# *4774CACC0210*
	delete this;
	//#UC END# *4774CACC0210*
}

// ������������� ������� ������ � 1
void RefCountObjectBase::init_counter () const {
	//#UC START# *4774CCC8033E*
	m_counter = 1;
	//#UC END# *4774CCC8033E*
}

// ����� ��������� ������� ������ � ���������� � �������� ���������� ��� ��������. ������� ��
// release � ���, ��� � ������ ������ �� ���������� �������� �������, ���� ���� ������� ������
// ������ ����.
unsigned long RefCountObjectBase::internal_release () const {
	//#UC START# *4774CB050130*
	return --m_counter;
	//#UC END# *4774CB050130*
}

// ���������� �������� �������� ������
unsigned long RefCountObjectBase::ref_count () const {
	//#UC START# *4774C9B40391*
	return m_counter.value ();
	//#UC END# *4774C9B40391*
}

// ��������� ������� ������, ��� ���������� �������� ���� - ������ ���������
unsigned long RefCountObjectBase::release () const {
	//#UC START# *4774C93B031B*
	long const counter = --this->m_counter;
	if (counter == 0) {			
		// For objects in ObjectPool m_counter MUST be equal to 1 after releasing
		this->m_counter = 1;
		const_cast<RefCountObjectBase*const>(this)->delete_obj ();
	}
	return counter;
	//#UC END# *4774C93B031B*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

