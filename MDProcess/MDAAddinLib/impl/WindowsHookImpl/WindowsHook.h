////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHook.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookImpl::WindowsHook
//
// �����, ��������������  �������� ��������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_WINDOWSHOOK_H__
#define __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_WINDOWSHOOK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHookImpl.h"

//#UC START# *45CC2CE4038A_CUSTOM_INCLUDES*
//#UC END# *45CC2CE4038A_CUSTOM_INCLUDES*

namespace WindowsHookImpl {

// �����, ��������������  �������� ��������� �������
class WindowsHook {
	SET_OBJECT_COUNTER (WindowsHook)

	// singleton declaration
	typedef ACE_Singleton <WindowsHook, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <WindowsHook, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static WindowsHook* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��������� ��� �������� ���������� � ��������� ����
	struct MouseStateDummy {
		// ���������� ������� ����
		POINT point;
		// ��� ���������
		unsigned int message;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ��������� ������������������ ������������
	static HandlerSet s_handlers;

	// ��������� ����
	static MouseStateDummy s_mouse_state;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// ����������
	WindowsHook ();

	~WindowsHook ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������������� ����������
	void register_handler (const IHookHandler* handler);

	// ����������������� ����������
	void unregister_handler (const IHookHandler* handler);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������� �������������� �����
	HookSet m_hookes;

//#UC START# *45CC2CE4038A*
	struct KeyboardFunctor {
		KeyboardFunctor (IHookHandler* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {
			return obj->keyboard_proc (code, wParam, lParam);
		}
	private:
		IHookHandler* obj;
	};
	struct MouseFunctor {
		MouseFunctor (IHookHandler* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {						
			LRESULT res = obj->mouse_proc (code, wParam, lParam);
			s_mouse_state.message = (unsigned long)wParam;
			s_mouse_state.point = (reinterpret_cast<MOUSEHOOKSTRUCT*>(lParam))->pt;
			return res;
		}
	private:
		IHookHandler* obj;
	};

	struct GetMessageFunctor {
		GetMessageFunctor (IHookHandler* obj_) {
			obj = obj_;
		}
		LRESULT exec (int code, WPARAM wParam, LPARAM lParam) {			
			return obj->get_message_proc (code, wParam, lParam);
		}
	private:
		IHookHandler* obj;
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
	struct functor_select<WH_GETMESSAGE> {
		typedef GetMessageFunctor Result;
	};

	template <int HOOK_ID>
	class HookProc {
	public:
		typedef typename functor_select<HOOK_ID>::Result Functor;

		static LRESULT CALLBACK proc (int code, WPARAM wParam, LPARAM lParam) {
			if (code >= 0) {
				const HandlerSet::iterator it_begin = WindowsHook::s_handlers.begin ();
				const HandlerSet::iterator it_end = WindowsHook::s_handlers.end ();
				for (HandlerSet::iterator it = it_begin; it != it_end; ++it) {
					Functor func (*it);
					LRESULT res = func.exec (code, wParam, lParam);
					if (res >= 0) {
						return res;
					}
				}
			}
			return CallNextHookEx(0, code, wParam, lParam);
		}
	};	
//#UC END# *45CC2CE4038A*
}; // class WindowsHook

} // namespace WindowsHookImpl


#endif //__MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_WINDOWSHOOK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

