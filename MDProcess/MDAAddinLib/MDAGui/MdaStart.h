////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/MDAGui/MdaStart.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::MdaStart
//
// ������ ���������� ����� ����� ������� ���� ��������� ������� ������ �� Recent ������, ����
// ������� ����� ������ �� ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_MDASTART_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_MDASTART_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/StartProperties.h"
#include "MDProcess/MDAAddinLib/CommonViews/CTooltipListCtrl.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457415F60222_CUSTOM_INCLUDES*
//#UC END# *457415F60222_CUSTOM_INCLUDES*


// ������ ���������� ����� ����� ������� ���� ��������� ������� ������ �� Recent ������, ����
// ������� ����� ������ �� ������ �������
class MdaStart : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (MdaStart)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��� �����: �� ������ Recent, �� ������ ��������
	enum ResultFileType {
		RFT_MRU // ���� ����������� �� ������ Recent list
		, RFT_MDA_TPL // ���� ����������� �� ������ ��������
	};

	// ��������� ������ � ������� MDAStart
	struct Result {
		// ���, ������������ �����
		std::string file_name;
		// ��������� �������� ����� ������� (���, ���� ��� ���������, ��������� ����������)
		StartProperties::Result properties;
		// ��� ������������ �����
		ResultFileType file_type;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_MDA_START };

public:
	MdaStart ();

public:
	virtual ~MdaStart ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(MdaStart)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CTooltipListCtrl m_mda_box;

	Result m_result;

	CTooltipListCtrl m_rml_box;

//#UC START# *457415F60222*
public:
	const Result& get_result () {
		return m_result;
	}

public:
	afx_msg void OnBnClickedOk();	
	afx_msg void OnDblClick (NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnBnClickedButton1();

//#UC END# *457415F60222*
}; // class MdaStart



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_MDASTART_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

