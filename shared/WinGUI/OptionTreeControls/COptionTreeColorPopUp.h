////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeColorPopUp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeColorPopUp
//
// pop-up окно с выбором цветов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREECOLORPOPUP_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREECOLORPOPUP_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFD9300DA_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"

namespace WinGUI {
	class COptionTree;
}

// Structures
typedef struct 
{
    COLORREF crColor;
    TCHAR    *szName;
} OT_COLOR_ITEM;
//#UC END# *470AFD9300DA_CUSTOM_INCLUDES*

namespace WinGUI {

// pop-up окно с выбором цветов
class COptionTreeColorPopUp : public CWnd {
	SET_OBJECT_COUNTER (COptionTreeColorPopUp)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeColorPopUp ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeColorPopUp)


//#UC START# *470AFD9300DA*
public:
    COptionTreeColorPopUp();
    COptionTreeColorPopUp(CPoint pPoint, COLORREF crColor, COLORREF crDefault, CWnd* pParentWnd, LPCTSTR szDefaultText = NULL, LPCTSTR szCustomText = NULL);
    void Initialize();

// Attributes
public:

// Operations
public:
    BOOL Create(CPoint pPoint, COLORREF crColor, CWnd* pParentWnd, LPCTSTR szDefaultText = NULL, LPCTSTR szCustomText = NULL);

// Overrides
    // ClassWizard generated virtual function overrides
    //{{AFX_VIRTUAL(COptionTreeColorPopUp)

public:
    virtual BOOL PreTranslateMessage(MSG* pMsg);
    //}}AFX_VIRTUAL

protected:
    BOOL GetCellRect(int nIndex, const LPRECT& rect);
    void FindCellFromColor(COLORREF crColor);
    void SetWindowSize();
    void CreateToolTips();
    void ChangeSelection(int nIndex);
    void EndSelection(int nMessage);
    void DrawCell(CDC* pDC, int nIndex);

    COLORREF GetColor(int nIndex)              { return m_crColors[nIndex].crColor; }
    LPCTSTR GetColorName(int nIndex)           { return m_crColors[nIndex].szName; }
    int  GetIndex(int nRow, int nCol) const;
    int  GetRow(int nIndex) const;
    int  GetColumn(int nIndex) const;

// protected attributes
protected:
    static OT_COLOR_ITEM m_crColors[];
    int m_nNumColors;
    int m_nNumColumns, m_nNumRows;
    int m_nBoxSize, m_nMargin;
    int m_nCurrentSel;
    int m_nChosenColorSel;
    CString m_strDefaultText;
    CString m_strCustomText;
    CRect m_rcCustomTextRect, m_rcDefaultTextRect, m_rcWindowRect;
    CFont m_fFont;
    CPalette m_plPalette;
    COLORREF m_crInitialColor, m_crColor, m_crDefault;
    CToolTipCtrl m_ttToolTip;
    CWnd* m_wndParent;

    BOOL m_bChildWindowVisible;

    // Generated message map functions
protected:
    //{{AFX_MSG(COptionTreeColorPopUp)
    afx_msg void OnNcDestroy();
    afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
    afx_msg void OnPaint();
    afx_msg void OnMouseMove(UINT nFlags, CPoint point);
    afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
    afx_msg BOOL OnQueryNewPalette();
    afx_msg void OnPaletteChanged(CWnd* pFocusWnd);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnActivateApp(BOOL bActive, DWORD hTask);
	//}}AFX_MSG
//#UC END# *470AFD9300DA*
}; // class COptionTreeColorPopUp

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREECOLORPOPUP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

