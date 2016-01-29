////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/PropertyViews/IppDerivedImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppDerivedImpl
//
// �������� ����������� � ���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPDERIVEDIMPL_H__
#define __MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPDERIVEDIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/data/StaticNode.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppBase.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "boost/property_tree/ptree.hpp"
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/Controls/ETSLayout.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574178302DE_CUSTOM_INCLUDES*
//#UC END# *4574178302DE_CUSTOM_INCLUDES*


// �������� ����������� � ���������� ��������
class IppDerivedImpl : public IppBase {
	SET_OBJECT_COUNTER (IppDerivedImpl)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// ������������ ����� ������� ������ ��� ����������� � ������
	class TreeNode;
	typedef Core::Var<TreeNode> TreeNode_var;
	typedef Core::Var<const TreeNode> TreeNode_cvar;

	class TreeNode :
		virtual public GCL::StaticNode
	{
		SET_OBJECT_COUNTER (TreeNode)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		// ������ ����
		TreeNode (IRoseElementPtr elem, InheritedItem* inherited_state);

	public:
		virtual ~TreeNode ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// ���������� ���������� ������������ ��������
		virtual const std::string get_guid () const;

		// ���������� ��� ����
		virtual const std::string name () const;

		// �������������� ��� (��� �������� - ���������, ��� ������� - ��� ��������, ��� ��������� - ���
		// ����)
		virtual const std::string subname () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		// ���������, ��������� � ���������������� ��������� (����� ���� 0)
		InheritedItem_var m_inhertied_state;

		// �������� ������� (�� �������)
		IRoseElementPtr m_real_elem;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
		virtual const InheritedItem* get_inhertied_state () const;

		virtual void set_inhertied_state (InheritedItem* inhertied_state);

		virtual IRoseElementPtr get_real_elem () const;

		virtual void set_real_elem (IRoseElementPtr real_elem);
	}; // class TreeNode

	// ������ ���������������� �������
	typedef std::vector < boost::property_tree::ptree > OverridenProperties;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ��������� ������� �������
	static void fill_tree (const GCL::StrSet& selections, CTreeCtrl& tree, const TreeNode* data_node);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_IPP_DERIVED_IMPL };

public:
	IppDerivedImpl ();

public:
	virtual ~IppDerivedImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNCREATE(IppDerivedImpl)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();

	int OnCreate(LPCREATESTRUCT create_struct);

	void init_constraint ();
private:
	// �������� �������������� ������. ���� expand_all = true, �� ������������� ��� �������� ������,
	// ����� ������������� ������ �� �����, � ������� ���� ���������� ��������.
	virtual void expand (CTreeCtrl& tree, bool expand_all);

	// ��������� ������ � ������������ ����������
	virtual void fill_implement (bool use_gen_tree);

	// ��������� ������ � ����������������� ��������
	virtual void fill_overload (bool use_gen_tree);

	// ���� ���� � �������� ��������������� ������� � ���� start
	virtual TreeNode* find_node (TreeNode* start, const std::string& id) const;

	// ������������� �������
	virtual void init_dialog ();

	// ���������� ������� ������ - ������������ ������ ��������� ��� ���������� ������� DerivedImpl -
	// ��������� ���������� ������ ��������� � ���������
	virtual void on_use_gen_tree ();


//////////////////////////////////////////////////////////////////////////////////////////
// template methods
private:
	// ���������� ������ ������ ���������, ������� ��������� � ������, ��� ���� ���� ������� ����, ��
	// ��� ���� � ���� ������ �� ��������
	template <class Type, class ResultType>
	ResultType* get_selected (const CTreeCtrl& tree, const OverridenProperties& overriden_properties) const;
	
	template <class Type, class ResultType, class Collection>
	ResultType* get_selected2 (const CTreeCtrl& tree, const Collection& collection, const OverridenProperties& overriden_properties) const;

	// ���������� ������ ���������, ������� �� ��������� � ������, ��� ���� ���� ������� ���� � ���
	// ���� ���, �� ��� ���� � ���� ������ �� ��������
	template <class Type, class ResultType>
	ResultType* get_unselected (const CTreeCtrl& tree, const OverridenProperties& overriden_properties) const;


private:
	// ��������� ������ ������ ��� �����������
	template <class CollectionType>
	void fill_data (
		const GCL::StrSet& all_tems
		, const CollectionType& selected_items
		, TreeNode*& root
		, bool use_gen_tree
	);



//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CTreeCtrl m_implement;

	// ������ ��� ������ Implemented
	TreeNode_var m_implement_data;

	CTreeCtrl m_overload;

	// ������ ��� ������ overload
	TreeNode_var m_overload_data;

//#UC START# *4574178302DE*
// Implementation
protected:
	virtual bool on_ok(bool& need_colorize);
	
	typedef std::set<HTREEITEM> TreeItemSet;

public:
	afx_msg void OnBnClickedImplAll();
	CButton m_rb_impl_all;
	CButton m_rb_impl_incl;
	CButton m_rb_impl_excl;
	afx_msg void OnBnClickedImplIncl();
	afx_msg void OnBnClickedImplExcl();
	CButton m_rb_over_all;
	CButton m_rb_over_incl;
	CButton m_rb_over_excl;
	afx_msg void OnBnClickedOverAll();
	afx_msg void OnBnClickedOverIncl();
	afx_msg void OnBnClickedOverExcl();

	void on_dbl_click (CTreeCtrl& ctrl, TreeItemSet& collectionForSelected, bool exclude_checked, NMHDR* pNMHDR, LRESULT* pResult);
	void on_overloaded_dbl_click (NMHDR* pNMHDR, LRESULT* pResult);
	void on_implemented_dbl_click (NMHDR* pNMHDR, LRESULT* pResult);

	LRESULT on_tree_check_state_changed (WPARAM wParam, LPARAM lParam);

	void on_tree_click (CTreeCtrl& ctrl, NMHDR* pNMHDR, LRESULT* pResult);

	void on_implemented_click (NMHDR* pNMHDR, LRESULT* pResult);
	void on_overloaded_click (NMHDR* pNMHDR, LRESULT* pResult);

	void on_tree_keydown (CTreeCtrl& ctrl, NMHDR* pNMHDR, LRESULT* pResult);
	void on_implemented_keydown (NMHDR* pNMHDR, LRESULT* pResult);
	void on_overloaded_keydown (NMHDR* pNMHDR, LRESULT* pResult);

private:	
	TreeItemSet m_implement_selected;
	TreeItemSet m_overload_selected;
//#UC END# *4574178302DE*
}; // class IppDerivedImpl



#endif //__MDPROCESS_MDAADDINLIB_PROPERTYVIEWS_IPPDERIVEDIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

