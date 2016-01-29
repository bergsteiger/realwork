////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::CmdHandler
//
// ����� ���������� ������ ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CMDHANDLER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CMDHANDLER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CModelExplorer.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MouseEventHandler.h"
#include "shared/WinGUI/Controls/CPPToolTip.h"

//#UC START# *46480B2E006D_CUSTOM_INCLUDES*
//#define WM_CONTINUE_PROCESSING_MSG (WM_USER + 2)
//#define WM_BROWSE_IN_DIAG (WM_CONTINUE_PROCESSING_MSG + 1)
//#define WM_SHOW_TOOL_TIP (WM_CONTINUE_PROCESSING_MSG + 3)
//#UC END# *46480B2E006D_CUSTOM_INCLUDES*


// ����� ���������� ������ ����
class CmdHandler :
	public CStatic
{
	SET_OBJECT_COUNTER (CmdHandler)

	// singleton declaration
	typedef ACE_Singleton <CmdHandler, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CmdHandler, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static CmdHandler* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ���������
	static const unsigned long WM_SHOW_TOOL_TIP; // ��������� ��� ������ ������� �������� lParam ��������� �������� true, ���� ����� �������� ������, false - ���� ��� ���� ������
	static const unsigned long WM_BROWSE_IN_DIAG; // ��������� ��� ������ �������� �� ���������
	static const unsigned long WM_CONTINUE_PROCESSING_MSG; // ������������ ���������� ��������� - ���������� � ���, ��� ����� ���������� ���������� �������
	static const unsigned long WM_DBL_CLICK; // ����-���� �� ���������
	static const unsigned long WM_UNDO_CHANGE_NAME; // ������������� ��������� ��� ������ ��������� �����, ��� ��������� ������������ ��� ������ ��������� �����, ������� ����� ��������� ��-�� ����, ��� ���� ���������, ��� ����� ������� � ��� �������� - ��� ����� ���
	static const unsigned long WM_OPEN_PROPERTIES; // ��������� ��� �������� ������� ��������
	static const unsigned long TOOLTIP_TIMER; // ������������� �������, ������������ ��� ������ �������

	// ��������� ��� �������� ���������� � ���������� ��������� WM_OPEN_PROPERTIES
	struct OpenPropertiesParam {
		// GUID ��������, ��� �������� ����� ������� ��������
		std::string guid;
		// ���� - ����� ������� ��� ���
		bool is_new;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// ����������� �� ���������
	CmdHandler ();

	virtual ~CmdHandler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������� �������
	virtual void clear ();

	// ����� ������� ��������� ���� CmdHandler
	virtual void create ();

	// ������������� ������ �� ������-�������
	virtual void set_explorer (CModelExplorer* explorer);

protected:
	// ������� ��� ������������� �������.
	// elem - �������, ��� �������� ����������� �������
	// command_id  - ������������� �������
	virtual void dispatch_command (IRoseElementPtr elem, unsigned int command_id) const;

	// ���������� ��� ������� ������� �� ������ �� � � ���� - ���������� ������� �� ���������
	virtual LRESULT on_browse_in_diag (WPARAM w_param, LPARAM l_param);

	// ���������� ������ � ��������
	virtual void on_command_from_diag (unsigned int id);

	// ���������� ������ � ������-���
	virtual void on_command_from_tree (unsigned int id);

	// ���������� ��������� WM_CONTEXT_MENU - ���������� ����������� ���� ��� ���������
	virtual LRESULT on_context_menu (WPARAM w_param, LPARAM l_param);

	// ���������� ����������������� ���������  WM_CONTINUE_PROCESSING
	virtual LRESULT on_continue_processing (WPARAM w_param, LPARAM l_param);

	// ��������� ���������� ������� ID_MODEL_SEARCH - ��������� ����� �� ������
	virtual void on_search_command ();

private:
	// ���������� ����-����� �� ���������
	virtual LRESULT on_dbl_click (WPARAM w_param, LPARAM l_param);

	// ���������� ��������� WM_OPEN_PROPERTIES
	// � ��������� l_param �������� ��������� �� ��������� � ������������ �����������, ������,
	// ���������� ���� ���������� ������������� � ������ �������
	virtual LRESULT on_open_properties (WPARAM w_param, LPARAM l_param);

	// ���������� ��������� WM_UNDO_CHANGE_NAME
	virtual LRESULT on_undo_change_name (WPARAM w_param, LPARAM l_param);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���� ���������� ����� �� ������������ ��������� ��� ��� ����� ����������
	bool m_can_process_message;

	// ����������� ��������� ��� ���������� ��������
	Core::Box<WinGUI::CPPToolTip> m_element_tool_tip;

	// ������ ������
	CModelExplorer* m_explorer;

	// ���������� ��������� �� ����
	MouseEventHandler_var m_mouse_event_handler;

//#UC START# *46480B2E006D*
	bool tool_tip_callback (PPTOOLTIP_INFO& ti);

public:
	void relay_event (MSG* msg) {
		if (m_element_tool_tip.is_nil () == false) {
			m_element_tool_tip->RelayEvent (msg);
		}
	}
	DECLARE_MESSAGE_MAP()
//#UC END# *46480B2E006D*
}; // class CmdHandler



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CMDHANDLER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

