////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Controls/ProgressIndicator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> shared::WinGUI::Controls::ProgressIndicator
//
// Прогресс индикатор. Выполнен в виде НЕ модального диалога, при закрытии "убивает сам себя",
// поэтому объект его создающий не должен заботится об удалении!!!
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_CONTROLS_PROGRESSINDICATOR_H__
#define __SHARED_WINGUI_CONTROLS_PROGRESSINDICATOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/Controls/CommonControls.h"
//#UC START# *4AD426A003AF_CUSTOM_INCLUDES*
#include "shared/WinGUI/Controls/Controls.h"
//#UC END# *4AD426A003AF_CUSTOM_INCLUDES*

namespace WinGUI {

class ProgressIndicatorDelegate;
// Прогресс индикатор. Выполнен в виде НЕ модального диалога, при закрытии "убивает сам себя",
// поэтому объект его создающий не должен заботится об удалении!!!
class ProgressIndicator : public CDialog {
	SET_OBJECT_COUNTER (ProgressIndicator)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// сообщения
	static const unsigned long WM_UPDATE_LABEL_TEXT; // сообщение об обновлении текста лэйбла
	static const unsigned long WM_PROGRESS_STEPIT; // сообщение о шаге

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_PROGRESS_INDICATOR };

public:
	// конструктор
	explicit ProgressIndicator (ProgressIndicatorDelegate* delegate);

public:
	virtual ~ProgressIndicator ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(ProgressIndicator)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
public:
	// закрыть диалог
	virtual void close ();

	// показать диалог
	/*oneway*/ Core::ThreadHandle show ();

	// шаг прогресса
	virtual void step ();

	// инициирует шаг, передает сообщение описывающее шаг
	virtual void step (const std::string& message);

	// обновляет текст в IDC_PROGRESS_LABEL на text
	virtual void update_label_text (const std::string& text);

private:
	// обрабочтик нажатия кнопки "Cancel"
	virtual void on_cancel ();

	// закрывает диалог
	virtual void on_ok ();

	// реализация шага прогресс индикатора, если прогресс достиг конца - диалог с индикатор
	// закрывается, перед этим посылается сообщение progress_indicator_finished ()
	virtual LRESULT step_impl (WPARAM w_param, LPARAM l_param);

	// обработчик сообщения WM_UPDATE_LABEL_TEXT
	virtual LRESULT update_label_impl (WPARAM w_param, LPARAM l_param);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// делегат, реализующий логику связанную с работой индикатора и обеспечивающий его данными
	ProgressIndicatorDelegate* m_delegate;

	// флаг, что дилог показан на экране
	bool m_is_showed;

	// мьютекс дял синхронизации
	mutable Core::Mutex m_mutex;

	// контролл для отображения процесса
	CProgressCtrl m_progress;

	// событие о том, что была нажата кнопка "Cancel"
	bool m_was_canceled;
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_show_ (void* arg);

protected:
	virtual void show_ ();


//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const ProgressIndicatorDelegate* get_delegate () const;

	virtual void set_delegate (ProgressIndicatorDelegate* delegate);

//#UC START# *4AD426A003AF*
protected:
	//virtual void PostNcDestroy ();
//#UC END# *4AD426A003AF*
}; // class ProgressIndicator

} // namespace WinGUI


#endif //__SHARED_WINGUI_CONTROLS_PROGRESSINDICATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

