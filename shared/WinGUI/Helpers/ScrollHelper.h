////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/ScrollHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::ScrollHelper
//
// ��������������� ����� ��� ��������� ��������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_SCROLLHELPER_H__
#define __SHARED_WINGUI_HELPERS_SCROLLHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// ��������������� ����� ��� ��������� ��������������
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
	// ��������� ������ � �����, ���������� ��� ����� ���� ����� ����������� ��������������
	virtual void attach_wnd (CWnd& wnd);

	// ���������� ������ �� ��� ���������� ����
	virtual void detach_wnd ();

	// ���������� ���������� ������
	virtual const CSize& get_display_size () const;

	// ���������� ��������� ��������������� �������������
	virtual void on_hscroll (unsigned int code, unsigned int pos, CScrollBar*& scroll_bar);

	// ���������� ��������� ������������� ������ ����
	virtual bool on_mouse_wheel (unsigned int flags, short delta, const CPoint& pt);

	// ���������� ��������� "��������� ��������"
	virtual void on_size (unsigned int type, int cx, int cy);

	// ���������� ��������� ������������� �������������
	virtual void on_vscroll (unsigned int code, unsigned int pos, CScrollBar*& scroll_bar);

	// ����������� � ��������, ������ ��� ��������-������ ���� ����
	virtual void scroll_to_orign (bool scroll_left, bool scroll_top);

	// �������������� ����������� ������. ���� �������� ������ ���� ������ ��� �����������, �� �����
	// ���������� ������.
	virtual void set_display_size (const CSize& size);

private:
	// ���������� ������� ���������. ���� ����� scroll_bar, �� ������������ ��� �������, �����
	// ���������� � ��������� ���������� �� ���������� ����
	virtual int get_32bit_scroll_pos (int bar, CScrollBar*& scroll_bar);

	// ��������� ������
	virtual void update_scroll_bar (
		int bar
		, int wnd_size
		, int display_size
		, long& page_size
		, long& scroll_pos
		, long& delta_pos
	);

	// ��������� ���������� ��� ��������������
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

