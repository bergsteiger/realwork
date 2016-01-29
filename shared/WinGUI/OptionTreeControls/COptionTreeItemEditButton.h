////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemEditButton.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemEditButton
//
// непонятный контрол...
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMEDITBUTTON_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMEDITBUTTON_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemEdit.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B029301E4_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B029301E4_CUSTOM_INCLUDES*

namespace WinGUI {

// непонятный контрол...
class COptionTreeItemEditButton : public COptionTreeItemEdit {
	SET_OBJECT_COUNTER (COptionTreeItemEditButton)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemEditButton ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemEditButton)


//#UC START# *470B029301E4*
// Construction
public:
	COptionTreeItemEditButton();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemEditButton)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetOption(DWORD dwOption, BOOL bSet);
	void SetEditLong(long lValue);
	void SetEditDword(DWORD dwValue);
	void SetEditFloat(float fValue);
	void SetEditInt(int nValue);
	void SetEditDouble(double dValue);
	virtual BOOL CreateEditItem(  DWORD dwOptions, 
								DWORD dwAddStyle = 0,
								const CString& inputmask="");
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnShow(BOOL bShow);

	BOOL GetEditDword(DWORD &dwReturn);
	BOOL GetEditInt(int &nReturn);
	BOOL GetEditLong(long &lReturn);
	BOOL GetEditDouble(double &dReturn);
	BOOL GetEditFloat(float &fReturn);

protected:
	BOOL PreTranslateMessage(MSG* pMsg) ;
	// Generated message map functions
protected:
	BOOL IsStringNumeric(CString strString);
	//{{AFX_MSG(COptionTreeItemEditButton)
	afx_msg UINT OnGetDlgCode();
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	//}}AFX_MSG

protected:
	void OptionsChanges();
	BOOL m_bFocus;
	CButton m_ctrlButton;
public:
	afx_msg void OnEnChange();
//#UC END# *470B029301E4*
}; // class COptionTreeItemEditButton

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMEDITBUTTON_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

