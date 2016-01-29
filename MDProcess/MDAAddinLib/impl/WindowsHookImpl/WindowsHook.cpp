////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHook.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookImpl::WindowsHook
//
// Класс, обеспечивающий  перехват различных событий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHook.h"

//#UC START# *45CC2CE4038A_CUSTOM_INCLUDES*
//#UC END# *45CC2CE4038A_CUSTOM_INCLUDES*

namespace WindowsHookImpl {

//#UC START# *45CC2CE4038A*
//#UC END# *45CC2CE4038A*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// множество зарегестрированных обработчиков
HandlerSet WindowsHook::s_handlers;

// состояние мыши
WindowsHook::MouseStateDummy WindowsHook::s_mouse_state;


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// констуктор
WindowsHook::WindowsHook ()
//#UC START# *46F9FA58031C_BASE_INIT*
//#UC END# *46F9FA58031C_BASE_INIT*
{
	//#UC START# *46F9FA58031C_BODY*
	s_handlers.clear ();
	m_hookes.clear ();
	m_hookes.insert (SetWindowsHookEx (WH_KEYBOARD, HookProc<WH_KEYBOARD>::proc, NULL, GetCurrentThreadId ()));
	m_hookes.insert (SetWindowsHookEx (WH_MOUSE, HookProc<WH_MOUSE>::proc, NULL, GetCurrentThreadId ()));
	//m_hookes.insert (SetWindowsHookEx (WH_MSGFILTER, HookProc<WH_MSGFILTER>::proc, NULL, GetCurrentThreadId ()));
	//m_hookes.insert (SetWindowsHookEx (WH_CALLWNDPROC, HookProc<WH_CALLWNDPROC>::proc, NULL, GetCurrentThreadId ()));
	m_hookes.insert (SetWindowsHookEx (WH_GETMESSAGE, HookProc<WH_GETMESSAGE>::proc, NULL, GetCurrentThreadId ()));
	//#UC END# *46F9FA58031C_BODY*
}

WindowsHook::~WindowsHook () {
	//#UC START# *45CC2CE4038A_DESTR_BODY*
	const HookSet::iterator it_begin = m_hookes.begin ();
	const HookSet::iterator it_end = m_hookes.end ();
	for (HookSet::iterator it = it_begin; it != it_end; ++it) {
		UnhookWindowsHookEx (*it);
	}
	s_handlers.clear ();
	//#UC END# *45CC2CE4038A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// зарегистрировать обработчик
void WindowsHook::register_handler (const IHookHandler* handler) {
	//#UC START# *46F9FA4701B5*
	s_handlers.insert (const_cast<IHookHandler*> (handler));
	//#UC END# *46F9FA4701B5*
}

// дерегестирировать обработчик
void WindowsHook::unregister_handler (const IHookHandler* handler) {
	//#UC START# *46F9FA4B00EA*
	s_handlers.erase (const_cast<IHookHandler*> (handler));
	//#UC END# *46F9FA4B00EA*
}

} // namespace WindowsHookImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

