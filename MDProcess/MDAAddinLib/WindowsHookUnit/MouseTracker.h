////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/WindowsHookUnit/MouseTracker.h"
// C++ header files (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::WindowsHookUnit::MouseTracker
//
// класс-для слежения за мышью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_WINDOWSHOOKUNIT_MOUSETRACKER_H__
#define __MDPROCESS_MDAADDINLIB_WINDOWSHOOKUNIT_MOUSETRACKER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "MDProcess/MDAAddinLib/WindowsHookUnit/WindowsHookBase.h"


// класс-для слежения за мышью
class MouseTracker :
	virtual public WindowsHookBase
{
	SET_OBJECT_COUNTER (MouseTracker)

	// singleton declaration
	typedef ACE_Singleton <MouseTracker, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MouseTracker, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static MouseTracker* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~MouseTracker ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// x - координата курсора мыши
	long m_x_coord;

	// y - координата курсора мыши
	long m_y_coord;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const long& x_coord () const {
		return m_x_coord;
	}
	
	long& x_coord () {
		return m_x_coord;
	}

	const long& y_coord () const {
		return m_y_coord;
	}
	
	long& y_coord () {
		return m_y_coord;
	}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from WindowsHookBase
	// функция обработчик сообщений от мыши
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam);

}; // class MouseTracker



#endif //__MDPROCESS_MDAADDINLIB_WINDOWSHOOKUNIT_MOUSETRACKER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

