////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/WindowsHookUnit/MouseTracker.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookUnit::MouseTracker
//
// класс-для слежения за мышью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/WindowsHookUnit/MouseTracker.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MouseTracker::~MouseTracker () {
	//#UC START# *462D9A1D000F_DESTR_BODY*
	//#UC END# *462D9A1D000F_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from WindowsHookBase
// функция обработчик сообщений от мыши
LRESULT MouseTracker::mouse_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *45CC2DB30203_462D9A1D000F*
	MOUSEHOOKSTRUCT* st = (MOUSEHOOKSTRUCT*)lParam;
	UINT msg = (UINT) wParam;	
	if (st && msg && (msg == WM_RBUTTONUP)) {	
		this->x_coord () = st->pt.x;
		this->y_coord () = st->pt.y;
	}
	return -1;
	//#UC END# *45CC2DB30203_462D9A1D000F*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

