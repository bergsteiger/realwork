////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppSystem.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppSystem
//
// страница редактирвоания системных свойств (путь к рутовой папке генерации, выбор шаблона)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppSystem.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"

//#UC START# *457417A3005D_CUSTOM_INCLUDES*
//#UC END# *457417A3005D_CUSTOM_INCLUDES*


//#UC START# *457417A3005D*
bool IppSystem::on_ok (bool& need_colorize) {
	IRoseItemPtr item = this->get_rose_item();
	if (m_is_incomlete.GetCheck ()) {
		RoseHelper::override_property(item, TOOL_NAME, PROP_INCOMPLETE, "true");
	} else {
		RoseHelper::override_property(item, TOOL_NAME, PROP_INCOMPLETE, "");
	}

	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);

	if (AbstractDumperBase::get_template (stereotype).main_st) {
		CString str;
		m_root_dir.GetWindowText (str);
		std::string root_dir = (const char*) str;
		GCL::str_replace (root_dir, "\\", "/");
		GCL::kill_final_char (root_dir, "/");
		RoseHelper::set_root_dir(item, root_dir.data());
	}

	need_colorize = false;
	if (m_chg_templ.IsWindowEnabled()) {
		CString str;
		m_templ_file.GetWindowText (str);

		bool by_parent;
		std::string cur_templ = RoseHelper::get_template_file(item, by_parent);
		std::string file_name = (const char*) str;
		std::string template_dir = MDAModelParams::get_templates_dir();
		std::string::size_type pos = file_name.find (template_dir);
		if (pos != std::string::npos) {
			file_name = file_name.substr (pos + template_dir.length ());
		} else {
//			pos = file_name.find_first_of ("\\");
//			if (pos != std::string::npos) {
//				file_name = file_name.substr (pos + 1);
//			}
		}

		if (cur_templ != file_name) {
			std::ifstream templ_file (RoseHelper::make_template_file (file_name).c_str (), std::ios::in);
			if (templ_file.is_open ()) {
				templ_file.close ();

				try {
					RoseHelper::set_template_file(item, file_name);
					RoseHelper::reset_template ();

					if (RoseHelper::load_template () == true) {
						MessageBox ("Template changed", "OK", MB_OK);
						need_colorize = true;
					} else {
						MessageBox ("Template was not changed", "ERROR", MB_OK);
					}
				} catch (Base::FatalError&) {
					GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
					dlg.DoModal ();
				}
			} else {
				MessageBox ("Can't open template file", "ERROR", MB_OK);
			}
		}
	}
	
	return true;
}

void IppSystem::OnChangeRootDir() {
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

void IppSystem::OnChangeTempl() {
	char szFilters[] = "MDA Template Files (*.tpl)|*.tpl|All Files (*.*)|*.*||";

	CFileDialog f_dlg (true, "tpl", "*.tpl", OFN_FILEMUSTEXIST| OFN_HIDEREADONLY, szFilters);

	if (f_dlg.DoModal() == IDOK) {
		std::string from_dlg = (const char*) f_dlg.GetPathName ();
		std::string template_dir = MDAModelParams::get_templates_dir();
		std::string::size_type pos = from_dlg.find (template_dir);
		if (pos != std::string::npos) {
			from_dlg = from_dlg.substr (pos + template_dir.length ());
		} else {
//			pos = from_dlg.find_first_of ("\\");
//			if (pos != std::string::npos) {
//				from_dlg = from_dlg.substr (pos + 1);
//			}
		}
		m_templ_file.SetWindowText(from_dlg.c_str ());
	}
}
//#UC END# *457417A3005D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppSystem::IppSystem ()
	: IppBase (IppSystem::IDD)
//#UC START# *457417A3005D_CTOR_BASE_INIT*
//#UC END# *457417A3005D_CTOR_BASE_INIT*
{
	//#UC START# *457417A3005D_CTOR*
	//#UC END# *457417A3005D_CTOR*
}


IppSystem::~IppSystem () {
	//#UC START# *457417A3005D_DESTR_BODY*
	//#UC END# *457417A3005D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppSystem, IppBase)
	ON_WM_CREATE()
	//#UC START# *457417A3005D_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_TEMPL_SELECT, OnChangeTempl)
	ON_BN_CLICKED(IDC_ROOT_DIR_SELECT, OnChangeRootDir)
	//#UC END# *457417A3005D_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppSystem, CPropertyPage)

void IppSystem::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *457417A3005D_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_ROOT_DIR, m_root_dir);
	DDX_Control(pDX, IDC_TEMPL, m_templ_file);
	DDX_Control(pDX, IDC_TEMPL_SELECT, m_chg_templ);
	DDX_Control(pDX, IDC_ROOT_DIR_SELECT, m_chg_root_dir);
	DDX_Control(pDX, IDC_IS_INCOMPLETE, m_is_incomlete);
	//#UC END# *457417A3005D_DO_DATA_EXCHANGE*
}

BOOL IppSystem::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *457417A3005D_ON_INIT_DLG*
		IRoseItemPtr item = this->get_rose_item ();

		AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);
		
		bool disable_generation = RoseHelper::is_incomplete (item);
		m_is_incomlete.SetCheck (disable_generation);

		if (AbstractDumperBase::get_template (stereotype).main_st) {
			std::string root_dir = RoseHelper::get_root_dir(item);
			root_dir += "/";
			m_root_dir.SetWindowText(root_dir.data());	
		} else {
			m_root_dir.SetWindowText("root dirs defined by model's Main-elements");
			m_root_dir.EnableWindow(false);
			m_chg_root_dir.EnableWindow(false);
		}		
		bool by_parent;
		std::string template_file = RoseHelper::get_template_file(item, by_parent);
		if (by_parent) {
			template_file = "(BY PARENT) " + template_file;
			// disable remove button
			m_chg_templ.EnableWindow (false);
			m_templ_file.EnableWindow (false);
		}
		m_templ_file.SetWindowText(template_file.data());
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
		//#UC END# *457417A3005D_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppSystem\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppSystem::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppSystem::init_constraint () {
	//#UC START# *457417A3005D_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL)			
		<< (pane (HORIZONTAL)
			<< (pane (VERTICAL, ABSOLUTE_HORZ)
				<< itemFixed (VERTICAL, 1)
				<< item ( IDC_STATIC1, NORESIZE)
				<< itemFixed (VERTICAL, 4)
				<< item ( IDC_STATIC2, NORESIZE)
			) << (pane (VERTICAL, GREEDY)
				<< item ( IDC_TEMPL, ABSOLUTE_VERT )			
				<< item ( IDC_ROOT_DIR, ABSOLUTE_VERT )
			) << (pane (VERTICAL, ABSOLUTE_HORZ)
				<< item ( IDC_TEMPL_SELECT, NORESIZE )			
				<< item ( IDC_ROOT_DIRSELECT, NORESIZE )
			)
		)
		<< item (IDC_IS_INCOMPLETE, ABSOLUTE_VERT)
		<< itemGrowing (VERTICAL);
	//#UC END# *457417A3005D_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

