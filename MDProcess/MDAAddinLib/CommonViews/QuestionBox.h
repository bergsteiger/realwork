////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/QuestionBox.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::QuestionBox
//
// диалог - вопрос с возможностью сохранения выбранного значения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_QUESTIONBOX_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_QUESTIONBOX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45FE6247002E_CUSTOM_INCLUDES*
//#UC END# *45FE6247002E_CUSTOM_INCLUDES*


// диалог - вопрос с возможностью сохранения выбранного значения
class QuestionBox : public CDialog {
	SET_OBJECT_COUNTER (QuestionBox)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// показывает окно с вопросом, возвращает IDOK или IDCANCEL
	// \question - текст вопроса
	// \caption - заголовок окна
	static int show (const char* question, const char* caption);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_QUESTION_BOX };

public:
	QuestionBox (const char* question, const char* caption);

public:
	virtual ~QuestionBox ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(QuestionBox)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
public:
	// возвращает true, если ответ нужно сохранить
	virtual bool need_save () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_caption;

	int m_need_save;

	std::string m_question;

//#UC START# *45FE6247002E*
	afx_msg void on_no ();
//#UC END# *45FE6247002E*
}; // class QuestionBox



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_QUESTIONBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

