////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemListBox.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemListBox
//
// list-box
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMLISTBOX_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMLISTBOX_H__

#include "shared/Core/sys/std_inc.h"
#include "afxwin.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B055702EE_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B055702EE_CUSTOM_INCLUDES*

namespace WinGUI {

// list-box
class COptionTreeItemListBox : public CListBox, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemListBox)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemListBox ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemListBox)


//#UC START# *470B055702EE*
// Construction
public:
	COptionTreeItemListBox();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void OnActivate();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void OnExpand(BOOL bExpand);
	virtual void OnShow(BOOL bShow);
// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemListBox)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL CreateListItem(DWORD dwAddStyle = 0,const int Height=OT_LISTBOX_HEIGHT);

	// Generated message map functions
protected:
	BOOL m_bFocus;
	//{{AFX_MSG(COptionTreeItemListBox)
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	//}}AFX_MSG

protected:
	bool  _bRootExpanded;
public:
	afx_msg void OnLbnSelchange();
//#UC END# *470B055702EE*
}; // class COptionTreeItemListBox

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMLISTBOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

