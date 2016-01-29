////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/ReportView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::ReportView
//
// дилог построения отчета, например отчет о недокументированных элементах модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_REPORTVIEW_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_REPORTVIEW_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *457415DF00BB_CUSTOM_INCLUDES*
//#UC END# *457415DF00BB_CUSTOM_INCLUDES*


// дилог построения отчета, например отчет о недокументированных элементах модели
class ReportView : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (ReportView)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_REPORT_VIEW };

public:
	explicit ReportView (const RoseElementVector& items, const AbstractDumperBase::ReportsTreeItem* auto_run_rep = 0);

public:
	virtual ~ReportView ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ReportView)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// элементы, по которым строить отчет
	RoseElementVector m_items;

//#UC START# *457415DF00BB*
	HICON m_hIcon;

private:
	std::string m_mess;
	const AbstractDumperBase::ReportsTreeItem* m_auto_run_rep;

	CListCtrl m_result_list;
	CComboBox m_reports_combo;
	bool m_constructed;

	unsigned m_prev_leny;
	unsigned m_prev_lenx;
public:
	afx_msg void run_query();
	afx_msg void OnLvnItemActivateResult(NMHDR *pNMHDR, LRESULT *pResult);
	
	afx_msg void OnBnClickedAdvancedSearch();
	CButton m_run_btn;
	afx_msg void OnCbnSelchangeCombo1();
	afx_msg void OnBnClickedButEdit();
	afx_msg void OnBnClickedButBrowse();
	afx_msg void OnBnClickedButBrowseClose();
	CButton m_ok_btn;
	CButton m_cancel_btn;
	afx_msg void OnBnClickedButBrowseClose3();
	afx_msg void OnBnClickedButBrowseClose2();
	CButton m_edit_btn;
	CButton m_browse_btn;
	CButton m_bnc_btn;
	Core::Aptr<CImageList> m_il;
//#UC END# *457415DF00BB*
}; // class ReportView



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_REPORTVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

