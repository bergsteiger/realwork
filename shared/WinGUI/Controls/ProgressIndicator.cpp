////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Controls/ProgressIndicator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> shared::WinGUI::Controls::ProgressIndicator
//
// Прогресс индикатор. Выполнен в виде НЕ модального диалога, при закрытии "убивает сам себя",
// поэтому объект его создающий не должен заботится об удалении!!!
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Controls/ProgressIndicator.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

//#UC START# *4AD426A003AF_CUSTOM_INCLUDES*
//#UC END# *4AD426A003AF_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *4AD426A003AF*
/*void ProgressIndicator::PostNcDestroy () {
	CDialog::PostNcDestroy();
	if(!m_was_canceled && m_delegate) {
		try {
			if (m_delegate) {
				m_delegate->progress_indicator_closed (*this);
			}
			delete this;
		} catch (...) {
			delete this;
			throw;
		}
	}
}*/
//#UC END# *4AD426A003AF*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// сообщения
const unsigned long ProgressIndicator::WM_UPDATE_LABEL_TEXT = WM_USER + 1000; // сообщение об обновлении текста лэйбла
const unsigned long ProgressIndicator::WM_PROGRESS_STEPIT = WM_USER + 1001; // сообщение о шаге

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
ProgressIndicator::ProgressIndicator (
	ProgressIndicatorDelegate* delegate
) :
	CDialog (ProgressIndicator::IDD)
	, m_was_canceled (false)
//#UC START# *4AD426BE03A6_BASE_INIT*
	, m_delegate (delegate)
	, m_is_showed (false)
//#UC END# *4AD426BE03A6_BASE_INIT*
{
	//#UC START# *4AD426BE03A6_BODY*
	//#UC END# *4AD426BE03A6_BODY*
}

ProgressIndicator::~ProgressIndicator () {
	//#UC START# *4AD426A003AF_DESTR_BODY*	
	//#UC END# *4AD426A003AF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ProgressIndicator, CDialog)
	//#UC START# *4AD426A003AF_MESSAGE_MAP*
	ON_BN_CLICKED(IDCANCEL, on_cancel)
	ON_BN_CLICKED(IDOK, on_ok)
	ON_MESSAGE(WM_UPDATE_LABEL_TEXT, update_label_impl)
	ON_MESSAGE(WM_PROGRESS_STEPIT, step_impl)
	//#UC END# *4AD426A003AF_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ProgressIndicator, CDialog)

void ProgressIndicator::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4AD426A003AF_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_PROGRESS_INDICATOR, m_progress);
	//#UC END# *4AD426A003AF_DO_DATA_EXCHANGE*
}

BOOL ProgressIndicator::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *4AD426A003AF_ON_INIT_DLG*
		GUARD(m_mutex);
		if (m_delegate) {
			m_progress.SetRange32 (0, m_delegate->get_progress_size ());
			m_progress.SetStep (m_delegate->get_step_size ());
			this->SetWindowText ("Progress: 0%");
		}
		//#UC END# *4AD426A003AF_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ProgressIndicator\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}


// закрыть диалог
void ProgressIndicator::close () {
	//#UC START# *4AD6CFC00148*
	GUARD(m_mutex);
	if(!m_was_canceled && m_delegate) {
		try {
			if (m_delegate) {
				m_delegate->progress_indicator_closed (*this);
			}
			if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
				this->PostMessage (WM_COMMAND, MAKEWPARAM (IDOK, 0), 0);
			}
		} catch (...) {
			if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
				this->PostMessage (WM_COMMAND, MAKEWPARAM (IDOK, 0), 0);
			}
			throw;
		}
	}
	//#UC END# *4AD6CFC00148*
}

// обрабочтик нажатия кнопки "Cancel"
void ProgressIndicator::on_cancel () {
	//#UC START# *4AD5DED5035E*
	GUARD(m_mutex);
		
	try {
		if (m_delegate) {
			m_delegate->progress_indicator_canceled (*this);
		}
	} catch (...) {
		CDialog::OnCancel ();
		m_was_canceled = true;
		m_is_showed = false;

		throw;
	}
	
	CDialog::OnCancel ();
	m_was_canceled = true;
	m_is_showed = false;
	//#UC END# *4AD5DED5035E*
}

// закрывает диалог
void ProgressIndicator::on_ok () {
	//#UC START# *4AD702720358*
	GUARD(m_mutex);
	CDialog::OnOK ();
	//#UC END# *4AD702720358*
}

// показать диалог
void ProgressIndicator::show_ () {
	//#UC START# *4AD6F7840166*
	bool need_show = false;
	{
		GUARD(m_mutex);
		if (m_is_showed == false) {
			need_show = true;
			m_is_showed = true;
		}
	}
	if (need_show) {
		try {
			this->DoModal ();
			{
				GUARD(m_mutex);
				m_is_showed = false;
			}
			delete this;
		} catch (...) {
			{
				GUARD(m_mutex);
				m_is_showed = false;
			}
			delete this;
			throw;
		}		
	}
	//#UC END# *4AD6F7840166*
}

// шаг прогресса
void ProgressIndicator::step () {
	//#UC START# *4AD427C5028C*
	GUARD(m_mutex);
	if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		this->PostMessage (WM_PROGRESS_STEPIT, 0, 0);
	}
	//#UC END# *4AD427C5028C*
}

// инициирует шаг, передает сообщение описывающее шаг
void ProgressIndicator::step (const std::string& message) {
	//#UC START# *4AD427E002AC*
	GUARD(m_mutex);
	if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		this->update_label_text (message);
		this->PostMessage (WM_PROGRESS_STEPIT, 0, 0);
	}
	//#UC END# *4AD427E002AC*
}

// реализация шага прогресс индикатора, если прогресс достиг конца - диалог с индикатор
// закрывается, перед этим посылается сообщение progress_indicator_finished ()
LRESULT ProgressIndicator::step_impl (WPARAM w_param, LPARAM l_param) {
	//#UC START# *4AD6C2080148*
	GUARD(m_mutex);
	if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		m_progress.StepIt ();
		unsigned int pos = static_cast<unsigned int> (m_progress.GetPos ());
		int lower = 0;
		int upper = 0;
		m_progress.GetRange (lower, upper);
		if (pos >= static_cast<unsigned int> (upper)) {
			m_progress.SetPos (upper);
			
			if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
				this->PostMessage (WM_COMMAND, MAKEWPARAM (IDOK, 0), 0);
			}

			if (m_delegate) {
				m_delegate->progress_indicator_finished (*this);
			}
		} else {
			std::string text ("Progress: ");
			text += boost::lexical_cast<std::string> (unsigned int (ceil(float(pos*100)/float(upper))));
			text += "%";
			this->SetWindowText (text.c_str ());
		}
	}

	return S_OK;
	//#UC END# *4AD6C2080148*
}

// обработчик сообщения WM_UPDATE_LABEL_TEXT
LRESULT ProgressIndicator::update_label_impl (WPARAM w_param, LPARAM l_param) {
	//#UC START# *4AD6DAE3001C*
	char* str = (char*)l_param;
	std::string text (str);
	delete [] str;

	GUARD(m_mutex);
	CWnd* label = this->GetDlgItem (IDC_PROGRESS_LABEL);
	if (label) {
		label->SetWindowText (text.c_str ());
	}

	return S_OK;
	//#UC END# *4AD6DAE3001C*
}

// обновляет текст в IDC_PROGRESS_LABEL на text
void ProgressIndicator::update_label_text (const std::string& text) {
	//#UC START# *4AD5E0F70198*
	GUARD(m_mutex);
	if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		char* msg = new char[text.size () + 1];
		strcpy (msg, text.c_str ());
		this->PostMessage (WM_UPDATE_LABEL_TEXT, 0, (LPARAM)msg);
	}
	//#UC END# *4AD5E0F70198*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const ProgressIndicatorDelegate* ProgressIndicator::get_delegate () const {
	//#UC START# *4AD43CD20389_GET_ACCESSOR*
	GUARD(m_mutex);
	return m_delegate;
	//#UC END# *4AD43CD20389_GET_ACCESSOR*
}

void ProgressIndicator::set_delegate (ProgressIndicatorDelegate* delegate) {
	//#UC START# *4AD43CD20389_SET_ACCESSOR*
	GUARD(m_mutex);
	m_delegate = delegate;
	//#UC END# *4AD43CD20389_SET_ACCESSOR*
}

//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct ShowParams_ {
	ProgressIndicator* self;
	ShowParams_ (ProgressIndicator* self_) : self(self_) {
	}
};

void ProgressIndicator::thr_show_ (void* arg) {
	try {
		Core::Aptr<ShowParams_> arg_ (reinterpret_cast<ShowParams_*>(arg));
		arg_->self->show_ ();
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute ProgressIndicator::show oneway function"));
	} catch (...) {
		LOG_UEX (("while execute ProgressIndicator::show oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle ProgressIndicator::show () {
	Core::Aptr<ShowParams_> arg = new ShowParams_ (this);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (ProgressIndicator::thr_show_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}


} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

