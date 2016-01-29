////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/GeneratorSelect.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GeneratorSelect
//
// диалог выбора генераторов позволяет выбрать какие генераторы учавствуют в генерации модели, а
// также позволяет настроить некоторые параметры генерации: "отключить/включить авто-инкремент",
// "отключить/включить запуск спец. комманд после генерации" и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/GeneratorSelect.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"

//#UC START# *4574166E02FD_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "shared/GCL/str/str_op.h"
//#UC END# *4574166E02FD_CUSTOM_INCLUDES*


//#UC START# *4574166E02FD*
bool GeneratorSelect::make_choice (IRoseItemPtr root) {
	m_root = root;
	return this->DoModal() == IDOK;
}

struct ParentSelectFilterX {
	ParentSelectFilterX (IRoseItemPtr item): m_item (item) {
	}
	
	bool is_meet (const AbstractDumperBase::GenTreeItem* node) const {
		IRoseElementPtr context = m_item;

		while (context) {
			std::string merged_sels = context->GetPropertyValue(TOOL_NAME, PROP_APPLGEN);

			context = RoseHelper::get_context (context);

			RoseHelper::Selections selections = GCL::split_string_by_sub_string_uniq (merged_sels.data(), "|");

			if (selections.size()) {
				bool good = false;

				Core::Var<const AbstractDumperBase::GenTreeItem> parent = AbstractDumperBase::GenTreeItem::_duplicate(node);

				if (this->check_parent_down (parent.in(), selections)) {
					good = true;
				} else {
					while (!parent.is_nil()) {
						if (selections.find (parent->name()) != selections.end()) {
							good = true;
							break;
						}

						parent = dynamic_cast<const AbstractDumperBase::GenTreeItem*>(parent->parent());
					}
				}

				if (!good) {
					return false;
				}
			}
		}

		return true;
	}

	void each_func (const GCL::StaticNode* item, RoseHelper::Selections& all_child_gens) const {
		all_child_gens.insert(dynamic_cast<const AbstractDumperBase::GenTreeItem*>(item)->name());
	}

	bool check_parent_down (const AbstractDumperBase::GenTreeItem* root_gen, const RoseHelper::Selections& selections) const {
		RoseHelper::Selections all_child_gens;
		root_gen->for_each (*this, all_child_gens);
		
		if (std::find_first_of(all_child_gens.begin(), all_child_gens.end(), selections.begin(), selections.end()) != all_child_gens.end()) {
			return true;
		} else {
			return false;
		}
	}

	IRoseItemPtr m_item;
};

void GeneratorSelect::update_template () {
	RoseHelper::reset_template ();
	if (RoseHelper::load_template ()) {
		m_gen_tree.DeleteAllItems();

		m_gen_tree_copy = AbstractDumperBase::GenTreeItem::clone_tree (
			RoseAbstractDumper::s_gen_tree.in()
			, RoseAbstractDumper::s_gen_tree.in()
			, ParentSelectFilterX (m_root)
		);
		m_selections.erase (AbstractDumperBase::SPELL_GENERATOR_ID);
		RoseHelper::fill_node (m_selections, m_gen_tree, 0, m_gen_tree_copy.in());
	
	} else {
		MessageBox ("Can't load template", "ERROR", MB_OK|MB_ICONEXCLAMATION);
	}
}

/////////////////////////////////////////////////////////////////////////////
// GeneratorSelect message handlers

void GeneratorSelect::OnOK() {
	
	RoseHelper::TreeItems selected_item;
	RoseHelper::TreeItems selected_leaf;
	RoseHelper::collect_all_checked (m_gen_tree, selected_item, selected_leaf);

	RoseAbstractDumper::clean_active_map ();
	GCL::StrSet selections;
	
	for (RoseHelper::TreeItems::iterator it = selected_item.begin(); it != selected_item.end(); it++) {
		AbstractDumperBase::GenTreeItem* item = (AbstractDumperBase::GenTreeItem*)m_gen_tree.GetItemData (*it);
		selections.insert(item->name());
	}

	// save selection into registry	
	std::string registry_option_name = "-LastSelection";
	registry_option_name += m_root->GetModel()->GetName();
	registry_option_name += get_rose_element_uid(m_root);
	std::string merged_sels = GCL::join (selections, "|");
	Core::ParamManagerFactory::get ().set_string (registry_option_name.c_str (), merged_sels.c_str ());
	/*std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";
	std::string	REGISTRY_OPTION_NAME = "LastSelection";	
	REGISTRY_OPTION_NAME += m_root->GetModel()->GetName();
	REGISTRY_OPTION_NAME += m_root->GetUniqueID();

	Core::RegistryHelper::set_option_value (
		Core::RegistryHelper::KEY_LOCAL_MACHINE
		, REGISTRY_KEY_PATH
		, REGISTRY_OPTION_NAME
		, merged_sels
	);*/

	for (RoseHelper::TreeItems::iterator it = selected_leaf.begin(); it != selected_leaf.end(); it++) {
		AbstractDumperBase::GenTreeItem* item = (AbstractDumperBase::GenTreeItem*)m_gen_tree.GetItemData (*it);
		RoseAbstractDumper::add_active_map (item->name());
	}
	
	GenSupport::EnvironmentFactory::get ().set_suppress_user_code ((m_suppress_uc.GetCheck() == 1));
	GenSupport::EnvironmentFactory::get ().set_rewrite_user_code ((m_rewrite_uc.GetCheck() == 1));
	GenSupport::EnvironmentFactory::get ().set_disable_auto_count ((m_dis_auto_count.GetCheck() == 1));
	GenSupport::EnvironmentFactory::get ().set_disable_post_processing ((m_disable_post_processing.GetCheck() == 1));
	
	if (m_lock_allways.GetCheck() == 1) {
		GenSupport::EnvironmentFactory::get ().set_lock_strategy (GenSupport::LS_LOCK_ALL);
	} else if (m_ask_lock.GetCheck() == 1) {
		GenSupport::EnvironmentFactory::get ().set_lock_strategy (GenSupport::LS_ASK);
	} else if (m_no_lock.GetCheck() == 1) {
		GenSupport::EnvironmentFactory::get ().set_lock_strategy (GenSupport::LS_NO_LOCK);
	}
	
	GenerationParams::set_lock_strategy(GenSupport::EnvironmentFactory::get ().get_lock_strategy ());
	CDialog::OnOK();
}
//#UC END# *4574166E02FD*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GeneratorSelect::GeneratorSelect ()
	: WinGUI::ETSLayoutDialog (GeneratorSelect::IDD)
//#UC START# *4574166E02FD_CTOR_BASE_INIT*
//#UC END# *4574166E02FD_CTOR_BASE_INIT*
{
	//#UC START# *4574166E02FD_CTOR*
	//#UC END# *4574166E02FD_CTOR*
}


GeneratorSelect::~GeneratorSelect () {
	//#UC START# *4574166E02FD_DESTR_BODY*
	//#UC END# *4574166E02FD_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(GeneratorSelect, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *4574166E02FD_MESSAGE_MAP*
	//#UC END# *4574166E02FD_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(GeneratorSelect, CDialog)

void GeneratorSelect::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4574166E02FD_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_DIS_POST_PROCESSING, m_disable_post_processing);
	DDX_Control(pDX, IDC_DIS_AUTO_COUNTER, m_dis_auto_count);
	DDX_Control(pDX, IDC_REWRITE_UC, m_rewrite_uc);
	DDX_Control(pDX, IDC_SUPPRES_UC, m_suppress_uc);

	DDX_Control(pDX, IDC_NO_LOCK, m_no_lock);
	DDX_Control(pDX, IDC_LOCK_ALLWAYS, m_lock_allways);
	DDX_Control(pDX, IDC_ASK, m_ask_lock);
	
	DDX_Control(pDX, IDC_TREE1, m_gen_tree);
	//#UC END# *4574166E02FD_DO_DATA_EXCHANGE*
}

BOOL GeneratorSelect::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *4574166E02FD_ON_INIT_DLG*
		this->SetWindowText (std::string ("Generation from " + std::string((const char*)m_root->Name)).data());
		
		m_gen_tree.ModifyStyle( TVS_CHECKBOXES, 0 );
		m_gen_tree.ModifyStyle( 0, TVS_CHECKBOXES );
		
		std::string registry_option_name = "-LastSelection";
		registry_option_name += m_root->GetModel()->GetName();
		registry_option_name += get_rose_element_uid(m_root);

		/*std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";		

		std::string merged_sels = Core::RegistryHelper::get_option_value (
			Core::RegistryHelper::KEY_LOCAL_MACHINE
			, REGISTRY_KEY_PATH
			, REGISTRY_OPTION_NAME
			, ""
		);*/
		std::string merged_sels = Core::ParamManagerFactory::get ().get_string (registry_option_name.c_str (), "");
		m_selections = GCL::split_string_by_sub_string_uniq (merged_sels.data(), "|");
		
		try {
			this->update_template();
		} catch (Base::FatalError&) {
			GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
			dlg.DoModal ();

			this->EndDialog (IDCANCEL);
		}
			
		if (GenSupport::EnvironmentFactory::get ().get_suppress_user_code ()) {
			m_suppress_uc.SetCheck(1);
		}

		if (GenSupport::EnvironmentFactory::get ().get_rewrite_user_code ()) {
			m_rewrite_uc.SetCheck(1);
		}

		if (GenSupport::EnvironmentFactory::get ().get_disable_auto_count ()) {
			m_dis_auto_count.SetCheck(1);
		}

		if (GenSupport::EnvironmentFactory::get ().get_disable_post_processing ()) {
			m_disable_post_processing.SetCheck(1);
		}
		
		m_lock_allways.SetCheck (0);
		m_ask_lock.SetCheck (0);
		m_no_lock.SetCheck (0);
		
		GenSupport::EnvironmentFactory::get ().set_lock_strategy (
			static_cast<GenSupport::LockStrategy> (
				GenerationParams::get_lock_strategy()
			)
		);

		switch (GenSupport::EnvironmentFactory::get ().get_lock_strategy ()) {
			case GenSupport::LS_LOCK_ALL:
				m_lock_allways.SetCheck (1);
				break;
			case GenSupport::LS_ASK:
				m_ask_lock.SetCheck (1);
				break;
			case GenSupport::LS_NO_LOCK:
				m_no_lock.SetCheck (1);
				break;


		}
		//#UC END# *4574166E02FD_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"GeneratorSelect\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int GeneratorSelect::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void GeneratorSelect::init_constraint () {
	//#UC START# *4574166E02FD_CUSTOM_CONTROLS_CONSTRAINT*
	CPane radioPane = pane( VERTICAL )
		<< item( IDC_LOCK_ALLWAYS, NORESIZE)
		<< item( IDC_ASK, NORESIZE)
		<< item( IDC_NO_LOCK, NORESIZE);

	// note the usage of sizeExtraBorder and sizeTopExtra
	CPane groupPane = paneCtrl (
		IDC_STRATEGY_GROUP, HORIZONTAL, ALIGN_FILL_HORZ, WinGUI::nDefaultBorder, 10, 10
	)	<< radioPane
		<< itemGrowing(HORIZONTAL);

	CPane checkPane = 
		pane( HORIZONTAL )
			<< (pane(VERTICAL )
				<< item(IDC_SUPPRES_UC, NORESIZE)
				<< item( IDC_REWRITE_UC, NORESIZE)
				<< item( IDC_DIS_AUTO_COUNTER, NORESIZE)
				<< item( IDC_DIS_POST_PROCESSING, NORESIZE)
			)
			//<< itemGrowing(HORIZONTAL)
			<< groupPane;

	CreateRoot(VERTICAL)
		<< item ( IDC_STATIC, NORESIZE )
		<< item ( IDC_TREE1, GREEDY )
		<< itemFixed (VERTICAL, 2)
		<< checkPane
		<< itemFixed (VERTICAL, 2)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
				<< item( IDCANCEL, NORESIZE )
		);	
	//#UC END# *4574166E02FD_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

