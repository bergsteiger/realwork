////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/HookHandlerBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookImpl::HookHandlerBase
//
// ������� ����� ��� ���� ������������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_HOOKHANDLERBASE_H__
#define __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_HOOKHANDLERBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHookImpl.h"

namespace WindowsHookImpl {

// ������� ����� ��� ���� ������������� �����
class HookHandlerBase;
typedef Core::Var<HookHandlerBase> HookHandlerBase_var;
typedef Core::Var<const HookHandlerBase> HookHandlerBase_cvar;

class HookHandlerBase :
	virtual public IHookHandler
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (HookHandlerBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// ����������� ��-��������� - � �� ���������� ����������� �����������
	HookHandlerBase ();

public:
	virtual ~HookHandlerBase ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IHookHandler
	// ���������� ���������, �� �� �������� � ������� ���������
	virtual LRESULT call_wnd_proc (int code, WPARAM wParam, LPARAM lParam);

	// implemented method from IHookHandler
	// ���������� ���������, ���������� � �������
	virtual LRESULT get_message_proc (int code, WPARAM wParam, LPARAM lParam);

	// implemented method from IHookHandler
	// ������� ���������� ��������� �� ����������
	virtual LRESULT keyboard_proc (int code, WPARAM wParam, LPARAM lParam);

	// implemented method from IHookHandler
	// ������� ���������� WH_MSGFILTER
	virtual LRESULT message_proc (int code, WPARAM wParam, LPARAM lParam);

	// implemented method from IHookHandler
	// ������� ���������� ��������� �� ����
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam);
}; // class HookHandlerBase

} // namespace WindowsHookImpl


#endif //__MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_HOOKHANDLERBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

