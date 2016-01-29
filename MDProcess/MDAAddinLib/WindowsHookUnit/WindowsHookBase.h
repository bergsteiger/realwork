////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/WindowsHookUnit/WindowsHookBase.h"
// C++ header files (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookUnit::WindowsHookBase
//
// ������� ����������� ����� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_WINDOWSHOOKUNIT_WINDOWSHOOKBASE_H__
#define __MDPROCESS_MDAADDINLIB_WINDOWSHOOKUNIT_WINDOWSHOOKBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>

//#UC START# *45CC2CE4038A_CUSTOM_INCLUDES*
//#UC END# *45CC2CE4038A_CUSTOM_INCLUDES*


// ������� ����������� ����� ����
class WindowsHookBase :
	virtual public Core::UnsortedLessBase
{
	SET_OBJECT_COUNTER (WindowsHookBase)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// �� ����
	typedef int HookID;

	// ���� ��� ���� - ��� ���� (WH_CALLWNDPROC, WH_DEBUG � �.�) ��������
	// - ����� ����
	typedef std::map < const HookID, HHOOK > HookMap;

	// ��������� � ������������� �����
	typedef Core::UnsortedSet < WindowsHookBase* > HookSet;

	// ���� ������������������� �����
	typedef std::map < const HookID, HookSet > HookProcMap;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ����������� �����
	typedef ACE_Singleton <HookProcMap, ACE_SYNCH_RECURSIVE_MUTEX> HookHandlersSingleton;

	// ���������� ����� ����, ������� ��������� ����� SetWindowsHookEx
	static HookMap s_hookes;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ����������� �� ��������� - � ��� ���������� ����������� �������
	// � �������� ����������� ����
	WindowsHookBase ();

public:
	virtual ~WindowsHookBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// ���������� ���������, �� �� �������� � ������� ���������
	virtual LRESULT call_wnd_proc (int code, WPARAM wParam, LPARAM lParam);

	// ���������� ���������, ���������� � �������
	virtual LRESULT get_message_proc (int code, WPARAM wParam, LPARAM lParam);

	// ������� ���������� ��������� �� ����������
	virtual LRESULT keyboard_proc (int code, WPARAM wParam, LPARAM lParam);

	// ������� ���������� WH_MSGFILTER
	virtual LRESULT message_proc (int code, WPARAM wParam, LPARAM lParam);

	// ������� ���������� ��������� �� ����
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam);


//#UC START# *45CC2CE4038A*
	struct KeyboardFunctor {
		KeyboardFunctor (WindowsHookBase* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {
			return obj->keyboard_proc (code, wParam, lParam);
		}
	private:
		WindowsHookBase* obj;
	};
	struct MouseFunctor {
		MouseFunctor (WindowsHookBase* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {
			MOUSEHOOKSTRUCT* st = (MOUSEHOOKSTRUCT*)lParam;
			/*if (
				s_mouse_point.x == st->pt.x
				&& s_mouse_point.y == st->pt.y
			) {
				return 1;
			}*/
			s_mouse_point = st->pt;
			return obj->mouse_proc (code, wParam, lParam);
		}
	private:
		static POINT s_mouse_point;
		WindowsHookBase* obj;
	};

	struct MessageFunctor {
		MessageFunctor (WindowsHookBase* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {
			return obj->message_proc (code, wParam, lParam);
		}
	private:
		WindowsHookBase* obj;
	};

	struct CallWndProcFunctor {
		CallWndProcFunctor (WindowsHookBase* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {
			return obj->call_wnd_proc (code, wParam, lParam);
		}
	private:
		WindowsHookBase* obj;
	};
	struct GetMessageFunctor {
		GetMessageFunctor (WindowsHookBase* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {
			return obj->get_message_proc (code, wParam, lParam);
		}
	private:
		WindowsHookBase* obj;
	};

	template <int HOOK_ID> struct functor_select;
	template <>
	struct functor_select<WH_KEYBOARD> {
		typedef KeyboardFunctor Result;
	};
	template <>
	struct functor_select<WH_MOUSE> {
		typedef MouseFunctor Result;
	};
	template <>
	struct functor_select<WH_MSGFILTER> {
		typedef MessageFunctor Result;
	};
	
	template <>
	struct functor_select<WH_CALLWNDPROC> {
		typedef CallWndProcFunctor Result;
	};
	template <>
	struct functor_select<WH_GETMESSAGE> {
		typedef GetMessageFunctor Result;
	};

	template <int HOOK_ID>
	class HookProc {
	public:
		typedef typename functor_select<HOOK_ID>::Result Functor;
		static LRESULT CALLBACK proc (int code, WPARAM wParam, LPARAM lParam) {
			if (code >= 0) {
				WindowsHookBase::HookProcMap::iterator proc_it = HookHandlersSingleton::instance ()->find (HOOK_ID);
				if (proc_it != HookHandlersSingleton::instance ()->end ()) {
					WindowsHookBase::HookProcMap::data_type::iterator handlers_it = proc_it->second.begin ();
					WindowsHookBase::HookProcMap::data_type::iterator handlers_it_end = proc_it->second.end ();
					for (; handlers_it != handlers_it_end; ++handlers_it) {
						Functor func (*handlers_it);
						LRESULT res = func.exec (code, wParam, lParam);
						if (res >= 0) {
							return res;
						}
					}
				}
			}
			return CallNextHookEx(s_hookes[HOOK_ID], code, wParam, lParam);
		}
	};	
//#UC END# *45CC2CE4038A*
}; // class WindowsHookBase



#endif //__MDPROCESS_MDAADDINLIB_WINDOWSHOOKUNIT_WINDOWSHOOKBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

