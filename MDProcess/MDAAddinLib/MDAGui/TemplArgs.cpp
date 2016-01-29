////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/TemplArgs.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::TemplArgs
//
// дилог для редактирования, добавления, удаления шаблонных аргументов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/TemplArgs.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"

//#UC START# *4574165F0222_CUSTOM_INCLUDES*
//#UC END# *4574165F0222_CUSTOM_INCLUDES*


//#UC START# *4574165F0222*
void TemplArgs::OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	NMLVDISPINFO *pDispInfo = reinterpret_cast<NMLVDISPINFO*>(pNMHDR);
	// TODO: Add your control notification handler code here

	m_args_list.SetItem (pDispInfo->item.iItem, pDispInfo->item.iSubItem, LVIF_TEXT, pDispInfo->item.pszText, 0, 0, 0, 0);
	*pResult = 0;
}

void TemplArgs::OnBnClickedOk() {
	MDPSupport::CatLockerFacade_var clf = 
		MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)m_cls);
	
	IRoseClassDiagramPtr diag = RoseHelper::get_self_diagram (m_cls);

	MDPSupport::CatLockerFacade_var diag_clf = 
		MDPSupport::CatLockerFacadeFactory::make (diag ? (IRoseElementPtr)diag : 0);
	
	if (clf->try_change () && diag_clf->try_change ()) {
		IRoseParameterCollectionPtr pars = m_cls->Parameters;
		while (pars->Count) {
			m_cls->DeleteParameter(pars->GetAt(1));
		}

		if (m_args_list.GetItemCount()) {
			RoseHelper::set_parameterized(m_cls, true);
			for (int i = m_args_list.GetItemCount(); i != 0; i--) {
				_bstr_t n = (const char*)m_args_list.GetItemText(i-1, 0);
				GCL::StrVector parts = GCL::split_string_by ((const char*)n, '=');
				std::string param_name = GCL::trim_ws (parts[0].data ());
				std::string param_init_value = parts.size() > 1 ?  GCL::trim_ws (parts[1].data ()) : "";
				m_cls->AddParameter (
					param_name.data()
					, ""
					, param_init_value.data ()
					, 0
				);
			}
		} else {
			RoseHelper::set_parameterized(m_cls, false);
		}
		clf->do_change ();
		diag_clf->do_change ();
	}
	// TODO: Add your control notification handler code here
	OnOK();
}

void TemplArgs::OnBnClickedButton2() {
	m_args_list.DeleteItem (m_args_list.GetSelectionMark ());
}

void TemplArgs::OnBnClickedButton4() //move up
{
	int i = m_args_list.GetSelectionMark ();
	if (i >= 1) {
		CString str_1 = m_args_list.GetItemText (i, 0);
		CString str_2 = m_args_list.GetItemText (i-1, 0);
		m_args_list.SetItemText (i, 0, str_2);
		m_args_list.SetItemText (i-1, 0, str_1);

		m_args_list.SetSelectionMark (i-1);
		m_args_list.SetItemState (i-1, LVIS_SELECTED, LVIS_SELECTED);
		m_args_list.EnsureVisible(i-1, false);
	}
}

void TemplArgs::OnBnClickedButton5() //down
{
	int i = m_args_list.GetSelectionMark ();
	if (i < m_args_list.GetItemCount() - 1) {
		CString str_1 = m_args_list.GetItemText (i, 0);
		CString str_2 = m_args_list.GetItemText (i+1, 0);
		m_args_list.SetItemText (i, 0, str_2);
		m_args_list.SetItemText (i+1, 0, str_1);

		m_args_list.SetSelectionMark (i+1);
		m_args_list.SetItemState (i+1, LVIS_SELECTED, LVIS_SELECTED);
		m_args_list.EnsureVisible(i+1, false);
	}
}

void TemplArgs::OnBnClickedButton1() {
	int item_count = m_args_list.GetItemCount();
	m_args_list.InsertItem (item_count, "T");

	m_args_list.SetSelectionMark (item_count);
	m_args_list.SetItemState (item_count, LVIS_SELECTED, LVIS_SELECTED);
	m_args_list.EnsureVisible(item_count, false);
}
//#UC END# *4574165F0222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TemplArgs::TemplArgs (IRoseClassPtr cls) : CDialog (TemplArgs::IDD)
//#UC START# *458E8D0B01ED_BASE_INIT*
	, m_cls (cls)
//#UC END# *458E8D0B01ED_BASE_INIT*
{
	//#UC START# *458E8D0B01ED_BODY*	
	//#UC END# *458E8D0B01ED_BODY*
}

TemplArgs::~TemplArgs () {
	//#UC START# *4574165F0222_DESTR_BODY*
	//#UC END# *4574165F0222_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(TemplArgs, CDialog)
	//#UC START# *4574165F0222_MESSAGE_MAP*
	ON_NOTIFY(LVN_ENDLABELEDIT, IDC_LIST1, OnLvnEndlabeleditList1)
	ON_BN_CLICKED(IDOK, OnBnClickedOk)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON4, OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, OnBnClickedButton5)
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	//#UC END# *4574165F0222_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(TemplArgs, CDialog)

void TemplArgs::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4574165F0222_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_LIST1, m_args_list);
	//#UC END# *4574165F0222_DO_DATA_EXCHANGE*
}

BOOL TemplArgs::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *4574165F0222_ON_INIT_DLG*
		m_args_list.InsertColumn (0, "Argument name", LVCFMT_LEFT, 200 );
		//m_args_list.InsertColumn (1, "Stereotype", LVCFMT_LEFT, 200 );

		IRoseParameterCollectionPtr pars = m_cls->Parameters;
		for (int i = 1; i < pars->Count + 1; i++) {
			IRoseParameterPtr par = pars->GetAt(i);
			
			std::string val = (const char*)par->Name;
			if (par->GetInitValue() != _bstr_t("")) {
				val += " = ";
				val += par->GetInitValue();
			}
			m_args_list.InsertItem (i, val.data());
		}

		if (m_args_list.GetItemCount() > 0) {
			m_args_list.SetSelectionMark (0);
			m_args_list.SetItemState (0, LVIS_SELECTED, LVIS_SELECTED);
			m_args_list.EnsureVisible(0, false);
		}
		//#UC END# *4574165F0222_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"TemplArgs\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

