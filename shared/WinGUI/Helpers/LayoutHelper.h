////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Helpers/LayoutHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::LayoutHelper
//
// ��������������� ����� ��� �������� ������������ � �������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_LAYOUTHELPER_H__
#define __SHARED_WINGUI_HELPERS_LAYOUTHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/WinGUI/Helpers/LayoutInfo.h"

namespace WinGUI {

// ��������������� ����� ��� �������� ������������ � �������� ��������
class LayoutHelper {
	SET_OBJECT_COUNTER (LayoutHelper)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��������� �����������
	enum LayoutStyles {
		DEFAULT_LAYOUT // �������� �� ���������
		, CENTERED_LAYOUT // �������� ������������� �� ������
	};

	// ����� ���������
	typedef std::map < HWND, Core::Box<LayoutInfo> > Controls;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	LayoutHelper ();

public:
	virtual ~LayoutHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� � ������ ��� �������� ��������, ���������� ����
	virtual bool add_child_controls ();

	// ��������� ctrl � ������ ��������
	virtual bool add_control (CWnd& ctrl);

	// ��������� ctrl � ������ ��������� info - ���������� � ������������
	virtual bool add_control_info (CWnd& ctrl, const LayoutInfo& info);

	// ������������ ����
	virtual void attach_wnd (CWnd& wnd);

	// ��������� ����
	virtual void detach_wnd ();

	// ��������� ���������� � ������������ ��������� � ���������
	virtual bool get_layout_info (CWnd& ctrl, LayoutInfo& info) const;

	// ��������� ���������� ��������
	virtual void layout_controls ();

	// �������� ��������
	virtual void on_size (unsigned int type, int cx, int cy);

	// ������� ctrl �� ������
	virtual bool remove_control (CWnd& ctrl);

private:
	// �������� ����������� ��������
	virtual void apply_aspect_ratio (const LayoutInfo& info, int& width, int& height);

	// ��������� ����������� ������������� �� x
	virtual void apply_centering_constraint_x (const LayoutInfo& info, double scaleX, int& x, int width);

	// ��������� ��������� ������������� �� Y
	virtual void apply_centering_constraint_y (const LayoutInfo& info, double scaleY, int& y, int height);

	// ��������� ����������� �� X
	virtual void apply_constraint_x (const LayoutInfo& info, int cx, double scaleX, int& x, int& width);

	// ��������� ����������� �� Y
	virtual void apply_constraint_y (const LayoutInfo& info, int cy, double scaleY, int& y, int& height);

	// ��������� �������� ��������� ��� ����������� ������������ ��������� ���� ��� �������
	virtual void perfom_centered_layout (int cx, int cy);

	// ��������� �������� �� ��������� ��� ����������� ������������ ��������� ���� ��� �������
	virtual void perfom_default_layout (int cx, int cy);

	// ��������
	virtual void perfom_layout (int cx, int cy);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������� ����
	CWnd* m_attach_wnd;

	Controls m_controls;

	// ��������
	LayoutStyles m_layout_style;

	// ����������� ������ ���������� �������
	CSize m_minimum_size;

	// ���������� ������ ����
	int m_prev_wnd_height;

	// ���������� ������ ����
	int m_prev_wnd_width;

	// ����������� ������ ���������� ������� ����, ������������ ��� �������
	CSize m_reference_size;

	// ���, ���������� ������ ��� ��������� �� ������� ���������� �������� ��������. ������������ ���,
	// ���� ����� ��������� �� ������������� ������� ��� ������� ����
	int m_step_size;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	int get_prev_wnd_height () const;

	void set_prev_wnd_height (int prev_wnd_height);

	int get_step_size () const;

	void set_step_size (int step_size);
}; // class LayoutHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_LAYOUTHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

