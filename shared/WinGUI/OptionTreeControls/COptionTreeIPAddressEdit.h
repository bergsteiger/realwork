////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeIPAddressEdit.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeIPAddressEdit
//
// ввод IP-адреса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEIPADDRESSEDIT_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEIPADDRESSEDIT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B008500BB_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B008500BB_CUSTOM_INCLUDES*

namespace WinGUI {

// ввод IP-адреса
class COptionTreeIPAddressEdit : public CEdit {
	SET_OBJECT_COUNTER (COptionTreeIPAddressEdit)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeIPAddressEdit ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeIPAddressEdit)


//#UC START# *470B008500BB*
// Construction
public:
	COptionTreeIPAddressEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeIPAddressEdit)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetNotifyWnd(HWND hWnd);

protected:
  BOOL PreTranslateMessage(MSG* pMsg) ;
	// Generated message map functions
protected:
	HWND m_wndNotify;
	//{{AFX_MSG(COptionTreeIPAddressEdit)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnMaxText();
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG

public:
  afx_msg void OnEnChange();
//#UC END# *470B008500BB*
}; // class COptionTreeIPAddressEdit

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEIPADDRESSEDIT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

