////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ProgessIndicatorServiceImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl.h"

namespace GenSupportImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ProgessIndicatorServiceImpl::ProgessIndicatorServiceImpl ()
//#UC START# *4AD42138004F_4AD4215B01EB_4AD423B900A4_BASE_INIT*
: m_step_size (1), m_progress_size (100), m_indicator (0)
//#UC END# *4AD42138004F_4AD4215B01EB_4AD423B900A4_BASE_INIT*
{
	//#UC START# *4AD42138004F_4AD4215B01EB_4AD423B900A4_BODY*
	//#UC END# *4AD42138004F_4AD4215B01EB_4AD423B900A4_BODY*
}

ProgessIndicatorServiceImpl::~ProgessIndicatorServiceImpl () {
	//#UC START# *4AD423B900A4_DESTR_BODY*
	if (this->is_started ()) {
		this->end ();
	}
	//#UC END# *4AD423B900A4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GenSupport::ProgessIndicatorService
// событие завершения генерации
void ProgessIndicatorServiceImpl::end () /*throw (GenSupport::GenerationNotStarted)*/ {
	//#UC START# *4AD421B1018A_4AD423B900A4*
	GUARD (m_mutex);
	if (m_indicator) {
		m_indicator->close ();
		m_indicator = 0;
	} else {
		//throw GenSupport::GenerationNotStarted ();
	}
	//#UC END# *4AD421B1018A_4AD423B900A4*
}

// implemented method from GenSupport::ProgessIndicatorService
// возвращает true, если прогресс запущен, но еще не закончен
bool ProgessIndicatorServiceImpl::is_started () const {
	//#UC START# *4AD6C3CB01CB_4AD423B900A4*
	GUARD (m_mutex);
	return m_indicator != 0;
	//#UC END# *4AD6C3CB01CB_4AD423B900A4*
}

// implemented method from GenSupport::ProgessIndicatorService
// начало генерации - показывает прогресс индикатор
void ProgessIndicatorServiceImpl::start () /*throw (GenSupport::GenerationAlreadyStarted)*/ {
	//#UC START# *4AD4217703D6_4AD423B900A4*
	GUARD (m_mutex);
	if (m_indicator) {
		//throw GenSupport::GenerationAlreadyStarted ();
	} else {
		m_indicator = new WinGUI::ProgressIndicator (this);
		m_indicator->show ();		
	}
	//#UC END# *4AD4217703D6_4AD423B900A4*
}

// implemented method from GenSupport::ProgessIndicatorService
// выполняет шаг прогресса. Если не был вызыван start, то вызывает его
void ProgessIndicatorServiceImpl::step () {
	//#UC START# *4AD422FC037F_4AD423B900A4*
	GUARD (m_mutex);
	if (m_indicator) {
		m_indicator->step ();
	} else {
		//throw GenSupport::GenerationNotStarted ();
	}
	//#UC END# *4AD422FC037F_4AD423B900A4*
}

// implemented method from GenSupport::ProgessIndicatorService
// инициирует шаг, передает сообщение описывающее шаг. Если не был вызыван start, то вызывает его
void ProgessIndicatorServiceImpl::step (const std::string& message) {
	//#UC START# *4AD4232C0061_4AD423B900A4*
	GUARD (m_mutex);
	if (m_indicator) {
		m_indicator->step (message);
	} else {
		//throw GenSupport::GenerationNotStarted ();
	}	
	//#UC END# *4AD4232C0061_4AD423B900A4*
}

// implemented method from GenSupport::ProgessIndicatorService
// обновляет информацию в прогресс индикаторе
void ProgessIndicatorServiceImpl::update_message (const std::string& mess) {
	//#UC START# *4AD6D10C00D2_4AD423B900A4*
	GUARD (m_mutex);
	if (m_indicator) {
		m_indicator->update_label_text (mess);
	}
	//#UC END# *4AD6D10C00D2_4AD423B900A4*
}

// implemented method from WinGUI::ProgressIndicatorDelegate
// обработчик нажатия кнопки "CANCEL" при этом событие progress_indicator_closed не вызывается!
void ProgessIndicatorServiceImpl::progress_indicator_canceled (const WinGUI::ProgressIndicator& indicator) {
	//#UC START# *4AD43E310354_4AD423B900A4*
	GUARD (m_mutex);
	m_indicator = 0;	
	//#UC END# *4AD43E310354_4AD423B900A4*
}

// implemented method from WinGUI::ProgressIndicatorDelegate
// событие о закрытии окна прогресс индикатора
void ProgessIndicatorServiceImpl::progress_indicator_closed (const WinGUI::ProgressIndicator& indicator) {
	//#UC START# *4AD6C0F50143_4AD423B900A4*
	GUARD (m_mutex);
	m_indicator = 0;
	//#UC END# *4AD6C0F50143_4AD423B900A4*
}

// implemented method from WinGUI::ProgressIndicatorDelegate
// собатие  о том, что прогресс бар дошел до конца
void ProgessIndicatorServiceImpl::progress_indicator_finished (const WinGUI::ProgressIndicator& indicator) {
	//#UC START# *4AD6C07103E7_4AD423B900A4*
	GUARD (m_mutex);
	m_indicator = 0;
	//#UC END# *4AD6C07103E7_4AD423B900A4*
}

// implemented method from WinGUI::ProgressIndicatorDelegate
// размер прогресс-индикатора
unsigned int ProgessIndicatorServiceImpl::get_progress_size () const {
	//#UC START# *4AD43E140385_4AD423B900A4_GET*
	return m_progress_size;
	//#UC END# *4AD43E140385_4AD423B900A4_GET*
}

void ProgessIndicatorServiceImpl::set_progress_size (unsigned int progress_size) {
	//#UC START# *4AD43E140385_4AD423B900A4_SET*
	m_progress_size = progress_size;
	//#UC END# *4AD43E140385_4AD423B900A4_SET*
}

// implemented method from WinGUI::ProgressIndicatorDelegate
// устанавливает размер шага
unsigned int ProgessIndicatorServiceImpl::get_step_size () const {
	//#UC START# *4AD43E170080_4AD423B900A4_GET*
	return m_step_size;
	//#UC END# *4AD43E170080_4AD423B900A4_GET*
}

void ProgessIndicatorServiceImpl::set_step_size (unsigned int step_size) {
	//#UC START# *4AD43E170080_4AD423B900A4_SET*
	m_step_size = step_size;
	//#UC END# *4AD43E170080_4AD423B900A4_SET*
}
} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

