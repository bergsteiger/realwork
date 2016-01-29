////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeList.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeList
//
// list
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREELIST_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREELIST_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B05D5032C_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"

namespace WinGUI {
	class COptionTree;
	class COptionTreeItem;
}
//#UC END# *470B05D5032C_CUSTOM_INCLUDES*

namespace WinGUI {

// list
class COptionTreeList : public CWnd {
	SET_OBJECT_COUNTER (COptionTreeList)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeList ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeList)


//#UC START# *470B05D5032C*
// Construction
public:
	COptionTreeList();
	BOOL Create(DWORD dwStyle, RECT rcRect, CWnd* pParentWnd, UINT nID);

  const CRect& GetCurrentClientRect(void) const {return _CurrentClientRect;}

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeList)
	//}}AFX_VIRTUAL

// Implementation
public:
  // this function calculates the total visible virtual height
  // and sets the scrollragne
	void UpdateResize();

protected:
  BOOL PreTranslateMessage(MSG* pMsg) ;

	// Generated message map functions
protected:
	// CPropTree class that this class belongs
	COptionTree *m_otOption;
	long m_lPrevCol;
	BOOL m_bColDrag;
	HCURSOR m_hSplitter;
	HCURSOR m_hHand;
	HCURSOR _hDrag;
	long m_lColumn;
	//{{AFX_MSG(COptionTreeList)
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnPaint();
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg BOOL OnMouseWheel(UINT nFlags, short zDelta, CPoint pt);
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg UINT OnGetDlgCode();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSizing(UINT fwSide, LPRECT pRect);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg BOOL OnWndMsg( UINT message, WPARAM wParam, LPARAM lParam, LRESULT *pResult );
	//}}AFX_MSG

public:
	void GetHandCursor();
	void SetOptionsOwner(COptionTree *otOption);
	void CheckVisibleFocus();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);

	void ScrollDirect(UINT nSBCode=SB_VERT,UINT nPos=0) ;

protected:
	int               _iDrag;
	COptionTreeItem * _pDragItem;
	CRect             _CurrentClientRect;
//#UC END# *470B05D5032C*
}; // class COptionTreeList

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREELIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

