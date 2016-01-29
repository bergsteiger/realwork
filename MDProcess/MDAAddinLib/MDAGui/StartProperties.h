////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/MDAGui/StartProperties.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::StartProperties
//
// ������ �������� ����� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_STARTPROPERTIES_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_STARTPROPERTIES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457416030271_CUSTOM_INCLUDES*
#include "shared/GCL/data/std_defs.h"
//#UC END# *457416030271_CUSTOM_INCLUDES*


// ������ �������� ����� �������
class StartProperties : public CDialog {
	SET_OBJECT_COUNTER (StartProperties)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ��������� ������ � ������� StartProperties
	struct Result {
		// ��� ������������ �������
		std::string main_name;
		// ������� ���� ��� ���������
		std::string root_dir;
		// ��������� ��������� �����������  (��, ������� ���������� �����)
		GCL::StrSet selected_gens;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_START_PROPERTIES };

public:
	StartProperties ();

public:
	virtual ~StartProperties ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(StartProperties)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

//#UC START# *457416030271*
public:
	const Result& get_result () const {
		return m_result;
	}

protected:
	Result m_result;

public:
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedButton2();
	CEdit m_root_dir;
	CTreeCtrl m_gen_tree;
	CEdit m_proj_name;
//#UC END# *457416030271*
}; // class StartProperties



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_STARTPROPERTIES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

