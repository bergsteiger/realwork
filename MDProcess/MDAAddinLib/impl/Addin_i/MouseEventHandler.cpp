////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MouseEventHandler.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::MouseEventHandler
//
// обработчик событий от мыши - перехватывает движения мыши, нажатие клавиш и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MouseEventHandler.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
MouseEventHandler::DragInfo::DragInfo (
	const CRect& start_element_rect_
	, const CPoint& end_drag_point_
	, IRoseItemViewPtr item_view_
	, IRoseDiagramPtr diag_
)
//#UC START# *474562E801A2_INIT_CTOR_BASE_INIT*
	: start_element_rect (start_element_rect_)
	, end_drag_point (end_drag_point_)
	, item_view (item_view_)
	, diag (diag_)
//#UC END# *474562E801A2_INIT_CTOR_BASE_INIT*
{
	//#UC START# *474562E801A2_INIT_CTOR*
	//#UC END# *474562E801A2_INIT_CTOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор.
// \handler - обрабочтик сообщений
MouseEventHandler::MouseEventHandler (CmdHandler& handler)
//#UC START# *46F741D5002E_BASE_INIT*
	: m_handler (&handler)
	, m_context_menu (false)
	, m_dragging (false)
	, m_start_drag_point (0, 0)
	, m_start_element_rect (0, 0, 0, 0)
//#UC END# *46F741D5002E_BASE_INIT*
{
	//#UC START# *46F741D5002E_BODY*
	//m_tooltip.Create (m_handler);
	//#UC END# *46F741D5002E_BODY*
}

MouseEventHandler::~MouseEventHandler () {
	//#UC START# *46F740620138_DESTR_BODY*
	//#UC END# *46F740620138_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Обработчик движения мышью с зажатой кнопкой. Определяет началось ли перетаскивание элемента,
// если началось - взводит флаг и сохраняет координаты точки с которой началось перетаскивание
void MouseEventHandler::drag_handler () {
	//#UC START# *474525A802FA*
	if (!m_dragging) {
		IRoseApplicationPtr app = RoseHelper::rose_app ();
		IRoseModelPtr model = app ? app->CurrentModel : NULL;

		IRoseDiagramPtr diag = model ? model->GetActiveDiagram () : NULL;
		CPoint pt;
		GetCursorPos (&pt);
		HWND wnd = ::WindowFromPoint (pt);
		if (
			diag		
			&& wnd
			&& RoseHelper::is_diagram_window (wnd, diag)			
		) {
			IRoseItemViewCollectionPtr item_views;
			if (diag->GetSelectedItems ()->Count > 0) {				
				IRoseItemPtr item = diag->GetSelectedItems ()->GetAt (1);
				item_views = RoseHelper::get_views (item, diag);
				if (item_views) {
					short count_views = item_views->Count;
					if (count_views == 1) {
						m_dragging_item = item_views->GetAt (1);
					} else if (count_views != 0) {
						if (RoseHelper::point_to_diagram (pt, diag)) {
							for (short i = 1; i <= count_views; ++i) {
								IRoseItemViewPtr view = item_views->GetAt (i);			
								if (view->PointInView ((short)pt.x, (short)pt.y)) {
									m_dragging_item = view;
									break;
								}
							}
						}
					}			
				}
			} else /*if (diag->IsClass ("ScenarioDiagram"))*/ {
				IRoseItemViewCollectionPtr item_views = diag->ItemViews;
				if (RoseHelper::point_to_diagram (pt, diag)) {
					short count_views = item_views->Count;
					for (short i = 1; i <= count_views; ++i) {
						IRoseItemViewPtr view = item_views->GetAt (i);
						//std::string name = view->GetName ();
						//LOG_D (("View: %s", name.c_str ()));
						if (view->PointInView ((short)pt.x, (short)pt.y)) {
							m_dragging_item = view;
							break;
						}
					}
				}
			}			
			if (m_dragging_item) {
				RoseHelper::get_rect (m_dragging_item, m_start_element_rect);				
				m_start_drag_point = pt;
				m_dragging = true;
			}
		}
	}
	//#UC END# *474525A802FA*
}

// Обработчик события об окончании перетаскивания элемента на диаграмме. Определяет изменились ли
// координаты курсора при перетаскивании - если изменились, то добавляет диаграмму в спсиок
// изменённых
void MouseEventHandler::end_drag_handler () {
	//#UC START# *4745345B00C9*
	if (m_dragging) {
		IRoseDiagramPtr diag = RoseHelper::rose_app ()->CurrentModel->GetActiveDiagram ();
		CPoint pt;
		GetCursorPos (&pt);
		HWND wnd = ::WindowFromPoint (pt);		
		if (
			diag		
			&& wnd
			&& RoseHelper::is_diagram_window (wnd, diag)
			&& m_dragging_item
		) {
			m_dragging = false;		
			if (
				(
					abs (m_start_drag_point.x - pt.x) >= 1
					|| abs (m_start_drag_point.y - pt.y) >= 1
				) && (
					RoseHelper::can_modify_elem (diag)
				)
			) {				
				m_drag_info = new DragInfo (
					m_start_element_rect
					, pt
					, m_dragging_item
					, diag
				);				
			}
			m_dragging_item = 0;
		}
	}
	//#UC END# *4745345B00C9*
}

// обработчик перемещения мыши (используется для того, чтобы проанализировать информацию о
// перетаскивании после окончания перетаскивания и принять решение был ли элемент действительно
// перетащен)
void MouseEventHandler::move_handler () {
	//#UC START# *474563D001B0*
	if (m_drag_info.is_nil () == false) {		
		CRect rect;
		try {
			RoseHelper::get_rect (m_drag_info->item_view, rect);
			if (!rect.EqualRect (m_drag_info->start_element_rect)) {
				std::string diag_guid (get_rose_element_uid(m_drag_info->diag));
				RoseHelper::get_changed_diags ().insert (diag_guid);			
#ifdef _DEBUG
				LOG_D(("ELEMENT MOVED"));
#endif
			}
		} catch (...) {
			//вью могли удалить :((
		}
		m_drag_info = 0;
	}
	//#UC END# *474563D001B0*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from WindowsHookImpl::IHookHandler
// функция обработчик сообщений от мыши
LRESULT MouseEventHandler::mouse_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECD401A5_46F740620138*
	LRESULT res = -1;
	MOUSEHOOKSTRUCT* st = (MOUSEHOOKSTRUCT*)lParam;
	UINT msg = (UINT) wParam;
	MSG msg_ = {};
	msg_.hwnd = st->hwnd;
	msg_.message = msg;
	msg_.wParam = wParam;
	msg_.lParam = lParam;
	msg_.time = 0;
	msg_.pt = st->pt;
	if (msg == WM_LBUTTONUP) {
		end_drag_handler ();
	} else if (msg == WM_MOUSEMOVE) {
		move_handler ();
	}
	if (m_handler && IsWindow (*m_handler)) {
		if (m_context_menu == false) {	
			m_handler->relay_event (&msg_);
		}
		if (		
			msg == WM_MOUSEMOVE
			&& !(GetAsyncKeyState(MK_LBUTTON) & 0x8000)
			&& !(GetAsyncKeyState(MK_RBUTTON) & 0x8000)			
		) {
			
			//просто "возим" мышкой по экрану
			//нужно проверить - если мышка над окном с диаграммой,
			//то нужно вернуть 1, чтобы Роза не показывала свой тултип
			if (m_context_menu == false) {
				HWND wnd = ::WindowFromPoint (st->pt);
				IRoseApplicationPtr app = RoseHelper::rose_app ();
				if (app && app->CurrentModel) {
					IRoseDiagramPtr diag = app->CurrentModel->GetActiveDiagram ();
					res = RoseHelper::is_diagram_window (wnd, diag) ? 1 : res;
				}
			}
		} else {
			m_context_menu = false;
			if (
				msg == WM_RBUTTONUP && (GetKeyState (VK_CONTROL) & 0x8000) // нажали Ctrl+right_click
				|| (msg == WM_RBUTTONUP && (GetKeyState (VK_MENU) & 0x8000)) // нажали Alt+right_click
				|| (msg == WM_RBUTTONUP && !(GetKeyState (VK_SHIFT) & 0x8000)) // right_click и не нажат Shift
				|| msg == WM_LBUTTONDBLCLK //дабл клик на модели
			) {	
				if (WM_RBUTTONUP) {
					m_context_menu = true;
				}

				IRoseDiagramPtr diag;

				IRoseApplicationPtr app = RoseHelper::rose_app ();
				if (app && app->CurrentModel) {
					diag = app->CurrentModel->GetActiveDiagram ();
				}

				HWND wnd = ::WindowFromPoint (st->pt);
				if (
					diag
					&& (!diag->IsClass ("ScenarioDiagram") && !diag->IsClass ("StateDiagram"))
					&& wnd
					&& RoseHelper::is_diagram_window (wnd, diag)					
				) {
					//кликнули не в дереве, а на диаграмме				
					if (					
						msg != WM_LBUTTONUP 
						&& msg != WM_LBUTTONDBLCLK					
					) {
						POINT pt = st->pt;				
						bool need_click = true;
						if (diag->GetSelectedItems ()->Count >0) {
							IRoseElementPtr point_elem = RoseHelper::get_element (diag, pt.x, pt.y);
							IRoseElementPtr selected_item = diag->GetSelectedItems ()->GetAt (1);
							if (point_elem && selected_item) {
								need_click = get_rose_element_uid(point_elem) != get_rose_element_uid(selected_item);
							}
						}
						if (need_click) {
							::ScreenToClient (wnd, &pt);
							::SendMessage (wnd, WM_LBUTTONDOWN, MK_LBUTTON, MAKELPARAM (pt.x, pt.y));
							::SendMessage (wnd, WM_LBUTTONUP, 0, MAKELPARAM (pt.x, pt.y));
							//::SendMessage (wnd, WM_LBUTTONUP, 0, MAKELPARAM (pt.x, pt.y));
						}
					}
					IRoseElementPtr elem;
					switch (msg) {
						case WM_RBUTTONUP: {						
							if (GetKeyState (VK_CONTROL) & 0x8000) {							
								m_handler->PostMessage (WM_COMMAND, MAKEWPARAM (ID_SHOW_IN_BROWSER, 0), 0);							
							} else if (GetKeyState (VK_MENU) & 0x8000) {
								IRoseItemCollectionPtr selections = diag->GetSelectedItems ();
								if (selections->Count > 0) {						
									elem = selections->GetAt (1);
									if (elem->IsClass("Association")) {
										elem = RoseHelper::get_role (elem);						
									}
								}
								if (elem) {
									m_handler->PostMessage (WM_COMMAND, MAKEWPARAM (ID_PROPERTIES_DIAG, 0), 0);
								}						
							} else {
								m_handler->PostMessage (WM_CONTEXTMENU, 0, 0);
								//m_context_menu = true;
							}
						}
						break;

						case WM_LBUTTONDBLCLK: {
							int res = -1;
							IRoseItemCollectionPtr selections = diag->GetSelectedItems ();
							if (selections->Count > 0) {						
								elem = selections->GetAt (1);
							}
							if (
								elem 
								&& (
									elem->IsClass (CLASS_TYPE)
									|| elem->IsClass (CATEGORY_TYPE)
									|| elem->IsClass ("DependencyRelation")
								)

							) {
								m_handler->PostMessage (CmdHandler::WM_DBL_CLICK, 0, 0);								
								res = 1;
							}
							return res;
						}
						break;
					}
					return 1;
				}
			} else if (
				msg == WM_MOUSEMOVE
				&& (GetAsyncKeyState(MK_LBUTTON) & 0x8000)
				&& !(GetAsyncKeyState(MK_RBUTTON) & 0x8000)
				&& !(GetAsyncKeyState (VK_CONTROL) & 0x8000)
				&& !(GetAsyncKeyState (VK_MENU) & 0x8000)
				&& !(GetAsyncKeyState (VK_SHIFT) & 0x8000)
			) {
				this->drag_handler ();
			}
		}		
	}
	return res;
	//#UC END# *46F9ECD401A5_46F740620138*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

