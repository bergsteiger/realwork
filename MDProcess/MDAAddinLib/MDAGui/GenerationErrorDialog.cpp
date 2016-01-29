////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::GenerationErrorDialog
//
// дилог со списком ошибок, возникших в процессе генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// инициализация диалога списком ошибок
GenerationErrorDialog::GenerationErrorDialog (
	const GenSupport::ErrorInfoList& errors
	, bool can_be_ignored
) :
	WinGUI::ETSLayoutDialog (GenerationErrorDialog::IDD)
	, m_can_be_ignored (false)
//#UC START# *4BE15AB902DD_BASE_INIT*
	, m_data (errors)
//#UC END# *4BE15AB902DD_BASE_INIT*
{
	//#UC START# *4BE15AB902DD_BODY*
	m_can_be_ignored = can_be_ignored;
	//#UC END# *4BE15AB902DD_BODY*
}

GenerationErrorDialog::~GenerationErrorDialog () {
	//#UC START# *4BE15A4F0223_DESTR_BODY*
	//#UC END# *4BE15A4F0223_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(GenerationErrorDialog, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *4BE15A4F0223_MESSAGE_MAP*
	//#UC END# *4BE15A4F0223_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(GenerationErrorDialog, CDialog)

void GenerationErrorDialog::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4BE15A4F0223_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_ERRORS_LIST, m_view);
	//#UC END# *4BE15A4F0223_DO_DATA_EXCHANGE*
}

BOOL GenerationErrorDialog::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *4BE15A4F0223_ON_INIT_DLG*
		this->SetIcon(::LoadIcon(NULL, IDI_ERROR), false);

		if (m_can_be_ignored) {
			this->GetDlgItem (IDCANCEL)->ShowWindow (SW_SHOW);
		} else {
			this->GetDlgItem (IDCANCEL)->ShowWindow (SW_HIDE);
		}

		m_view.init ();
		
		//Колонки списка: имя элемента, текст ошибки
		CRect rect;
		m_view.GetWindowRect (rect);
		m_view.InsertColumn (0, "Имя", LVCFMT_LEFT, static_cast<long>(rect.Width ()*0.25));
		m_view.InsertColumn (1, "Ошибка", LVCFMT_RIGHT, static_cast<long>(rect.Width ()*0.75));	

		for (GenSupport::ErrorInfoList::const_iterator it = m_data.begin (); it != m_data.end (); ++it) {
			this->add_error_impl (*it);
		}
		
		RoseItemList::SortParam param;
		param.primary_column_id = 1;
		param.secondary_column_id = 0;		
		m_view.sort (param);
		//#UC END# *4BE15A4F0223_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"GenerationErrorDialog\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int GenerationErrorDialog::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void GenerationErrorDialog::init_constraint () {
	//#UC START# *4BE15A4F0223_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
	<< item (IDC_ERRORS_LIST, GREEDY)
	<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< itemGrowing (HORIZONTAL)
			<< item(IDCANCEL, NORESIZE)
			<< item(IDOK, NORESIZE)
	);
	//#UC END# *4BE15A4F0223_CUSTOM_CONTROLS_CONSTRAINT*
}


// добавляет ошибку в список
void GenerationErrorDialog::add_error (const GenSupport::ErrorInfo& error) {
	//#UC START# *4BE15A8C017B*
	if (::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		this->add_error_impl (error);
	} else {
		m_data.push_back (error);
	}
	//#UC END# *4BE15A8C017B*
}

// метод для добавления информации в список, когда дилог уже инициализирован
void GenerationErrorDialog::add_error_impl (const GenSupport::ErrorInfo& info) {
	//#UC START# *4BE15EDB0373*
	GCL::StrVector view_info;
	
	const RoseAbstractDumper* rad = info.dumper ? dynamic_cast<const RoseAbstractDumper*> (info.dumper) : 0;
	
	view_info.push_back (rad ? rad->get_name_str () : info.alternative_name);
	view_info.push_back (info.message);
	
	m_view.add_item (rad ? rad->rose_element () : 0, view_info);
	//#UC END# *4BE15EDB0373*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

