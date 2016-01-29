////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/EnterStringDialog.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::EnterStringDialog
//
// диалог ввода текста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/EnterStringDialog.h"

//#UC START# *462D86BF02FD_CUSTOM_INCLUDES*
//#UC END# *462D86BF02FD_CUSTOM_INCLUDES*


//#UC START# *462D86BF02FD*
//#UC END# *462D86BF02FD*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EnterStringDialog::EnterStringDialog ()
	: CDialog (EnterStringDialog::IDD)
//#UC START# *462D86BF02FD_CTOR_BASE_INIT*
//#UC END# *462D86BF02FD_CTOR_BASE_INIT*
{
	//#UC START# *462D86BF02FD_CTOR*
	//#UC END# *462D86BF02FD_CTOR*
}


EnterStringDialog::~EnterStringDialog () {
	//#UC START# *462D86BF02FD_DESTR_BODY*
	//#UC END# *462D86BF02FD_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(EnterStringDialog, CDialog)
	//#UC START# *462D86BF02FD_MESSAGE_MAP*
	//#UC END# *462D86BF02FD_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(EnterStringDialog, CDialog)

void EnterStringDialog::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *462D86BF02FD_DO_DATA_EXCHANGE*
	CString str = m_entered_string.c_str ();	
	DDX_Text (pDX, IDC_EDIT_STRING, str);
	m_entered_string = static_cast<LPCTSTR>(str);
	//#UC END# *462D86BF02FD_DO_DATA_EXCHANGE*
}

BOOL EnterStringDialog::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *462D86BF02FD_ON_INIT_DLG*
		//GetDlgItem (IDC_EDIT_STRING)->SetWindowText (this->entered_string ().c_ctr ());
		//#UC END# *462D86BF02FD_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"EnterStringDialog\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& EnterStringDialog::get_entered_string () const {
	//#UC START# *462DC93D0186_GET_ACCESSOR*
	return m_entered_string;
	//#UC END# *462DC93D0186_GET_ACCESSOR*
}

void EnterStringDialog::set_entered_string (const std::string& entered_string) {
	//#UC START# *462DC93D0186_SET_ACCESSOR*
	m_entered_string = entered_string;
	//#UC END# *462DC93D0186_SET_ACCESSOR*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

