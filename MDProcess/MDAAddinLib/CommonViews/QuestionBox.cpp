////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/QuestionBox.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::QuestionBox
//
// диалог - вопрос с возможностью сохранения выбранного значения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/QuestionBox.h"

//#UC START# *45FE6247002E_CUSTOM_INCLUDES*
#include <boost/functional/hash/hash.hpp>
#include <boost/lexical_cast.hpp>
//#UC END# *45FE6247002E_CUSTOM_INCLUDES*


//#UC START# *45FE6247002E*
void QuestionBox::on_no () {
	this->EndDialog (IDNO);
}
//#UC END# *45FE6247002E*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// показывает окно с вопросом, возвращает IDOK или IDCANCEL
// \question - текст вопроса
// \caption - заголовок окна
int QuestionBox::show (const char* question, const char* caption) {
	//#UC START# *45FE627E0177*	
	std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";
	std::string REGISTRY_OPTION_NAME = question;	
	

	std::string answer = Core::RegistryHelper::get_option_value (
		Core::RegistryHelper::KEY_CURRENT_USER
		, REGISTRY_KEY_PATH
		, REGISTRY_OPTION_NAME
		, ""
	);
	int res;
	if (answer.empty ()) {
		QuestionBox box (question, caption);
		res = box.DoModal ();
		if (res != IDCANCEL) {
			std::string new_answer;
			if (box.need_save ()) {
				if (res = IDOK) {
					new_answer = "Yes";
				} else {
					new_answer = "No";
				}
				Core::RegistryHelper::set_option_value (
					Core::RegistryHelper::KEY_CURRENT_USER
					, REGISTRY_KEY_PATH
					, REGISTRY_OPTION_NAME
					, new_answer
					, true
				);
			}
		}
	} else if (answer == "Yes") {
		res = IDOK;
	} else if (answer == "No") {
		res = IDNO;
	}
	return res;
	//#UC END# *45FE627E0177*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QuestionBox::QuestionBox (const char* question, const char* caption) : CDialog (QuestionBox::IDD)
//#UC START# *45FE625D0138_BASE_INIT*
, m_caption (caption), m_question (question)
//#UC END# *45FE625D0138_BASE_INIT*
{
	//#UC START# *45FE625D0138_BODY*
	//#UC END# *45FE625D0138_BODY*
}

QuestionBox::~QuestionBox () {
	//#UC START# *45FE6247002E_DESTR_BODY*
	//#UC END# *45FE6247002E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(QuestionBox, CDialog)
	//#UC START# *45FE6247002E_MESSAGE_MAP*
	ON_BN_CLICKED (IDNO, on_no)
	//#UC END# *45FE6247002E_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(QuestionBox, CDialog)

void QuestionBox::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *45FE6247002E_DO_DATA_EXCHANGE*
	DDX_Check (pDX, IDC_SAVE, m_need_save);
	//#UC END# *45FE6247002E_DO_DATA_EXCHANGE*
}

BOOL QuestionBox::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *45FE6247002E_ON_INIT_DLG*
		CWnd* text = GetDlgItem (IDC_STATIC);
		text->SetWindowText (m_question.data());
		this->SetWindowText (m_caption.data());
		//#UC END# *45FE6247002E_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"QuestionBox\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}


// возвращает true, если ответ нужно сохранить
bool QuestionBox::need_save () const {
	//#UC START# *45FE62A5035B*
	return m_need_save;
	//#UC END# *45FE62A5035B*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

