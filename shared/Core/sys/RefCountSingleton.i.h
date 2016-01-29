////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/sys/RefCountSingleton.i.h"
// ��������� inline ������ ���������� C++ (.i.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::Core::sys::RefCountSingleton
//
// ������� ��� ACE-������ ����������� ��� ������ � �������� �� ��������� ������. ������ ������
// ������ ���������� ��� Var, �� ���� ���� ��������� ���������� � ���������� ����� ����������
// ����������� ����� ������� ������ . ��������, "��������" ���� ���������, ���� ���-�� ������
// (��������� ������ ���������) �� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

//#UC START# *457EDB0B02DA_CUSTOM_INCLUDES*
//#UC END# *457EDB0B02DA_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *457EDB0B02DA*
//#UC END# *457EDB0B02DA*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ���������� ������������ ������ �� ���������
template <class _RefCountType>
_RefCountType& RefCountSingleton<_RefCountType>::instance () {
	//#UC START# *457EDB8E0078*
	return *Singleton::instance ()->ptr;
	//#UC END# *457EDB8E0078**cpp*
}

// ���������� ����������� ��� �������� ���������� ����������
template <class _RefCountType>
_RefCountType* RefCountSingleton<_RefCountType>::make () {
	//#UC START# *457F23A60242*
	return new _RefCountType;
	//#UC END# *457F23A60242**cpp*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

