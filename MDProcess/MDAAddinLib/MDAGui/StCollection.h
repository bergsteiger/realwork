////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/StCollection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::StCollection
//
// дилог выводит список доступных стереотипов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_STCOLLECTION_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_STCOLLECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574164F0242_CUSTOM_INCLUDES*
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
//#UC END# *4574164F0242_CUSTOM_INCLUDES*


// дилог выводит список доступных стереотипов
class StCollection : public WinGUI::ETSLayoutDialog {
	SET_OBJECT_COUNTER (StCollection)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_ST_COLLECTION };

public:
	explicit StCollection (IRoseItemPtr item, IRoseItemPtr item_context = 0);

public:
	virtual ~StCollection ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(StCollection)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();

//#UC START# *4574164F0242*
public:
	void fill_list ();
	void fill_info (int index);
	void set_selected_type (const std::string& type) {
		m_selected_type = type;
	}
public:
	Core::Aptr<CImageList> m_il;
	CButton m_all_rb;
	CButton m_cat_rb;
	CButton m_class_rb;
	CButton m_attr_rb;
	CButton m_op_rb;
	CListCtrl m_st_details;
	CEdit m_description;
	IRoseItemPtr m_item;
	IRoseItemPtr m_item_context;
	std::string m_selected_type;

	afx_msg void OnNMClickList1(NMHDR *pNMHDR, LRESULT *pResult);
	CButton m_show_all;
	afx_msg void OnBnClickedCheck1();
	afx_msg void OnBnClickedOk();

	const std::string& get_result () const {
		return m_result;
	}

	std::string m_result;
	CButton m_ok;
	CEdit m_enable_for;
	bool m_forsed_show_all;
	afx_msg void OnHdnItemdblclickList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnBnClickedAllRb();
	afx_msg void OnBnClickedCatRb();
	afx_msg void OnBnClickedClassRb();
	afx_msg void OnBnClickedAttrRb();
	afx_msg void OnBnClickedOpRb();
//#UC END# *4574164F0242*
}; // class StCollection



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_STCOLLECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

