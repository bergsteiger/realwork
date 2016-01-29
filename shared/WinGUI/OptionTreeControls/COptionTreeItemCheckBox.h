////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemCheckBox.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemCheckBox
//
// чек-бокс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCHECKBOX_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCHECKBOX_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B00C00138_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B00C00138_CUSTOM_INCLUDES*

namespace WinGUI {

// чек-бокс
class COptionTreeItemCheckBox : public COptionTreeCheckButton {
	SET_OBJECT_COUNTER (COptionTreeItemCheckBox)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemCheckBox ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemCheckBox)


//#UC START# *470B00C00138*
// Construction
public:
	COptionTreeItemCheckBox();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void OnShow(BOOL bShow){;}

	virtual void SetCheck(BOOL bCheck,const bool bcommit=false);
	BOOL CreateCheckBoxItem(BOOL bChecked, DWORD dwOptions);

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemCheckBox)
	//}}AFX_VIRTUAL

// Generated message map functions
protected:
	BOOL m_bFocus;
	CRect m_rcCheck;
	//{{AFX_MSG(COptionTreeItemCheckBox)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	//}}AFX_MSG
//#UC END# *470B00C00138*
}; // class COptionTreeItemCheckBox

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCHECKBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

