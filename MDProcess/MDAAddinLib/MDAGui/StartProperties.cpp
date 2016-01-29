////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/StartProperties.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::StartProperties
//
// диалог создания новго проекта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/StartProperties.h"

//#UC START# *457416030271_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "GeneratorSelect.h"
//#UC END# *457416030271_CUSTOM_INCLUDES*


//#UC START# *457416030271*
void StartProperties::OnBnClickedOk()
{
	CString name;
	m_proj_name.GetWindowText (name);

	CString dir;
	m_root_dir.GetWindowText (dir);

	RoseHelper::TreeItems selected_item;
	RoseHelper::TreeItems selected_leaf;
	RoseHelper::collect_all_checked (m_gen_tree, selected_item, selected_leaf);

	if (name.GetLength() && dir.GetLength() && selected_item.size()) {
		m_result.main_name = (const char*)name;
		m_result.root_dir = (const char*)dir;
		GCL::str_replace (m_result.root_dir, "\\", "/");
		GCL::kill_final_char (m_result.root_dir, "/");
	
		for (RoseHelper::TreeItems::iterator it = selected_item.begin(); it != selected_item.end(); it++) {
			AbstractDumperBase::GenTreeItem* item = (AbstractDumperBase::GenTreeItem*)m_gen_tree.GetItemData (*it);
			m_result.selected_gens.insert(item->name());
		}

		OnOK();
	}
}

void StartProperties::OnBnClickedButton2()
{
	BROWSEINFO bi;    // Browse information
	char szPath[MAX_PATH]; // Variable for holding path information

	bi.hwndOwner = NULL;
	bi.pidlRoot = NULL;
	bi.lpszTitle = "Каталог для генерации выходных файлов";
	bi.ulFlags = BIF_RETURNONLYFSDIRS | 0x0040;	// A little hack to get 'New Folder' button under W2K
	bi.lpfn = NULL;
	bi.lParam = 0;
	bi.pszDisplayName = szPath;
	LPITEMIDLIST pidlBrowse;
	pidlBrowse = SHBrowseForFolder( &bi);
	if( pidlBrowse ) {
		SHGetPathFromIDList( pidlBrowse, szPath);	
		m_root_dir.SetWindowText(szPath);
	}
}
//#UC END# *457416030271*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StartProperties::StartProperties ()
	: CDialog (StartProperties::IDD)
//#UC START# *457416030271_CTOR_BASE_INIT*
//#UC END# *457416030271_CTOR_BASE_INIT*
{
	//#UC START# *457416030271_CTOR*
	//#UC END# *457416030271_CTOR*
}


StartProperties::~StartProperties () {
	//#UC START# *457416030271_DESTR_BODY*
	//#UC END# *457416030271_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(StartProperties, CDialog)
	//#UC START# *457416030271_MESSAGE_MAP*
	ON_BN_CLICKED(IDOK, OnBnClickedOk)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
	//#UC END# *457416030271_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(StartProperties, CDialog)

void StartProperties::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *457416030271_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_EDIT2, m_root_dir);
	DDX_Control(pDX, IDC_TREE1, m_gen_tree);
	DDX_Control(pDX, IDC_EDIT3, m_proj_name);
	//#UC END# *457416030271_DO_DATA_EXCHANGE*
}

BOOL StartProperties::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *457416030271_ON_INIT_DLG*
		m_proj_name.SetWindowText ("NewProject");
		m_root_dir.SetWindowText ("w:");
		m_gen_tree.ModifyStyle( TVS_CHECKBOXES, 0 );
		m_gen_tree.ModifyStyle( 0, TVS_CHECKBOXES );

		RoseHelper::Selections selections;
		RoseHelper::fill_node (selections, m_gen_tree, 0, RoseAbstractDumper::s_gen_tree.in());
		m_gen_tree.Expand(m_gen_tree.GetRootItem (), TVE_EXPAND);
		//#UC END# *457416030271_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"StartProperties\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

