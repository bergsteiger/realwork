////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GenerationErrorDialog
//
// ����� �� ������� ������, ��������� � �������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_GENERATIONERRORDIALOG_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_GENERATIONERRORDIALOG_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseItemList.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"

// ����� �� ������� ������, ��������� � �������� ���������
class GenerationErrorDialog : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (GenerationErrorDialog)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_GENERATION_ERROR_DIALOG };

public:
	// ������������� ������� ������� ������
	explicit GenerationErrorDialog (const GenSupport::ErrorInfoList& errors, bool can_be_ignored = false);

public:
	virtual ~GenerationErrorDialog ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(GenerationErrorDialog)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
public:
	// ��������� ������ � ������
	virtual void add_error (const GenSupport::ErrorInfo& error);

private:
	// ����� ��� ���������� ���������� � ������, ����� ����� ��� ���������������
	virtual void add_error_impl (const GenSupport::ErrorInfo& info);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ����� �� �������������� ������ "������������" � �������
	bool m_can_be_ignored;

	// ������ ��� �����������
	GenSupport::ErrorInfoList m_data;

	// ���������� ���-������
	RoseItemList m_view;
}; // class GenerationErrorDialog



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_GENERATIONERRORDIALOG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

