////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppStd.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppStd
//
// General - страница
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPSTD_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPSTD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574173603A9_CUSTOM_INCLUDES*
//#UC END# *4574173603A9_CUSTOM_INCLUDES*


// General - страница
class IppStd : public IppBase {
	SET_OBJECT_COUNTER (IppStd)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_STD };

public:
	IppStd ();

public:
	virtual ~IppStd ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppStd)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// чек-бокс для свойства локальной глобальности
	CButton m_global_locally_chk;

	IRoseItemPtr m_post_command_item;

//#UC START# *4574173603A9*
	enum PostCommand {
		PCMD_NONE
		, PCMD_CONTENT
	};

	PostCommand m_post_command;
	CComboBox	m_model_stereotype;
	CComboBox	m_link_type;
	CButton	m_const_targ;
	CEdit	m_name;
	CEdit	m_doc;
	CButton m_public_rb;
	CButton m_protected_rb;
	CButton m_private_rb;
	CButton m_impl_rb;
	CButton m_abstract_rb;
	CButton m_regular_rb;
	CButton m_final_rb;
	CButton m_optional_rb;
	CEdit m_guid;
	//Пока не используем!!!
	/*CSpinButtonCtrl m_visibility_level;*/

public:
	virtual bool on_ok(bool& need_colorize);
	void fill_data (bool on_apply);

public:
	CComboBox m_target_st;
	CButton m_is_native_btn;
	afx_msg void OnEnSetfocusName();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedButton4();
	CButton m_parameterized;
	CButton m_templ_args_dlg;
	afx_msg void OnBnClickedCheck2();
	CButton m_global_chk;
	CButton m_is_main;
	afx_msg void OnBnClickedContent();
	CButton m_contents_chk;
	CButton m_contents_btn;
	afx_msg void OnBnClickedContentsChk();
	afx_msg void OnBnClickedStdNative();
	CStatic m_static_name;
	afx_msg void OnStnClickedStaticName2();
	CStatic m_static_name2;
	afx_msg void OnBnClickedButton5();
	afx_msg void OnBnClickedButton2();
	CButton m_content_btn;
	afx_msg void OnBnClickedButton6();
//#UC END# *4574173603A9*
}; // class IppStd



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPSTD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

