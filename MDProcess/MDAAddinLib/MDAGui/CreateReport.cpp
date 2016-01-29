////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/CreateReport.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::CreateReport
//
// дилог для создания новго отчета, созданные отчет добавляется в общий список.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/CreateReport.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CreateReport::CreateReport ()
	: WinGUI::ETSLayoutDialog (CreateReport::IDD)
//#UC START# *46CA74630128_CTOR_BASE_INIT*
//#UC END# *46CA74630128_CTOR_BASE_INIT*
{
	//#UC START# *46CA74630128_CTOR*
	//#UC END# *46CA74630128_CTOR*
}


CreateReport::~CreateReport () {
	//#UC START# *46CA74630128_DESTR_BODY*
	//#UC END# *46CA74630128_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(CreateReport, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *46CA74630128_MESSAGE_MAP*
	ON_BN_CLICKED(IDOK, on_ok)
	//#UC END# *46CA74630128_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(CreateReport, CDialog)

void CreateReport::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *46CA74630128_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_EDIT_REPORT_QUERY, m_query);
	DDX_Control(pDX, IDC_EDIT_REPORT_NAME, m_name_edit);
	//#UC END# *46CA74630128_DO_DATA_EXCHANGE*
}

BOOL CreateReport::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *46CA74630128_ON_INIT_DLG*
		//#UC END# *46CA74630128_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"CreateReport\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int CreateReport::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void CreateReport::init_constraint () {
	//#UC START# *46CA74630128_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
		<< item (IDC_STATIC1, NORESIZE)
		<< item (IDC_EDIT_REPORT_NAME, ABSOLUTE_VERT)
		<< item (IDC_STATIC2, NORESIZE)
		<< item (IDC_EDIT_REPORT_QUERY, ABSOLUTE_VERT)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
				<< item( IDCANCEL, NORESIZE )
		);
	//#UC END# *46CA74630128_CUSTOM_CONTROLS_CONSTRAINT*
}


// обработчик нажатия кнопки OK
void CreateReport::on_ok () {
	//#UC START# *46CA751A00FA*
	CString str;
	m_name_edit.GetWindowText (str);
	m_report_name = (const char*)str;
	if (AbstractDumperBase::s_report_infos.find(m_report_name) != AbstractDumperBase::s_report_infos.end()) {
		std::string mess (m_report_name);
		mess += " report already exist";		
		if (MessageBox (mess.c_str (), "Exception while executing report", MB_OKCANCEL) != IDOK) {
			this->EndDialog (IDCANCEL);
		}
	} else {

		AbstractDumperBase::ReportsTreeItem* new_item = new AbstractDumperBase::ReportsTreeItem (m_report_name.data());
		if (AbstractDumperBase::s_reports_tree.is_nil()) {
			AbstractDumperBase::s_reports_tree = new_item;
		} else {
			AbstractDumperBase::s_reports_tree->insert_back_child (new_item);
		}
		m_query.GetWindowText (str);
		std::string q = "[{";
		q += GCL::trim_ws((const char*)str);
		q += "}true]";
		new_item->query (q);
		new_item->set_view ("Item name", "\\<\\<%SS\\>\\>%SN", 200);
		new_item->set_view ("Model path", "<{/}{}{r}%PN>", 400);
		AbstractDumperBase::s_report_infos[m_report_name] = new_item;
		this->EndDialog (IDOK);
	}	
	//#UC END# *46CA751A00FA*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& CreateReport::get_report_name () const {
	//#UC START# *46CA755F0203_GET_ACCESSOR*
	return m_report_name;
	//#UC END# *46CA755F0203_GET_ACCESSOR*
}

void CreateReport::set_report_name (const std::string& report_name) {
	//#UC START# *46CA755F0203_SET_ACCESSOR*
	m_report_name = report_name;
	//#UC END# *46CA755F0203_SET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

