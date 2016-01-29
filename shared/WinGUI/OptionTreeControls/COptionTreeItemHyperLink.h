////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemHyperLink.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemHyperLink
//
// контрол киперссылка для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMHYPERLINK_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMHYPERLINK_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B04000119_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC END# *470B04000119_CUSTOM_INCLUDES*

namespace WinGUI {

// контрол киперссылка для отображения в дереве
class COptionTreeItemHyperLink : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemHyperLink)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemHyperLink ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemHyperLink)


//#UC START# *470B04000119*
// Construction
public:
	COptionTreeItemHyperLink();
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
	virtual CString GetAttributeText(void);

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeItemHyperLink)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetVisited(BOOL bVisited);
	void SetLink(CString strLink);
	CString GetLink();
	COLORREF GetVisitedColor();
	COLORREF GetHoverColor();
	COLORREF GetLinkColor();
	void SetVisitedColor(COLORREF crColor);
	void SetHoverColor(COLORREF crColor);
	void SetLinkColor(COLORREF crColor);
	BOOL GetVisited();
	HCURSOR GetLinkCursor();
	void SetLinkCursor(HCURSOR hCursor);
	BOOL CreateHyperlinkItem(DWORD dwOptions, CString strLink, COLORREF crLink, COLORREF crHover = NULL, COLORREF crVisited = NULL);

	// Generated message map functions
protected:
	BOOL m_bFocus;
	void SetDefaultCursor();
	COLORREF m_crLink;
	COLORREF m_crHover;
	COLORREF m_crVisited;
	BOOL m_bVisited;
	CString m_strLink;
	HCURSOR  m_hLinkCursor;
	CRect m_rcHover;
	BOOL m_bHover;
	CFont m_fUnderlineFont;
	//{{AFX_MSG(COptionTreeItemHyperLink)
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnPaint();
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	//}}AFX_MSG
//#UC END# *470B04000119*
}; // class COptionTreeItemHyperLink

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMHYPERLINK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

