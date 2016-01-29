////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MouseEventHandler.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::MouseEventHandler
//
// ���������� ������� �� ���� - ������������� �������� ����, ������� ������ � �.�
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MOUSEEVENTHANDLER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MOUSEEVENTHANDLER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/HookHandlerBase.h"


class CmdHandler;
// ���������� ������� �� ���� - ������������� �������� ����, ������� ������ � �.�
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
	// ���������� � �������������� �������� - ������������ ��� ����������� ����, ���������� �� ��
	// ����� ���� ������� ��� ���
	struct DragInfo {
		// �������������, ���������������� �������� � ��������� ������ �������������� (� �����������
		// ���������)
		CRect start_element_rect;
		// ���������� ������� � ������ ��������� ��������������
		CPoint end_drag_point;
		// ��������������� ���-��������
		IRoseItemViewPtr item_view;
		// ���������, �� ������� ������������� �������
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
	// �����������.
	// \handler - ���������� ���������
	explicit MouseEventHandler (CmdHandler& handler);

public:
	virtual ~MouseEventHandler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ���������� �������� ����� � ������� �������. ���������� �������� �� �������������� ��������,
	// ���� �������� - ������� ���� � ��������� ���������� ����� � ������� �������� ��������������
	virtual void drag_handler ();

	// ���������� ������� �� ��������� �������������� �������� �� ���������. ���������� ���������� ��
	// ���������� ������� ��� �������������� - ���� ����������, �� ��������� ��������� � ������
	// ���������
	virtual void end_drag_handler ();

	// ���������� ����������� ���� (������������ ��� ����, ����� ���������������� ���������� �
	// �������������� ����� ��������� �������������� � ������� ������� ��� �� ������� �������������
	// ���������)
	virtual void move_handler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���� ���������, ����� �������� ����������� ���� � �� ����� ����������� ������� ����������� ��
	// �������� ����
	bool m_context_menu;

	// ���������� � ��������������
	Core::Box<DragInfo> m_drag_info;

	// ���� ���������� ��������� �� � ������ �������������� ��������
	bool m_dragging;

	// ������������ ���-��������
	IRoseItemViewPtr m_dragging_item;

	// ���������� ��������� - ��� ����� ������������ ��������� � ���������� �������
	CmdHandler* m_handler;

	// ���������� ������� � ������ ��������������
	CPoint m_start_drag_point;

	// ���������� �������� � ������ ��������������
	CRect m_start_element_rect;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from WindowsHookImpl::IHookHandler
	// ������� ���������� ��������� �� ����
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam);

}; // class MouseEventHandler



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MOUSEEVENTHANDLER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

