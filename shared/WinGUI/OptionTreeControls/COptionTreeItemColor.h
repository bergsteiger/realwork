////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemColor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemColor
//
// элемент выбора цвета
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCOLOR_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCOLOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B00F7035B_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeColorPopUp.h"
//#UC END# *470B00F7035B_CUSTOM_INCLUDES*

namespace WinGUI {

// элемент выбора цвета
class COptionTreeItemColor : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemColor)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemColor ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemColor)


//#UC START# *470B00F7035B*
// Construction
public:
	COptionTreeItemColor();
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
	//{{AFX_VIRTUAL(COptionTreeItemColor)
	//}}AFX_VIRTUAL

// Implementation
public:
	COLORREF GetAutomaticColor();
	void SetAutomaticColor(COLORREF crAutomatic);
	BOOL CreateColorItem(DWORD dwOptions, COLORREF rcColor, COLORREF rcAutomatic);
	void SetColor(COLORREF rcColor);
	COLORREF GetColor();

	// Generated message map functions
protected:
	void DrawControl(CDC *pDC, const RECT &rcRect);
	BOOL m_bFocus;
	COLORREF m_crColor;
	COLORREF m_crColorOrigin;
	COLORREF m_crAutomatic;
	//{{AFX_MSG(COptionTreeItemColor)
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnPaint();
	//}}AFX_MSG
	afx_msg long OnSelEndOK(UINT lParam, long wParam);
	afx_msg long OnSelEndCancel(UINT lParam, long wParam);
	afx_msg long OnSelChange(UINT lParam, long wParam);
	afx_msg long OnCloseColorPopUp(UINT lParam, long wParam);
//#UC END# *470B00F7035B*
}; // class COptionTreeItemColor

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMCOLOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

