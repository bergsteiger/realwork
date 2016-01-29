////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeImagePopUp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeImagePopUp
//
// pop-up окно для выбора изображений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEIMAGEPOPUP_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEIMAGEPOPUP_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFFF6030D_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include <afxtempl.h>
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"

namespace WinGUI {
	class COptionTree;
}
//#UC END# *470AFFF6030D_CUSTOM_INCLUDES*

namespace WinGUI {

// pop-up окно для выбора изображений
class COptionTreeImagePopUp : public CWnd {
	SET_OBJECT_COUNTER (COptionTreeImagePopUp)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeImagePopUp ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeImagePopUp)


//#UC START# *470AFFF6030D*
// Construction
public:
	COptionTreeImagePopUp(CPoint pPoint, CSize sImageSize, int nNumColumns, CImageList *imgImageList, COptionTree *otImageOption, CStringArray &strText, int nSelected, CWnd* pParentWnd);

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTreeImagePopUp)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	//}}AFX_VIRTUAL

	// Generated message map functions
protected:
	void SetUpImages();
	void SetUpToolTips();
	void SetWindowSize();
	BOOL Create(CPoint pPoint);
	CToolTipCtrl m_ttToolTip;
	CPoint m_pHover;
	COptionTree *m_otImageOption;
	CImageList *m_pImageList;
	CWnd *m_pParent;
	CSize m_sImageSizes;
	int m_nNumColumns;
	int m_nNumRows;
	CStringArray m_strText;
	CArray<CRect, CRect&> m_rcRectangles;
	int m_nSelected;
	//{{AFX_MSG(COptionTreeImagePopUp)
	afx_msg void OnDestroy();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnNcDestroy();
	afx_msg void OnActivateApp(BOOL bActive, DWORD hTask);
	afx_msg void OnPaint();
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG
//#UC END# *470AFFF6030D*
}; // class COptionTreeImagePopUp

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEIMAGEPOPUP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

