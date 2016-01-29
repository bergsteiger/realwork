////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppUses.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppUses
//
// страница показывает список элементов, которые используют данный
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppUses.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"

//#UC START# *45741774008C_CUSTOM_INCLUDES*
//#UC END# *45741774008C_CUSTOM_INCLUDES*


//#UC START# *45741774008C*
bool IppUses::on_ok(bool& need_colorize) {
	return true;
}

BOOL IppUses::OnSetActive() {
	if (!m_initialized) {
		m_used_in_list.InsertColumn (0, "Client Full Name", LVCFMT_CENTER, 400 );
		m_used_in_list.InsertColumn (1, "Used as", LVCFMT_LEFT, 120 );

		IRoseItemPtr item = this->get_rose_item();			
		try {
			RoseHelper::reset_template ();
			RoseHelper::load_template ();
			
			RoseHelper::check_model_for_changes ();
			RoseAbstractDumper::get_model_tree_root();			
		} catch (Base::FatalError&) {
			/*GenSupport::LogManagerFactory::get ().log_error("Loading model tree finished by Fatal error:");
			GenSupport::LogManagerFactory::get ().log_error(ex.what ());
			RoseAbstractDumper::has_error (true);
			MessageBox ("Fatal errors while loading model tree - see log for detail", "Fatal Error", MB_OK|MB_ICONEXCLAMATION );*/

			GenSupport::ErrorManagerFactory::get ().error (0, "Ошибка при построении дерева генерации", "Uses");
			GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
			dlg.DoModal ();
		} catch (...) {
			/*RoseAbstractDumper::has_error (true);
			MessageBox ("Unknown exception while loading model tree", "Fatal Error", MB_OK|MB_ICONEXCLAMATION );*/

			GenSupport::ErrorManagerFactory::get ().error (0, "Неизвестная ошибка при построении дерева генерации", "Uses");
			GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
			dlg.DoModal ();
		}

		const RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (item);
		//элемента может не быть в дереве если он только создаётся...
		if (rad) {
			m_consumers = rad->get_consumer_infos();
			unsigned i = 0;
			for (ObjectTreeResolver::Consumer_set::iterator it = m_consumers.begin(); it != m_consumers.end(); it++) {
				m_used_in_list.InsertItem (i, it->consumer->get_full_name().data() );
				m_used_in_list.SetItemText (i++, 1, it->link_stereotype.data() );
			}
		}
		m_initialized = true;
	}
	
	return CPropertyPage::OnSetActive();
} 

void IppUses::OnLvnColumnclickList1(NMHDR *pNMHDR, LRESULT *pResult) {
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: Add your control notification handler code here
	*pResult = 0;
}


void IppUses::OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult) {
	*pResult = 0;

	int selection = m_used_in_list.GetSelectionMark();
	ObjectTreeResolver::Consumer_set::iterator it = m_consumers.begin();
	while (it != m_consumers.end() && selection) {
		it++;
		selection--;
	}
	
	if (it != m_consumers.end()) {
		const ObjectTreeResolver* otr_it = it->consumer;
		const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*>(otr_it);
		if (rad) {
			IRoseItemPtr item_to_select = RoseHelper::get_nearest_container (rad->rose_element());
			IRoseDiagramPtr diag = RoseHelper::get_self_diagram (rad->rose_element());

			if (diag != 0) {
				IRoseItemViewPtr iview = diag->GetViewFrom(item_to_select);
				diag->Activate();
				iview->SetSelected(true);
				diag->CenterDiagramToView(iview);
			} else {
				MessageBox("No diagrams availbale");
			}
		}		
	}
}
//#UC END# *45741774008C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppUses::IppUses ()
	: IppBase (IppUses::IDD)
//#UC START# *45741774008C_CTOR_BASE_INIT*
//#UC END# *45741774008C_CTOR_BASE_INIT*
{
	//#UC START# *45741774008C_CTOR*
	m_initialized = false;
	//#UC END# *45741774008C_CTOR*
}


IppUses::~IppUses () {
	//#UC START# *45741774008C_DESTR_BODY*
	//#UC END# *45741774008C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppUses, IppBase)
	ON_WM_CREATE()
	//#UC START# *45741774008C_MESSAGE_MAP*
	ON_NOTIFY(LVN_COLUMNCLICK, IDC_LIST1, OnLvnColumnclickList1)
	ON_NOTIFY(NM_DBLCLK, IDC_LIST1, OnNMDblclkList1)
	//#UC END# *45741774008C_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppUses, CPropertyPage)

void IppUses::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *45741774008C_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_LIST1, m_used_in_list);
	//#UC END# *45741774008C_DO_DATA_EXCHANGE*
}

BOOL IppUses::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *45741774008C_ON_INIT_DLG*
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
		//#UC END# *45741774008C_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppUses\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppUses::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppUses::init_constraint () {
	//#UC START# *45741774008C_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL)
		<< item ( IDC_STATIC, NORESIZE )	
		<< item ( IDC_LIST1, GREEDY );
	//#UC END# *45741774008C_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

