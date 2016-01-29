////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MouseEventHandler.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::MouseEventHandler
//
// обработчик событий от мыши - перехватывает движения мыши, нажатие клавиш и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MOUSEEVENTHANDLER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MOUSEEVENTHANDLER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/HookHandlerBase.h"


class CmdHandler;
// обработчик событий от мыши - перехватывает движения мыши, нажатие клавиш и т.д
class MouseEventHandler;
typedef Core::Var<MouseEventHandler> MouseEventHandler_var;
typedef Core::Var<const MouseEventHandler> MouseEventHandler_cvar;

class MouseEventHandler :
	virtual public WindowsHookImpl::HookHandlerBase
{
	SET_OBJECT_COUNTER (MouseEventHandler)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// информация о пертаскиваемом элементе - используется при определения того, перетащили ли на
	// самом деле элемент или нет
	struct DragInfo {
		// прямоугольник, перетаскиваемого элемента в начальный момент перетаскивания (в координатах
		// диаграммы)
		CRect start_element_rect;
		// координата курсора в момент окончания перетаскивания
		CPoint end_drag_point;
		// перетаскиваемый вью-элемента
		IRoseItemViewPtr item_view;
		// диаграмма, на которой перетаскивали элемент
		IRoseDiagramPtr diag;

		DragInfo (
			const CRect& start_element_rect_
			, const CPoint& end_drag_point_
			, IRoseItemViewPtr item_view_
			, IRoseDiagramPtr diag_
		);
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор.
	// \handler - обрабочтик сообщений
	explicit MouseEventHandler (CmdHandler& handler);

public:
	virtual ~MouseEventHandler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// Обработчик движения мышью с зажатой кнопкой. Определяет началось ли перетаскивание элемента,
	// если началось - взводит флаг и сохраняет координаты точки с которой началось перетаскивание
	virtual void drag_handler ();

	// Обработчик события об окончании перетаскивания элемента на диаграмме. Определяет изменились ли
	// координаты курсора при перетаскивании - если изменились, то добавляет диаграмму в спсиок
	// изменённых
	virtual void end_drag_handler ();

	// обработчик перемещения мыши (используется для того, чтобы проанализировать информацию о
	// перетаскивании после окончания перетаскивания и принять решение был ли элемент действительно
	// перетащен)
	virtual void move_handler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// флаг взводится, когда показано контекстное меню и не нужно специальным образом реагировать на
	// движение мыши
	bool m_context_menu;

	// информация о перетаскивании
	Core::Box<DragInfo> m_drag_info;

	// флаг определяет находимся ли в режиме перетаскивания элемента
	bool m_dragging;

	// перемещаемый вью-элемента
	IRoseItemViewPtr m_dragging_item;

	// обработчик сообщений - ему будут передаваться сообщения о выполнении комманд
	CmdHandler* m_handler;

	// координаты курсора в начале перетаскивания
	CPoint m_start_drag_point;

	// координаты элемента в начале перетаскивания
	CRect m_start_element_rect;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from WindowsHookImpl::IHookHandler
	// функция обработчик сообщений от мыши
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam);

}; // class MouseEventHandler



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MOUSEEVENTHANDLER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

