////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHook.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookImpl::WindowsHook
//
// Класс, обеспечивающий  перехват различных событий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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

// Класс, обеспечивающий  перехват различных событий
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
	// структура для хранения информации о состоянии мыши
	struct MouseStateDummy {
		// координаты курсора мыши
		POINT point;
		// тип сообщения
		unsigned int message;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// множество зарегестрированных обработчиков
	static HandlerSet s_handlers;

	// состояние мыши
	static MouseStateDummy s_mouse_state;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// констуктор
	WindowsHook ();

	~WindowsHook ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// зарегистрировать обработчик
	void register_handler (const IHookHandler* handler);

	// дерегестирировать обработчик
	void unregister_handler (const IHookHandler* handler);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// множество поддерживаемых хуков
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

