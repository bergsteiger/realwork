////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/ChoiceDialog.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::ChoiceDialog
//
// диалог выбора - представляет собой диалог со списком различных вариантов список задаётся извне
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/ChoiceDialog.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор, selections - доступные варианты выбора
ChoiceDialog::ChoiceDialog (
	const std::string& caption
	, const GCL::StrSet& selections
) :
	WinGUI::ETSLayoutDialog (ChoiceDialog::IDD)
//#UC START# *46FA6F080203_BASE_INIT*
, m_selections (selections), m_caption (caption)
//#UC END# *46FA6F080203_BASE_INIT*
{
	//#UC START# *46FA6F080203_BODY*
	//#UC END# *46FA6F080203_BODY*
}

ChoiceDialog::~ChoiceDialog () {
	//#UC START# *46FA6E2B030D_DESTR_BODY*
	//#UC END# *46FA6E2B030D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ChoiceDialog, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *46FA6E2B030D_MESSAGE_MAP*
	ON_LBN_DBLCLK(IDC_SELECTION_LIST, on_dbl_click)
	//#UC END# *46FA6E2B030D_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ChoiceDialog, CDialog)

void ChoiceDialog::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *46FA6E2B030D_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_SELECTION_LIST, m_list);
	DDX_LBString(pDX, IDC_SELECTION_LIST, m_value);
	//#UC END# *46FA6E2B030D_DO_DATA_EXCHANGE*
}

BOOL ChoiceDialog::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *46FA6E2B030D_ON_INIT_DLG*
		this->SetWindowText(m_caption.c_str());

		for (
			GCL::StrSet::iterator it = m_selections.begin()
			; it != m_selections.end()
			; ++it 
		) {
			m_list.AddString ((*it).c_str ());
		};
		//#UC END# *46FA6E2B030D_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ChoiceDialog\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ChoiceDialog::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void ChoiceDialog::init_constraint () {
	//#UC START# *46FA6E2B030D_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL)
		<< item (IDC_STATIC, NORESIZE)
		<< item (IDC_SELECTION_LIST, GREEDY)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
				<< item( IDCANCEL, NORESIZE )
		);
	//#UC END# *46FA6E2B030D_CUSTOM_CONTROLS_CONSTRAINT*
}


// возвращает выбор, сделанный пользователем
const std::string ChoiceDialog::get_selection () const {
	//#UC START# *46FA6F40005D*
	return std::string (static_cast<const char*> (m_value));
	//#UC END# *46FA6F40005D*
}

// реакция на дабл-клик в списке
void ChoiceDialog::on_dbl_click () {
	//#UC START# *46FB396A034B*
	OnOK ();
	//#UC END# *46FB396A034B*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

