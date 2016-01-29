////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppDerivedImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppDerivedImpl
//
// страница наследуемых и релизуемых операций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppDerivedImpl.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_op.h"
#include "shared/GCL/data/StaticNodeIterator.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "boost/bind.hpp"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOperationImpl.h"
#include "boost/lambda/bind.hpp"
#include "boost/lambda/lambda.hpp"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

//#UC START# *4574178302DE_CUSTOM_INCLUDES*
#define TREE_VIEW_CHECK_STATE_CHANGE (WM_USER + 100)
//#UC END# *4574178302DE_CUSTOM_INCLUDES*


//#UC START# *4574178302DE*
static int CALLBACK compare_tree_item (LPARAM par1, LPARAM par2, LPARAM tree_par) {
	int res = 0;
	CTreeCtrl* tree_wnd = reinterpret_cast<CTreeCtrl*> (tree_par);
	if (tree_wnd) {
		IppDerivedImpl::TreeNode* item1 = reinterpret_cast<IppDerivedImpl::TreeNode*> (par1);
		IppDerivedImpl::TreeNode* item2 = reinterpret_cast<IppDerivedImpl::TreeNode*> (par2);
		
		if (item1 && item2) {
			res = ACE_OS::strcmp (item1->name ().c_str (), item2->name ().c_str ());
		}
	}

	return res;
}

void sort_tree (CTreeCtrl& ctrl) {
	TVSORTCB tvs;
	tvs.hParent = TVI_ROOT;
	tvs.lpfnCompare = (PFNTVCOMPARE)compare_tree_item;
	tvs.lParam = (LPARAM)&ctrl;
	//сортируем первый уровень
	ctrl.SortChildrenCB(&tvs);
	HTREEITEM item = ctrl.GetRootItem ();
	if (item) {
		tvs.hParent = item;
		ctrl.SortChildrenCB(&tvs);
		while (item = ctrl.GetNextSiblingItem (item)) {
			tvs.hParent = item;
			ctrl.SortChildrenCB(&tvs);
		}
	}
	ctrl.SendMessage (WM_SETREDRAW, TRUE, 0L);
}

bool IppDerivedImpl::on_ok (bool& need_colorize) {
	IRoseItemPtr item = this->get_rose_item();	
	
	RoseAbstractDumper* rad = 0;

	if (RoseAbstractDumper::is_model_tree_initialized ()) {
		rad = RoseAbstractDumper::find_in_tree (item);
	}

	need_colorize = false;
	
	OverridenProperties props;
	Core::Aptr<ImplementedItemSet> implements 
		= get_selected2<ImplementedItem, ImplementedItemSet> (m_implement, m_implement_selected, props);	

	Core::Aptr<OverloadedItemSet> overload
		= get_selected2<OverloadedItem, OverloadedItemSet> (m_overload, m_overload_selected, props);
	
	GDS_ASSERT_MSG(implements.ptr () != 0 && overload.ptr () != 0, ("get_selected must return non-nil value"));

	if (/*!RoseAbstractDumper::is_model_tree_initialized ()*/true) {
		//если не используется дерево генерации для построения списков DerivedImpl
		Core::Aptr<ImplementedItemSet> stored_implemented = InheritedItemHelperFactory::get ().get_stored_implemented (item);
		Core::Aptr<OverloadedItemSet> stored_overloaded = InheritedItemHelperFactory::get ().get_stored_overloaded (item);
		
		//т.к в модели могли быть сохранены виртуальные операции - нужно их добавить к текущим, выставленным
		//чтобы они не пропали, при этом нужно из списка сохраненных исключить те операции с которых
		//снята галка не должны быть добавлены

		Core::Aptr<ImplementedItemSet> unselected_implements = get_unselected<ImplementedItem, ImplementedItemSet> (m_implement, props);
		Core::Aptr<OverloadedItemSet> unselected_overloaded = get_unselected<OverloadedItem, OverloadedItemSet> (m_overload, props);
		
		std::set_difference (
			stored_implemented->begin ()
			, stored_implemented->end ()
			, unselected_implements->begin ()
			, unselected_implements->end ()
			, std::inserter (*implements.ptr (), implements->begin ())
			, ImplementedItemComparator ()
		);

		std::set_difference (
			stored_overloaded->begin ()
			, stored_overloaded->end ()
			, unselected_overloaded->begin ()
			, unselected_overloaded->end ()
			, std::inserter (*overload.ptr (), overload->begin ())
			, OverloadedItemComparator ()
		);
	}

	if (rad) {
		need_colorize |= InheritedItemHelperFactory::get ().save (rad, *implements.ptr ());
		need_colorize |= InheritedItemHelperFactory::get ().save (rad, *overload.ptr ());
	} else {
		need_colorize |= InheritedItemHelperFactory::get ().save (item, *implements.ptr ());
		need_colorize |= InheritedItemHelperFactory::get ().save (item, *overload.ptr ());
	}

	_bstr_t implemented_select_type ("");
	if (m_rb_impl_all.GetCheck()) {
		implemented_select_type = "all";
	} else if (m_rb_impl_incl.GetCheck()) {
		implemented_select_type = "include";
	} else {
		implemented_select_type = "exclude";
	}
	need_colorize |= RoseHelper::override_property(item, TOOL_NAME, PROP_IMPLEMENT_SELECT_TYPE, implemented_select_type);

	_bstr_t overload_select_type ("");
	if (m_rb_over_all.GetCheck()) {
		overload_select_type = "all";
	} else if (m_rb_over_incl.GetCheck()) {
		overload_select_type = "include";
	} else {
		overload_select_type = "exclude";
	}
	need_colorize |= RoseHelper::override_property(item, TOOL_NAME, PROP_OVERLOAD_SELECT_TYPE, overload_select_type);

	if (need_colorize) {
		//нужно обновить временные свойства в элементе!
		if (rad) {
			rad->set_temporary_property (
				std::string(_bstr_t(TOOL_NAME))
				, std::string(_bstr_t(PROP_IMPLEMENT_SELECT_TYPE))
				, std::string(implemented_select_type)
			);

			rad->set_temporary_property (
				std::string(_bstr_t(TOOL_NAME))
				, std::string(_bstr_t(PROP_OVERLOAD_SELECT_TYPE))
				, std::string(overload_select_type)
			);
		}
		
		AbstractDumperBase::s_need_run_spell = true;
	}
	
	return true;
}

void make_readonly (CTreeCtrl& ctrl) {
	ctrl.ModifyStyle (TVS_CHECKBOXES, 0);
	if (ctrl.IsWindowEnabled ()) {
		ctrl.SetTextColor(::GetSysColor(COLOR_GRAYTEXT));
		ctrl.SetBkColor (::GetSysColor(COLOR_BTNFACE));
		ctrl.RedrawWindow ();
	}
}

void make_readwrite (CTreeCtrl& ctrl) {
	ctrl.ModifyStyle (0, TVS_CHECKBOXES);
	if (ctrl.IsWindowEnabled ()) {
		ctrl.SetTextColor(::GetSysColor(COLOR_WINDOWTEXT));
		ctrl.SetBkColor (::GetSysColor(COLOR_WINDOW));
		ctrl.RedrawWindow ();
	}
}

void IppDerivedImpl::OnBnClickedImplAll() {
	m_rb_impl_all.SetCheck(true);
	m_rb_impl_incl.SetCheck(false);
	m_rb_impl_excl.SetCheck(false);

	make_readonly (m_implement);
}

void IppDerivedImpl::OnBnClickedImplIncl() {
	m_rb_impl_all.SetCheck(false);
	m_rb_impl_incl.SetCheck(true);
	m_rb_impl_excl.SetCheck(false);

	make_readwrite (m_implement);
}

void IppDerivedImpl::OnBnClickedImplExcl() {
	m_rb_impl_all.SetCheck(false);
	m_rb_impl_incl.SetCheck(false);
	m_rb_impl_excl.SetCheck(true);

	make_readwrite (m_implement);
}

void IppDerivedImpl::OnBnClickedOverAll() {
	m_rb_over_all.SetCheck(true);
	m_rb_over_incl.SetCheck(false);
	m_rb_over_excl.SetCheck(false);

	m_overload.EnableWindow(false);
}

void IppDerivedImpl::OnBnClickedOverIncl() {
	m_rb_over_all.SetCheck(false);
	m_rb_over_incl.SetCheck(true);
	m_rb_over_excl.SetCheck(false);

	m_rb_over_all.EnableWindow(false);
	m_rb_over_incl.EnableWindow(false);
	m_rb_over_excl.EnableWindow(false);

	m_overload.EnableWindow(true);
}

void IppDerivedImpl::OnBnClickedOverExcl() {
	m_rb_over_all.SetCheck(false);
	m_rb_over_incl.SetCheck(false);
	m_rb_over_excl.SetCheck(true);

	m_overload.EnableWindow(true);
}

void IppDerivedImpl::on_dbl_click (CTreeCtrl& ctrl, TreeItemSet& collectionForSelected, bool exclude_checked, NMHDR* pNMHDR, LRESULT* pResult){
	
	if (!exclude_checked) {
		//дабл клик только если не режим "Exclude" - т.к в этом случае
		//бессмысленно создавать обертку

		UINT flags;
		HTREEITEM item;
		CPoint pt;
		*pResult = 0;
		if(!GetCursorPos(&pt)) {
			return;
		}

		ctrl.ScreenToClient (&pt);
		if ((item = ctrl.HitTest(pt, &flags)) != NULL) {
			///The hTarget  is the reference to the node
			ctrl.SelectItem (item);
			
			if (ctrl.GetCheck (item)) {
				collectionForSelected.insert(item);

				const TreeNode* ptr = reinterpret_cast<const TreeNode*> (ctrl.GetItemData (item));

				if (ptr) {
					const InheritedItem* inherited_state = ptr->get_inhertied_state ();
					if (inherited_state) {
						IRoseElementPtr wrapper = InheritedItemHelperFactory::get ().make_wrapper (ptr->get_real_elem (), inherited_state);
						if (wrapper) {
							Commands::CmdManagerFactory::get ().properties (wrapper, false, false);
						}
					}
				}
			} else {
				collectionForSelected.erase(item);
			}
		}
	}

	*pResult = 0;
}

void IppDerivedImpl::on_implemented_dbl_click (NMHDR* pNMHDR, LRESULT* pResult) {
	on_dbl_click (m_implement, m_implement_selected, m_rb_impl_excl.GetCheck (), pNMHDR, pResult);
}

void IppDerivedImpl::on_overloaded_dbl_click (NMHDR* pNMHDR, LRESULT* pResult) {
	on_dbl_click (m_overload, m_overload_selected, m_rb_over_excl.GetCheck (), pNMHDR, pResult);
}

LRESULT IppDerivedImpl::on_tree_check_state_changed (WPARAM wParam, LPARAM lParam) {
	CTreeCtrl* ctrl = reinterpret_cast<CTreeCtrl*>(wParam);
	HTREEITEM item = reinterpret_cast<HTREEITEM>(lParam);
	
	TreeItemSet* collection = NULL;
	if (ctrl == &m_implement) {
		collection = &m_implement_selected;
	} else {
		collection = &m_overload_selected;
	}

	if (ctrl->GetCheck(item)) {
		collection->insert (item);
	} else {
		collection->erase (item);
	}
	return S_OK;
}

void IppDerivedImpl::on_tree_keydown (CTreeCtrl& ctrl, NMHDR* pNMHDR, LRESULT* pResult) {
	LPNMTVKEYDOWN pTVKeyDown = reinterpret_cast<LPNMTVKEYDOWN>(pNMHDR);

	if (pTVKeyDown->wVKey==VK_SPACE) {

		// Determine the selected tree item.

		HTREEITEM item = ctrl.GetSelectedItem();

		if (item != NULL) {
			PostMessage (TREE_VIEW_CHECK_STATE_CHANGE, (WPARAM)&ctrl, (LPARAM)item);
		}
	}

	*pResult = 0;
}

void IppDerivedImpl::on_tree_click (CTreeCtrl& ctrl, NMHDR* pNMHDR, LRESULT* pResult) {
	HTREEITEM item;

	UINT flags;

	// verify that we have a mouse click in the check box area

	DWORD pos = GetMessagePos();

	CPoint point(LOWORD(pos), HIWORD(pos));

	ctrl.ScreenToClient(&point);

	item = ctrl.HitTest(point, &flags);

	if( item && (flags & TVHT_ONITEMSTATEICON)) {
		PostMessage(TREE_VIEW_CHECK_STATE_CHANGE, (WPARAM)&ctrl,(LPARAM)item);
	}

	*pResult = 0; 
}

void IppDerivedImpl::on_implemented_click (NMHDR* pNMHDR, LRESULT* pResult) {
	this->on_tree_click (m_implement, pNMHDR, pResult);
}

void IppDerivedImpl::on_overloaded_click (NMHDR* pNMHDR, LRESULT* pResult) {
	this->on_tree_click (m_overload, pNMHDR, pResult);
}

void IppDerivedImpl::on_implemented_keydown (NMHDR* pNMHDR, LRESULT* pResult) {
	this->on_tree_keydown (m_implement, pNMHDR, pResult);
}

void IppDerivedImpl::on_overloaded_keydown (NMHDR* pNMHDR, LRESULT* pResult) {
	this->on_tree_keydown (m_overload, pNMHDR, pResult);
}

//#UC END# *4574178302DE*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// заполняет контрол данными
void IppDerivedImpl::fill_tree (const GCL::StrSet& selections, CTreeCtrl& tree, const TreeNode* data_node) {
	//#UC START# *49818BCF0321*
	class local {
	public:	
		static void check_item (CTreeCtrl& tree, HTREEITEM item) {
			HTREEITEM parent = tree.GetParentItem (item);
			if (!parent || !tree.GetCheck (parent)) {
				tree.SetCheck(item);
			}
		}
		
		static void fill_tree_impl (const GCL::StrSet& selections, CTreeCtrl& tree, HTREEITEM view_node, const TreeNode* data_node) {
			if (view_node == 0) {
				view_node = tree.InsertItem (data_node->name().data(), TVI_ROOT);
				tree.SetItemData (view_node, (DWORD)data_node);		
				if (selections.find (data_node->get_guid ()) != selections.end()) {
					check_item (tree, view_node);
				}
				fill_tree_impl (selections, tree, view_node, data_node);

				Core::Var<const TreeNode> sibling = dynamic_cast<const TreeNode*> (data_node->next ());
				while (!sibling.is_nil()) {
					HTREEITEM ht_sibling = tree.InsertItem (sibling->name().data(), TVI_ROOT);

					if (selections.find (sibling->get_guid ()) != selections.end()) {
						check_item (tree, ht_sibling);
					}

					tree.SetItemData (ht_sibling, (DWORD)sibling.ptr());

					if (sibling->has_children()) {
						fill_tree_impl (selections, tree, ht_sibling, sibling.in());
					}
					sibling = dynamic_cast<const TreeNode*>(sibling->next());
				}
			} else {
				typedef std::map<std::string, unsigned int> NameCountMap;
				NameCountMap counter;
				Core::Var<const TreeNode> tmp = dynamic_cast<const TreeNode*>(data_node->first_child());				
				while (!tmp.is_nil()) {
					std::string name = tmp->name ();
					NameCountMap::iterator it = counter.find (name);
					if (it == counter.end ()) {
						counter[name] = 1;
					} else {
						it->second++;
					}
					tmp = dynamic_cast<const TreeNode*>(tmp->next());
				}

				std::string space (" ");
				Core::Var<const TreeNode> child = dynamic_cast<const TreeNode*>(data_node->first_child());
				while (!child.is_nil()) {
					std::string child_name = child->name();
					
					NameCountMap::iterator it = counter.find (child_name);
					if (it != counter.end () && it->second > 1) {
						child_name += space + child->subname ();
					}

					HTREEITEM ht_child = tree.InsertItem (child_name.data(), view_node);
					
					if (selections.find (child->get_guid ()) != selections.end()) {
						check_item (tree, ht_child);
					}

					tree.SetItemData (ht_child, (DWORD)child.ptr());

					if (child->has_children()) {
						fill_tree_impl (selections, tree, ht_child, child.in());
					}
					child = dynamic_cast<const TreeNode*>(child->next());
				}				
			}
		}		
	};
	if (data_node) {
		//дерево с данными не пустое
		local::fill_tree_impl (selections, tree, 0, data_node);		
	}
	//#UC END# *49818BCF0321*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppDerivedImpl::IppDerivedImpl ()
	: IppBase (IppDerivedImpl::IDD)
//#UC START# *4574178302DE_CTOR_BASE_INIT*
//#UC END# *4574178302DE_CTOR_BASE_INIT*
{
	//#UC START# *4574178302DE_CTOR*
	//#UC END# *4574178302DE_CTOR*
}


IppDerivedImpl::~IppDerivedImpl () {
	//#UC START# *4574178302DE_DESTR_BODY*
	//#UC END# *4574178302DE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppDerivedImpl, IppBase)
	ON_WM_CREATE()
	//#UC START# *4574178302DE_MESSAGE_MAP*
	ON_MESSAGE(TREE_VIEW_CHECK_STATE_CHANGE, on_tree_check_state_changed)

	ON_BN_CLICKED(IDC_IMPL_ALL, OnBnClickedImplAll)
	ON_BN_CLICKED(IDC_IMPL_INCL, OnBnClickedImplIncl)
	ON_BN_CLICKED(IDC_IMPL_EXCL, OnBnClickedImplExcl)
	ON_BN_CLICKED(IDC_OVER_ALL, OnBnClickedOverAll)
	ON_BN_CLICKED(IDC_OVER_INCL, OnBnClickedOverIncl)
	ON_BN_CLICKED(IDC_OVER_EXCL, OnBnClickedOverExcl)
	ON_BN_CLICKED(IDC_USE_GEN_TREE, on_use_gen_tree)
	ON_NOTIFY(NM_DBLCLK, IDC_IMPLEMENT, on_implemented_dbl_click)
	ON_NOTIFY(NM_DBLCLK, IDC_OVERLOAD, on_overloaded_dbl_click)

	ON_NOTIFY(NM_CLICK, IDC_IMPLEMENT, on_implemented_click)
	ON_NOTIFY(NM_CLICK, IDC_OVERLOAD, on_overloaded_click)

	ON_NOTIFY(TVN_KEYDOWN, IDC_IMPLEMENT, on_implemented_keydown)
	ON_NOTIFY(TVN_KEYDOWN, IDC_OVERLOAD, on_overloaded_keydown)
	//#UC END# *4574178302DE_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppDerivedImpl, CPropertyPage)

void IppDerivedImpl::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *4574178302DE_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_IMPLEMENT, m_implement);
	DDX_Control(pDX, IDC_OVERLOAD, m_overload);
	DDX_Control(pDX, IDC_IMPL_ALL, m_rb_impl_all);
	DDX_Control(pDX, IDC_IMPL_INCL, m_rb_impl_incl);
	DDX_Control(pDX, IDC_IMPL_EXCL, m_rb_impl_excl);
	DDX_Control(pDX, IDC_OVER_ALL, m_rb_over_all);
	DDX_Control(pDX, IDC_OVER_INCL, m_rb_over_incl);
	DDX_Control(pDX, IDC_OVER_EXCL, m_rb_over_excl);
	//#UC END# *4574178302DE_DO_DATA_EXCHANGE*
}

BOOL IppDerivedImpl::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *4574178302DE_ON_INIT_DLG*
		this->check_for_editable ();
		CWnd* wnd = this->GetDlgItem (IDC_USE_GEN_TREE);
		if (wnd) {
			wnd->EnableWindow (true);
		}
		IRoseItemPtr item = this->get_rose_item();

		m_implement.ModifyStyle (TVS_CHECKBOXES, 0);
		m_implement.ModifyStyle (0, TVS_CHECKBOXES);

		m_overload.ModifyStyle (TVS_CHECKBOXES, 0);
		m_overload.ModifyStyle (0, TVS_CHECKBOXES);
				
		///////////////////////////////////////////////////////////////////////
		RoseHelper::check_model_for_changes ();
		
		std::string impl_sel_type = RoseHelper::get_implement_select_type (item);
		if (impl_sel_type == "exclude") {
			this->OnBnClickedImplExcl ();
		} else if (impl_sel_type == "include") {
			this->OnBnClickedImplIncl ();
		} else {
			this->OnBnClickedImplAll ();
		}

		this->OnBnClickedOverIncl ();		

		this->init_dialog ();
		//#UC END# *4574178302DE_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppDerivedImpl\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppDerivedImpl::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppDerivedImpl::init_constraint () {
	//#UC START# *4574178302DE_CUSTOM_CONTROLS_CONSTRAINT*
	CPane pane_derived_abstract = pane (VERTICAL)
		<< item (IDC_ABSTRACT_LABEL, NORESIZE)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_IMPL_ALL, NORESIZE)
			<< item (IDC_IMPL_INCL, NORESIZE)
			<< item (IDC_IMPL_EXCL, NORESIZE)
		)
		<< item (IDC_IMPLEMENT, GREEDY);

	CPane pane_overload = pane (VERTICAL)		
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< (pane (VERTICAL)
				<< item (IDC_OVERLOAD_LABEL, NORESIZE)
				<< (pane (HORIZONTAL, ABSOLUTE_VERT)
					<< item (IDC_OVER_ALL, NORESIZE)
					<< item (IDC_OVER_INCL, NORESIZE)
					<< item (IDC_OVER_EXCL, NORESIZE)
				)
			)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_USE_GEN_TREE, NORESIZE | ALIGN_RIGHT)
		)
		
		
		<< item (IDC_OVERLOAD, GREEDY);

	CreateRoot (HORIZONTAL)
		<< pane_derived_abstract
		<< pane_overload;
	//#UC END# *4574178302DE_CUSTOM_CONTROLS_CONSTRAINT*
}


// Алгоритм разворачивания дерева. Если expand_all = true, то разворачиваем все элементы дерева,
// иначе разворачиваем только те ветки, в которых есть отмеченных элементы.
void IppDerivedImpl::expand (CTreeCtrl& tree, bool expand_all) {
	//#UC START# *498ACD8402C6*
	class local {
	public:
		static void expand_all (CTreeCtrl& tree) {
			HTREEITEM item = tree.GetRootItem ();			
			if (item) {
				tree.Expand(item, TVE_EXPAND);
				while (item = tree.GetNextSiblingItem (item)) {
					tree.Expand(item, TVE_EXPAND);
				}
			}
		}
		
		static bool has_checked_child (CTreeCtrl& tree, HTREEITEM item) {
			bool res = false;
			if (tree.ItemHasChildren (item)) {					
				HTREEITEM child = tree.GetNextItem (item, TVGN_CHILD);
				if (child) {
					res |= tree.GetCheck (child) == TRUE;
					while (child = tree.GetNextSiblingItem (child)) {
						res |= tree.GetCheck (child) == TRUE;
					}
				}
			}

			return res;
		}

		static void expand_only_for_checked (CTreeCtrl& tree) {
			HTREEITEM item = tree.GetRootItem ();			
			if (item) {
				if (has_checked_child (tree, item)) {
					tree.Expand(item, TVE_EXPAND);
				}
				while (item = tree.GetNextSiblingItem (item)) {
					if (has_checked_child (tree, item)) {
						tree.Expand(item, TVE_EXPAND);
					}
				}
			}
		}
	};

	if (expand_all) {
		local::expand_all (tree);
	} else {
		local::expand_only_for_checked (tree);
	}
	//#UC END# *498ACD8402C6*
}

// заполняет дерево с абстрактными операциями
void IppDerivedImpl::fill_implement (bool use_gen_tree) {
	//#UC START# *498153C1036C*
	m_implement.DeleteAllItems ();
	m_implement_data = 0;

	IRoseItemPtr item = this->get_rose_item();
	GCL::StrSet all_derived_abstract;
	GCL::StrSet all_derived_impl;
	
	Core::Aptr<ImplementedItemSet> implemented_items;
	if (!use_gen_tree) {
		RoseHelper::find_all_derived_abstract (item, all_derived_abstract);
		RoseHelper::find_all_derived_impl (item, all_derived_impl);

		implemented_items = InheritedItemHelperFactory::get ().get_stored_implemented (item);
	} else {
		RoseAbstractDumper::UnorderedRADSet all_derived_abstract_rad;
		RoseAbstractDumper::UnorderedRADSet all_derived_impl_rad;

		const RoseAbstractDumper* item_rad = RoseAbstractDumper::find_in_tree (item);
		//элемента может не быть в дереве если он только создаётся...
		if (item_rad) {
			RoseHelper::find_all_derived_abstract (item_rad, all_derived_abstract_rad);
			RoseHelper::find_all_derived_impl (item_rad, all_derived_impl_rad);
			
			std::transform (
				all_derived_abstract_rad.begin ()
				, all_derived_abstract_rad.end ()
				, std::inserter (all_derived_abstract, all_derived_abstract.begin ())
				, boost::bind (&RoseAbstractDumper::get_model_unique_id_str, _1)
			);

			std::transform (
				all_derived_impl_rad.begin ()
				, all_derived_impl_rad.end ()
				, std::inserter (all_derived_impl, all_derived_impl.begin ())
				, boost::bind (&RoseAbstractDumper::get_model_unique_id_str, _1)
			);

			implemented_items = InheritedItemHelperFactory::get ().get_stored_implemented (item_rad);
		} else {
			RoseHelper::find_all_derived_abstract (item, all_derived_abstract);
			RoseHelper::find_all_derived_impl (item, all_derived_impl);

			implemented_items = InheritedItemHelperFactory::get ().get_stored_implemented (item);
		}
		
	}
	
	for (GCL::StrSet::const_iterator it = all_derived_impl.begin(); it != all_derived_impl.end(); ++it) {
		all_derived_abstract.erase (*it);
	}

	GCL::StrSet implemented;

	if (!implemented_items.is_nil ()) {
		std::transform (
			implemented_items->begin ()
			, implemented_items->end ()
			, std::inserter (implemented, implemented.begin ())
			, boost::bind (
				&ImplementedItem::get_uid
				, boost::bind (
					static_cast<const ImplementedItem* (ImplementedItem_var::*) () const> (&ImplementedItem_var::ptr)
					, _1
				)
			)
		);
	}
	
	this->fill_data (all_derived_abstract, *implemented_items.ptr (), m_implement_data.out (), use_gen_tree);
	this->fill_tree (implemented, m_implement, m_implement_data.in ());
	//#UC END# *498153C1036C*
}

// заполняет дерево с переопределяемыми методами
void IppDerivedImpl::fill_overload (bool use_gen_tree) {
	//#UC START# *4981553E03A0*
	m_overload.DeleteAllItems ();
	m_overload_data = 0;

	IRoseItemPtr item = this->get_rose_item();
	GCL::StrSet all_derived_impl;
	
	Core::Aptr<OverloadedItemSet> overloaded_items;

	if (!use_gen_tree) {
		RoseHelper::find_all_derived_impl (item, all_derived_impl);
		overloaded_items = InheritedItemHelperFactory::get ().get_stored_overloaded (item);
	} else {
		RoseAbstractDumper::UnorderedRADSet all_derived_impl_rad;

		const RoseAbstractDumper* item_rad = RoseAbstractDumper::find_in_tree (item);
		//элемента может не быть в дереве если он только создаётся...
		if (item_rad) {		
			RoseHelper::find_all_derived_impl (item_rad, all_derived_impl_rad);
			
			std::transform (
				all_derived_impl_rad.begin ()
				, all_derived_impl_rad.end ()
				, std::inserter (all_derived_impl, all_derived_impl.begin ())
				, boost::bind (&RoseAbstractDumper::get_model_unique_id_str, _1)
			);

			overloaded_items = InheritedItemHelperFactory::get ().get_stored_overloaded (item_rad);
		} else {
			RoseHelper::find_all_derived_impl (item, all_derived_impl);
			overloaded_items = InheritedItemHelperFactory::get ().get_stored_overloaded (item);
		}
	}

	GCL::StrSet overloaded;

	if (!overloaded_items.is_nil ()) {
		std::transform (
			overloaded_items->begin ()
			, overloaded_items->end ()
			, std::inserter (overloaded, overloaded.begin ())
			, boost::bind (
				&OverloadedItem::get_uid
				, boost::bind (
					static_cast<const OverloadedItem* (OverloadedItem_var::*) () const> (&OverloadedItem_var::ptr)
					, _1
				)
			)
		);
	} else {
		overloaded_items = new OverloadedItemSet ();
	}

	this->fill_data (all_derived_impl, *overloaded_items.ptr (), m_overload_data.out (), use_gen_tree);
	this->fill_tree (overloaded, m_overload, m_overload_data.in ());
	//#UC END# *4981553E03A0*
}

// ищет ноду с заданным идентификатором начиная с ноды start
IppDerivedImpl::TreeNode* IppDerivedImpl::find_node (TreeNode* start, const std::string& id) const {
	//#UC START# *4981970802EE*
	if (start->get_guid () == id) {
		return ::Core::IObject::_duplicate (start);
	}

	GCL::StaticNodeIterator iter (start);
	for (
		TreeNode_var found_node = dynamic_cast<TreeNode*> (iter.get_next ())
		; !found_node.is_nil ()
		; found_node = dynamic_cast<TreeNode*> (iter.get_next ())
	) {
		if (found_node->get_guid () == id) {
			return found_node._sretn ();
		}
	}

	return 0;
	//#UC END# *4981970802EE*
}

// инициализация диалога
void IppDerivedImpl::init_dialog () {
	//#UC START# *4B345A9D0238*
	this->fill_implement (RoseAbstractDumper::is_model_tree_initialized ());
	this->fill_overload (RoseAbstractDumper::is_model_tree_initialized ());

	this->expand (m_implement, m_rb_impl_all.GetCheck () == TRUE ? true : false);
	this->expand (m_overload, false);

	//сортируем
	sort_tree (m_implement);
	sort_tree (m_overload);
	//#UC END# *4B345A9D0238*
}

// обработчик нажатия кнопки - использовать дерево генерации для построения списков DerivedImpl -
// запускает построение дерева генерации и сумонинга
void IppDerivedImpl::on_use_gen_tree () {
	//#UC START# *4B344E080084*
	try {
		RoseHelper::check_model_for_changes ();
		RoseAbstractDumper::get_model_tree_root();	
	} catch (Base::FatalError&) {
		GenSupport::ErrorManagerFactory::get ().error (0, "Ошибка при построении дерева генерации", "DerivedImpl");
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();

		/*GenSupport::LogManagerFactory::get ().log_error("Loading model tree finished by Fatal error:");
		GenSupport::LogManagerFactory::get ().log_error(ex.what ());
		MessageBox ("Fatal errors while loading model tree - see log for detail", "Fatal Error", MB_OK|MB_ICONEXCLAMATION );*/
		return;

	} catch (...) {
		//MessageBox ("Unknown exception while loading model tree", "Fatal Error", MB_OK|MB_ICONEXCLAMATION );
		GenSupport::ErrorManagerFactory::get ().error (0, "Неизвестная ошибка при построении дерева генерации", "DerivedImpl");
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();

		return;
	}
	
	this->init_dialog ();
	//#UC END# *4B344E080084*
}
//////////////////////////////////////////////////////////////////////////////////////////
// template methods implementation

// Возвращает список гуидов элементов, которые отмеченны в дереве, при этом если отмечен узел, то
// его дети в этот список не попадают
template <class Type, class ResultType>
ResultType* IppDerivedImpl::get_selected (
	const CTreeCtrl& tree
	, const OverridenProperties& overriden_properties
) const {
	//#UC START# *4981ABC300B3_4574178302DE*
	class local {
	public:
		static void visit (const CTreeCtrl& tree, HTREEITEM from, ResultType& selections) {
			if (tree.GetCheck (from)) {
				const TreeNode* ptr = reinterpret_cast<const TreeNode*> (tree.GetItemData (from));
				if (ptr) {
					GCL::StaticNode_cvar parent (ptr->parent ());

					bool need_collect_children = parent.is_nil () ? true : false;
					const InheritedItem* inhertied_state = ptr->get_inhertied_state ();

					Core::Var<Type> item;
					if (inhertied_state) {
						item = const_cast<Type*> (
							dynamic_cast<const Type*> (
								Core::IObject::_duplicate (inhertied_state)
							)
						);
						item->set_need_collect_children (need_collect_children);
					} else {
						item = Core::TypeTraits<Type>::Factory::make (ptr->get_guid (), need_collect_children);
					}

					selections.insert (item);
				}
				visit_siblings (tree, from, selections);
			} else {
				//если узел не выбран - собираем детей
				if (tree.ItemHasChildren (from)) {					
					HTREEITEM child = from;
					child = tree.GetNextItem (from, TVGN_CHILD);
					if (child) {
						visit (tree, child, selections);						
					}
				} else {
					visit_siblings (tree, from, selections);
				}
			}			
		}

		static void visit_siblings (const CTreeCtrl& tree, HTREEITEM from, ResultType& selections) {
			HTREEITEM sibling = tree.GetNextSiblingItem (from);
			if (sibling) {
				visit (tree, sibling, selections);
			} else {
				HTREEITEM parent = tree.GetParentItem (from);
				if (parent) {
					visit_siblings (tree, parent, selections);
				}
			}
		}

		static void visit (const CTreeCtrl& tree, ResultType& selections) {
			HTREEITEM root = tree.GetRootItem ();
			if (root) {
				visit (tree, root, selections);
			}
		}
	};
	Core::Aptr<ResultType> selected (new ResultType ());
	local::visit (tree, *selected);

	return selected.forget ();
	//#UC END# *4981ABC300B3_4574178302DE*
}

template <class Type, class ResultType, class Collection>
ResultType* IppDerivedImpl::get_selected2 (const CTreeCtrl& tree, const Collection& collection, const OverridenProperties& overriden_properties) const {
	Core::Aptr<ResultType> selected (new ResultType ());

	//оставляем только элементы, у которых родители не отмечены
	Collection filtered_collection;
	for (Collection::const_iterator it = collection.begin (); it != collection.end (); ++it) {
		HTREEITEM item = *it;
		HTREEITEM parent = item;
		bool has_selected_parent = false;
		while (!has_selected_parent && parent) {
			parent = tree.GetParentItem (parent);
			if (parent) {
				has_selected_parent = tree.GetCheck (parent);
			}
		}

		if (!has_selected_parent) {
			filtered_collection.insert (item);
		}
	}

	for (Collection::const_iterator it = filtered_collection.begin (); it != filtered_collection.end (); ++it) {
		const TreeNode* ptr = reinterpret_cast<const TreeNode*> (tree.GetItemData (*it));
		if (ptr) {
			GCL::StaticNode_cvar parent (ptr->parent ());

			bool need_collect_children = parent.is_nil () ? true : false;
			const InheritedItem* inhertied_state = ptr->get_inhertied_state ();

			Core::Var<Type> item;
			if (inhertied_state) {
				item = const_cast<Type*> (
					dynamic_cast<const Type*> (
						Core::IObject::_duplicate (inhertied_state)
					)
				);
				item->set_need_collect_children (need_collect_children);
			} else {
				item = Core::TypeTraits<Type>::Factory::make (ptr->get_guid (), need_collect_children);
			}

			selected->insert (item);
		}
	}

	return selected.forget ();
}

// Возвращает список элементов, которые НЕ отмеченны в дереве, при этом если отмечен узел а его
// дети нет, то эти дети в этот список не попадают
template <class Type, class ResultType>
ResultType* IppDerivedImpl::get_unselected (
	const CTreeCtrl& tree
	, const OverridenProperties& overriden_properties
) const {
	//#UC START# *4D34040E02EE_4574178302DE*
	class local {
	public:
		static void visit (const CTreeCtrl& tree, HTREEITEM from, ResultType& selections) {
			if (!tree.GetCheck (from)) {
				const TreeNode* ptr = reinterpret_cast<const TreeNode*> (tree.GetItemData (from));
				if (ptr) {
					GCL::StaticNode_cvar parent (ptr->parent ());

					bool need_collect_children = parent.is_nil () ? true : false;
					const InheritedItem* inhertied_state = ptr->get_inhertied_state ();

					Core::Var<Type> item;
					if (inhertied_state) {
						item = const_cast<Type*> (
							dynamic_cast<const Type*> (
							Core::IObject::_duplicate (inhertied_state)
							)
							);
						item->set_need_collect_children (need_collect_children);
					} else {
						item = Core::TypeTraits<Type>::Factory::make (ptr->get_guid (), need_collect_children);
					}

					selections.insert (item);
				}
				
				if (tree.ItemHasChildren (from)) {					
					HTREEITEM child = from;
					child = tree.GetNextItem (from, TVGN_CHILD);
					if (child) {
						visit (tree, child, selections);						
					}
				}
			}

			visit_siblings (tree, from, selections);			
		}

		static void visit_siblings (const CTreeCtrl& tree, HTREEITEM from, ResultType& selections) {
			HTREEITEM sibling = tree.GetNextSiblingItem (from);
			if (sibling) {
				visit (tree, sibling, selections);
			}
		}

		static void visit (const CTreeCtrl& tree, ResultType& selections) {
			HTREEITEM root = tree.GetRootItem ();
			if (root) {
				visit (tree, root, selections);
			}
		}
	};
	Core::Aptr<ResultType> selected (new ResultType ());
	local::visit (tree, *selected);

	return selected.forget ();
	//#UC END# *4D34040E02EE_4574178302DE*
}


// формирует модель данных для отображения
template <class CollectionType>
void IppDerivedImpl::fill_data (
	const GCL::StrSet& all_tems
	, const CollectionType& selected_items
	, TreeNode*& root
	, bool use_gen_tree
) {
	//#UC START# *4C19C6C70221_4574178302DE*
	typedef typename CollectionType::const_iterator CollectionTypeIterator;
	typedef typename CollectionType::value_type CollectionTypeValueType;

	IRoseItemPtr item = this->get_rose_item();
	IRoseModelPtr model = item->Model;

	typedef std::map<std::string, std::pair<CollectionTypeValueType, IRoseElementPtr>> Items;
	RoseElementSet roots;
	Items methods;

	//разбиваем элементы на две группы: классы и операции
	ModelSearcher* searcher = &ModelSearcherFactory::get ();
	for (GCL::StrSet::const_iterator it = all_tems.begin(); it != all_tems.end(); ++it) {
		std::string guid (*it);
		if (!use_gen_tree) {
			item = searcher->search (guid);
		} else {
			const RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (guid);
			if (rad) {
				item = rad->rose_element ();
			}
		}
		
		if (item) {
			CollectionTypeValueType inherited_state = Core::TypeTraits<CollectionTypeValueType::value_type>::Factory::make (guid, true);

			CollectionTypeIterator selected_it = selected_items.find (inherited_state);

			if (selected_it != selected_items.end ()) {
				inherited_state = *selected_it;
			}

			methods[guid] = std::make_pair (
				inherited_state
				, item
			);

			IRoseItemPtr cls = RoseHelper::get_nearest_container (RoseHelper::get_context (item));

			if (cls) {
				roots.insert (RoseElementWrapper (cls));
			}
		}
	}

	root = 0;
	//сначала формируем первый уровень - это классы
	for (RoseElementSet::iterator it = roots.begin (); it != roots.end (); ++it) {
		if (root == 0) {			
			root = new TreeNode (it->element, 0);
		} else {
			root->insert_next (new TreeNode (it->element, 0));
		}
	}

	//теперь формируем второй уровень - уровень операций
	for (Items::iterator it = methods.begin (); it != methods.end (); ++it) {
		IRoseItemPtr cls = it->second.second->IsClass (CLASS_TYPE) 
			? RoseHelper::get_nearest_container (RoseHelper::get_context (it->second.second))
			: RoseHelper::get_nearest_container (it->second.second);

		std::string uid = get_rose_element_uid(cls);
		TreeNode_var parent = this->find_node (root, uid);
		//GDS_ASSERT(!parent.is_nil());
		if (!parent.is_nil()) {
			parent->insert_back_child (new TreeNode (it->second.second, it->second.first.in ()));
		}
	}
	//#UC END# *4C19C6C70221_4574178302DE*
}




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

