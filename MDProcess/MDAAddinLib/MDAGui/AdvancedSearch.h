////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/AdvancedSearch.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::AdvancedSearch
//
// диалог расширенного поиска элементов в модели, позволяет искать по элементы по имени, классу,
// стереотипу, и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_ADVANCEDSEARCH_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_ADVANCEDSEARCH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4573E7840177_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "afxwin.h"
#include "afxcmn.h"
//#UC END# *4573E7840177_CUSTOM_INCLUDES*


// диалог расширенного поиска элементов в модели, позволяет искать по элементы по имени, классу,
// стереотипу, и т.д
class AdvancedSearch : public CDialog {
	SET_OBJECT_COUNTER (AdvancedSearch)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_ADVANCED_SEARCH };

public:
	explicit AdvancedSearch (const RoseElementVector& items);

public:
	virtual ~AdvancedSearch ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(AdvancedSearch)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// элементы, среди которых нужно проводить поиск
	RoseElementVector m_items;

//#UC START# *4573E7840177*
	struct Query {
		std::string text;
		bool in_name;
		bool in_doc;
		bool in_guid;

		std::string self_st;
		std::string parent_st;
		std::string grand_parent_st;
		std::string content_st;

		bool is_cat;
		bool is_class;
		bool is_usecase;
		bool is_op;
		bool is_attr;
		bool is_dep;

		bool is_public;
		bool is_protected;
		bool is_private;
		bool is_impl;

		bool is_regular;
		bool is_abstract;
		bool is_inline;
		bool is_final;

		bool is_native;
		bool is_modeled;
		bool is_parameterized;
		bool is_not_parameterized;

		std::string up_name_1;
		std::string up_value_1;
		std::string up_name_2;
		std::string up_value_2;
		std::string up_name_3;
		std::string up_value_3;
		std::string up_name_4;
		std::string up_value_4;
	};

protected:
	void fill_query(Query& q);

	bool is_fit_to_query(const Query& q, const RoseAbstractDumper* rad);

	void fill_st_list ();

	void fill_up_list (const AbstractDumperBase::Template& tpl);

	void requrcive_fill_content_sts (
		const AbstractDumperBase::Templates::key_type& key_child
		, const AbstractDumperBase::Templates::value_type& child
	);

	void reset_dlg();

private:
	Core::Aptr<CImageList> m_il;
	
	bool m_constructed;
	std::string m_upc_name_1;
	std::string m_upc_name_2;
	std::string m_upc_name_3;
	std::string m_upc_name_4;

	CEdit m_text_field;
	CButton m_in_name;
	CButton m_in_doc;
	CButton m_in_guid;
	CButton m_run_spell;
	CButton m_cat;
	CButton m_class;
	CButton m_op;
	CButton m_attr;
	CComboBox m_self_st;
	CComboBox m_parent_st;
	CComboBox m_g_parent_st;
	CComboBox m_up_name_1;
	CComboBox m_up_name_2;
	CComboBox m_up_name_3;
	CComboBox m_up_name_4;
	CEdit m_up_value_1;
	CEdit m_up_value_2;
	CEdit m_up_value_3;
	CEdit m_up_value_4;
	CListCtrl m_result_list;

	GCL::StrSet m_self_st_set;
	GCL::StrSet m_content_st_set;
	GCL::StrSet	m_parent_st_set;
	GCL::StrSet	m_g_parent_st_set;

	afx_msg void on_run();
	afx_msg void on_cancel();
	
public:
	afx_msg void OnLvnItemActivateList1(NMHDR *pNMHDR, LRESULT *pResult);
	CButton m_dep;
	CButton m_st_view;
	CButton m_path_view;
	CButton m_doc_view;
	afx_msg void OnBnClickedCheck9();
	afx_msg void OnBnClickedCheck10();
	CButton m_context_view;
	afx_msg void OnBnClickedCheck11();
	afx_msg void OnBnClickedCheck8();
	afx_msg void OnBnClickedCat();
	afx_msg void OnBnClickedClass();
	afx_msg void OnBnClickedOp();
	afx_msg void OnBnClickedAttr();
	afx_msg void OnBnClickedDep();
	CButton m_selected_up_view;
	afx_msg void OnBnClickedCheck21();
	CComboBox m_content_st;
	CButton m_usecase;
	afx_msg void OnBnClickedCheck12();
	CButton m_public;
	CButton m_protected;
	CButton m_private;
	CButton m_impl;
	CButton m_regular;
	CButton m_abstract;
//	CButton m_inline;
	CButton m_final;
	CComboBox m_native;
	CComboBox m_parameterized;
	afx_msg void OnBnClickedClear();
	afx_msg void OnCbnSelchangeCombo2();
	afx_msg void OnCbnSelchangeCombo5();
	afx_msg void OnCbnSelchangeCombo6();
	afx_msg void OnCbnSelchangeCombo7();	
	afx_msg void OnBnClickedButEdit();
	afx_msg void OnBnClickedButBrowse();
	afx_msg void OnBnClickedButBrowseClose();
//#UC END# *4573E7840177*
}; // class AdvancedSearch



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_ADVANCEDSEARCH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

