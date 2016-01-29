////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/LockViews/MDSupportServerAuthorization.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::MDSupportServerAuthorization
//
// диалог для ввода логина и пароля для доступа на сервер залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LockViews/MDSupportServerAuthorization.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MDSupportServerAuthorization::MDSupportServerAuthorization ()
	: CDialog (MDSupportServerAuthorization::IDD)
//#UC START# *45E8174C0193_CTOR_BASE_INIT*
//#UC END# *45E8174C0193_CTOR_BASE_INIT*
{
	//#UC START# *45E8174C0193_CTOR*
	//#UC END# *45E8174C0193_CTOR*
}


MDSupportServerAuthorization::~MDSupportServerAuthorization () {
	//#UC START# *45E8174C0193_DESTR_BODY*
	//#UC END# *45E8174C0193_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(MDSupportServerAuthorization, CDialog)
	//#UC START# *45E8174C0193_MESSAGE_MAP*
	//#UC END# *45E8174C0193_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(MDSupportServerAuthorization, CDialog)

void MDSupportServerAuthorization::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *45E8174C0193_DO_DATA_EXCHANGE*
	CString str;
	DDX_Text(pDX, IDC_EDIT_LOGIN, str);
	m_result.login = static_cast<LPCTSTR>(str);
	DDX_Text(pDX, IDC_EDIT_PASS, str);
	m_result.pass = static_cast<LPCTSTR>(str);
	int i;
	DDX_Check(pDX, IDC_REMEMBER_ME, i);
	m_result.use_saved_auth = (i != 0);
	//#UC END# *45E8174C0193_DO_DATA_EXCHANGE*
}

BOOL MDSupportServerAuthorization::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *45E8174C0193_ON_INIT_DLG*
		this->ModifyStyleEx (0, WS_EX_APPWINDOW);
		CWnd* login = this->GetDlgItem (IDC_EDIT_LOGIN);
		if (login) {
			login->SetWindowText (m_init_login.c_str ());
		}

		CWnd* passwd = this->GetDlgItem (IDC_EDIT_PASS);
		if (passwd) {
			passwd->SetWindowText (m_init_password.c_str ());
		}		
		//#UC END# *45E8174C0193_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"MDSupportServerAuthorization\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}


// возвращает реультаты выполнения диалога
const MDSupportServerAuthorization::DialogData& MDSupportServerAuthorization::get_result () const {
	//#UC START# *461FB3D503C7*
	return m_result;
	//#UC END# *461FB3D503C7*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& MDSupportServerAuthorization::get_init_login () const {
	//#UC START# *4ADC061000F7_GET_ACCESSOR*
	return m_init_login;
	//#UC END# *4ADC061000F7_GET_ACCESSOR*
}

void MDSupportServerAuthorization::set_init_login (const std::string& init_login) {
	//#UC START# *4ADC061000F7_SET_ACCESSOR*
	m_init_login = init_login;
	//#UC END# *4ADC061000F7_SET_ACCESSOR*
}

const std::string& MDSupportServerAuthorization::get_init_password () const {
	//#UC START# *4ADC061E0032_GET_ACCESSOR*
	return m_init_password;
	//#UC END# *4ADC061E0032_GET_ACCESSOR*
}

void MDSupportServerAuthorization::set_init_password (const std::string& init_password) {
	//#UC START# *4ADC061E0032_SET_ACCESSOR*
	m_init_password = init_password;
	//#UC END# *4ADC061E0032_SET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

