////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/CommonViews/ChoiceDialog.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::ChoiceDialog
//
// ������ ������ - ������������ ����� ������ �� ������� ��������� ��������� ������ ������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_CHOICEDIALOG_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_CHOICEDIALOG_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "afxstr.h"
#include "afxwin.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// ������ ������ - ������������ ����� ������ �� ������� ��������� ��������� ������ ������� �����
class ChoiceDialog : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (ChoiceDialog)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_CHOICE_DIALOG };

public:
	// �����������, selections - ��������� �������� ������
	ChoiceDialog (const std::string& caption, const GCL::StrSet& selections);

public:
	virtual ~ChoiceDialog ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ChoiceDialog)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
public:
	// ���������� �����, ��������� �������������
	virtual const std::string get_selection () const;

private:
	// ������� �� ����-���� � ������
	virtual void on_dbl_click ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������� ����
	std::string m_caption;

	// ������� - ������
	CListBox m_list;

	// ������ ��������� ���������
	GCL::StrSet m_selections;

	// ��������� ��������
	CString m_value;
}; // class ChoiceDialog



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_CHOICEDIALOG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

