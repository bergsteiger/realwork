////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemEdit.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemEdit
//
// поле ввода для отображения в дереве контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMEDIT_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMEDIT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/WinGUI/OptionTreeControls/CEditMask.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B0202007D_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B0202007D_CUSTOM_INCLUDES*

namespace WinGUI {

// поле ввода для отображения в дереве контролов
class COptionTreeItemEdit : public CEditMask, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemEdit)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemEdit ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemEdit)


//#UC START# *470B0202007D*
// Construction
public:
	COptionTreeItemEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemEdit)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual void SetOption(DWORD dwOption, BOOL bSet);

	virtual void SetEditLong(long lValue);
	virtual void SetEditDword(DWORD dwValue);
	virtual void SetEditFloat(float fValue);
	virtual void SetEditInt(int nValue);
	virtual void SetEditDouble(double dValue);
	BOOL PrepareEditItem(const CString& sWindowText="",
							  DWORD dwOptions=0, 
							  DWORD dwAddStyle = 0,
							  const CString& inputmask="");

	BOOL CreateEditItem(DWORD dwOptions, 
					  DWORD dwAddStyle = 0,
					  const CString& inputmask="");

	///
	/// Attention: Use this instead of SetWindowText
	///
	virtual void    SetEditText(const CString& sText);

	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnShow(BOOL bShow);
	virtual CString GetAttributeText(void);

	BOOL GetEditDword(DWORD &dwReturn);
	BOOL GetEditInt(int &nReturn);
	BOOL GetEditLong(long &lReturn);
	BOOL GetEditDouble(double &dReturn);
	BOOL GetEditFloat(float &fReturn);

	void set_maximum_height (int height);
protected:
  BOOL PreTranslateMessage(MSG* pMsg) ;

	// Generated message map functions
protected:
	BOOL IsStringNumeric(CString strString);
	//{{AFX_MSG(COptionTreeItemEdit)
	afx_msg UINT OnGetDlgCode();
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	//}}AFX_MSG

protected:
	void OptionsChanges();
	BOOL m_bFocus;
	int m_maximum_height;
	// these members store creation params
	DWORD   _dwExStyleBuffer;
	CString _InputMaskBuffer;
	CString _WindowTextBuffer;
public:
  afx_msg void OnEnChange();

  void Fit ();
//#UC END# *470B0202007D*
}; // class COptionTreeItemEdit

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMEDIT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

