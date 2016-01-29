////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/HookHandlerBase.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookImpl::HookHandlerBase
//
// ������� ����� ��� ���� ������������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/HookHandlerBase.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHook.h"

namespace WindowsHookImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// ����������� ��-��������� - � �� ���������� ����������� �����������
HookHandlerBase::HookHandlerBase ()
//#UC START# *46F9FC2401B5_BASE_INIT*
//#UC END# *46F9FC2401B5_BASE_INIT*
{
	//#UC START# *46F9FC2401B5_BODY*
	WindowsHook::instance()->register_handler (this);
	//#UC END# *46F9FC2401B5_BODY*
}

HookHandlerBase::~HookHandlerBase () {
	//#UC START# *46F9F244036B_DESTR_BODY*
	WindowsHook::instance()->unregister_handler (this);
	//#UC END# *46F9F244036B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IHookHandler
// ���������� ���������, �� �� �������� � ������� ���������
LRESULT HookHandlerBase::call_wnd_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECC8037A_46F9F244036B*
	return -1;
	//#UC END# *46F9ECC8037A_46F9F244036B*
}

// implemented method from IHookHandler
// ���������� ���������, ���������� � �������
LRESULT HookHandlerBase::get_message_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECCB03A9_46F9F244036B*
	return -1;
	//#UC END# *46F9ECCB03A9_46F9F244036B*
}

// implemented method from IHookHandler
// ������� ���������� ��������� �� ����������
LRESULT HookHandlerBase::keyboard_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECCE036B_46F9F244036B*
	return -1;
	//#UC END# *46F9ECCE036B_46F9F244036B*
}

// implemented method from IHookHandler
// ������� ���������� WH_MSGFILTER
LRESULT HookHandlerBase::message_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECD10242_46F9F244036B*
	return -1;
	//#UC END# *46F9ECD10242_46F9F244036B*
}

// implemented method from IHookHandler
// ������� ���������� ��������� �� ����
LRESULT HookHandlerBase::mouse_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECD401A5_46F9F244036B*
	return -1;
	//#UC END# *46F9ECD401A5_46F9F244036B*
}
} // namespace WindowsHookImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

