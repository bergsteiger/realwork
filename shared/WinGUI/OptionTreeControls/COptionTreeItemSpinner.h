////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemSpinner.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemSpinner
//
// spinner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMSPINNER_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMSPINNER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeSpinnerButton.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B0CA60271_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B0CA60271_CUSTOM_INCLUDES*

namespace WinGUI {

// spinner
class COptionTreeItemSpinner : public COptionTreeSpinnerButton, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemSpinner)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemSpinner ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemSpinner)


//#UC START# *470B0CA60271*
// Construction
public:
	COptionTreeItemSpinner();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
  virtual void OnShow(BOOL bShow){;}



// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemSpinner)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL CreateSpinnerItem(DWORD dwOptions, double dValue, double dRangeBottom, double dRangeTop);

protected:
	LRESULT WM_CommitChanges(WPARAM wParam, LPARAM lParam);
	LRESULT WM_TextChanged(WPARAM wParam, LPARAM lParam);

	// Generated message map functions
protected:
	BOOL m_bFocus;

	//{{AFX_MSG(COptionTreeItemSpinner)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	//}}AFX_MSG

//#UC END# *470B0CA60271*
}; // class COptionTreeItemSpinner

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMSPINNER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

