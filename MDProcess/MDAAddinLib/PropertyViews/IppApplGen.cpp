////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppApplGen.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppApplGen
//
// страница для выбора разрешенных генераторв для элемента, т.е тех генераторв, которыми можно
// генерить данный элемент
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppApplGen.h"

//#UC START# *4574179402BF_CUSTOM_INCLUDES*
//#UC END# *4574179402BF_CUSTOM_INCLUDES*


//#UC START# *4574179402BF*
bool IppApplGen::on_ok (bool& need_colorize) {
	IRoseItemPtr item = this->get_rose_item();

	RoseHelper::TreeItems selected_item;
	RoseHelper::TreeItems selected_leaf;
	RoseHelper::collect_all_checked (m_gen_tree, selected_item, selected_leaf);

	GCL::StrSet selections;
	
	for (RoseHelper::TreeItems::iterator it = selected_item.begin(); it != selected_item.end(); it++) {
		AbstractDumperBase::GenTreeItem* item = (AbstractDumperBase::GenTreeItem*)m_gen_tree.GetItemData (*it);
		selections.insert(item->name());
	}

	// save selection into registry	
	std::string merged_sels = GCL::join (selections, "|");
	
	//_bstr_t proj_prop_key = PROP_APPLGEN;
	//proj_prop_key += (const char*)item->GetUniqueID();

	if (merged_sels == "") {
		merged_sels = "none";
	}

	//if (m_global_rb.GetCheck()) {
	if (RoseHelper::override_property (item, TOOL_NAME, PROP_APPLGEN, merged_sels.data())) {
		//изменился список разрешённых генераторов - нужно сбросить кэш
		AbstractDumperBase::reset_accepted_gens ();
	}
	//	RoseHelper::override_property(RoseHelper::get_main_model_element(), TOOL_NAME, proj_prop_key, "");
	//} else {		
	//	RoseHelper::override_property(RoseHelper::get_main_model_element(), TOOL_NAME, proj_prop_key, merged_sels.data());
	//}

	need_colorize = false;
	return true;
}

void IppApplGen::load_gen_tree (bool use_global) {
	m_gen_tree.DeleteAllItems ();

	IRoseItemPtr item = this->get_rose_item();
	std::string merged_sels;

	//if (!use_global) {
	//	_bstr_t prop_key = PROP_APPLGEN;
	//	prop_key += item->GetUniqueID();
	//	merged_sels = RoseHelper::get_main_model_element()->GetPropertyValue(TOOL_NAME, prop_key);
	//} else {
		merged_sels = item->GetPropertyValue(TOOL_NAME, PROP_APPLGEN);
	//}

	m_selections = GCL::split_string_by_sub_string_uniq (merged_sels.data(), "|");

    m_gen_tree_copy = AbstractDumperBase::GenTreeItem::clone_tree (
		RoseAbstractDumper::s_gen_tree.in()
		, RoseAbstractDumper::s_gen_tree.in()
		, RoseHelper::ParentSelectFilter (item)
	);
	
	RoseHelper::fill_node (m_selections, m_gen_tree, 0, m_gen_tree_copy.in());
}

void IppApplGen::OnBnClickedGlobalRb()
{
	//assert (m_global_rb.GetCheck());
	//this->load_gen_tree (true);
}

void IppApplGen::OnBnClickedProjectRb()
{
	//assert (m_project_rb.GetCheck());
	//this->load_gen_tree (false);
}
//#UC END# *4574179402BF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppApplGen::IppApplGen ()
	: IppBase (IppApplGen::IDD)
//#UC START# *4574179402BF_CTOR_BASE_INIT*
//#UC END# *4574179402BF_CTOR_BASE_INIT*
{
	//#UC START# *4574179402BF_CTOR*
	//#UC END# *4574179402BF_CTOR*
}


IppApplGen::~IppApplGen () {
	//#UC START# *4574179402BF_DESTR_BODY*
	//#UC END# *4574179402BF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppApplGen, IppBase)
	ON_WM_CREATE()
	//#UC START# *4574179402BF_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_GLOBAL_RB, OnBnClickedGlobalRb)
	ON_BN_CLICKED(IDC_PROJECT_RB, OnBnClickedProjectRb)
	//#UC END# *4574179402BF_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppApplGen, CPropertyPage)

void IppApplGen::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *4574179402BF_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_TREE1, m_gen_tree);
	//DDX_Control(pDX, IDC_GLOBAL_RB, m_global_rb);
	//DDX_Control(pDX, IDC_PROJECT_RB, m_project_rb);
	//#UC END# *4574179402BF_DO_DATA_EXCHANGE*
}

BOOL IppApplGen::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *4574179402BF_ON_INIT_DLG*
		m_gen_tree.ModifyStyle( TVS_CHECKBOXES, 0 );
		m_gen_tree.ModifyStyle( 0, TVS_CHECKBOXES );

		IRoseItemPtr item = this->get_rose_item();

		//_bstr_t prop_key = PROP_APPLGEN;
		//prop_key += item->GetUniqueID();
		//std::string merged_sels = RoseHelper::get_main_model_element()->GetPropertyValue(TOOL_NAME, prop_key);
		
		//RoseHelper::ParentSelectFilter psf (item);
		//bool hppf = psf.has_parent_project_filters();
		

		//if (merged_sels == "" && !hppf) {
			this->load_gen_tree (true);
		//	m_global_rb.SetCheck(true);
		//} else {
		//	this->load_gen_tree (false);
		//	m_project_rb.SetCheck(true);
		//	if (hppf) {
		//		m_global_rb.EnableWindow (false);
		//	}
		//}
		this->check_for_editable ();
		/*CPropertySheet* pSheet = (CPropertySheet*) this->GetParent();
		if(pSheet) {
			CRect rcWnd;
			pSheet->GetTabControl()->GetWindowRect(&rcWnd);
			pSheet->ScreenToClient(&rcWnd);
			if(!pSheet->IsWizard()) {// get inside of tab
				pSheet->GetTabControl()->AdjustRect(FALSE, &rcWnd);
			} else {
				rcWnd.bottom += 5;
			}
			this->MoveWindow (&rcWnd);
		}*/
		//#UC END# *4574179402BF_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppApplGen\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppApplGen::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppApplGen::init_constraint () {
	//#UC START# *4574179402BF_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
		<< item (IDC_STATIC, NORESIZE)
		<< item (IDC_TREE1, GREEDY);
	//#UC END# *4574179402BF_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

