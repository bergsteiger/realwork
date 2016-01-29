////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppNative.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppNative
//
// страница для редакртирования native путей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppNative.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/GCL/data/StaticNode.h"

//#UC START# *457417BB0232_CUSTOM_INCLUDES*
//#UC END# *457417BB0232_CUSTOM_INCLUDES*


//#UC START# *457417BB0232*
struct InsertInDlg {	
	IppNative* dlg;
	
	WinGUI::COptionTreeItem* m_root;		
	
	InsertInDlg (IppNative* _dlg) : dlg(_dlg) {		
		m_root = dlg->m_native_paths.InsertItem(new WinGUI::COptionTreeItem());
		m_root->SetLabelText(_T("Native paths"));
	}

	~InsertInDlg () {		
	}
	
	void each_func (const GCL::StaticNode* item, IRoseItem* r_item) {		
		if (!item->has_children()) {
			const AbstractDumperBase::GenTreeItem* gen_item = dynamic_cast<const AbstractDumperBase::GenTreeItem*>(item);
			std::string gen_id = gen_item->name();
			std::string description = gen_item->description();
			std::string prop_name = "NATIVE_PATH";
			prop_name += gen_id;

			std::string prop_native_path = r_item->GetPropertyValue (TOOL_NAME, prop_name.data());

			WinGUI::COptionTreeItemEdit* edit = (WinGUI::COptionTreeItemEdit*)dlg->m_native_paths.InsertItem(
				new WinGUI::COptionTreeItemEdit(), m_root
			);
			edit->SetLabelText(gen_id.c_str ());
			edit->SetInfoText(description.c_str ());
			
			if (edit->CreateEditItem (NULL, 0) == TRUE) {
				edit->SetWindowText (prop_native_path.data ());
			}
			dlg->m_properties_list.push_back (IppNative::Property (edit, gen_id));
		}
	}
};

bool IppNative::on_ok (bool& need_colorize) {
	need_colorize = false;
	IRoseItemPtr item = this->get_rose_item();
	
	for (Properties::iterator it = m_properties_list.begin(); it != m_properties_list.end(); it++) {
		std::string prop_name = "NATIVE_PATH";
		prop_name += it->gen_id;
		
		CString cstr;
		it->item->GetWindowText(cstr);
		std::string native_path = GCL::trim_ws (static_cast<const char*> (cstr));
		need_colorize |= RoseHelper::override_property (item, TOOL_NAME, prop_name.data(), native_path.c_str ());
	}
	return true;
}

//#UC END# *457417BB0232*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppNative::IppNative ()
	: IppBase (IppNative::IDD)
//#UC START# *457417BB0232_CTOR_BASE_INIT*
//#UC END# *457417BB0232_CTOR_BASE_INIT*
{
	//#UC START# *457417BB0232_CTOR*
	//#UC END# *457417BB0232_CTOR*
}


IppNative::~IppNative () {
	//#UC START# *457417BB0232_DESTR_BODY*
	//#UC END# *457417BB0232_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppNative, IppBase)
	ON_WM_CREATE()
	//#UC START# *457417BB0232_MESSAGE_MAP*
	ON_WM_SIZE()
	//#UC END# *457417BB0232_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppNative, CPropertyPage)

void IppNative::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *457417BB0232_DO_DATA_EXCHANGE*	
	//#UC END# *457417BB0232_DO_DATA_EXCHANGE*
}

BOOL IppNative::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *457417BB0232_ON_INIT_DLG*
		IRoseItemPtr item = this->get_rose_item();

		Core::Var<AbstractDumperBase::GenTreeItem> gen_tree_copy = AbstractDumperBase::GenTreeItem::clone_tree (
			RoseAbstractDumper::s_gen_tree.in()
			, RoseAbstractDumper::s_gen_tree.in()
			, RoseHelper::ParentSelectFilter (item)
		);
		/// ======= Tree Creation =======
		///
		// Get the clients rectangle
		CRect rcClient;
		GetClientRect(rcClient);
		rcClient.top += 46;
		rcClient.bottom -= 23;
		
		// Setup the window style
		DWORD dwStyle, dwOptions;
		dwStyle = WS_VISIBLE;
		
		// Setup the tree options 
		// OT_OPTIONS_SHOWINFOWINDOW
		dwOptions = OT_OPTIONS_SHADEEXPANDCOLUMN | OT_OPTIONS_SHADEROOTITEMS | OT_OPTIONS_SHOWINFOWINDOW;
		
		// Create tree options
		if (m_native_paths.Create (dwStyle, rcClient, this, dwOptions, IDC_STATIC) == FALSE) {
			TRACE0("Failed to create options control.\r\n");
			return FALSE;
		}
		m_native_paths.DeleteAllItems ();
		m_properties_list.clear ();
		// Want to be notified
		//m_native_paths.SetNotify(TRUE, this,WM_BT_CLICKED,false);
		m_native_paths.SetAutoSizeColumn(false);
		m_native_paths.SetAttributeOffset(4);
		m_native_paths.LockAll();
		gen_tree_copy->for_each (InsertInDlg(this), item);
		m_native_paths.UnLockAll();
		m_native_paths.ExpandAllItems();
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
		//#UC END# *457417BB0232_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppNative\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppNative::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppNative::init_constraint () {
	//#UC START# *457417BB0232_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL) << item (&m_native_paths, GREEDY);
	//#UC END# *457417BB0232_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

