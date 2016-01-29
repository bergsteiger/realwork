////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/TemplArgs.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::TemplArgs
//
// дилог для редактирования, добавления, удаления шаблонных аргументов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDAGUI_TEMPLARGS_H__
#define __MDPROCESS_MDAADDINLIB_MDAGUI_TEMPLARGS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *4574165F0222_CUSTOM_INCLUDES*
//#UC END# *4574165F0222_CUSTOM_INCLUDES*


// дилог для редактирования, добавления, удаления шаблонных аргументов
class TemplArgs : public CDialog {
	SET_OBJECT_COUNTER (TemplArgs)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	enum { IDD = IDD_TEMPL_ARGS };

public:
	explicit TemplArgs (IRoseClassPtr cls);

public:
	virtual ~TemplArgs ();
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(TemplArgs)

	virtual void DoDataExchange(CDataExchange* pDX);

	BOOL OnInitDialog ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseClassPtr m_cls;

//#UC START# *4574165F0222*
public:
	CListCtrl m_args_list;
	afx_msg void OnLvnEndlabeleditList1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton4();
	afx_msg void OnBnClickedButton5();
	afx_msg void OnBnClickedButton1();
//#UC END# *4574165F0222*
}; // class TemplArgs



#endif //__MDPROCESS_MDAADDINLIB_MDAGUI_TEMPLARGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

