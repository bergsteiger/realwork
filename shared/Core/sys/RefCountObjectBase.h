////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/sys/RefCountObjectBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::RefCountObjectBase
//
// �����-������� ��� ���������� �������� ������ �� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_REFCOUNTOBJECTBASE_H__
#define __SHARED_CORE_SYS_REFCOUNTOBJECTBASE_H__

#include "ace/ACE.h"
#include "shared/Core/sys/IObject.h"

//#UC START# *45003674031C_CUSTOM_INCLUDES*
#include "shared/Core/sys/AtomicOp.h"
//#UC END# *45003674031C_CUSTOM_INCLUDES*

namespace Core {

// �����-������� ��� ���������� �������� ������ �� ���������
class RefCountObjectBase :
	virtual public IObject
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// �����������, ��� �������� ������� ������� ������ ��������������� � 1
	RefCountObjectBase ();

public:
	virtual ~RefCountObjectBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ������� ������
	unsigned long addref () const;

	// ���������� �������� �������� ������
	unsigned long ref_count () const;

	// ��������� ������� ������, ��� ���������� �������� ���� - ������ ���������
	virtual unsigned long release () const;

protected:
	// ����� ��� ����������� ������� (����������, ����� ������� ������ �� ������� ����� ����)
	virtual void delete_obj ();

	// ������������� ������� ������ � 1
	void init_counter () const;

	// ����� ��������� ������� ������ � ���������� � �������� ���������� ��� ��������. ������� ��
	// release � ���, ��� � ������ ������ �� ���������� �������� �������, ���� ���� ������� ������
	// ������ ����.
	unsigned long internal_release () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Core::AtomicOp<long> m_counter;

//#UC START# *45003674031C*
// ��������� ���������� ����������� � �������� ������������
private:
	RefCountObjectBase (const RefCountObjectBase&);
	RefCountObjectBase& operator= (const RefCountObjectBase&);
//#UC END# *45003674031C*
}; // class RefCountObjectBase

} // namespace Core


#endif //__SHARED_CORE_SYS_REFCOUNTOBJECTBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

