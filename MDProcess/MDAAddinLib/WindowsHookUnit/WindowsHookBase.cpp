////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/WindowsHookUnit/WindowsHookBase.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookUnit::WindowsHookBase
//
// базовый абстраткный класс хука
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/WindowsHookUnit/WindowsHookBase.h"

//#UC START# *45CC2CE4038A_CUSTOM_INCLUDES*
//#UC END# *45CC2CE4038A_CUSTOM_INCLUDES*


//#UC START# *45CC2CE4038A*
POINT WindowsHookBase::MouseFunctor::s_mouse_point = {0, 0};
//#UC END# *45CC2CE4038A*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// собственно хэндл хука, который создается через SetWindowsHookEx
WindowsHookBase::HookMap WindowsHookBase::s_hookes;




//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор по умолчанию - в нем происходит регистрация объекта
// в качестве обработчика хука
WindowsHookBase::WindowsHookBase ()
//#UC START# *45CC38C6038A_BASE_INIT*
//#UC END# *45CC38C6038A_BASE_INIT*
{
	//#UC START# *45CC38C6038A_BODY*
	(*HookHandlersSingleton::instance ())[WH_KEYBOARD].insert (this);
	(*HookHandlersSingleton::instance ())[WH_MOUSE].insert (this);
	(*HookHandlersSingleton::instance ())[WH_MSGFILTER].insert (this);
	(*HookHandlersSingleton::instance ())[WH_CALLWNDPROC].insert (this);
	(*HookHandlersSingleton::instance ())[WH_GETMESSAGE].insert (this);

	for (
		HookProcMap::iterator it = HookHandlersSingleton::instance ()->begin ()
		; it != HookHandlersSingleton::instance ()->end ()
		; it++
	) {
		HookMap::iterator hook_it = s_hookes.find (it->first);
		if (hook_it == s_hookes.end ()) {
			HOOKPROC func = 0;			
			switch (it->first) {
				case WH_KEYBOARD: 
					func = HookProc<WH_KEYBOARD>::proc;
					break;
				case WH_MOUSE:
					func = HookProc<WH_MOUSE>::proc;
					break;
				case WH_MSGFILTER:
					func = HookProc<WH_MSGFILTER>::proc;
					break;
				case WH_CALLWNDPROC:
					func = HookProc<WH_CALLWNDPROC>::proc;
					break;
				case WH_GETMESSAGE:
					func = HookProc<WH_GETMESSAGE>::proc;
					break;
			}	
			if (func) {
				s_hookes[it->first] = SetWindowsHookEx (it->first, func, NULL, GetCurrentThreadId ());
			}
		}
	}
	//#UC END# *45CC38C6038A_BODY*
}

WindowsHookBase::~WindowsHookBase () {
	//#UC START# *45CC2CE4038A_DESTR_BODY*
	
	for (
		HookProcMap::iterator it = HookHandlersSingleton::instance ()->begin ()
		; it != HookHandlersSingleton::instance ()->end ()
		; it++
	) {
		HookProcMap::iterator proc_it = HookHandlersSingleton::instance ()->find (it->first);		
		if (proc_it != HookHandlersSingleton::instance ()->end ()) {		
			proc_it->second.erase (this);		
			//если есть хэндл и не осталось зарегистрированных обработчиков
			//отписываем хук
			HookMap::iterator hook_it = s_hookes.find (it->first);
			if (hook_it != s_hookes.end () && proc_it->second.empty ()) {
				UnhookWindowsHookEx (hook_it->second);
				s_hookes.erase (hook_it->first);
			}
		}
	}
	//#UC END# *45CC2CE4038A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// обработчик сообщение, до их передачи в окннную процедуру
LRESULT WindowsHookBase::call_wnd_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F38604037A*
	return -1;
	//#UC END# *46F38604037A*
}

// обработчик сообщений, помещаемых в очередь
LRESULT WindowsHookBase::get_message_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F385F0002E*
	return -1;
	//#UC END# *46F385F0002E*
}

// функция обработчик сообщений от клавиатуры
LRESULT WindowsHookBase::keyboard_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *45D2CDAB00FA*
	return -1;
	//#UC END# *45D2CDAB00FA*
}

// функция обработчик WH_MSGFILTER
LRESULT WindowsHookBase::message_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F366ED008C*
	return -1;
	//#UC END# *46F366ED008C*
}

// функция обработчик сообщений от мыши
LRESULT WindowsHookBase::mouse_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *45CC2DB30203*
	return -1;
	//#UC END# *45CC2DB30203*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

