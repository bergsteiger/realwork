////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemImage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemImage
//
// контрол выбора изображения для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMIMAGE_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMIMAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470B043B030D_CUSTOM_INCLUDES*
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeImagePopUp.h"
//#UC END# *470B043B030D_CUSTOM_INCLUDES*

namespace WinGUI {

// контрол выбора изображения для отображения в дереве
class COptionTreeItemImage : public CWnd, public COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItemImage)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItemImage ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTreeItemImage)


//#UC START# *470B043B030D*
// Construction
public:
	COptionTreeItemImage();
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
	//{{AFX_VIRTUAL(COptionTreeItemImage)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetSelection(int nSelection);
	int GetSelection();
	void AddIcon(CString strIcon, CString strText);
	void AddBitmap(CString strBitmap, COLORREF crMask, CString strText);
	void AddBitmap(UINT uBitmap, COLORREF crMask, CString strText);
	void AddBitmap(CBitmap &bBitmap, COLORREF crMask, CString strText);
	void AddIcon(UINT uIcon, CString strText);
	void AddIcon(HICON hIcon, CString strText);
	void SetNumberColumns(int nNum);
	CSize GetImageSize();
	void SetImageSize(CSize sSize);
	BOOL CreateImageItem(DWORD dwOptions, CSize sImageSizes, int nNumberColumns);

	// Generated message map functions
protected:
	HICON CreateGreyScaleIcon(HICON hIcon);
	void DitherBlt(CDC *drawdc, int nXDest, int nYDest, int nWidth, int nHeight, CBitmap &bmp, int nXSrc, int nYSrc);
	BOOL GetBitmapFromImageList(CDC *pDC, HICON hIcon, CBitmap &bmp);
	void DrawControl(CDC *pDC, const RECT &rcRect);
	BOOL m_bFocus;
	int m_nNumColumns;
	CSize m_sImageSizes;
	int m_nSelected;
	CImageList m_imgImages;
	CStringArray m_strText;
	//{{AFX_MSG(COptionTreeItemImage)
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnPaint();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	//}}AFX_MSG
	afx_msg LONG OnPopUpClose(UINT lParam, long wParam);
//#UC END# *470B043B030D*
}; // class COptionTreeItemImage

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEMIMAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

