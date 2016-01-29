////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/ScrollHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::ScrollHelper
//
// вспомогательный класс для поддержки скроллирования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_SCROLLHELPER_H__
#define __SHARED_WINGUI_HELPERS_SCROLLHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// вспомогательный класс для поддержки скроллирования
class ScrollHelper {
	SET_OBJECT_COUNTER (ScrollHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	ScrollHelper ();

public:
	virtual ~ScrollHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// связывает хелпер с окном, собственно для этого окна будет выполняться скроллирование
	virtual void attach_wnd (CWnd& wnd);

	// отвязывает хелпер от уже связанного окна
	virtual void detach_wnd ();

	// возвращает виртульный размер
	virtual const CSize& get_display_size () const;

	// обработчик сообщения горизонтального скролирования
	virtual void on_hscroll (unsigned int code, unsigned int pos, CScrollBar*& scroll_bar);

	// обработчик сообщения прокручивания колеса мыши
	virtual bool on_mouse_wheel (unsigned int flags, short delta, const CPoint& pt);

	// обработчик сообщения "изменение размеров"
	virtual void on_size (unsigned int type, int cx, int cy);

	// обработчик сообщения вертикального скролирования
	virtual void on_vscroll (unsigned int code, unsigned int pos, CScrollBar*& scroll_bar);

	// скроллирует к верхнему, левому или врехнему-левому углу окна
	virtual void scroll_to_orign (bool scroll_left, bool scroll_top);

	// Уставнавливает виртуальный размер. Если реальный размер окна меньше чем виртуальный, то тогда
	// появляется скролл.
	virtual void set_display_size (const CSize& size);

private:
	// возвращает позоцию скроллера. если задан scroll_bar, то возвращается его позиция, иначе
	// информация о скроллере получается из связанного окна
	virtual int get_32bit_scroll_pos (int bar, CScrollBar*& scroll_bar);

	// обновляет скролл
	virtual void update_scroll_bar (
		int bar
		, int wnd_size
		, int display_size
		, long& page_size
		, long& scroll_pos
		, long& delta_pos
	);

	// обновляет информацию дял скроллирования
	virtual void update_scroll_info ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CWnd* m_attach_wnd;

	CSize m_display_size;

	CSize m_page_size;

	CSize m_scroll_pos;
}; // class ScrollHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_SCROLLHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

