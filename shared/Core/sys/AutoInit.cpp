////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/sys/AutoInit.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Core::sys::start_stop::AutoInit
//
// ����� ��� �������������� ������������� ���������� � �������������� ������ �������� �����
// ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/AutoInit.h"
// by <<uses>> dependencies
#include "shared/Core/sys/start_stop.h"

namespace Core {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// ��������� ������������� (Core::init)
AutoInit::AutoInit ()
//#UC START# *48F6D0820143_BASE_INIT*
//#UC END# *48F6D0820143_BASE_INIT*
{
	//#UC START# *48F6D0820143_BODY*
	Core::init ();
	//#UC END# *48F6D0820143_BODY*
}

AutoInit::~AutoInit () {
	//#UC START# *48F6D00C03C9_DESTR_BODY*
	Core::fini ();
	//#UC END# *48F6D00C03C9_DESTR_BODY*
}


} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

