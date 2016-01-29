////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTree
//
// дерево-контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"

#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
//#UC START# *470AFBFE0213_CUSTOM_INCLUDES*
// Added Headers
#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

#include "shared/WinGUI/OptionTreeControls/COptionTreeInfo.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemCheckBox.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemColor.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemComboBox.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemDate.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemEdit.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemEditButton.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemFile.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemFile.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemFont.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemHyperLink.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemImage.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemIPAddress.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemListBox.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemRadio.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemSpinner.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemStatic.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeList.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree3StateCheckBox.h"

#define _D_REFRESH_LABEL 1
#define _D_REFRESH_ATTRIBUTE 2

namespace WinGUI {
	class COptionTree;
	class COptionTreeItem;
}
typedef BOOL (CALLBACK* ENUM_OPTIONITEMPROC)(WinGUI::COptionTree* otProp, WinGUI::COptionTreeItem* otiItem, LPARAM lParam);
// CPropTree WM_NOTIFY notification structure
typedef struct _NMOPTIONTREE
{
    NMHDR hDR;
	WinGUI::COptionTreeItem* otiItem;
} NMOPTIONTREE, *PNMOPTIONTREE, FAR *LPNMOPTIONTREE;


// Global Functions
// -- Draw dark horizontal line
static void _DrawDarkHLine(HDC hdc, long lX, long lY, long lWidth)
{
	CRect rcPaint(lX, lY, lX + lWidth, lY + 1);
	int nOldBack = SetBkColor(hdc, GetSysColor(COLOR_BTNSHADOW));

	// GDI calls driver directly
	ExtTextOut(hdc, 0, 0, ETO_OPAQUE, rcPaint, 0, 0, 0); 

	// Restore
	SetBkColor(hdc, nOldBack);	
}
// -- Draw dark vertical line
static void _DrawDarkVLine(HDC hdc, long lX, long lY, long lHeight)
{
	CRect rcPaint(lX, lY, lX + 1, lY + lHeight);
	int nOldBack = SetBkColor(hdc, GetSysColor(COLOR_BTNSHADOW));

	// GDI calls driver directly
	ExtTextOut(hdc, 0, 0, ETO_OPAQUE, rcPaint, 0, 0, 0); 

	// Restore
	SetBkColor(hdc, nOldBack);	
}
// -- Draw lite horizontal line
static void _DrawLiteHLine(HDC hdc, long lX, long lY, long lWidth)
{
	HBRUSH hbr = (HBRUSH )CDC::GetHalftoneBrush()->GetSafeHandle();
	SetBrushOrgEx(hdc, 0, 0, NULL);
	UnrealizeObject(hbr);
	HBRUSH holdbr = (HBRUSH )SelectObject(hdc, hbr);
	COLORREF rcOldColor = SetTextColor(hdc, GetSysColor(COLOR_BTNSHADOW));
	int nOldBack = SetBkColor(hdc, GetSysColor(COLOR_WINDOW));
	PatBlt(hdc, lX, lY, lWidth, 1, PATCOPY);
	SelectObject(hdc, holdbr);
	SetTextColor(hdc, rcOldColor);
	SetBkColor(hdc, nOldBack);
}
// -- Draw lite vertical line
static void _DrawLiteVLine(HDC hdc, long lX, long lY, long lHeight)
{
	HBRUSH hbr = (HBRUSH )CDC::GetHalftoneBrush()->GetSafeHandle();
	SetBrushOrgEx(hdc, 0, 0, NULL);
	UnrealizeObject(hbr);
	HBRUSH holdbr = (HBRUSH )SelectObject(hdc, hbr);
	COLORREF rcOldColor = SetTextColor(hdc, GetSysColor(COLOR_BTNSHADOW));
	int nOldBack = SetBkColor(hdc, GetSysColor(COLOR_WINDOW));
	PatBlt(hdc, lX, lY, 1, lHeight, PATCOPY);
	SelectObject(hdc, holdbr);
	SetTextColor(hdc, rcOldColor);
	SetBkColor(hdc, nOldBack);
}
// -- Draw selection rectangle
static void _DrawSelectRect(HDC hdc, long lX, long lY, long lWidth)
{
	HBRUSH hbr = (HBRUSH )CDC::GetHalftoneBrush()->GetSafeHandle();
	SetBrushOrgEx(hdc, 0, 0, NULL);
	UnrealizeObject(hbr);
	HBRUSH holdbr = (HBRUSH )SelectObject(hdc, hbr);
	COLORREF rcOldColor = SetTextColor(hdc, GetSysColor(COLOR_3DHILIGHT));
	int nOldBack = SetBkColor(hdc, GetSysColor(COLOR_3DFACE));
	PatBlt(hdc, lX, lY, lWidth, 1, PATCOPY);
	SelectObject(hdc, holdbr);
	SetTextColor(hdc, rcOldColor);
	SetBkColor(hdc, nOldBack);
}

/* -- Draw splitter bar selected
static void _DrawXorBar(HDC hdc, int x1, int y1, int nWidth, int nHeight)
{
	// Declare variables
	static WORD _dotPatternBmp[8] = { 0x00aa, 0x0055, 0x00aa, 0x0055, 0x00aa, 0x0055, 0x00aa, 0x0055};
	HBITMAP hbm;
	HBRUSH  hbr, hbrushOld;

	// Create a monochrome checkered pattern
	hbm = CreateBitmap(8, 8, 1, 1, _dotPatternBmp);

	hbr = CreatePatternBrush(hbm);
    
	SetBrushOrgEx(hdc, x1, y1, 0);
	hbrushOld = (HBRUSH)SelectObject(hdc, hbr);
    
	// Draw the checkered rectangle to the screen
	PatBlt(hdc, x1, y1, nWidth, nHeight, PATINVERT);
    
	SelectObject(hdc, hbrushOld);
    
	DeleteObject(hbr);
	DeleteObject(hbm);
}
*/
// -- Make short string
static LPCTSTR _MakeShortString(CDC* pDC, LPCTSTR lpszLong, int nWidth, int nOffset)
{
	// Declare variables
	const _TCHAR szThreeDots[]=_T("...");
	int nStringLen = lstrlen(lpszLong);
	static _TCHAR szShort[MAX_PATH];
	int nAddLen;

	// Validate length
	if(nStringLen == 0 || pDC->GetTextExtent(lpszLong,nStringLen).cx + nOffset <= nWidth)
	{
		return lpszLong;
	}

	// Shorten
	lstrcpy(szShort, lpszLong);
	nAddLen = pDC->GetTextExtent(szThreeDots,sizeof(szThreeDots)).cx;
	for(int i = nStringLen - 1; i > 0; i--)
	{
		szShort[i] = 0;
		if(pDC->GetTextExtent(szShort, i).cx + nOffset + nAddLen <= nWidth)
		{
			break;
		}
	}
	lstrcat(szShort, szThreeDots);

	return szShort;
}
//#UC END# *470AFBFE0213_CUSTOM_INCLUDES*

namespace WinGUI {

// дерево-контролов
class COptionTree : public CWnd {
	SET_OBJECT_COUNTER (COptionTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTree ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
	DECLARE_MESSAGE_MAP()

	DECLARE_DYNAMIC(COptionTree)


//#UC START# *470AFBFE0213*
friend class COptionTreeItem;
friend class COptionTreeList;

public:
	COptionTree();
	BOOL Create(DWORD dwStyle, RECT rcRect, CWnd* pParentWnd, DWORD dwTreeOptions, UINT nID);
	int CreateChilds(); //hb - added this function to better handle subclassing
	static int Register(CWinApp *app, UINT id); //hb - added this function to register a window

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COptionTree)
	//}}AFX_VIRTUAL

// Implementation
public:
	void Expand(COptionTreeItem *pItem, BOOL bExpand);
	void ExpandAllItems();
	void ShadeRootItems(BOOL bShade);
	BOOL GetShadeRootItems();
	void ShadeExpandColumn(BOOL bShade);
	BOOL GetShadeExpandColumn();
	void ClearAllLabelRect();
	const CRect& GetLargestVisibleLabel(const bool bcalc=true);
	// with is called from items draw routine.
	void UpdateLargestVisibleLabel(const int& newright=OT_EXPANDCOLUMN + OT_RESIZEBUFFER);
	void ResetLargestVisibleLabel(void); 
	void SetNotify(BOOL bNotify, 
                 CWnd *pWnd,
                 const UINT btclickmessage=0, // message sent or post on button clicked (to catch in pretrans of pWnd)
                 const bool besend=false);    // message to send or to post 
	BOOL GetNotify();

	void SetDefInfoTextNoSel(BOOL bNoSelect);
	BOOL GetDefInfoTextNoSel();
	DWORD GetTreeOptions();
	BOOL IsSingleSelection();
	COptionTreeItem * FocusNext();
	COptionTreeItem * FocusPrev();
	COptionTreeItem * FocusLast();
	BOOL IsDisableInput();
	COptionTreeItem * InsertItem(COptionTreeItem* otiItem, COptionTreeItem* otiParent = NULL);
	void ClearVisibleList();
	// ce for drag and drop
	void MoveItem(COptionTreeItem* otiToMove,COptionTreeItem* otiTarget);
	void SetColumn(long lColumn,const bool bredraw=true);
	long GetColumn();
	void DeleteItem(COptionTreeItem* otiItem);
	void DeleteAllItems();
	// delete of all update and updating tree on if window handle avaiable
	void SaveClearItems();
	void SetOriginOffset(long lOffset);
	BOOL IsItemVisible(COptionTreeItem* otiItem);
	void UpdatedItems();
	///
	/// This function enumerates OnRefresh of each item.
	///
	void RefreshItems(COptionTreeItem* otiItem = NULL);
	///
	/// This function invalidates itemrect in tree and performs an update.
	///
	void RefreshItem(COptionTreeItem* otiItem,const int type=_D_REFRESH_LABEL | _D_REFRESH_ATTRIBUTE);
	void UpdateMoveAllItems();
	void EnsureVisible(COptionTreeItem* otiItem);
	void SetFocusedItem(COptionTreeItem* otiItem);
	COptionTreeItem * FocusFirst();
	void SelectItems(COptionTreeItem* otiItem, BOOL bSelect);
	void DisableInput(BOOL bDisable = TRUE);
	COptionTreeItem * FindItem(const POINT& pt);
	COptionTreeItem * FindItem(UINT uCtrlID);
	COptionTreeItem * FindItem(const CString& Text,const DWORD flag=OT_FI_LABEL,COptionTreeItem * pOffset=NULL);
	long HitTest(const POINT& pt);
	void AddToVisibleList(COptionTreeItem* otiItem);
	COptionTreeItem * GetVisibleList();
	COptionTreeItem * GetFocusedItem();
	COptionTreeItem * GetRootItem();
	BOOL GetShowInfoWindow();
	void ShowInfoWindow(BOOL bShow);
	static CFont* GetNormalFont();
	static CFont* GetBoldFont();
	const POINT& GetOrigin();
	CWnd* GetCtrlParent();
	LRESULT SendNotify(UINT uNotifyCode, COptionTreeItem* otiItem = NULL);
	// hb - add functions to suppress multiple updates during insert/delete of many items at once
	virtual void LockUpdate();
	virtual void UnlockUpdate();
	inline BOOL UpdateLocked(void) const {return (m_bLockUpdate > 0 ? TRUE : FALSE);}

	virtual void LockNotification();
	virtual void UnlocNotification();
	inline BOOL NotificationLocked(void) const {return (m_bLockNotification > 0 ? TRUE : FALSE);}

	inline void LockAll(void)
	{
	 this->LockUpdate();
	 this->LockNotification();
	}
	inline void UnLockAll(void)
	{
	 this->UnlocNotification();
	 this->UnlockUpdate();
	}
	void SetAutoSizeColumn(const bool x=false);
	inline bool GetAutoSizeColumn(void) const {return _bAutoSizeColumn;}

	virtual void Invalidate(BOOL bErase=TRUE);
	virtual void UpdateWindow();

	/// Process the button click.
	/// Out: true: message post or sent.
	bool ButtonClicked(COptionTreeItem *pItem,const DWORD code);

	inline COptionTreeList& GetList(void) {return m_otlList;}

	inline long GetItemCount(void) const {return _iItemCount;}

	inline HPEN GetPenShadow(void) {return _PenShadow;}

	void  ClearInfoTitle(void);
	void  ClearInfoText(void);
	///
	/// Update position of column separator line.
	/// In: width: new width of column;default: use largest labelrect.right
	BOOL UpdateColumnWidth(const int width=-1,const bool block=true);

	inline void SetAttributeOffset(const int offset=OT_SPACE)
	{
	_AttributeOffset = offset;
	}
	inline int GetAttributeOffset(void) const
	{
	return _AttributeOffset;
	}

	inline bool HasFindFlag(const DWORD flag) const
	{
	return ((m_dwFindFlag & flag) > 0 ? true : false);
	}

	inline void SetFindOffset(COptionTreeItem* pFindItemOffset = NULL)
	{
	m_pFindItemOffset = pFindItemOffset;
	}
	inline COptionTreeItem* GetFindOffset(void) const 
	{
	return m_pFindItemOffset;
	}
	inline COptionTreeItem* GetEnumOffset(void) const 
	{
	return m_pEnumOffset;
	}

public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);

	// Generated message map functions
protected:
	BOOL EnumItems(COptionTreeItem* otiItem, ENUM_OPTIONITEMPROC enumProc, LPARAM lParam = 0L);
	static BOOL CALLBACK EnumFindItemStr(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumFindItem(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumMoveAll(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumNotifyExpand(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);	
	static BOOL CALLBACK EnumRefreshAll(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumExpandAll(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumSelectAll(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumGetLargestVisibleLabelRect(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	static BOOL CALLBACK EnumClearAllLabelRect(COptionTree* otProp, COptionTreeItem* otiItem, LPARAM lParam);
	void DeleteGlobalResources();
	void InitGlobalResources();
	void ResizeAllWindows(int cx, int cy);
	void Delete(COptionTreeItem* otiItem);
	//{{AFX_MSG(COptionTree)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnEnable(BOOL bEnable);
	afx_msg void OnSysColorChange();
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnPaint();
	afx_msg void OnSizing(UINT fwSide, LPRECT pRect);
	afx_msg void OnSetFocus(CWnd* pOldWnd);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	//}}AFX_MSG

	inline void SetEnumOffset(COptionTreeItem* pFindItemOffset = NULL)
	{
	m_pEnumOffset = pFindItemOffset;
	}

  // Variables
protected:
	static CFont* m_fNormalFont;
	static CFont* m_fBoldFont;
	static UINT	m_uInstanceCount;
	static COptionTreeItem *m_otiFound;
	DWORD m_dwTreeOptions;
	COptionTreeInfo m_otInfo;     // shows label
	COptionTreeInfo m_otInfoInfo; // shows info text
	COptionTreeItem	m_otiRoot;
	COptionTreeItem* m_otiVisibleList;
	COptionTreeItem* m_otiFocus;
	COptionTreeItem* m_pFindItemOffset;
	COptionTreeItem* m_pEnumOffset;
	DWORD m_dwFindFlag;
	CPoint m_ptOrigin;
	COptionTreeList m_otlList;
	BOOL m_bDisableInput;
	UINT m_uLastUID;
	static CRect m_rcLargestLabel;
	CWnd *m_pNotify;
	BOOL  m_bLockUpdate; // hb - prevent multiple window updates
	BOOL  m_bLockNotification; // hb - prevent multiple window updates
	long  _iItemCount;

protected:
	///
	/// Frequently used gdi objects
	///
	HPEN    _PenShadow;    // COLOR_BTNSHADOW  

	UINT    _Message;
	bool    _bsend;
	// if an item has been expanded, autosize column to fit with larges vis. item
	bool    _bAutoSizeColumn;
	int     _AttributeOffset;

//#UC END# *470AFBFE0213*
}; // class COptionTree

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

