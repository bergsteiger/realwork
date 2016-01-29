////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/EnterStringDialog.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::CommonViews::EnterStringDialog
//
// диалог ввода текста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ENTERSTRINGDIALOG_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ENTERSTRINGDIALOG_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *462D86BF02FD_CUSTOM_INCLUDES*
//#UC END# *462D86BF02FD_CUSTOM_INCLUDES*


// диалог ввода текста
class EnterStringDialog : public CDialog {
	SET_OBJECT_COUNTER (EnterStringDialog)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_ENTER_STRING_DIALOG };

public:
	EnterStringDialog ();

public:
	virtual ~EnterStringDialog ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(EnterStringDialog)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_entered_string;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_entered_string () const;

	void set_entered_string (const std::string& entered_string);

//#UC START# *462D86BF02FD*
private:
	CString m_string;
//#UC END# *462D86BF02FD*
}; // class EnterStringDialog



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_ENTERSTRINGDIALOG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

