////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItem.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItem
//
// элемент дерева контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEM_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEM_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *470AFC61008C_CUSTOM_INCLUDES*
#include <hash_map>

#include "shared/WinGUI/OptionTreeControls/OptionTreeDef.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"
#include "shared/WinGUI/OptionTreeControls/CEditMask.h"

#define _CLR_CHECKED RGB(0,160,0)
#define _CLR_UNCHECKED RGB(160,0,0)
#define _CLR_DEFAULT RGB(34,34,54)
#define _CLR_USER RGB(10,10,120)

#define _CLR_CHECKEDHL RGB(0,190,0)
#define _CLR_UNCHECKEDHL RGB(190,0,0)
#define _CLR_DEFAULTHL RGB(64,64,84)
#define _CLR_USERHL RGB(40,40,150)

#define _CLR_BT_FRAME RGB(205,205,205)
#define _CLR_BT_FRAMEHL RGB(235,235,235)

#define _CLR_DEFAULT_FG RGB(255,255,255)

#define _CLR_DISABLED_BK RGB(100,100,100)
#define _CLR_DISABLED_FG RGB(205,205,205)


// button height/width
#define _D_TREEBT_HEIGHT 14
#define _D_TREEBT_WIDTH 14
#define _D_TREEBT_WIDTH_USER (3*(_D_TREEBT_WIDTH+2)-1)

// button codes
#define _D_BT_NONE 0
#define _D_BT_PLUS 1
#define _D_BT_MINUS 2
#define _D_BT_DEFAULT 4
#define _D_BT_USER 8
#define _D_BT_ALL (_D_BT_PLUS | _D_BT_MINUS | _D_BT_DEFAULT | _D_BT_USER)
#define ATTRIB_OFFSET (m_otOption != NULL ? m_otOption->GetAttributeOffset() : OT_SPACE)

namespace WinGUI {
	// Classes
	class COptionTree;
}
//#UC END# *470AFC61008C_CUSTOM_INCLUDES*

namespace WinGUI {

// элемент дерева контролов
class COptionTreeItem {
	SET_OBJECT_COUNTER (COptionTreeItem)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~COptionTreeItem ();


//#UC START# *470AFC61008C*	
public:
	COLORREF GetTextColor();
	void SetTextColor(COLORREF crColor);
	COLORREF GetLabelBackgroundColor();
	void SetLabelBackgroundColor(COLORREF crColor);
	COLORREF GetRootBackgroundColor();
	void SetRootBackgroundColor(COLORREF crColor);
	COLORREF GetLabelTextColor();
	void SetLabelTextColor(COLORREF crColor);
	COLORREF GetBackgroundColor();
	void SetBackgroundColor(COLORREF crColor);
	BOOL GetDrawMultiline();
	void SetDrawMultiline(BOOL bMultiline);
	int GetItemType();
	void SetItemType(int nType);
	void SetLabelRect(CRect rcLabel);
	inline CRect GetLabelRect() const {return m_rcLabelRect;}
	inline CRect GetAttributeRect() const {return m_rcAttribute;}

			long DrawItem(CDC* pDC, const RECT &rcRect, long x, long y);
	virtual void DrawAttribute(CDC *pDC, const RECT &rcRect);
	virtual void DrawButtons( CDC *pDC, 
							const CRect &rcRect,
							const int code=_D_BT_ALL,
							const bool bHighlight=false);

	virtual void OnActivate();
	virtual void OnMove();
	virtual void OnRefresh();
	virtual void OnCommit();
	virtual void CleanDestroyWindow();
	virtual void OnDeSelect();
	virtual void OnSelect();
	virtual void OnExpand(BOOL bExpand);
	// overwrite this,if your derived class also derived from CWnd.
	virtual void OnShow(BOOL bShow){;}

	inline bool GetAllowChildDrag(void) const {return _bAllowChildDrag;}
	inline void SetAllowChildDrag(const bool x=false) {_bAllowChildDrag=x;}
	inline void SetItemParam(const LPARAM x=0) {m_lParam = x;}
	inline LPARAM GetItemParam(void) const {return m_lParam;}

	/// === button helper functions ===
	// functions to be extended if a new button is defined
	void DeleteButton(const int code=_D_BT_ALL);
	/// text,bk and fg are only used for user button
	void AddButton( const int code=_D_BT_NONE,
				  const CString& text="",
				  const COLORREF bk=_CLR_USER,
				  const COLORREF fg=_CLR_DEFAULT_FG);
	CRect GetButtonRect(const CRect& rec,const int btcode=_D_BT_PLUS) const;

	///
	/// Maps a point to a button.
	/// Out: _D_BT_NONE: point not located within button.
	///
	DWORD Point2ButtonCode(const CPoint& pt);

	///
	/// Highlights a button if point is located in it.
	/// Out: FALSE: point outside of ANY button
	///
	BOOL  HighlightFromPoint(const CPoint& pt);

	virtual void SetChanged(const int changed=1);
	virtual BOOL GetOption(DWORD dwOption);
	virtual void SetOption(DWORD dwOption, BOOL bSet);
	BOOL  HasButton(const DWORD btcode) const;
	virtual long  CalcHeight(void);
		  int   GetTotalButtonWidth(void) const;
	// 

	/// === gdi helper functions ===
	CBrush* GetBrushBk(void);
	CBrush* GetBrushBkRoot(void);
	CBrush* GetBrushBkLabel(void);

	static CBrush* GetBrushBTAdd(const bool bhighlight=false);
	static CBrush* GetBrushBTDelete(const bool bhighlight=false);
	static CBrush* GetBrushBTDefault(const bool bhighlight=false);
	static CBrush* GetBrushBTBTUser(const bool bhighlight=false);
	static CBrush* GetFrameBrush(const bool bhighlight=false);

	void SetItemHeight(long lHeight);
	void CommitChanges(const bool bnotify=true);
	void Activate();
	long GetHeight();
	void SetOptionsOwner(COptionTree* otOption);
	long GetTotalHeight();
	BOOL IsRootLevel();
	BOOL HitExpand(const POINT& pt);
	void ReadOnly(BOOL bReadOnly = TRUE);
	void Expand(BOOL bExpand = TRUE);
	void Select(BOOL bSelect = TRUE);
	BOOL IsActivated();
	BOOL IsReadOnly();
	BOOL IsSelected();
	BOOL IsExpanded();
	void SetNextVisible(COptionTreeItem *otiNextVisible);
	COptionTreeItem * GetNextVisible();
	void SetChild(COptionTreeItem *otiChild);
	COptionTreeItem * GetChild();
	void SetSibling(COptionTreeItem *otiSibling);
	COptionTreeItem * GetSibling();
	void SetParent(COptionTreeItem *otiParent);
	COptionTreeItem * GetParent();

	UINT GetCtrlID();
	void SetCtrlID(UINT nID);
	CString GetLabelText();
	virtual CString GetAttributeText(void){return "";}
	void SetLabelText(CString strLabel);
	CString GetInfoText();
	void SetInfoText(CString strText);
	const POINT& GetLocation();
	COptionTreeItem();
	BOOL IsVisible(void) const;

protected:
	void _DrawExpand(HDC hdc, long lX, long lY, BOOL bExpand, BOOL bFill);
	void DrawButton(const CString& text,CDC *pDC,CBrush* pBrush,CRect &btRect,const bool bhighlight=false);
	BOOL IsStringEmpty(CString strString);

protected:
	CString m_strLabel;
	CString m_strInfoText;
	UINT m_uControlID;
	COptionTreeItem *m_otiParent;
	COptionTreeItem *m_otiSibling;
	COptionTreeItem *m_otiChild;
	COptionTreeItem *m_otiNextVisible;
	CRect m_rcExpand;
	COptionTree *m_otOption;
	CPoint m_ptLocation;
	CRect m_rcAttribute;
  CRect m_rcButtons;
	BOOL m_bCommitOnce;
	LPARAM m_lParam;
	long m_lItemHeight;
	CRect m_rcLabelRect;
	BOOL m_bSelected;
	BOOL m_bExpanded;
	BOOL m_bActivated;
	BOOL m_bReadOnly;
	int m_nItemType;
	BOOL m_bDrawMultiline;
	COLORREF m_crBackground;
	COLORREF m_crText;
	COLORREF m_crRootBackground;
	COLORREF m_crLabelText;
	COLORREF m_crLabelBackground;
  // child can be dragged
  bool     _bAllowChildDrag;

  //CStandardButton* _btHelp;
  // flag for changed
  int _changed;
  DWORD m_dwOptions;

  DWORD           _btqueue;
  CBrush          _BrushBk;
  CBrush          _BrushBkRoot;
  CBrush          _BrushBkLabel;
  ///
  /// normal brushes
  ///
  static CBrush          __BrushBTAdd;
  static CBrush          __BrushBTDelete;
  static CBrush          __BrushBTDefault;
  static CBrush          __BrushBTUser;
  
  ///
  /// highlight brushes
  ///
  static CBrush          __BrushBTAddHL;
  static CBrush          __BrushBTDeleteHL;
  static CBrush          __BrushBTDefaultHL;
  static CBrush          __BrushBTUserHL;
  /// frame brush
  static CBrush          __BrushFrame;
  static CBrush          __BrushFrameHL;

  // button click notify params

  // text of user button
  CString _text;
  // visible state on last DrawItem call.
  bool  _bVisible;

 private:
	 static unsigned long __InstanceCount;
//#UC END# *470AFC61008C*
}; // class COptionTreeItem

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_COPTIONTREEITEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

