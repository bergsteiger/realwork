////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItem.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItem
//
// элемент дерева контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItem.h"

//#UC START# *470AFC61008C_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470AFC61008C_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470AFC61008C*
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
CBrush COptionTreeItem::__BrushBTAdd;
CBrush COptionTreeItem::__BrushBTDelete;
CBrush COptionTreeItem::__BrushBTDefault;
CBrush COptionTreeItem::__BrushBTUser;
CBrush COptionTreeItem::__BrushBTAddHL;
CBrush COptionTreeItem::__BrushBTDeleteHL;
CBrush COptionTreeItem::__BrushBTDefaultHL;
CBrush COptionTreeItem::__BrushBTUserHL;
CBrush COptionTreeItem::__BrushFrame;
CBrush COptionTreeItem::__BrushFrameHL;
unsigned long COptionTreeItem::__InstanceCount = 0;

COptionTreeItem::COptionTreeItem()
{
  ++__InstanceCount;
	// Initialize variables
	m_strInfoText = _T("");
	m_strLabel = _T("");
	m_uControlID = 0;
	m_otiParent = NULL;
	m_otiSibling = NULL;
	m_otiChild = NULL;
	m_otiNextVisible = NULL;
	m_rcExpand = CRect(0, 0, 0, 0);
	m_rcAttribute = CRect(0, 0, 0, 0);
	m_rcLabelRect = CRect(0, 0, 0, 0);
  m_rcButtons = CRect(0, 0, 0, 0);
	m_otOption = NULL;
	m_bCommitOnce = FALSE;
	m_lParam = NULL;
	m_lItemHeight = OT_DEFHEIGHT;
	m_bSelected = FALSE;
	m_bExpanded = FALSE;
	m_bActivated = FALSE;
	m_bReadOnly = FALSE;
	m_nItemType = OT_ITEM_STATIC;
	m_bDrawMultiline = FALSE;
	m_crBackground = GetSysColor(COLOR_WINDOW);
	m_crLabelText = GetSysColor(COLOR_BTNTEXT);
	m_crRootBackground = GetSysColor(COLOR_BTNFACE);
	m_crLabelBackground = GetSysColor(COLOR_WINDOW);
	m_crText = GetSysColor(COLOR_BTNTEXT);
  _bAllowChildDrag=false;
  _changed = -1;
  m_dwOptions=0;
  _bVisible = true;

  _text = "";
  _btqueue =_D_BT_NONE;
}

long  COptionTreeItem::CalcHeight(void)
{
  long defheight = this->GetHeight();

  long newheight=defheight;
  // this means 2 buttons rows
  if(HasButton(_D_BT_USER) == TRUE && HasButton(_D_BT_PLUS | _D_BT_MINUS | _D_BT_DEFAULT) == TRUE)
    newheight = 2 *_D_TREEBT_HEIGHT + 8;
  if(defheight < newheight)
    return newheight;
  return defheight;
}
void COptionTreeItem::DeleteButton(const int code)
{
   _btqueue &= ~code;
  int newheight=CalcHeight();
  if(newheight != m_lItemHeight)
  {
    m_lItemHeight = newheight;
    m_otOption->RefreshItems(this);
  }
  
}
void COptionTreeItem::AddButton(const int code,const CString& text,const COLORREF bk,const COLORREF fg)
{
  _btqueue |= code;
  _text = text;
  int newheight=CalcHeight();
  if(newheight != m_lItemHeight)
  {
    m_lItemHeight = newheight;
    m_otOption->RefreshItems(this);
  }
}
CRect COptionTreeItem::GetButtonRect(const CRect& totalrec,const int btcode) const
{
  int offset=0;


  if(btcode & _D_BT_PLUS)
  {
    CRect rec(totalrec);
    rec.top = rec.top + 3;
    rec.bottom = rec.top + _D_TREEBT_HEIGHT;
    rec.right -= 2;
    rec.left = rec.right - _D_TREEBT_WIDTH;
    return rec;
  }
  else if(btcode & _D_BT_MINUS)
  {
    if(_btqueue & _D_BT_PLUS)
      offset += (2+_D_TREEBT_WIDTH);

    CRect rec(totalrec);
    rec.top = rec.top + 3;
    rec.bottom = rec.top + _D_TREEBT_HEIGHT;
    rec.right -= (2 + offset);
    rec.left = rec.right - _D_TREEBT_WIDTH;
    return rec;
  }
  else if(btcode & _D_BT_DEFAULT)
  {
    if(_btqueue & _D_BT_PLUS)
      offset += (2+_D_TREEBT_WIDTH);
    if(_btqueue & _D_BT_MINUS)
      offset += (2+_D_TREEBT_WIDTH);

    CRect rec(totalrec);
    rec.top = rec.top + 3;
    rec.bottom = rec.top + _D_TREEBT_HEIGHT;
    rec.right -= (2 + offset);
    rec.left = rec.right - _D_TREEBT_WIDTH;
    return rec;
  }
  else if(btcode & _D_BT_USER)
  {
    CRect rec(totalrec);
  
    int fac=0;
    if(HasButton(_D_BT_PLUS|_D_BT_MINUS|_D_BT_DEFAULT) == TRUE)
      rec.top = rec.top + 3 + _D_TREEBT_HEIGHT + 2;
    else
      rec.top = rec.top + 3;
    rec.bottom = rec.top + _D_TREEBT_HEIGHT;

    rec.right -= 2;
    rec.left = rec.right - _D_TREEBT_WIDTH_USER;
    return rec;
  }
  return CRect(0,0,0,0);
}
CBrush* COptionTreeItem::GetBrushBTAdd(const bool bhighlight)
{
  if(bhighlight == false)
  {
    if(__BrushBTAdd.GetSafeHandle() == NULL)
    {
      __BrushBTAdd.CreateSolidBrush(_CLR_CHECKED);
    }
    return &__BrushBTAdd;
  }
  else
  {
    if(__BrushBTAddHL.GetSafeHandle() == NULL)
    {
      __BrushBTAddHL.CreateSolidBrush(_CLR_CHECKEDHL);
    }
    return &__BrushBTAddHL;
  }
}
CBrush* COptionTreeItem::GetBrushBTDelete(const bool bhighlight)
{
  if(bhighlight == false)
  {
    if(__BrushBTDelete.GetSafeHandle() == NULL)
    {
      __BrushBTDelete.CreateSolidBrush(_CLR_UNCHECKED);
    }
    return &__BrushBTDelete;
  }
  else
  {
    if(__BrushBTDeleteHL.GetSafeHandle() == NULL)
    {
      __BrushBTDeleteHL.CreateSolidBrush(_CLR_UNCHECKEDHL);
    }
    return &__BrushBTDeleteHL;
  }
}
CBrush* COptionTreeItem::GetBrushBTDefault(const bool bhighlight)
{
  if(bhighlight == false)
  {
    if(__BrushBTDefault.GetSafeHandle() == NULL)
    {
      __BrushBTDefault.CreateSolidBrush(_CLR_DEFAULT);
    }
    return &__BrushBTDefault;
  }
  else
  {
    if(__BrushBTDefaultHL.GetSafeHandle() == NULL)
    {
      __BrushBTDefaultHL.CreateSolidBrush(_CLR_DEFAULTHL);
    }
    return &__BrushBTDefaultHL;
  }
  
}
CBrush* COptionTreeItem::GetBrushBTBTUser(const bool bhighlight)
{
  if(bhighlight == false)
  {
    if(__BrushBTUser.GetSafeHandle() == NULL)
    {
      __BrushBTUser.CreateSolidBrush(_CLR_USER);
    }
    return &__BrushBTUser;
  }
  else
  {
    if(__BrushBTUserHL.GetSafeHandle() == NULL)
    {
      __BrushBTUserHL.CreateSolidBrush(_CLR_USERHL);
    }
    return &__BrushBTUserHL;
  }
}
CBrush* COptionTreeItem::GetFrameBrush(const bool bhighlight)
{
  if(bhighlight == false)
  {
    if(__BrushFrame.GetSafeHandle() == NULL)
    {
      __BrushFrame.CreateSolidBrush(_CLR_BT_FRAME);
    }
    return &__BrushFrame;
  }
  else
  {
    if(__BrushFrameHL.GetSafeHandle() == NULL)
    {
      __BrushFrameHL.CreateSolidBrush(_CLR_BT_FRAME);
    }
    return &__BrushFrameHL;
  }
}

CBrush* COptionTreeItem::GetBrushBkRoot(void)
{
  // brush not yet created
  if(_BrushBkRoot.GetSafeHandle() == NULL)
  {
    _BrushBkRoot.CreateSolidBrush(m_crRootBackground);
  }
  return &_BrushBkRoot;
}
CBrush* COptionTreeItem::GetBrushBk(void)
{
  // brush not yet created
  if(_BrushBk.GetSafeHandle() == NULL)
  {
    _BrushBk.CreateSolidBrush(m_crBackground);
  }
  return &_BrushBk;
}
CBrush* COptionTreeItem::GetBrushBkLabel(void)
{
  // brush not yet created
  if(_BrushBkLabel.GetSafeHandle() == NULL)
  {
    _BrushBkLabel.CreateSolidBrush(m_crLabelBackground);
  }
  return &_BrushBkLabel;
}
void COptionTreeItem::SetInfoText(CString strText)
{
	// Set info text
	m_strInfoText = strText;
}

CString COptionTreeItem::GetInfoText()
{
	// Return info text
	return m_strInfoText;
}

void COptionTreeItem::SetLabelText(CString strLabel)
{
	// Set label
	m_strLabel = strLabel;
}

CString COptionTreeItem::GetLabelText()
{
	// Return label
	return m_strLabel;
}

void COptionTreeItem::SetCtrlID(UINT nID)
{
	// Set the ID
	m_uControlID = nID;
}

UINT COptionTreeItem::GetCtrlID()
{
	// Return ID
	return m_uControlID;
}

COptionTreeItem * COptionTreeItem::GetParent()
{
	// Return parent
	return m_otiParent;
}

void COptionTreeItem::SetParent(COptionTreeItem *otiParent)
{
	// Set parent
	m_otiParent = otiParent;
}

COptionTreeItem * COptionTreeItem::GetSibling()
{
	// Return sibling
	return m_otiSibling;
}

void COptionTreeItem::SetSibling(COptionTreeItem *otiSibling)
{
	// Set sibling
	m_otiSibling = otiSibling;
}

COptionTreeItem * COptionTreeItem::GetChild()
{
	// Return child
	return m_otiChild;
}

void COptionTreeItem::SetChild(COptionTreeItem *otiChild)
{
	// Set child
	m_otiChild = otiChild;
}

COptionTreeItem * COptionTreeItem::GetNextVisible()
{
	// Return next visible
	return m_otiNextVisible;
}

void COptionTreeItem::SetNextVisible(COptionTreeItem *otiNetVisible)
{
	// Set child
	m_otiNextVisible = otiNetVisible;
}

BOOL COptionTreeItem::IsExpanded()
{
	// Return value
	return m_bExpanded;
}

BOOL COptionTreeItem::IsSelected()
{
	// Return value
	return m_bSelected;
}

BOOL COptionTreeItem::IsReadOnly()
{
	// Return value
	return m_bReadOnly;
}

BOOL COptionTreeItem::IsActivated()
{
	// Return value
	return m_bActivated;
}

void COptionTreeItem::Select(BOOL bSelect)
{
	// Select
	m_bSelected = bSelect;

	// Send message
	if (bSelect == FALSE)
	{
		OnDeSelect();
	}
	else
	{
		OnSelect();
	}
}

void COptionTreeItem::Expand(BOOL bExpand)
{
	// Make sure not null
	if (m_otOption == NULL)
	{
		return;
	}

	// Expand
	m_bExpanded = bExpand;

	// On expand
	m_otOption->Expand(this, bExpand);
}

void COptionTreeItem::ReadOnly(BOOL bReadOnly)
{
	// Read Only
	m_bReadOnly = bReadOnly;
}

BOOL COptionTreeItem::HitExpand(const POINT &pt)
{
	// Hit
	return m_rcExpand.PtInRect(pt);
}

BOOL COptionTreeItem::IsRootLevel()
{
	// Make sure not null
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Return
	return GetParent() == m_otOption->GetRootItem();
}

long COptionTreeItem::GetTotalHeight()
{
	// Declare variables
	COptionTreeItem *otiItem=NULL;
	long lHeight=GetHeight();

	// Add up total height if expanded
	if (IsExpanded() == TRUE)
	{
		// -- Go through all children
		for (otiItem = GetChild(); otiItem != NULL; otiItem = otiItem->GetSibling())
		{
			lHeight += otiItem->GetTotalHeight();
		}
	}

	return lHeight;
}

void COptionTreeItem::OnCommit()
{
	// Do nothing
}

void COptionTreeItem::OnRefresh()
{
// Do nothing
}

void COptionTreeItem::OnMove()
{
}

void COptionTreeItem::SetOptionsOwner(COptionTree *otOption)
{
	// Save pointer
	m_otOption = otOption;
}

long COptionTreeItem::DrawItem(CDC *pDC, const RECT &rcRect, long x, long y)
{
	// Make sure not null
	if (m_otOption == NULL)
	{
		return FALSE;
	}
	// Declare variables
	COptionTreeItem* otiNext;
	CPoint ptPoint;
	long lTotal, lCol, lHeight;
	CRect rcDRC, rcIR, rcTemp, rcLabelRight, rcRegion;
	HGDIOBJ hOld, hHighlight;
	HRGN hRgn = NULL;
	COLORREF crOld;
	int nOldBack;
	CString strShortLabel;
	CRect rcBack;
	CFont *pOldFont;

	// Add TreeItem the list of visible items
  // ce!
	//m_otOption->AddToVisibleList(this);

	// Store the item's location
	m_ptLocation = CPoint(x, y);

	// Store the items rectangle position
	// -- Attribute
	m_rcAttribute.SetRect(m_otOption->GetOrigin().x + ATTRIB_OFFSET, m_ptLocation.y, rcRect.right, m_ptLocation.y + GetHeight() - 1);
	m_rcAttribute.OffsetRect(0, -m_otOption->GetOrigin().y);
	// -- Background
	rcBack.SetRect(m_otOption->GetOrigin().x, m_ptLocation.y, rcRect.right - 2, m_ptLocation.y + GetHeight() - 1);
	rcBack.OffsetRect(0, -m_otOption->GetOrigin().y);

	// Intialize temporary drawing variables
	lTotal = GetHeight();
  // draw only if visible
  if(m_rcAttribute.bottom > 0 && m_rcAttribute.top < rcRect.bottom)
  {
    m_otOption->AddToVisibleList(this);
    //this->OnShow(TRUE);
	  // Convert item coordinates to screen coordinates
	  ptPoint = m_ptLocation;
	  ptPoint.y -= m_otOption->GetOrigin().y;
	  lCol = m_otOption->GetOrigin().x;

	  // See if root level
	  if (IsRootLevel() == TRUE)
	  {
		  rcDRC.SetRect(ptPoint.x + OT_EXPANDCOLUMN, ptPoint.y, rcRect.right, ptPoint.y + lTotal);
		  rcRegion.SetRect(ptPoint.x + OT_EXPANDCOLUMN, ptPoint.y, rcRect.right, ptPoint.y + lTotal);
	  }
	  else
	  {
		  rcDRC.SetRect(ptPoint.x + OT_EXPANDCOLUMN, ptPoint.y, lCol, ptPoint.y + lTotal);
		  rcRegion.SetRect(OT_EXPANDCOLUMN, ptPoint.y, lCol, ptPoint.y + lTotal);
	  }

	  // Shade root levels
	  if (IsRootLevel() == TRUE)
	  {
		  // -- Select brush
		  if (m_otOption->GetShadeRootItems() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
		  {
			  hOld = pDC->SelectObject(GetBrushBkRoot());
		  }
		  else
		  {
			  hOld = pDC->SelectObject(GetSysColorBrush(COLOR_WINDOW));
		  }

		  // -- Fill rectangle
		  pDC->PatBlt(rcRect.left + OT_EXPANDCOLUMN, rcDRC.top, rcRect.right - rcRect.left + 1, rcDRC.Height(), PATCOPY);

		  // -- Restore GDI objects
		  pDC->SelectObject(hOld);
  		
	  }
	  else
	  {
		  // -- Draw the item background
		  pDC->FillRect(&rcBack, GetBrushBk());
	  }
	  // Calc and draw expanded box position
	  if (GetChild())
	  {
		  // -- Calculate expand rectangle
		  m_rcExpand.left = OT_EXPANDCOLUMN/2 - OT_EXPANDBOXHALF;
		  m_rcExpand.top = m_ptLocation.y + ATTRIB_OFFSET;
		  m_rcExpand.right = m_rcExpand.left + OT_EXPANDBOX - 1;
		  m_rcExpand.bottom = m_rcExpand.top + OT_EXPANDBOX - 1;
		  rcIR = m_rcExpand;
		  rcIR.OffsetRect(0, -m_otOption->GetOrigin().y);

		  // -- Draw expanded
		  _DrawExpand(pDC->GetSafeHdc(), rcIR.left, rcIR.top, IsExpanded(), !IsRootLevel());
	  }
	  else
	  {
		  m_rcExpand.SetRectEmpty();
	  }

	  // Create a clipping region for the label
	  if (IsRootLevel() == FALSE)
	  {
		  hRgn = CreateRectRgn(rcDRC.left, rcDRC.top, rcDRC.right, rcDRC.bottom);
		  SelectClipRgn(pDC->GetSafeHdc(), hRgn);
	  }

	  // Calculate label position
	  rcIR = rcDRC;
	  rcIR.left += ATTRIB_OFFSET;

	  // Draw the label background
	  if (IsRootLevel() == FALSE)
	  {
		  rcBack = rcDRC;
		  pDC->FillRect(&rcBack,GetBrushBkLabel());
	  }

	  // Draw the label
    if (m_strLabel.IsEmpty() == FALSE)//IsStringEmpty(m_strLabel) == FALSE)
	  {
		  // -- Get the font
		  if (IsRootLevel() == TRUE)
		  {
			  pOldFont = pDC->SelectObject(COptionTree::GetBoldFont());
		  }
		  else
		  {
			  pOldFont = pDC->SelectObject(COptionTree::GetNormalFont());
		  }

		  // -- Set text color and background mode
		  crOld = pDC->SetTextColor(m_crLabelText);
		  nOldBack = pDC->SetBkMode(TRANSPARENT);

		  // -- Draw the text highlighted if selected
		  if (IsSelected() == TRUE)
		  {
			  // -- -- Select th objects
			  hOld = pDC->SelectObject(GetStockObject(NULL_PEN));
			  hHighlight = pDC->SelectObject(GetSysColorBrush(COLOR_HIGHLIGHT));

			  // -- -- Calculate highlighted rectangle
			  rcTemp = rcDRC;
			  rcTemp.left = OT_EXPANDCOLUMN;
			  rcTemp.right += OT_COLRNG;

			  // -- -- Draw rectangle
			  pDC->Rectangle(&rcTemp);

			  // -- -- Restore GDI objects
			  pDC->SelectObject(hOld);
			  pDC->SelectObject(hHighlight);

			  // -- -- Set text color for highlighted
			  pDC->SetTextColor(GetSysColor(COLOR_BTNHIGHLIGHT));
		  }

		  // -- Check if we need to draw the text as disabled
		  if (m_otOption->IsWindowEnabled() == FALSE)
		  {
			  pDC->SetTextColor(GetSysColor(COLOR_GRAYTEXT));
		  }

		  // -- Draw text
		  // -- -- Edit multiline
		  if (GetDrawMultiline() == TRUE)
		  {
			  // -- -- -- Center rectangle
			  rcLabelRight = rcIR;
			  rcLabelRight.top += ATTRIB_OFFSET;

			  // -- -- -- Shorten string
        if(m_otOption->GetAutoSizeColumn() == false)
			    strShortLabel = _MakeShortString(pDC, m_strLabel, rcLabelRight.Width(), 1);
        else
          strShortLabel = m_strLabel;

			  // -- -- -- Draw text
			  pDC->DrawText(strShortLabel, &rcLabelRight, DT_SINGLELINE | DT_TOP);
			  pDC->DrawText(strShortLabel, &rcLabelRight, DT_SINGLELINE | DT_TOP | DT_CALCRECT);

			  // -- -- -- Set label right
			  SetLabelRect(rcLabelRight);
		  }
		  // -- Normal
		  else
		  {
			  // -- -- -- Calculate rectangle
			  rcLabelRight = rcIR;

			  // -- -- -- Shorten string
        if(m_otOption->GetAutoSizeColumn() == false)
			    strShortLabel = _MakeShortString(pDC, m_strLabel, rcLabelRight.Width(), 1);
        else
          strShortLabel = m_strLabel;
			  // -- -- -- Draw text
			  pDC->DrawText(strShortLabel, &rcLabelRight, DT_SINGLELINE | DT_VCENTER);
			  pDC->DrawText(strShortLabel, &rcLabelRight, DT_SINGLELINE | DT_VCENTER | DT_CALCRECT);

			  // -- -- -- Set label right
			  SetLabelRect(rcLabelRight);
		  }
      // calculate largest label based on non root-items only
      if(this->IsRootLevel() == FALSE)
        m_otOption->UpdateLargestVisibleLabel(rcLabelRight.right + this->GetTotalButtonWidth());
		  // -- Restore GDI objects
		  pDC->SetTextColor(crOld);
		  pDC->SetBkMode(nOldBack);
		  pDC->SelectObject(pOldFont);
	  }

	  // Remove clip region
	  if (hRgn != NULL)
	  {
		  // -- Select clip region
		  SelectClipRgn(pDC->GetSafeHdc(), NULL);

		  // -- Delete region
		  DeleteObject(hRgn);
	  }

	  // Draw horizontal sep
	  if (IsRootLevel() == TRUE)
	  {
		  //  - OT_EXPANDCOLUMN + 1
		  _DrawDarkHLine(pDC->GetSafeHdc(), OT_EXPANDCOLUMN, ptPoint.y + lTotal - 1, rcRect.right);
		  _DrawDarkHLine(pDC->GetSafeHdc(), OT_EXPANDCOLUMN, ptPoint.y - 1, rcRect.right);
	  }
	  else
	  {
		  _DrawDarkHLine(pDC->GetSafeHdc(), OT_EXPANDCOLUMN, ptPoint.y + lTotal - 1, rcRect.right);
	  }

	  // Draw vertical sep
	  _DrawDarkVLine(pDC->GetSafeHdc(), OT_EXPANDCOLUMN, rcRect.top, rcRect.bottom);

	  // Draw separators
	  if (IsRootLevel() == FALSE)
	  {
		  _DrawDarkVLine(pDC->GetSafeHdc(), lCol, rcDRC.top, rcDRC.Height()); 
	  }

	  // Draw attribute
	  if (!IsRootLevel())
	  {
		  // -- Create clip region
		  hRgn = CreateRectRgn(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.right, m_rcAttribute.bottom);
		  SelectClipRgn(pDC->GetSafeHdc(), hRgn);
  		
		  // -- Draw attribute
		  DrawAttribute(pDC, m_rcAttribute);

		  // -- Select clip region
		  SelectClipRgn(pDC->GetSafeHdc(), NULL);

		  // -- Delete object
		  DeleteObject(hRgn);
	  }

    // draw buttons
    
    this->DrawButtons(pDC,rcBack);
    this->OnShow(TRUE);
    _bVisible = true;
  }
  // if item rect above origin, but last status was visible, hide it.
  else if(m_rcAttribute.bottom <= 0)
  {
    if(_bVisible == true)
    {
      this->OnShow(FALSE);
		  for (otiNext = GetChild(); otiNext != NULL; otiNext = otiNext->GetSibling())
		  {
			  // hide child
			  otiNext->OnShow(FALSE);
		  }
      _bVisible = false;
    }
  }
  // if below bottom, this and childs cannot be visible
  else if(m_rcAttribute.top >= rcRect.bottom)
  {
    this->OnShow(FALSE);
		for (otiNext = GetChild(); otiNext != NULL; otiNext = otiNext->GetSibling())
		{
			// hide child
			otiNext->OnShow(FALSE);
		}
    _bVisible = false;
    return lTotal;
  }
	// Draw children
	if (GetChild() != NULL && IsExpanded() == TRUE)
	{
		// -- Add to Y
		y += lTotal;

		for (otiNext = GetChild(); otiNext != NULL; otiNext = otiNext->GetSibling())
		{
			// -- -- Draw child
			lHeight = otiNext->DrawItem(pDC, rcRect, x + (IsRootLevel() ? 0 : OT_PNINDENT), y);
			
			// -- -- Add to total
			lTotal += lHeight;

			// -- -- Add to Y
			y += lHeight;
		}
	}
  //m_rcButtons = rcBack;
  //this->MoveButtons(rcBack);

	return lTotal;
}
void COptionTreeItem::DrawButtons(CDC *pDC, const CRect &rcRect,const int code,const bool bhighlight)
{
  COLORREF crOld = pDC->SetTextColor(_CLR_DEFAULT_FG);
  int nOldBack = pDC->SetBkMode(TRANSPARENT);
  m_rcButtons = rcRect;
  CFont* pOldFont = pDC->SelectObject(COptionTree::GetNormalFont());
  if(_btqueue & _D_BT_PLUS && (code == _D_BT_ALL || code == _D_BT_PLUS))
  {
    this->DrawButton("+",pDC,GetBrushBTAdd(bhighlight),GetButtonRect(m_rcButtons,_D_BT_PLUS),bhighlight);
  }
  if(_btqueue & _D_BT_MINUS && (code == _D_BT_ALL || code == _D_BT_MINUS))
  {
    this->DrawButton("-",pDC,GetBrushBTDelete(bhighlight),GetButtonRect(m_rcButtons,_D_BT_MINUS),bhighlight);
  }
  if(_btqueue & _D_BT_DEFAULT && (code == _D_BT_ALL || code == _D_BT_DEFAULT))
  {
    this->DrawButton("D",pDC,GetBrushBTDefault(bhighlight),GetButtonRect(m_rcButtons,_D_BT_DEFAULT),bhighlight);
  }
  if(_btqueue & _D_BT_USER && (code == _D_BT_ALL || code == _D_BT_USER))
  {
    this->DrawButton(_text,pDC,GetBrushBTBTUser(bhighlight),GetButtonRect(m_rcButtons,_D_BT_USER),bhighlight);
  }
  pDC->SetTextColor(crOld);
  pDC->SetBkMode(nOldBack);
  pDC->SelectObject(pOldFont);
}
void COptionTreeItem::DrawButton(const CString& text,CDC *pDC,CBrush* pBrush,CRect &btRect,const bool bhighlight)
{
  if(pDC && pBrush)
  {
    CBrush* BrushFame = this->GetFrameBrush(bhighlight);
    pDC->FrameRect(&btRect,pBrush);
    //btRect.DeflateRect(1,1);
    pDC->FillRect(&btRect,pBrush);
		pDC->DrawText(text, &btRect, DT_SINGLELINE | DT_VCENTER | DT_CENTER);
		pDC->DrawText(text, &btRect, DT_SINGLELINE | DT_VCENTER | DT_CENTER | DT_CALCRECT);
  }
}

const POINT& COptionTreeItem::GetLocation()
{
	return m_ptLocation;
}
DWORD COptionTreeItem::Point2ButtonCode(const CPoint& pt)
{
  if(m_otOption == NULL || _btqueue == _D_BT_NONE)
    return _D_BT_NONE;
  // transform the y-coordinate
  CPoint transpt(pt.x,pt.y + m_otOption->GetOrigin().y);

  CRect brec;
  brec = GetButtonRect(m_rcButtons,_D_BT_PLUS);
  brec.OffsetRect(0,m_otOption->GetOrigin().y);
  // check for add bt clicked
  if(brec.PtInRect(transpt) == TRUE)
  {
    if(HasButton(_D_BT_PLUS) == TRUE)
      return _D_BT_PLUS;
    if(HasButton(_D_BT_MINUS) == TRUE)
      return _D_BT_MINUS;
    if(HasButton(_D_BT_DEFAULT) == TRUE)
      return _D_BT_DEFAULT;
    if(HasButton(_D_BT_USER) == TRUE)
    return _D_BT_USER;
  }

  // check for delete bt clicked
  brec = GetButtonRect(m_rcButtons,_D_BT_MINUS);
  brec.OffsetRect(0,m_otOption->GetOrigin().y);
  if(brec.PtInRect(transpt) == TRUE)
  {
    if(HasButton(_D_BT_MINUS) == TRUE)
      return _D_BT_MINUS;
    if(HasButton(_D_BT_DEFAULT) == TRUE)
      return _D_BT_DEFAULT;
    if(HasButton(_D_BT_USER) == TRUE)
    return _D_BT_USER;
  }

  // check for default bt clicked
  brec = GetButtonRect(m_rcButtons,_D_BT_DEFAULT);
  brec.OffsetRect(0,m_otOption->GetOrigin().y);
  if(brec.PtInRect(transpt) == TRUE)
  {
    if(HasButton(_D_BT_DEFAULT) == TRUE)
      return _D_BT_DEFAULT;
    if(HasButton(_D_BT_USER) == TRUE)
    return _D_BT_USER;
  }

  // check for user bt clicked
  brec = GetButtonRect(m_rcButtons,_D_BT_USER);
  brec.OffsetRect(0,m_otOption->GetOrigin().y);
  if(brec.PtInRect(transpt) == TRUE)
  {
    if(HasButton(_D_BT_USER) == TRUE)
    return _D_BT_USER;
  }
  return _D_BT_NONE;
}
BOOL COptionTreeItem::HighlightFromPoint(const CPoint& pt)
{
  int hitcount=0;
  if(m_otOption == NULL || _btqueue == _D_BT_NONE)
    return FALSE;

  CDC *pDC = this->m_otOption->m_otlList.GetDC();
  if(pDC == NULL)
    return FALSE;

  // transform the y-coordinate
  CPoint transpt(pt.x,pt.y + m_otOption->GetOrigin().y);

  CRect brec;
  if(HasButton(_D_BT_PLUS) == TRUE)
  {
    brec = GetButtonRect(m_rcButtons,_D_BT_PLUS);
    brec.OffsetRect(0,m_otOption->GetOrigin().y);
    // check for add bt move over
    if(brec.PtInRect(transpt) == TRUE)
    {
      DrawButtons(pDC,m_rcButtons,_D_BT_PLUS,true);
      ++hitcount;
    }
    else
      DrawButtons(pDC,m_rcButtons,_D_BT_PLUS,false);
  }
  // check for delete bt move over
  if(HasButton(_D_BT_MINUS) == TRUE)
  {
    brec = GetButtonRect(m_rcButtons,_D_BT_MINUS);
    brec.OffsetRect(0,m_otOption->GetOrigin().y);
    if(hitcount == 0 && brec.PtInRect(transpt) == TRUE)
    {
      DrawButtons(pDC,m_rcButtons,_D_BT_MINUS,true);
      ++hitcount;
    }
    else
      DrawButtons(pDC,m_rcButtons,_D_BT_MINUS,false);
  }
  // check for default bt move over
  if(HasButton(_D_BT_DEFAULT) == TRUE)
  {
    brec = GetButtonRect(m_rcButtons,_D_BT_DEFAULT);
    brec.OffsetRect(0,m_otOption->GetOrigin().y);
    if(hitcount == 0 && brec.PtInRect(transpt) == TRUE)
    {
      DrawButtons(pDC,m_rcButtons,_D_BT_DEFAULT,true);
      ++hitcount;
    }
    else
      DrawButtons(pDC,m_rcButtons,_D_BT_DEFAULT,false);
  }
  // check for user bt move over
  if(HasButton(_D_BT_USER) == TRUE)
  {
    brec = GetButtonRect(m_rcButtons,_D_BT_USER);
    brec.OffsetRect(0,m_otOption->GetOrigin().y);
    if(hitcount == 0 && brec.PtInRect(transpt) == TRUE)
    {
      DrawButtons(pDC,m_rcButtons,_D_BT_USER,true);
      ++hitcount;
    }
    else
      DrawButtons(pDC,m_rcButtons,_D_BT_USER,false);
  }
  return (hitcount > 0 ? TRUE : FALSE);
}
long COptionTreeItem::GetHeight()
{
	// Return item height
	return m_lItemHeight;
}

void COptionTreeItem::_DrawExpand(HDC hdc, long lX, long lY, BOOL bExpand, BOOL bFill)
{
	// Declare variables
	HPEN oPen;
	HBRUSH oBrush;

	// Create pens
  oPen = (HPEN)SelectObject(hdc, m_otOption->GetPenShadow());
	if (bFill == TRUE)
	{
		oBrush = (HBRUSH)SelectObject(hdc, GetSysColorBrush(COLOR_WINDOW));
	}
	else
	{
		oBrush = (HBRUSH)SelectObject(hdc, GetStockObject(NULL_BRUSH));
	}

	// Draw rectangle
	Rectangle(hdc, lX, lY, lX + OT_EXPANDBOX, lY + OT_EXPANDBOX);
	SelectObject(hdc, GetStockObject(BLACK_PEN));

	// If not expanded
	if (bExpand == FALSE)
	{
		MoveToEx(hdc, lX + OT_EXPANDBOXHALF, lY + 2, NULL);
		LineTo(hdc, lX + OT_EXPANDBOXHALF, lY + OT_EXPANDBOX - 2);
	}

	// Draw lower line
	MoveToEx(hdc, lX + 2, lY + OT_EXPANDBOXHALF, NULL);
	LineTo(hdc, lX + OT_EXPANDBOX - 2, lY + OT_EXPANDBOXHALF);

	// Restore GDI objects
	SelectObject(hdc, oPen);
	SelectObject(hdc, oBrush);
}

BOOL COptionTreeItem::IsStringEmpty(CString strString)
{
	// Declare variables
	BOOL bEmpty = TRUE;

	// Go through each character
	for (int i = 0; i < strString.GetLength(); i++)
	{
		if (strString.GetAt(i) != ' ')
		{
			bEmpty = FALSE;
			break;
		}
	}

	return bEmpty;
}

void COptionTreeItem::DrawAttribute(CDC *pDC, const RECT &rcRect)
{
	// Do nothing here
}

void COptionTreeItem::Activate()
{
	// Set variables
	m_bActivated = TRUE;
	m_bCommitOnce = FALSE;

	// Activate
	OnActivate();
}
void COptionTreeItem::CommitChanges(const bool bnotify)
{
	// Set variables
	m_bActivated = FALSE;

	// Make sure valid
	if (m_otOption == NULL || bnotify == false)
	{
		return;
	}

	// Commit
	OnCommit();

	// Send notify to user
	m_otOption->SendNotify(OT_NOTIFY_ITEMCHANGED, this);
  _changed = 0;

	// Refresh items
	m_otOption->RefreshItems(this);
}
void COptionTreeItem::OnActivate()
{
	// No attributes, do nothing
}

void COptionTreeItem::SetItemHeight(long lHeight)
{
	// Save height
	m_lItemHeight = lHeight;
}

void COptionTreeItem::CleanDestroyWindow()
{
	// Do nothing here
}

void COptionTreeItem::OnDeSelect()
{
	// Do nothing here
}

void COptionTreeItem::OnSelect()
{
	// Do nothing here
}

void COptionTreeItem::OnExpand(BOOL bExpand)
{
	// Do nothing here
}

void COptionTreeItem::SetLabelRect(CRect rcLabel)
{
	// Save variable
	m_rcLabelRect = rcLabel;
}

void COptionTreeItem::SetItemType(int nType)
{
	// Save type
	m_nItemType = nType;
}

int COptionTreeItem::GetItemType()
{
	// Return
	return m_nItemType;
}

void COptionTreeItem::SetDrawMultiline(BOOL bMultiline)
{
	m_bDrawMultiline = bMultiline;
}

BOOL COptionTreeItem::GetDrawMultiline()
{
	return m_bDrawMultiline;
}

void COptionTreeItem::SetBackgroundColor(COLORREF crColor)
{
	m_crBackground = crColor;
  if(_BrushBk.GetSafeHandle() != NULL)
    _BrushBk.DeleteObject();
}

COLORREF COptionTreeItem::GetBackgroundColor()
{
	return m_crBackground;
}

void COptionTreeItem::SetLabelTextColor(COLORREF crColor)
{
	m_crLabelText = crColor;
}

COLORREF COptionTreeItem::GetLabelTextColor()
{
	return m_crLabelText;
}

void COptionTreeItem::SetRootBackgroundColor(COLORREF crColor)
{
	m_crRootBackground = crColor;
  if(_BrushBkRoot.GetSafeHandle() != NULL)
    _BrushBkRoot.DeleteObject();
}

COLORREF COptionTreeItem::GetRootBackgroundColor()
{
	return m_crRootBackground;
}

void COptionTreeItem::SetLabelBackgroundColor(COLORREF crColor)
{
	m_crLabelBackground = crColor;
  if(_BrushBkLabel.GetSafeHandle() != NULL)
    _BrushBkLabel.DeleteObject();
}

COLORREF COptionTreeItem::GetLabelBackgroundColor()
{
	return m_crLabelBackground;
}

void COptionTreeItem::SetTextColor(COLORREF crColor)
{
	m_crText = crColor;
}

COLORREF COptionTreeItem::GetTextColor()
{
	return m_crText;
}
void COptionTreeItem::SetChanged(const int changed)
{
 // _changed = (changed > 0 ? (_changed == -1 ? 0 : 1) : 0);
 _changed = (changed > 0 ?  _changed+1 : 0);
}
BOOL COptionTreeItem::GetOption(DWORD dwOption)
{
	// Return option
	return (m_dwOptions & dwOption) ? TRUE : FALSE;
}
BOOL COptionTreeItem::HasButton(const DWORD btcode) const
{
	// Return option
	return (_btqueue & btcode) ? TRUE : FALSE;
}
int COptionTreeItem::GetTotalButtonWidth(void) const
{
  if(_btqueue != _D_BT_NONE)
  {
    if(_btqueue & _D_BT_USER)
      return _D_TREEBT_WIDTH_USER;
    int count=0;
    if(_btqueue & _D_BT_PLUS)
      ++count;
    if(_btqueue & _D_BT_MINUS)
      ++count;
    if(_btqueue & _D_BT_DEFAULT)
      ++count;
    return (count*(_D_TREEBT_WIDTH+2));
  }
  return 0;
}
void COptionTreeItem::SetOption(DWORD dwOption, BOOL bSet)
{
	// Set option
	if (bSet == TRUE)
	{
		m_dwOptions |= dwOption;
	}
	else
	{
		m_dwOptions &= ~dwOption;
	}
}
BOOL COptionTreeItem::IsVisible(void) const
{
 // return (_bVisible == true) ? TRUE : FALSE;
  if(this->m_rcAttribute.bottom < 0 ||
     this->m_rcAttribute.top > this->m_otOption->GetList().GetCurrentClientRect().bottom)
     return FALSE;
  return TRUE;

}


//#UC END# *470AFC61008C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItem::~COptionTreeItem () {
	//#UC START# *470AFC61008C_DESTR_BODY*
	this->DeleteButton(_D_BT_ALL);
	if(_BrushBkRoot.GetSafeHandle() != NULL) {
		_BrushBkRoot.DeleteObject();
	}
	if(_BrushBk.GetSafeHandle() != NULL) {
		_BrushBk.DeleteObject();
	}
	if(_BrushBkLabel.GetSafeHandle() != NULL) {
		_BrushBkLabel.DeleteObject();
	}
	--__InstanceCount;
	// delete the static brushs
	if(__InstanceCount == 0) {
		if(__BrushBTAdd.GetSafeHandle() != NULL) {
			__BrushBTAdd.DeleteObject();
		}
		if(__BrushBTDelete.GetSafeHandle() != NULL) {
			__BrushBTDelete.DeleteObject();
		}
		if(__BrushBTDefault.GetSafeHandle() != NULL) {
			__BrushBTDefault.DeleteObject();
		}
		if(__BrushBTUser.GetSafeHandle() != NULL) {
			__BrushBTUser.DeleteObject();
		}

		if(__BrushBTAddHL.GetSafeHandle() != NULL) {
			__BrushBTAddHL.DeleteObject();
		}

		if(__BrushBTDeleteHL.GetSafeHandle() != NULL) {
			__BrushBTDeleteHL.DeleteObject();
		}

		if(__BrushBTDefaultHL.GetSafeHandle() != NULL) {
			__BrushBTDefaultHL.DeleteObject();
		}
		
		if(__BrushBTUserHL.GetSafeHandle() != NULL) {
			__BrushBTUserHL.DeleteObject();
		}

		if(__BrushFrame.GetSafeHandle() != NULL) {
			__BrushFrame.DeleteObject();
		}
	}
	//#UC END# *470AFC61008C_DESTR_BODY*
}


} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

