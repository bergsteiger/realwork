////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHookImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAAddinLib::WindowsHookImpl
//
// ����� � ������������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_H__
#define __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include "shared/Core/data/unsorted_containers.h"


namespace WindowsHookImpl {

// ��������� �������������� �����
typedef std::set < HHOOK > HookSet;

class IHookHandler;
typedef ::Core::Var<IHookHandler> IHookHandler_var;
typedef ::Core::Var<const IHookHandler> IHookHandler_cvar;
// ����� ����������� ��������, ������� ������ ������������� ���������� ����
class IHookHandler
	: virtual public ::Core::IObject
{
public:
	// ���������� ���������, �� �� �������� � ������� ���������
	virtual LRESULT call_wnd_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// ���������� ���������, ���������� � �������
	virtual LRESULT get_message_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// ������� ���������� ��������� �� ����������
	virtual LRESULT keyboard_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// ������� ���������� WH_MSGFILTER
	virtual LRESULT message_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// ������� ���������� ��������� �� ����
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam) = 0;
};

// ��������� ������������
typedef boost::unordered_set <IHookHandler*> HandlerSet;

} //namespace WindowsHookImpl


#endif //__MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

