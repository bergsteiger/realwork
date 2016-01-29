////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/ChoiceType.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::ChoiceType
//
// дилог для выбора типа в слчае его неоднозначности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/ChoiceType.h"

//#UC START# *457415BB033C_CUSTOM_INCLUDES*
//#UC END# *457415BB033C_CUSTOM_INCLUDES*


//#UC START# *457415BB033C*
void ChoiceType::OnDblclkList1() 
{
	// TODO: Add your control notification handler code here
	OnOK();
	
}

void ChoiceType::OnOK() 
{
	// TODO: Add extra validation here	
	CDialog::OnOK();
}

void ChoiceType::OnBnClickedCancel()
{
	CDialog::OnCancel();
	// TODO: Add your control notification handler code here
}
//#UC END# *457415BB033C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ChoiceType::ChoiceType ()
	: WinGUI::ETSLayoutDialog (ChoiceType::IDD)
//#UC START# *457415BB033C_CTOR_BASE_INIT*
//#UC END# *457415BB033C_CTOR_BASE_INIT*
{
	//#UC START# *457415BB033C_CTOR*
	m_list_value = _T("");
	//#UC END# *457415BB033C_CTOR*
}


ChoiceType::~ChoiceType () {
	//#UC START# *457415BB033C_DESTR_BODY*
	//#UC END# *457415BB033C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ChoiceType, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *457415BB033C_MESSAGE_MAP*
	ON_LBN_DBLCLK(IDC_LIST1, OnDblclkList1)
	ON_BN_CLICKED(IDCANCEL, OnBnClickedCancel)
	//#UC END# *457415BB033C_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ChoiceType, CDialog)

void ChoiceType::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *457415BB033C_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_FOR_ITEM_NAME, m_for_item_name);
	DDX_Control(pDX, IDC_LIST1, m_list);
	DDX_LBString(pDX, IDC_LIST1, m_list_value);
	//#UC END# *457415BB033C_DO_DATA_EXCHANGE*
}

BOOL ChoiceType::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *457415BB033C_ON_INIT_DLG*
		m_for_item_name.SetWindowText(m_for_item_name_str.c_str());

		for (GCL::StrSet::iterator it = m_data.begin(); it != m_data.end(); it++ ) {
			m_list.AddString ((*it).data());
		};
		//#UC END# *457415BB033C_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ChoiceType\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ChoiceType::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void ChoiceType::init_constraint () {
	//#UC START# *457415BB033C_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL)
		<< item (IDC_STATIC1, NORESIZE)
		<< item (IDC_FOR_ITEM_NAME, ABSOLUTE_VERT)
		<< item (IDC_STATIC2, NORESIZE)
		<< item (IDC_LIST1, GREEDY)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
				<< item( IDCANCEL, NORESIZE )
		);
	//#UC END# *457415BB033C_CUSTOM_CONTROLS_CONSTRAINT*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from RoseAbstractDumper::IChoiceDlg
// выполнить выбор конкретного элемента
const std::string ChoiceType::make_choice (const GCL::StrSet& ch_list, const std::string& for_item_name) {
	//#UC START# *457587CF00C7_457415BB033C*
	m_data = ch_list;
	m_for_item_name_str = for_item_name;
	if (this->DoModal() == IDOK) {
		return std::string(LPCTSTR(m_list_value));
	} else {
		return "";
	}
	//#UC END# *457587CF00C7_457415BB033C*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

