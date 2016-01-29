////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/LockViews/ToClearLockedPacks.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::ToClearLockedPacks
//
// показывает список залоченых только юзером пакетов и предлагается их разлочить
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LockViews/ToClearLockedPacks.h"

//#UC START# *45F177A70186_CUSTOM_INCLUDES*
//#UC END# *45F177A70186_CUSTOM_INCLUDES*


//#UC START# *45F177A70186*
void set_selection (CTreeCtrl& tree, bool flag) {
	for (HTREEITEM cur = tree.GetRootItem (); 0 != cur; cur = tree.GetNextSiblingItem (cur)) {
		tree.SetCheck (cur, flag);
	}
}

afx_msg void ToClearLockedPacks::OnOK() {
	this->close_dlg ();
	CDialog::OnOK ();
}

afx_msg void ToClearLockedPacks::OnCancel () {
	//this->close_dlg ();
	CDialog::OnCancel ();
}

afx_msg void ToClearLockedPacks::OnDeselectAllCurrent () {
	CWnd* button = GetDlgItem (IDC_BUTTON_DESELECT_CURRENT);
	GDS_ASSERT (button);
	CString caption;
	button->GetWindowText (caption);
	if (caption.Compare ("Deselect All") == 0) {
		set_selection (m_model_packs, false);
		button->SetWindowText ("Select All");
	} else {		
		set_selection (m_model_packs, true);
		button->SetWindowText ("Deselect All");
	}
}

afx_msg void ToClearLockedPacks::OnDeselectAllOther () {
	CWnd* button = GetDlgItem (IDC_BUTTON_DESELECT_OTHER);
	GDS_ASSERT (button);
	CString caption;
	button->GetWindowText (caption);
	if (caption.Compare ("Deselect All") == 0) {
		set_selection (m_others_pack, false);
		button->SetWindowText ("Select All");
	} else {		
		set_selection (m_others_pack, true);
		button->SetWindowText ("Deselect All");
	}
}
//#UC END# *45F177A70186*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToClearLockedPacks::ToClearLockedPacks ()
	: WinGUI::ETSLayoutDialog (ToClearLockedPacks::IDD)
//#UC START# *45F177A70186_CTOR_BASE_INIT*
//#UC END# *45F177A70186_CTOR_BASE_INIT*
{
	//#UC START# *45F177A70186_CTOR*
	//#UC END# *45F177A70186_CTOR*
}


ToClearLockedPacks::~ToClearLockedPacks () {
	//#UC START# *45F177A70186_DESTR_BODY*
	//#UC END# *45F177A70186_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ToClearLockedPacks, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *45F177A70186_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_BUTTON_DESELECT_CURRENT, OnDeselectAllCurrent)
	ON_BN_CLICKED(IDC_BUTTON_DESELECT_OTHER, OnDeselectAllOther)
	//#UC END# *45F177A70186_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ToClearLockedPacks, CDialog)

void ToClearLockedPacks::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *45F177A70186_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_CURRENT_MODEL_TREE, m_model_packs);
	DDX_Control(pDX, IDC_OTHER_MODEL_TREE, m_others_pack);
	//#UC END# *45F177A70186_DO_DATA_EXCHANGE*
}

BOOL ToClearLockedPacks::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *45F177A70186_ON_INIT_DLG*
		class Local {
		public:
			static void select_all (CTreeCtrl& tree) {
				for (HTREEITEM cur = tree.GetRootItem (); 0 != cur; cur = tree.GetNextSiblingItem (cur)) {
					tree.SetCheck (cur, TRUE);					
				}
			}
		};
		m_model_packs.ModifyStyle (TVS_CHECKBOXES, 0);
		m_model_packs.ModifyStyle (0, TVS_CHECKBOXES);

		m_others_pack.ModifyStyle (TVS_CHECKBOXES, 0);
		m_others_pack.ModifyStyle (0, TVS_CHECKBOXES);
		
		GCL::StrSet::const_iterator it = m_locked_model_packs.begin ();
		GCL::StrSet::const_iterator it_end = m_locked_model_packs.end ();

		for (; it != it_end; ++it) {
			HTREEITEM cur = m_model_packs.InsertItem (it->c_str ());
			m_model_packs.SetCheck (cur);
		}
		
		it = m_locked_other_packs.begin ();
		it_end = m_locked_other_packs.end ();
		
		for (; it != it_end; ++it) {
			HTREEITEM cur = m_others_pack.InsertItem (it->c_str ());
			m_others_pack.SetCheck (cur,FALSE);			
		}

		if (m_model_packs.GetCount () <= 0) {
			CWnd* button = GetDlgItem (IDC_BUTTON_DESELECT_CURRENT);
			GDS_ASSERT (button);
			button->EnableWindow (FALSE);
			m_model_packs.EnableWindow (FALSE);
		}

		if (m_others_pack.GetCount () <= 0) {
			CWnd* button = GetDlgItem (IDC_BUTTON_DESELECT_OTHER);
			GDS_ASSERT (button);
			button->EnableWindow (FALSE);
			m_others_pack.EnableWindow (FALSE);
		}
		//#UC END# *45F177A70186_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ToClearLockedPacks\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ToClearLockedPacks::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void ToClearLockedPacks::init_constraint () {
	//#UC START# *45F177A70186_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
		<< (pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< item (IDC_STATIC1, NORESIZE)
				<< itemGrowing (HORIZONTAL)
				<< item( IDC_BUTTON_DESELECT_CURRENT, NORESIZE )
		)		
		<< item (IDC_CURRENT_MODEL_TREE, GREEDY)		
		<< (pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< item (IDC_STATIC2, NORESIZE)
				<< itemGrowing (HORIZONTAL)
				<< item( IDC_BUTTON_DESELECT_OTHER, NORESIZE )
		)
		<< item (IDC_OTHER_MODEL_TREE, GREEDY)
		<< (pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
		);
	//#UC END# *45F177A70186_CUSTOM_CONTROLS_CONSTRAINT*
}


// добавить имя пакета текщей модели
void ToClearLockedPacks::add_model_pack_full_name (const std::string& name) {
	//#UC START# *45F54763005D*
	m_locked_model_packs.insert (name);
	//#UC END# *45F54763005D*
}

// доавбить имя залоченного пакета с других моделей
void ToClearLockedPacks::add_other_pack_full_name (const std::string& name) {
	//#UC START# *483BD755006C*
	m_locked_other_packs.insert (name);
	//#UC END# *483BD755006C*
}

// вызывается при закрытии дилога, в этом методе заполняется списки пакетов подлежащих разлочке
void ToClearLockedPacks::close_dlg () {
	//#UC START# *483BD44C0168*
	class Local {
	public:
		static void collect_checked (const CTreeCtrl& tree, GCL::StrSet& out)  {
			for (HTREEITEM cur = tree.GetRootItem (); 0 != cur; cur = tree.GetNextSiblingItem (cur)) {
				if (TRUE == tree.GetCheck (cur)) {
					CString i = tree.GetItemText (cur);
					out.insert (std::string (static_cast<const char*> (i)));
				}
			}
		}
	};
	m_model_packs_to_unlock.clear ();
	m_other_model_packs.clear ();

	Local::collect_checked (m_model_packs, m_model_packs_to_unlock);
	Local::collect_checked (m_others_pack, m_other_model_packs);
	//#UC END# *483BD44C0168*
}

// показать диалог
void ToClearLockedPacks::show_all () {
	//#UC START# *45F5476E037A*
	if (
		m_locked_model_packs.empty () == false 
		|| m_locked_other_packs.empty () == false
	) {
		this->DoModal ();
	}
	//#UC END# *45F5476E037A*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const GCL::StrSet& ToClearLockedPacks::get_model_packs_to_unlock () const {
	//#UC START# *483BD3A30233_GET_ACCESSOR*
	return m_model_packs_to_unlock;
	//#UC END# *483BD3A30233_GET_ACCESSOR*
}

const GCL::StrSet& ToClearLockedPacks::get_other_model_packs () const {
	//#UC START# *483BD4170388_GET_ACCESSOR*
	return m_other_model_packs;
	//#UC END# *483BD4170388_GET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

