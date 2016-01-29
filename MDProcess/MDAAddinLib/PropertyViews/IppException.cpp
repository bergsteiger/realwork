////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/IppException.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> MDProcess::MDAAddinLib::PropertyViews::IppException
//
// страница для снятия/установки эксепшнов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/IppException.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"

//#UC START# *457417610109_CUSTOM_INCLUDES*
//#UC END# *457417610109_CUSTOM_INCLUDES*


//#UC START# *457417610109*
void IppException::OnAddGet() 
{
	int nCount = m_all_get_ex.GetSelCount();
	CArray<int,int> aryListBoxSel;
	aryListBoxSel.SetSize(nCount);
	m_all_get_ex.GetSelItems(nCount, aryListBoxSel.GetData()); 

	for (int i=0; i<nCount; i++) {
		CString item;
		m_all_get_ex.GetText(aryListBoxSel[i]-i, item);
		m_all_get_ex.DeleteString(aryListBoxSel[i]-i);
		m_get_ex.AddString(item);
	}	
}

void IppException::OnAddSet() 
{
	int nCount = m_all_set_ex.GetSelCount();
	CArray<int,int> aryListBoxSel;
	aryListBoxSel.SetSize(nCount);
	m_all_set_ex.GetSelItems(nCount, aryListBoxSel.GetData()); 

	for (int i=0; i<nCount; i++) {
		CString item;
		m_all_set_ex.GetText(aryListBoxSel[i]-i, item);
		m_all_set_ex.DeleteString(aryListBoxSel[i]-i);
		m_set_ex.AddString(item);
	}	
}

void IppException::OnRemoveGet() 
{
	int nCount = m_get_ex.GetSelCount();
	CArray<int,int> aryListBoxSel;
	aryListBoxSel.SetSize(nCount);
	m_get_ex.GetSelItems(nCount, aryListBoxSel.GetData()); 

	for (int i=0; i<nCount; i++) {
		CString item;
		m_get_ex.GetText(aryListBoxSel[i]-i, item);
		m_get_ex.DeleteString(aryListBoxSel[i]-i);
		m_all_get_ex.AddString(item);
	}	
}

void IppException::OnRemoveSet() 
{
	int nCount = m_set_ex.GetSelCount();
	CArray<int,int> aryListBoxSel;
	aryListBoxSel.SetSize(nCount);
	m_set_ex.GetSelItems(nCount, aryListBoxSel.GetData()); 

	for (int i=0; i<nCount; i++) {
		CString item;
		m_set_ex.GetText(aryListBoxSel[i]-i, item);
		m_set_ex.DeleteString(aryListBoxSel[i]-i);
		m_all_set_ex.AddString(item);
	}	
}

bool IppException::on_ok (bool& need_colorize) {
	IRoseItemPtr item = this->get_rose_item();

	RoseHelper::RoseItemMap set_res;
	int i;
	for (i=0; i<m_set_ex.GetCount(); i++) {
		CString item;
		m_set_ex.GetText(i, item);
		
		RoseHelper::RoseItemMap::iterator it = m_set.find((LPCTSTR)item);
		if ( it != m_set.end() ) set_res.insert ((*it));
		else {
			it = m_all_set.find((LPCTSTR)item);
			if ( it != m_all_set.end() ) set_res.insert ((*it));
		}
	}
	m_set = set_res;

	RoseHelper::RoseItemMap get_res;
	for (i=0; i<m_get_ex.GetCount(); i++) {
		CString item;
		m_get_ex.GetText(i, item);
		
		RoseHelper::RoseItemMap::iterator it = m_get.find((LPCTSTR)item);
		if ( it != m_get.end() ) get_res.insert ((*it));
		else {
			it = m_all_get.find((LPCTSTR)item);
			if ( it != m_all_get.end() ) get_res.insert ((*it));
		}
	}
	m_get = get_res;

	RoseHelper::RoseItemMap::iterator it2;
	_bstr_t ex_str ("");
	for ( it2 = m_set.begin(); it2 != m_set.end(); it2++) {
		if (ex_str!= _bstr_t("")) ex_str += ",";
		ex_str += (*it2).second.data();
	}

	need_colorize = false;
	
	if (RoseHelper::override_property(item, TOOL_NAME, PROP_ATTR_SET_RAISES, ex_str)) {
		RoseTreeState::instance ()->set_changed (true);
	}

	ex_str = _bstr_t("");
	for ( it2 = m_get.begin(); it2 != m_get.end(); it2++) {
		if (ex_str!= _bstr_t("")) ex_str += ",";
		ex_str += (*it2).second.data();
	}
	if (RoseHelper::override_property(item, TOOL_NAME, PROP_ATTR_GET_RAISES, ex_str)) {
		RoseTreeState::instance ()->set_changed (true);
	}
	need_colorize = false;
		
	return true;
}
//#UC END# *457417610109*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IppException::IppException ()
	: IppBase (IppException::IDD)
//#UC START# *457417610109_CTOR_BASE_INIT*
//#UC END# *457417610109_CTOR_BASE_INIT*
{
	//#UC START# *457417610109_CTOR*
	//#UC END# *457417610109_CTOR*
}


IppException::~IppException () {
	//#UC START# *457417610109_DESTR_BODY*
	//#UC END# *457417610109_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(IppException, IppBase)
	ON_WM_CREATE()
	//#UC START# *457417610109_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_ADD_GET, OnAddGet)
	ON_BN_CLICKED(IDC_ADD_SET, OnAddSet)
	ON_BN_CLICKED(IDC_REMOVE_GET, OnRemoveGet)
	ON_BN_CLICKED(IDC_REMOVE_SET, OnRemoveSet)
	//#UC END# *457417610109_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(IppException, CPropertyPage)

void IppException::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *457417610109_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_SET_EX, m_set_ex);
	DDX_Control(pDX, IDC_GET_EX, m_get_ex);
	DDX_Control(pDX, IDC_ALL_SET_EX, m_all_set_ex);
	DDX_Control(pDX, IDC_ALL_GET_EX, m_all_get_ex);
	//#UC END# *457417610109_DO_DATA_EXCHANGE*
}

BOOL IppException::OnInitDialog () {
	BOOL ret = IppBase::OnInitDialog();
	try {
		//#UC START# *457417610109_ON_INIT_DLG*
		IRoseItemPtr item = this->get_rose_item();

		RoseHelper::RoseItemMap all_ex = RoseHelper::find_all_visible_ex (item, AbstractDumperBase::exception_stereotypes());

		GCL::StrVector set_e = GCL::split_string_by((char*) item->GetPropertyValue(TOOL_NAME, PROP_ATTR_SET_RAISES), ',');
		GCL::StrVector get_e = GCL::split_string_by((char*) item->GetPropertyValue(TOOL_NAME, PROP_ATTR_GET_RAISES), ',');

		RoseHelper::RoseItemMap::iterator it;
		for (it = all_ex.begin(); it != all_ex.end(); it++) {
			if ( std::find(set_e.begin(), set_e.end(), (*it).second) != set_e.end() ) 
				m_set.insert(*it);
			else 
				m_all_set.insert (*it);

			if ( std::find(get_e.begin(), get_e.end(), (*it).second) != get_e.end() ) 
				m_get.insert(*it);
			else 
				m_all_get.insert (*it);
		}

		for (it = m_all_set.begin(); it != m_all_set.end(); it++ ) {
			std::string str = (*it).first;	
			m_all_set_ex.AddString (str.data());
		}

		for (it = m_all_get.begin(); it != m_all_get.end(); it++ ) {
			std::string str = (*it).first;	
			m_all_get_ex.AddString (str.data());
		}

		for (it = m_set.begin(); it != m_set.end(); it++ ) {
			std::string str = (*it).first;	
			m_set_ex.AddString (str.data());
		}

		for (it = m_get.begin(); it != m_get.end(); it++ ) {
			std::string str = (*it).first;	
			m_get_ex.AddString (str.data());
		}

		AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (RoseHelper::get_gen_stereotype(item));

		bool is_set = tpl.has_set_except;

		this->GetDlgItem (IDC_ALL_SET_EX)->EnableWindow (is_set);
		this->GetDlgItem (IDC_SET_EX)->EnableWindow (is_set);
		this->GetDlgItem (IDC_ADD_SET)->EnableWindow (is_set);
		this->GetDlgItem (IDC_REMOVE_SET)->EnableWindow (is_set);
		this->GetDlgItem (IDC_SET_TITLE1)->EnableWindow (is_set);
		this->GetDlgItem (IDC_SET_TITLE2)->EnableWindow (is_set);

		bool is_get = tpl.has_get_except;

		this->GetDlgItem (IDC_ALL_GET_EX)->EnableWindow (is_get);
		this->GetDlgItem (IDC_GET_EX)->EnableWindow (is_get);
		this->GetDlgItem (IDC_ADD_GET)->EnableWindow (is_get);
		this->GetDlgItem (IDC_REMOVE_GET)->EnableWindow (is_get);
		this->GetDlgItem (IDC_GET_TITLE1)->EnableWindow (is_get);
		this->GetDlgItem (IDC_GET_TITLE2)->EnableWindow (is_get);

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
		//#UC END# *457417610109_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"IppException\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int IppException::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return IppBase::OnCreate (create_struct);
}

void IppException::init_constraint () {
	//#UC START# *457417610109_CUSTOM_CONTROLS_CONSTRAINT*
	CPane pane_get_all = pane (VERTICAL)
		<< item (IDC_GET_TITLE1, NORESIZE)
		<< item (IDC_ALL_GET_EX, GREEDY);

	CPane pane_set_all = pane (VERTICAL)
		<< item (IDC_SET_TITLE1, NORESIZE)
		<< item (IDC_ALL_SET_EX, GREEDY);
	
	CPane pane_get = pane (VERTICAL)
		<< item (IDC_GET_TITLE2, NORESIZE)
		<< item (IDC_GET_EX, GREEDY);

	CPane pane_set = pane (VERTICAL)
		<< item (IDC_SET_TITLE2, NORESIZE)
		<< item (IDC_SET_EX, GREEDY);
	
	CPane pane_btns_get = pane (VERTICAL, ABSOLUTE_HORZ)
		<< itemGrowing (VERTICAL)
		<< item (IDC_ADD_GET, NORESIZE)
		<< item (IDC_REMOVE_GET, NORESIZE)
		<< itemGrowing (VERTICAL);

	CPane pane_btns_set = pane (VERTICAL, ABSOLUTE_HORZ)
		<< itemGrowing (VERTICAL)
		<< item (IDC_ADD_SET, NORESIZE)
		<< item (IDC_REMOVE_SET, NORESIZE)
		<< itemGrowing (VERTICAL);
	
	CreateRoot (VERTICAL)
		<< (pane (HORIZONTAL)
			<< pane_get_all
			<< pane_btns_get
			<< pane_get
		) << (pane (HORIZONTAL)
			<< pane_set_all
			<< pane_btns_set
			<< pane_set
		);
	//#UC END# *457417610109_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

