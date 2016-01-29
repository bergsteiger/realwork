////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeList
//
// list
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeList.h"

//#UC START# *470B05D5032C_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
// Added Headers
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
#include "shared/WinGUI/OptionTreeControls/OptionTreeRes.h"

#include "shared/WinGUI/OptionTreeControls/CPreciseTimer.h"


//#UC END# *470B05D5032C_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B05D5032C*
static HBITMAP __hbm=NULL;
static HBRUSH  __hbr=NULL;
// -- Draw splitter bar selected
static void _DrawXorBar(HDC hdc, int x1, int y1, int nWidth, int nHeight)
{
	// Declare variables
	static WORD _dotPatternBmp[8] = { 0x00aa, 0x0055, 0x00aa, 0x0055, 0x00aa, 0x0055, 0x00aa, 0x0055};

	// Create a monochrome checkered pattern
  if(__hbm == NULL)
	  __hbm = CreateBitmap(8, 8, 1, 1, _dotPatternBmp);
  if(__hbr == NULL)
	  __hbr = CreatePatternBrush(__hbm);
    
	SetBrushOrgEx(hdc, x1, y1, 0);
	HBRUSH hbrushOld = (HBRUSH)SelectObject(hdc, __hbr);
    
	// Draw the checkered rectangle to the screen
	PatBlt(hdc, x1, y1, nWidth, nHeight, PATINVERT);
    
	SelectObject(hdc, hbrushOld);
    
	//DeleteObject(hbr);
	//DeleteObject(hbm);
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeList

COptionTreeList::COptionTreeList()
: _CurrentClientRect (0, 0, 0, 0)
{
	// Initialize variables
	m_lPrevCol = 0;
	m_bColDrag = FALSE;
	m_hSplitter = NULL;
	m_hHand = NULL;
  _hDrag = NULL;
	m_lColumn = -1;
  _iDrag=0;
  _pDragItem=NULL;
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeList message handlers

BOOL COptionTreeList::Create(DWORD dwStyle, RECT rcRect, CWnd* pParentWnd, UINT nID)
{
	
	// Load cursors
	// -- Splitter
	if (m_hSplitter == NULL)
	{
		//m_hSplitter = ::LoadCursor(AfxGetInstanceHandle(), MAKEINTRESOURCE(IDC_SIZE));
		m_hSplitter = ::LoadCursor(NULL, IDC_SIZEWE);
	}
  
	// -- Get Hand Cursor
	GetHandCursor();
  //_hDrag = m_hHand;

	// -- Drag
	if (_hDrag == NULL)
	{
		//_hDrag = ::LoadCursor(AfxGetInstanceHandle(), MAKEINTRESOURCE(IDC_HAND));
		_hDrag = ::LoadCursor(NULL, IDC_HAND);
	}
 
	// Add style
	dwStyle |= WS_CLIPSIBLINGS | WS_CLIPCHILDREN;

	// Create the window
	return CWnd::Create(AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS, ::LoadCursor(NULL, IDC_ARROW)), _T(""), dwStyle, rcRect, pParentWnd, nID);
}

void COptionTreeList::OnSize(UINT nType, int cx, int cy) 
{
	CWnd::OnSize(nType, cx, cy);	
  // Make sure we have an option tree
	if (m_otOption != NULL)
	{
    m_otOption->LockAll();
		// -- Update resize
		UpdateResize();

		// -- Inform all items that a resize has been made
		m_otOption->UpdateMoveAllItems();

    m_otOption->UnLockAll();
    /*
		// -- Redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
    */
	}
}

void COptionTreeList::UpdateResize()
{
	// Make sure not NULL
	if (m_otOption == NULL || m_otOption->UpdateLocked() == TRUE)
	{
		return;
	}

  // Declare variables
	SCROLLINFO si;
	int nHeight;
	long lHeight = 0;
	CRect rcClient;
	COptionTreeItem *otiRoot, *otiItem;

	// Get client rectangle
	GetClientRect(rcClient);
// GARANT {
	nHeight = rcClient.Height();
// } GARANT

	// Get root item
	otiRoot = m_otOption->GetRootItem();
	if (otiRoot == NULL)
	{
		return;
	}

	// Get total height
	otiItem = otiRoot->GetChild();
	while (otiItem != NULL)
	{
		// -- Get height
// GARANT {
		lHeight	+= otiItem->GetTotalHeight() + 1;
// } GARANT

		// -- Get next item
		otiItem = otiItem->GetSibling();
	}

	// Setup scroll info
	ZeroMemory(&si, sizeof(SCROLLINFO));
	si.cbSize = sizeof(SCROLLINFO);
	si.fMask = SIF_RANGE | SIF_PAGE;
	si.nMin = 0;
	si.nMax = (int) lHeight;
	si.nPage = nHeight;

	// Set scroll info
	if ((int)si.nPage > si.nMax)
	{
		m_otOption->SetOriginOffset(0);
	}
	SetScrollInfo(SB_VERT, &si, TRUE);

	// Set column
	m_otOption->SetColumn(m_otOption->GetColumn());

}

void COptionTreeList::OnPaint() 
{
	// Make sure valid
	if (m_otOption == NULL || m_otOption->UpdateLocked() == TRUE)
	{
		return;
	}
#ifdef _DEBUG
  CPreciseTimer pt;
#endif

	// Declare variables
	CPaintDC dc(this);
	CDC* pDCMem = new CDC;
	CBitmap bpMem;
	CBitmap *bmOld;
	COptionTreeItem* otiItem;
	CRect rcClient;
	HGDIOBJ hOldBrush;
	long lTotal, lHeight;
	HRGN hRgn;

	// Get client rectangle
	GetClientRect(rcClient);

	// Clear visible list
	m_otOption->ClearVisibleList();

	// Clear all label rectangle
	m_otOption->ClearAllLabelRect();

	// Create DC
	pDCMem->CreateCompatibleDC(&dc);

	// Create bitmap
	bpMem.CreateCompatibleBitmap(&dc, rcClient.Width(), rcClient.Height());

	// Select bitmap
	bmOld = pDCMem->SelectObject(&bpMem);

	// Draw control background
	hOldBrush = pDCMem->SelectObject(GetSysColorBrush(COLOR_BTNFACE));
	pDCMem->PatBlt(rcClient.left, rcClient.top, rcClient.Width(), rcClient.Height(), PATCOPY);

	// Draw control inside fill color
	rcClient.DeflateRect(2, 2);
	if (m_otOption->IsWindowEnabled() == TRUE)
	{
		pDCMem->SelectObject(GetSysColorBrush(COLOR_WINDOW));
	}
	else
	{
		pDCMem->SelectObject(GetSysColorBrush(COLOR_3DFACE));
	}
	pDCMem->PatBlt(rcClient.left, rcClient.top, rcClient.Width(), rcClient.Height(), PATCOPY);
	rcClient.InflateRect(2, 2);

	// Draw expand column	
	if (m_otOption->GetShadeExpandColumn() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
	{
		pDCMem->SelectObject(GetSysColorBrush(COLOR_BTNFACE));
	}
	else
	{
		pDCMem->SelectObject(GetSysColorBrush(COLOR_WINDOW));
	}
	pDCMem->PatBlt(0, 0, OT_EXPANDCOLUMN, rcClient.Height(), PATCOPY);

	// Create clip region
	hRgn = CreateRectRgn(rcClient.left, rcClient.top, rcClient.right, rcClient.bottom);
	SelectClipRgn(pDCMem->m_hDC, hRgn);

  CRect recLargest=m_otOption->GetLargestVisibleLabel(false);
  m_otOption->ResetLargestVisibleLabel();
	// Draw all items
	lTotal = 0;
	for (otiItem = m_otOption->GetRootItem()->GetChild(); otiItem != NULL; otiItem = otiItem->GetSibling())
	{
		lHeight = otiItem->DrawItem(pDCMem, rcClient, 0, lTotal);
		lTotal += lHeight;
	}
	// Remove clip region
	SelectClipRgn(pDCMem->GetSafeHdc(), NULL);
	DeleteObject(hRgn);

	// Draw vertical sep
	_DrawDarkVLine(pDCMem->GetSafeHdc(), OT_EXPANDCOLUMN, 0, rcClient.bottom);

	// Draw edge
	pDCMem->DrawEdge(&rcClient, BDR_SUNKENOUTER, BF_RECT);

	// Draw draw column
	if (m_bColDrag == TRUE)
	{
		_DrawXorBar(pDCMem->GetSafeHdc(), m_lColumn - OT_COLRNG / 2, 0, 4, rcClient.bottom);
	}

	// Copy back buffer to the display
	dc.BitBlt(0, 0, rcClient.Width(), rcClient.Height(), pDCMem, 0, 0, SRCCOPY);
	
	// Select old objects
	pDCMem->SelectObject(hOldBrush);
	pDCMem->SelectObject(bmOld);
	
	// Delete objects
	if (pDCMem->GetSafeHdc() != NULL)
	{
		pDCMem->DeleteDC();
	}
	delete pDCMem;
	if (bpMem.GetSafeHandle() != NULL)
	{
		bpMem.DeleteObject();
	}

#ifdef _DEBUG
  pt.StopTimer();
  CString sInfoText("");
  m_otOption->m_otInfoInfo.GetWindowText(sInfoText);
  sInfoText += "\r\n";
  sInfoText += "TreeList::OnPaint: ";
  sInfoText += pt.GetDurationString();
  m_otOption->m_otInfoInfo.SetWindowText(sInfoText);
  m_otOption->m_otInfoInfo.SetSel(sInfoText.GetLength()-1,sInfoText.GetLength()-1,TRUE);
#endif

  // the largest largest label changed -> so update column size
  if(recLargest != m_otOption->GetLargestVisibleLabel(false) ||
    recLargest.right != m_otOption->m_ptOrigin.x)
  {
    // not update after UpdateColumnWidth: we dont know how
    // often COptionTreeList::OnPaint will be called.
    m_otOption->UpdateColumnWidth(-1,false);
  }
  
}

BOOL COptionTreeList::OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message) 
{
  /*
	// Hit test
	if (nHitTest == HTCLIENT)
	{
		// -- Declare variables
		CPoint ptPoint;

		// -- Validate option
		if (m_otOption == NULL)
		{
			return CWnd::OnSetCursor(pWnd, nHitTest, message);
		}

		// Get cursor position
		GetCursorPos(&ptPoint);
		ScreenToClient(&ptPoint);

		// -- Run hit test and set cursor
    if(_iDrag == 0)
    {
      switch (m_otOption->HitTest(ptPoint))
		  {
			  case OT_HIT_COLUMN:
				  SetCursor(m_hSplitter);
#ifdef _DEBUG
  afxDump<<"\nOnSetCursor Splitter";
#endif
          return TRUE;

			  case OT_HIT_EXPAND:
				  SetCursor(m_hHand);
#ifdef _DEBUG
  afxDump<<"\nOnSetCursor Hand";
#endif
				  return TRUE;
		  }
    }
    else
    {
      //SetCursor(_hDrag);
      //return TRUE;
    }
	}
#ifdef _DEBUG
  afxDump<<"\nOnSetCursor Default";
#endif
	*/
	return CWnd::OnSetCursor(pWnd, nHitTest, message);
}

void COptionTreeList::OnLButtonDown(UINT nFlags, CPoint point) 
{
  _iDrag=0;
  _pDragItem=NULL;
	// Validate option
	if (m_otOption == NULL)
	{
		CWnd::OnLButtonDown(nFlags, point);
		return;
	}

	// See if disabled
	if (m_otOption->IsDisableInput() || !m_otOption->IsWindowEnabled())
	{
		CWnd::OnLButtonDown(nFlags, point);
		return;
	}

	// Send notify to user
	m_otOption->SendNotify(NM_CLICK);

	// Declare variables
	long lHit;
	COptionTreeItem *otiItem;
	COptionTreeItem *oliOldFocus;
	CRect rcClient;

	// Get client rectangle
	GetClientRect(rcClient);

	// Set focus to window
	SetFocus();

	// Hit test
	lHit = m_otOption->HitTest(point);
	switch (lHit)
	{
		case OT_HIT_COLUMN:
			
			if (m_otOption->SendNotify(OT_NOTIFY_COLUMNCLICK) || m_otOption->GetAutoSizeColumn() == true)
			{
				break;
			}

			// -- Set capture
			m_bColDrag = TRUE;
			SetCapture();

			m_lColumn = m_otOption->GetOrigin().x;

			// -- Force redraw
			Invalidate();

			// -- Update window
			UpdateWindow();

			break;
		case OT_HIT_EXPAND:

			if ((otiItem = m_otOption->FindItem(point)) != NULL)
			{
				if (otiItem->GetChild() && !m_otOption->SendNotify(OT_NOTIFY_ITEMEXPANDING, otiItem))
				{
          m_otOption->LockAll();
          // -- Expand
					otiItem->Expand(!otiItem->IsExpanded());
          // -- Update resize
					UpdateResize();
          m_otOption->UnLockAll();
					// -- Check visible
					CheckVisibleFocus();
				}
			}
			break;
    // ce
    // item
    case OT_HIT_LABEL:
      
      _pDragItem = m_otOption->FindItem(point);
      // begin dragging
      if( _pDragItem != NULL && 
          _pDragItem->GetParent() != NULL &&
          _pDragItem->GetParent()->GetAllowChildDrag() == true &&
          _pDragItem->Point2ButtonCode(point) == _D_BT_NONE)
      {
        _iDrag=1;
      }
      else
        _pDragItem=NULL;        
      // let the default work being done also
		default:

			if ((otiItem = m_otOption->FindItem(point)) != NULL)
			{
				// -- Get old focus
				oliOldFocus = m_otOption->GetFocusedItem();

				// -- Select items
				m_otOption->SelectItems(NULL, FALSE);

				// -- Select
				otiItem->Select();

				// -- Make sure new item
				if (otiItem != oliOldFocus)
				{
					m_otOption->SendNotify(OT_NOTIFY_SELCHANGE, otiItem);
				}

				// -- Send notify
				if (lHit == OT_HIT_ATTRIBUTE && !otiItem->IsRootLevel())
				{
					if (!m_otOption->SendNotify(OT_NOTIFY_PROPCLICK, otiItem) && !otiItem->IsReadOnly())
					{
						otiItem->Activate();
					}
				}

				// -- Set focus item
				m_otOption->SetFocusedItem(otiItem);

				// -- Force redraw
				Invalidate();

				// -- Update window
				UpdateWindow();

			}
			else
			{
				// -- Select items
				m_otOption->SelectItems(NULL, FALSE);

				// -- Set focus item
				m_otOption->SetFocusedItem(NULL);

				// -- Send notify
				m_otOption->SendNotify(OT_NOTIFY_SELCHANGE);

				// -- Force redraw
				Invalidate();

				// -- Update window
				UpdateWindow();
			}
			break;
	}
 
	CWnd::OnLButtonDown(nFlags, point);
}

void COptionTreeList::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// See if disabled
	if (m_otOption->IsDisableInput() || !m_otOption->IsWindowEnabled())
	{
		CWnd::OnLButtonUp(nFlags, point);
		return;
	}

	// Draw column
	if (m_bColDrag == TRUE)
	{
		// -- Declare variables
		CRect rcClient;

		// -- Get client rectangle
		GetClientRect(rcClient);

		// -- Release capture
		m_bColDrag = FALSE;

		// -- Release capture
		ReleaseCapture();

		// -- Resize limit
		// -- -- Left
		if (point.x < (OT_EXPANDCOLUMN + OT_RESIZEBUFFER))
		{
			// -- -- -- Set column
			m_otOption->SetColumn(OT_EXPANDCOLUMN + OT_RESIZEBUFFER);
		}
		// -- -- Right
		else if (point.x > (rcClient.BottomRight().x - OT_RESIZEBUFFER))
		{
			// -- -- -- Set column
			m_otOption->SetColumn(rcClient.BottomRight().x - OT_RESIZEBUFFER);
		}
		else
		{
			// -- -- -- Set column
			m_otOption->SetColumn(point.x);
		}

		// -- Update move items
		m_otOption->UpdateMoveAllItems();

		// -- Force redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
	}
  // ce
  else
  {
	  long lHit = m_otOption->HitTest(point);
	  switch (lHit)
	  {
      case OT_HIT_LABEL:
        {
          COptionTreeItem* pItemUnder = m_otOption->FindItem(point);
          // terminate dragging
          if(_pDragItem != NULL && pItemUnder != NULL)
          {
            if( pItemUnder != NULL && 
                _pDragItem != pItemUnder &&
                pItemUnder->GetParent() == _pDragItem->GetParent())
            {
              m_otOption->MoveItem(_pDragItem,pItemUnder);
            }
            else
            {
              ;
            }
            _iDrag=0;
            _pDragItem = NULL;
          } 
          // check for button click
          else if(pItemUnder != NULL && m_otOption != NULL)
          {
            m_otOption->ButtonClicked(pItemUnder,pItemUnder->Point2ButtonCode(point));
          }
        }
        break;
      case OT_HIT_ATTRIBUTE:
        {
          COptionTreeItem* pItemUnder = m_otOption->FindItem(point);
          if(pItemUnder && pItemUnder->IsRootLevel() == TRUE)
          {
            m_otOption->ButtonClicked(pItemUnder,pItemUnder->Point2ButtonCode(point));
          }
        }
        break;
      default:
        break;
    }
  }
	CWnd::OnLButtonUp(nFlags, point);
}

void COptionTreeList::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	// Validate option
	if (m_otOption == NULL)
	{
		CWnd::OnLButtonDblClk(nFlags, point);
		return;
	}

	// See if disabled
	if (m_otOption->IsDisableInput() || !m_otOption->IsWindowEnabled())
	{
		CWnd::OnLButtonDblClk(nFlags, point);
		return;
	}

	// Declare variables
	COptionTreeItem *otiItem;
	COptionTreeItem *oliOldFocus;
	CRect rcClient, rcLabel;

	// Send notify to user
	m_otOption->SendNotify(NM_DBLCLK);

	// Get client rect
	GetClientRect(rcClient);

	// Hit test
	if ((otiItem = m_otOption->FindItem(point)) != NULL && otiItem->GetChild())
	{
		switch (m_otOption->HitTest(point))
		{
			case OT_HIT_COLUMN:

				// -- Get largest visible label
				rcLabel = m_otOption->GetLargestVisibleLabel();

				// -- Resize limit
				// -- -- Right
				if (rcLabel.right + ATTRIB_OFFSET > (rcClient.right - OT_RESIZEBUFFER))
				{
					// -- -- -- Set column
					m_otOption->SetColumn(rcClient.right - OT_RESIZEBUFFER);
				}
				else
				{
					// -- -- -- Set column
					m_otOption->SetColumn(rcLabel.right + ATTRIB_OFFSET);
				}

				// -- Update move items
				m_otOption->UpdateMoveAllItems();

				// -- Force redraw
				Invalidate();

				// -- Update window
				UpdateWindow();

				break;

			case OT_HIT_ATTRIBUTE:

				if (!otiItem->IsRootLevel())
				{
					break;
				}

			default:
				// -- Get focus item
				oliOldFocus = m_otOption->GetFocusedItem();

				// -- Select items
				m_otOption->SelectItems(NULL, FALSE);

				// -- Set focus item
				m_otOption->SetFocusedItem(otiItem);

				// -- Select
				otiItem->Select();
			
				// -- Send notify to user
				if (otiItem != oliOldFocus)
				{
					m_otOption->SendNotify(OT_NOTIFY_SELCHANGE, otiItem);
				}

			case OT_HIT_EXPAND:

				if (!m_otOption->SendNotify(OT_NOTIFY_ITEMEXPANDING, otiItem))
				{
					// -- Expand
					otiItem->Expand(!otiItem->IsExpanded());

					// -- Update resize
					UpdateResize();

					// -- Force redraw
					Invalidate();

					// -- Update window
					UpdateWindow();

					// -- Check visible
					CheckVisibleFocus();
				}
				break;
		}
	}
	else
	{
		switch (m_otOption->HitTest(point))
		{
			case OT_HIT_COLUMN:

				// -- Get largest visible label
				rcLabel = m_otOption->GetLargestVisibleLabel();

				// -- Resize limit
				// -- -- Right
				if (rcLabel.right + ATTRIB_OFFSET > (rcClient.right - OT_RESIZEBUFFER))
				{
					// -- -- -- Set column
					m_otOption->SetColumn(rcClient.right - OT_RESIZEBUFFER);
				}
				else
				{
					// -- -- -- Set column
					m_otOption->SetColumn(rcLabel.right + ATTRIB_OFFSET);
				}

				// -- Update move items
				m_otOption->UpdateMoveAllItems();

				// -- Force redraw
				Invalidate();

				// -- Update window
				UpdateWindow();

				break;
		}
	}

	CWnd::OnLButtonDblClk(nFlags, point);
}

void COptionTreeList::OnMouseMove(UINT nFlags, CPoint point) 
{

  // Make sure option is not NULL
	if (m_otOption == NULL)
	{
		CWnd::OnMouseMove(nFlags, point);
		return;
	}

  if(_iDrag == 1)
    SetCursor(_hDrag);

  // Drag mode
	else if (m_bColDrag == TRUE)
	{
    SetCursor(m_hSplitter);

		// -- Save point
		m_lColumn = point.x;
	
		// -- Force redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
	}
  else
  {
    CPoint ptPoint;
		// Get cursor position
		GetCursorPos(&ptPoint);
		ScreenToClient(&ptPoint);

		// -- Run hit test and set cursor
    switch (m_otOption->HitTest(ptPoint))
		{
			case OT_HIT_COLUMN:
        if(m_otOption->GetAutoSizeColumn() == false)
				SetCursor(m_hSplitter);
        return;
			case OT_HIT_EXPAND:
				SetCursor(m_hHand);
				return;
      // mouse over a button
      /* ce! disabled: performance drawdown due to device context
      case OT_HIT_ATTRIBUTE:
			case OT_HIT_LABEL:
        {
          COptionTreeItem* pItemUnder = m_otOption->FindItem(point);
          if(pItemUnder != NULL && pItemUnder->HighlightFromPoint(point) == TRUE)
          {
				    SetCursor(m_hHand);
            return;
          }
        }
      */
      case OT_HIT_ATTRIBUTE:
			case OT_HIT_LABEL:
        {
          COptionTreeItem* pItemUnder = m_otOption->FindItem(point);
          if(pItemUnder != NULL && pItemUnder->Point2ButtonCode(point) != _D_BT_NONE)
          {
				    SetCursor(m_hHand);
            return;
          }
        }   
    }
  }
	CWnd::OnMouseMove(nFlags, point);
}

BOOL COptionTreeList::OnMouseWheel(UINT nFlags, short zDelta, CPoint pt) 
{
	// Declare variables
	SCROLLINFO si;
	CRect rcClient;

	// Setup scrollbar info
	ZeroMemory(&si, sizeof(SCROLLINFO));
	si.cbSize = sizeof(SCROLLINFO);
	si.fMask = SIF_RANGE;

	// Get scrollbar info
	GetScrollInfo(SB_VERT, &si);

	// Get client rectnagle
	GetClientRect(rcClient);

	// Validate
	if (si.nMax - si.nMin < rcClient.Height())
	{
		return TRUE;
	}

	// Set focus
	SetFocus();

	// Vertical scroll
	OnVScroll(zDelta < 0 ? SB_LINEDOWN : SB_LINEUP, 0, NULL);
	
	return TRUE;
	//return CWnd::OnMouseWheel(nFlags, zDelta, pt);
}

void COptionTreeList::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	// Declare variables
	COptionTreeItem* otiItem;
	CRect rcClient;

	// Get client rectangle
	GetClientRect(rcClient);

	// Validate option
	if (m_otOption == NULL)
	{
		CWnd::OnKeyDown(nChar, nRepCnt, nFlags);
		return;
	}

	// See if disabled
	if (m_otOption->IsDisableInput() || !m_otOption->IsWindowEnabled())
	{
		CWnd::OnKeyDown(nChar, nRepCnt, nFlags);
		return;
	}

	switch (nChar)
	{
		case VK_TAB:

			// -- Shift
			if (GetKeyState(VK_SHIFT) < 0)
			{
				// -- -- Focus next
				otiItem = m_otOption->GetFocusedItem();
				if (otiItem != NULL && !otiItem->IsRootLevel())
				{
					m_otOption->FocusPrev();
				}

				// -- -- Activate
				otiItem = m_otOption->GetFocusedItem();
				if (otiItem != NULL && !otiItem->IsRootLevel() && !otiItem->IsReadOnly())
				{
					otiItem->Activate();
				}

				Invalidate();

				UpdateWindow();
			}
			// -- No shift
			else
			{
				// -- -- Focus next
				otiItem = m_otOption->GetFocusedItem();
				if (otiItem != NULL && !otiItem->IsRootLevel())
				{
					m_otOption->FocusNext();
				}

				// -- -- Activate
				otiItem = m_otOption->GetFocusedItem();
				if (otiItem != NULL && !otiItem->IsRootLevel() && !otiItem->IsReadOnly())
				{
					otiItem->Activate();
				}

				Invalidate();

				UpdateWindow();
			}

			break;

		case VK_RETURN:

			// -- Activate
			otiItem = m_otOption->GetFocusedItem();
			if (otiItem != NULL && !otiItem->IsRootLevel() && !otiItem->IsReadOnly())
			{
				otiItem->Activate();
			}
			break;

		case VK_HOME:

			// -- Focus on first item
			if (m_otOption->FocusFirst())
			{
				Invalidate();

				UpdateWindow();
			}
			break;

		case VK_END:

			// -- Focus on last item
			if (m_otOption->FocusLast())
			{
				Invalidate();
				
				UpdateWindow();
			}
			break;

		case VK_LEFT:

			// -- Get focused item
			otiItem = m_otOption->GetFocusedItem();
			if (otiItem != NULL)
			{
				// -- -- Send notify to user
				if (!m_otOption->SendNotify(OT_NOTIFY_ITEMEXPANDING, otiItem))
				{
					// -- -- -- Validate
					if (otiItem->GetChild() && otiItem->IsExpanded())
					{
						// -- Expand
						otiItem->Expand(FALSE);

						// -- Update resize
						UpdateResize();

						// -- Force redraw
						Invalidate();

						// -- Update window
						UpdateWindow();

						// -- Check visible
						CheckVisibleFocus();

						break;
					}
				}
			}
			else
				break;
			
		case VK_UP:
			
			// -- Move focus up
			if (m_otOption->FocusPrev())
			{
				Invalidate();

				UpdateWindow();
			}
			break;

		case VK_RIGHT:

			// -- Get focused item
			otiItem = m_otOption->GetFocusedItem();
			if (otiItem != NULL)
			{
				// -- -- Send notify to user
				if (!m_otOption->SendNotify(OT_NOTIFY_ITEMEXPANDING, otiItem))
				{
					// -- -- -- Validate
					if (otiItem->GetChild() && !otiItem->IsExpanded())
					{
						// -- -- -- -- Expand
						otiItem->Expand(TRUE);

						// -- -- -- -- Update resize
						UpdateResize();

						// -- -- -- -- Force redraw
						Invalidate();

						// -- -- -- -- Update window
						UpdateWindow();

						// -- -- -- -- Check visible
						CheckVisibleFocus();

						break;
					}
				}
			}
			else
				break;
			
		case VK_DOWN:

			// -- Move focus down
			if (m_otOption->FocusNext())
			{
				Invalidate();

				UpdateWindow();
			}
			break;
	}
	
	CWnd::OnKeyDown(nChar, nRepCnt, nFlags);
}

UINT COptionTreeList::OnGetDlgCode() 
{
	return DLGC_WANTARROWS | DLGC_WANTCHARS | DLGC_WANTALLKEYS;
}
void COptionTreeList::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	// Declare variables
	SCROLLINFO si;
	CRect rcClient;
	long lHeight, lNY;

	// Setup scrollbar information
	ZeroMemory(&si, sizeof(SCROLLINFO));
	si.cbSize = sizeof(SCROLLINFO);
	si.fMask = SIF_RANGE;

	// Get client rectangle
	GetClientRect(rcClient);
	
	// Set focus
	SetFocus();

	// Get height
	lHeight = rcClient.Height() + 1;

	// Get scrollbar information
	GetScrollInfo(SB_VERT, &si);

	// Get origin
	lNY = m_otOption->GetOrigin().y;

	// Switch scrollbar code
	switch (nSBCode)
	{
		case SB_LINEDOWN:
			lNY += OT_DEFHEIGHT;
			break;

		case SB_LINEUP:
			lNY -= OT_DEFHEIGHT;
			break;

		case SB_PAGEDOWN:
			lNY += lHeight;
			break;

		case SB_PAGEUP:
			lNY -= lHeight;
			break;

		case SB_THUMBPOSITION:
		case SB_THUMBTRACK:
      {
        SCROLLINFO vert;
        GetScrollInfo(SB_VERT, &vert, SIF_TRACKPOS);
        lNY = vert.nTrackPos;
      }
			break;

		case SB_ENDSCROLL:
			return;
	}

// GARANT {
	// Calculate
	lNY = __min(__max(lNY, si.nMin), si.nMax - lHeight) + 5;
// } GARANT

	// Set origin
	m_otOption->SetOriginOffset(lNY);

	// Set scrollbar info
	si.fMask = SIF_POS;
	si.nPos = lNY;
	SetScrollInfo(SB_VERT, &si, TRUE);

	// Force to redraw
	Invalidate();

	// Update window
	UpdateWindow();
}
void COptionTreeList::ScrollDirect(UINT nSBCode, UINT nPos) 
{
	// Declare variables
	SCROLLINFO si;
	ZeroMemory(&si, sizeof(SCROLLINFO));
	// Setup scrollbar information
	si.cbSize = sizeof(SCROLLINFO);


  CRect rcClient;
	// Get client rectangle
	GetClientRect(rcClient);
	// Set focus
	SetFocus();

	// Get scrollbar information
	GetScrollInfo(nSBCode, &si);

  // Get height,Pos
  long lHeight = rcClient.Height() + 1, lNY=nPos;

	// Calculate
	lNY = __min(__max(lNY, si.nMin), si.nMax - lHeight);

	// Set origin
	m_otOption->SetOriginOffset(lNY);

	// Set scrollbar info
	si.fMask = SIF_POS;
	si.nPos = lNY;
	SetScrollInfo(nSBCode, &si, TRUE);

	// Force to redraw
	Invalidate();

	// Update window
	UpdateWindow();
}

void COptionTreeList::CheckVisibleFocus()
{
	// Declare variables
	COptionTreeItem *otiItem;	

	// Validate option
	if (m_otOption == NULL)
	{
		return;
	}
	
	// Get focused item
	otiItem = m_otOption->GetFocusedItem();
	if (otiItem == NULL)
	{
		return;
	}

	// See if item is visible
	if (!m_otOption->IsItemVisible(otiItem))
	{
		// -- Single select
		if (m_otOption->IsSingleSelection())
		{
			otiItem->Select(FALSE);
		}

		// -- Set focus
		m_otOption->SetFocusedItem(NULL);

		// -- Send notify to user
		m_otOption->SendNotify(OT_NOTIFY_SELCHANGE, NULL);

		// -- Force redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
	}
}

void COptionTreeList::SetOptionsOwner(COptionTree *otOption)
{
	// Save pointer
	m_otOption = otOption;
}

BOOL COptionTreeList::OnEraseBkgnd(CDC* pDC) 
{
	// Ha, Ha
	return FALSE;
}

void COptionTreeList::OnKillFocus(CWnd* pNewWnd) 
{
	CWnd::OnKillFocus(pNewWnd);	
}

void COptionTreeList::GetHandCursor()
{
// GARANT {
    m_hHand = ::LoadCursor(NULL, IDC_HAND);
// } GARANT
}

void COptionTreeList::OnSizing(UINT fwSide, LPRECT pRect) 
{
	// Make sure we have an option tree
	if (m_otOption != NULL)
	{
		// -- Update resize
		UpdateResize();

		// -- Inform all items that a resize has been made
		m_otOption->UpdateMoveAllItems();

		// -- Redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
	}

	CWnd::OnSizing(fwSide, pRect);	
}

void COptionTreeList::OnSetFocus(CWnd* pOldWnd) 
{
	// Invalidate
	Invalidate();

	// Update Window
	UpdateWindow();

	CWnd::OnSetFocus(pOldWnd);
}
// hb - added onButton to handle the button in COptionTreeItemEditButton
BOOL COptionTreeList::OnWndMsg( UINT message, WPARAM wParam, LPARAM lParam, LRESULT *pResult )
{
   CWnd::OnWndMsg(message, wParam, lParam, pResult); // call default
   if (message == WM_COMMAND && HIWORD(wParam) == BN_CLICKED)
   {
	   // Send notify to user
      COptionTreeItem *pItem = m_otOption->FindItem(LOWORD(wParam));
	   m_otOption->SendNotify(OT_NOTIFY_EDITBUTTONCLICK, pItem);
      return FALSE;
   }
   return FALSE;
}
BOOL COptionTreeList::PreTranslateMessage(MSG* pMsg) 
{
  return CWnd::PreTranslateMessage(pMsg);
}
//#UC END# *470B05D5032C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeList::~COptionTreeList () {
	//#UC START# *470B05D5032C_DESTR_BODY*
		// Delete objects
	// -- Splitter cursor
	if (m_hSplitter != NULL)
	{
		::DestroyCursor(m_hSplitter);
	}
	// -- Hand cursor
	if (m_hHand != NULL)
	{
		::DestroyCursor(m_hHand);
	}
  // --- Drag cursor 
	if (_hDrag != NULL)
	{
		::DestroyCursor(_hDrag);
	}
	//#UC END# *470B05D5032C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeList, CWnd)
	//#UC START# *470B05D5032C_MESSAGE_MAP*
	ON_WM_SIZE()
	ON_WM_PAINT()
	ON_WM_SETCURSOR()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_MOUSEMOVE()
	ON_WM_MOUSEWHEEL()
	ON_WM_KEYDOWN()
	ON_WM_GETDLGCODE()
	ON_WM_ERASEBKGND()
	ON_WM_KILLFOCUS()
	ON_WM_SIZING()
	ON_WM_VSCROLL()
	ON_WM_SETFOCUS()
	//#UC END# *470B05D5032C_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeList, CWnd)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

