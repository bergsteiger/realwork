////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeSpinnerEdit.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeSpinnerEdit
//
// вполе ввода с spinner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREESPINNEREDIT_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREESPINNEREDIT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B066600FA_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

namespace WinGUI {
	class COptionTreeSpinnerButton;
}
//#UC END# *470B066600FA_CUSTOM_INCLUDES*

namespace WinGUI {

// вполе ввода с spinner
class COptionTreeSpinnerEdit : public CEdit {
	SET_OBJECT_COUNTER (COptionTreeSpinnerEdit)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeSpinnerEdit ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeSpinnerEdit)


//#UC START# *470B066600FA*
// Construction
public:
	COptionTreeSpinnerEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeSpinnerEdit)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
public:
	void UpdateMenu();
	void SetOwnerSpinner(COptionTreeSpinnerButton *otSpinnerButton);

	// Generated message map functions
protected:
	COptionTreeSpinnerButton *m_otSpinnerButton;
	//{{AFX_MSG(COptionTreeSpinnerEdit)
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnTextChange();
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG

//#UC END# *470B066600FA*
}; // class COptionTreeSpinnerEdit

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREESPINNEREDIT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

