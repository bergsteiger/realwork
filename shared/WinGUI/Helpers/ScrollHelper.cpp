////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/ScrollHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::ScrollHelper
//
// вспомогательный класс для поддержки скроллирования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Helpers/ScrollHelper.h"
// by <<uses>> dependencies
#include "shared/WinGUI/Helpers/WinControlHelper.h"

namespace WinGUI {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ScrollHelper::ScrollHelper ()
//#UC START# *4652DAB50186_BASE_INIT*
: m_attach_wnd (NULL)
, m_page_size (0, 0)
, m_display_size (0, 0)
, m_scroll_pos (0, 0)
//#UC END# *4652DAB50186_BASE_INIT*
{
	//#UC START# *4652DAB50186_BODY*
	//#UC END# *4652DAB50186_BODY*
}

ScrollHelper::~ScrollHelper () {
	//#UC START# *4652DA88000F_DESTR_BODY*
	detach_wnd ();
	//#UC END# *4652DA88000F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// связывает хелпер с окном, собственно для этого окна будет выполняться скроллирование
void ScrollHelper::attach_wnd (CWnd& wnd) {
	//#UC START# *4652DAC00109*
	m_attach_wnd = &wnd;
	//#UC END# *4652DAC00109*
}

// отвязывает хелпер от уже связанного окна
void ScrollHelper::detach_wnd () {
	//#UC START# *4652DAC600EA*
	m_attach_wnd = NULL;
	//#UC END# *4652DAC600EA*
}

// возвращает позоцию скроллера. если задан scroll_bar, то возвращается его позиция, иначе
// информация о скроллере получается из связанного окна
int ScrollHelper::get_32bit_scroll_pos (int bar, CScrollBar*& scroll_bar) {
	//#UC START# *4652DC9303A9*
	GDS_ASSERT(m_attach_wnd != NULL);
    HWND hWndScroll;
    if ( scroll_bar == NULL )
        hWndScroll = m_attach_wnd->m_hWnd;
    else
        hWndScroll = scroll_bar->m_hWnd;

    SCROLLINFO si;
    si.cbSize = sizeof(SCROLLINFO);
    si.fMask = SIF_TRACKPOS;
    ::GetScrollInfo(hWndScroll, bar, &si);

    int scrollPos = si.nTrackPos;

    return scrollPos;
	//#UC END# *4652DC9303A9*
}

// возвращает виртульный размер
const CSize& ScrollHelper::get_display_size () const {
	//#UC START# *4652E2B900EA*
	return m_display_size;
	//#UC END# *4652E2B900EA*
}

// обработчик сообщения горизонтального скролирования
void ScrollHelper::on_hscroll (unsigned int code, unsigned int pos, CScrollBar*& scroll_bar) {
	//#UC START# *4652DB68036B*
	if ( m_attach_wnd == NULL )
        return;

    const int lineOffset = 60;

    // Compute the desired change or delta in scroll position.
    int deltaPos = 0;
    switch( code ) {
		case SB_LINELEFT:
			// Left scroll arrow was pressed.
			deltaPos = -lineOffset;
			break;

		case SB_LINERIGHT:
			// Right scroll arrow was pressed.
			deltaPos = lineOffset;
			break;

		case SB_PAGELEFT:
			// User clicked inbetween left arrow and thumb.
			deltaPos = -m_page_size.cx;
			break;

		case SB_PAGERIGHT:
			// User clicked inbetween thumb and right arrow.
			deltaPos = m_page_size.cx;
			break;

		case SB_THUMBTRACK:
			// Scrollbar thumb is being dragged.
			deltaPos = get_32bit_scroll_pos(SB_HORZ, scroll_bar) - m_scroll_pos.cx;
			break;

		case SB_THUMBPOSITION:
			// Scrollbar thumb was released.
			deltaPos = get_32bit_scroll_pos(SB_HORZ, scroll_bar) - m_scroll_pos.cx;
			break;

		default:
			// We don't process other scrollbar messages.
			return;
    }

    // Compute the new scroll position.
    int newScrollPos = m_scroll_pos.cx + deltaPos;

    // If the new scroll position is negative, we adjust
    // deltaPos in order to scroll the window back to origin.
    if ( newScrollPos < 0 )
        deltaPos = -m_scroll_pos.cx;

    // If the new scroll position is greater than the max scroll position,
    // we adjust deltaPos in order to scroll the window precisely to the
    // maximum position.
    int maxScrollPos = m_display_size.cx - m_page_size.cx;
    if ( newScrollPos > maxScrollPos )
        deltaPos = maxScrollPos - m_scroll_pos.cx;

    // Scroll the window if needed.
    if ( deltaPos != 0 )
    {
        m_scroll_pos.cx += deltaPos;
        m_attach_wnd->SetScrollPos(SB_HORZ, m_scroll_pos.cx, TRUE);
        m_attach_wnd->ScrollWindow(-deltaPos, 0);
    }
	//#UC END# *4652DB68036B*
}

// обработчик сообщения прокручивания колеса мыши
bool ScrollHelper::on_mouse_wheel (unsigned int flags, short delta, const CPoint& pt) {
	//#UC START# *4652DBAE0222*
	if ( m_attach_wnd == NULL )
        return false;

    // Don't do anything if the vertical scrollbar is not enabled.
    int scrollMin = 0, scrollMax = 0;
    m_attach_wnd->GetScrollRange(SB_VERT, &scrollMin, &scrollMax);
    if ( scrollMin == scrollMax )
        return false;

    // Compute the number of scrolling increments requested.
    int numScrollIncrements = abs(delta) / WHEEL_DELTA;

    // Each scrolling increment corresponds to a certain number of
    // scroll lines (one scroll line is like a SB_LINEUP or SB_LINEDOWN).
    // We need to query the system parameters for this value.
    int numScrollLinesPerIncrement = 0;
    ::SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, &numScrollLinesPerIncrement, 0);

    // Check if a page scroll was requested.
    if ( numScrollLinesPerIncrement == WHEEL_PAGESCROLL )
    {
        // Call the vscroll message handler to do the work.
		CScrollBar* scroll = NULL;
		this->on_vscroll (delta > 0 ? SB_PAGEUP : SB_PAGEDOWN, 0, scroll);
        return true;
    }

    // Compute total number of lines to scroll.
    int numScrollLines = numScrollIncrements * numScrollLinesPerIncrement;

    // Adjust numScrollLines to slow down the scrolling a bit more.
	numScrollLines = std::max(numScrollLines/3, 1);

    // Do the scrolling.
    for(int i = 0; i < numScrollLines; ++i)
    {
        // Call the vscroll message handler to do the work.
		CScrollBar* scroll = NULL;
        this->on_vscroll (delta > 0 ? SB_LINEUP : SB_LINEDOWN, 0, scroll);
    }

    return true;
	//#UC END# *4652DBAE0222*
}

// обработчик сообщения "изменение размеров"
void ScrollHelper::on_size (unsigned int type, int cx, int cy) {
	//#UC START# *4652DC720251*
	this->update_scroll_info ();
	//#UC END# *4652DC720251*
}

// обработчик сообщения вертикального скролирования
void ScrollHelper::on_vscroll (unsigned int code, unsigned int pos, CScrollBar*& scroll_bar) {
	//#UC START# *4652DB960232*
	if ( m_attach_wnd == NULL )
        return;

    const int lineOffset = 60;

    // Compute the desired change or delta in scroll position.
    int deltaPos = 0;
    switch( code ) {
		case SB_LINEUP:
			// Up arrow button on scrollbar was pressed.
			deltaPos = -lineOffset;
			break;

		case SB_LINEDOWN:
			// Down arrow button on scrollbar was pressed.
			deltaPos = lineOffset;
			break;

		case SB_PAGEUP:
			// User clicked inbetween up arrow and thumb.
			deltaPos = -m_page_size.cy;
			break;

		case SB_PAGEDOWN:
			// User clicked inbetween thumb and down arrow.
			deltaPos = m_page_size.cy;
			break;

		case SB_THUMBTRACK:
			// Scrollbar thumb is being dragged.
			deltaPos = get_32bit_scroll_pos(SB_VERT, scroll_bar) - m_scroll_pos.cy;
			break;

		case SB_THUMBPOSITION:
			// Scrollbar thumb was released.
			deltaPos = get_32bit_scroll_pos(SB_VERT, scroll_bar) - m_scroll_pos.cy;
			break;

		default:
			// We don't process other scrollbar messages.
			return;
    }

    // Compute the new scroll position.
    int newScrollPos = m_scroll_pos.cy + deltaPos;

    // If the new scroll position is negative, we adjust
    // deltaPos in order to scroll the window back to origin.
    if ( newScrollPos < 0 )
        deltaPos = -m_scroll_pos.cy;

    // If the new scroll position is greater than the max scroll position,
    // we adjust deltaPos in order to scroll the window precisely to the
    // maximum position.
    int maxScrollPos = m_display_size.cy - m_page_size.cy;
    if ( newScrollPos > maxScrollPos )
        deltaPos = maxScrollPos - m_scroll_pos.cy;

    // Scroll the window if needed.
    if ( deltaPos != 0 )
    {
        m_scroll_pos.cy += deltaPos;
        m_attach_wnd->SetScrollPos(SB_VERT, m_scroll_pos.cy, TRUE);
        m_attach_wnd->ScrollWindow(0, -deltaPos);
    }
	//#UC END# *4652DB960232*
}

// скроллирует к верхнему, левому или врехнему-левому углу окна
void ScrollHelper::scroll_to_orign (bool scroll_left, bool scroll_top) {
	//#UC START# *4652DB3B0271*
	if ( m_attach_wnd == NULL )
        return;

    if ( scroll_left )
    {
        if ( m_display_size.cx > 0 && m_page_size.cx > 0 && m_scroll_pos.cx > 0 )
        {
            int deltaPos = -m_scroll_pos.cx;
            m_scroll_pos.cx += deltaPos;
            m_attach_wnd->SetScrollPos(SB_HORZ, m_scroll_pos.cx, TRUE);
            m_attach_wnd->ScrollWindow(-deltaPos, 0);
        }
    }

    if ( scroll_top )
    {
        if ( m_display_size.cy > 0 && m_page_size.cy > 0 && m_scroll_pos.cy > 0 )
        {
            int deltaPos = -m_scroll_pos.cy;
            m_scroll_pos.cy += deltaPos;
            m_attach_wnd->SetScrollPos(SB_VERT, m_scroll_pos.cy, TRUE);
            m_attach_wnd->ScrollWindow(0, -deltaPos);
        }
    }
	//#UC END# *4652DB3B0271*
}

// Уставнавливает виртуальный размер. Если реальный размер окна меньше чем виртуальный, то тогда
// появляется скролл.
void ScrollHelper::set_display_size (const CSize& size) {
	//#UC START# *4652E2A10196*
	m_display_size = size;

	if (m_attach_wnd != NULL && ::IsWindow(m_attach_wnd->m_hWnd)) {
		this->update_scroll_info ();        
	}
	//#UC END# *4652E2A10196*
}

// обновляет скролл
void ScrollHelper::update_scroll_bar (
	int bar
	, int wnd_size
	, int display_size
	, long& page_size
	, long& scroll_pos
	, long& delta_pos
) {
	//#UC START# *4652DCE7030D*
	int scrollMax = 0;
    delta_pos = 0;
    if ( wnd_size < display_size ) {
        scrollMax = display_size - 1;
        if ( page_size > 0 && scroll_pos > 0 )
        {
            // Adjust the scroll position when the window size is changed.
            scroll_pos = (LONG)(1.0 * scroll_pos * wnd_size / page_size);
        }
        page_size = wnd_size;
		scroll_pos = std::min(scroll_pos, page_size - page_size - 1);
        delta_pos = m_attach_wnd->GetScrollPos( bar) - scroll_pos;
    } else {
        // Force the scrollbar to go away.
        page_size = 0;
        scroll_pos = 0;
        delta_pos = m_attach_wnd->GetScrollPos(bar);
    }

    SCROLLINFO si;
    memset(&si, 0, sizeof(SCROLLINFO));
    si.cbSize = sizeof(SCROLLINFO);
    si.fMask  = SIF_ALL;    // SIF_ALL = SIF_PAGE | SIF_RANGE | SIF_POS;
    si.nMin   = 0;
    si.nMax   = scrollMax;
    si.nPage  = page_size;
    si.nPos   = scroll_pos;
    m_attach_wnd->SetScrollInfo(bar, &si, TRUE);
	//#UC END# *4652DCE7030D*
}

// обновляет информацию дял скроллирования
void ScrollHelper::update_scroll_info () {
	//#UC START# *4652DCD1006D*
	if ( m_attach_wnd == NULL )
        return;

    // Get the width/height of the attached wnd that includes the area
    // covered by the scrollbars (if any). The reason we need this is
    // because when scrollbars are present, both cx/cy and GetClientRect()
    // when accessed from OnSize() do not include the scrollbar covered
    // areas. In other words, their values are smaller than what you would
    // expect.
	Core::Aptr<CRect> rect = WinControlHelper::get_client_rect_sb (*m_attach_wnd);
    CSize windowSize(rect->Width(), rect->Height());

    // Update horizontal scrollbar.
    CSize deltaPos(0,0);
    update_scroll_bar(SB_HORZ, windowSize.cx, m_display_size.cx,
        m_display_size.cx, m_scroll_pos.cx, deltaPos.cx);

    // Update vertical scrollbar.
    update_scroll_bar(SB_VERT, windowSize.cy, m_display_size.cy,
        m_display_size.cy, m_scroll_pos.cy, deltaPos.cy);

    // See if we need to scroll the window back in place.
    // This is needed to handle the case where the scrollbar is
    // moved all the way to the right for example, and controls
    // at the left side disappear from the view. Then the user
    // resizes the window wider until scrollbars disappear. Without
    // this code below, the controls off the page will be gone forever.
    if ( deltaPos.cx != 0 || deltaPos.cy != 0 )
    {
        m_attach_wnd->ScrollWindow(deltaPos.cx, deltaPos.cy);
    } 
	//#UC END# *4652DCD1006D*
}

} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

