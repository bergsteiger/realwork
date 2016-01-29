////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemColor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemColor
//
// элемент выбора цвета
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemColor.h"

//#UC START# *470B00F7035B_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B00F7035B_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B00F7035B*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemColor

COptionTreeItemColor::COptionTreeItemColor()
{
	// Initialize variables
	m_bFocus = FALSE;
	m_crColor = RGB(0, 0, 0);
  m_crColorOrigin = RGB(0, 0, 0);
	m_crAutomatic = RGB(0, 0, 0);
	m_dwOptions = NULL;
  _changed = 0;
	// Set item type
	SetItemType(OT_ITEM_COLOR);
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemColor message handlers

void COptionTreeItemColor::OnKillFocus(CWnd* pNewWnd) 
{
	// Mark focus
	m_bFocus = FALSE;

	// Commit changes
	CommitChanges(_changed > 0 ? true : false);

	CWnd::OnKillFocus(pNewWnd);	
}

void COptionTreeItemColor::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_bFocus = TRUE;		
	
	CWnd::OnSetFocus(pOldWnd);	
}

void COptionTreeItemColor::DrawAttribute(CDC *pDC, const RECT &rcRect)
{
	// If we don't have focus, text is drawn.
	if (m_bFocus == TRUE)
	{
		return;
	}

	// Make sure options aren't NULL
	if (m_otOption == NULL)
	{
		return;
	}

	// Make sure there is a window
	if (!IsWindow(GetSafeHwnd()))
	{
		return;
	}

	// Set window position
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}

	// Draw control
	DrawControl(pDC, rcRect);
}

void COptionTreeItemColor::OnCommit()
{
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemColor::OnRefresh()
{
	// Set the window positiion
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}
}

void COptionTreeItemColor::OnMove()
{
	// Set window position
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
  }


	// Hide window
	if (m_bFocus == FALSE && IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemColor::OnActivate()
{
	// Make sure window is valid
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_SHOW);

		// -- Set window position
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

		// -- Set focus
		SetFocus();
	}
}

void COptionTreeItemColor::CleanDestroyWindow()
{
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
}

void COptionTreeItemColor::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// Get cursor position
  CURSORINFO ci;
  ci.cbSize = sizeof(CURSORINFO) ;
  BOOL bres = GetCursorInfo(&ci);


	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
	m_crColorOrigin=m_crColor;
	// Show color popup

	//беспокоится об удалении окна не нужно - оно само себя удалит
	new COptionTreeColorPopUp(ci.ptScreenPos, m_crColor, m_crAutomatic, this, OT_COLOR_AUTOMATIC, OT_COLOR_MORECOLORS);

	// Update items
	if (m_otOption != NULL)
	{
		m_otOption->UpdatedItems();
	}
	
	CWnd::OnLButtonUp(nFlags, point);
}

COLORREF COptionTreeItemColor::GetColor()
{
	// Return variable
	return m_crColor;
}

void COptionTreeItemColor::SetColor(COLORREF crColor)
{
	// Save variable
	m_crColor = crColor;
}

BOOL COptionTreeItemColor::CreateColorItem(DWORD dwOptions, COLORREF rcColor, COLORREF rcAutomatic)
{
	// Declare variables
	DWORD dwStyle = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
	BOOL bRet = FALSE;

	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Create window
	if (!IsWindow(GetSafeHwnd()))
	{
		// -- Create the edit view
		bRet = Create(AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW, ::LoadCursor(NULL, IDC_ARROW)), _T(""), dwStyle, m_rcAttribute, m_otOption->GetCtrlParent(), GetCtrlID());

		// -- Setup window
		if (bRet == TRUE)
		{
			// -- -- Set font
			SetFont(m_otOption->GetNormalFont(), TRUE);

			// -- -- Set color
			SetColor(rcColor);

			// -- -- Set automatic color
			SetAutomaticColor(rcAutomatic);

			// -- -- Save options
			m_dwOptions = dwOptions;

			// -- -- Set window position
			MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

			// -- -- Hide window
			ShowWindow(SW_HIDE);
		}
	}

	return bRet;
}

long COptionTreeItemColor::OnSelEndOK(UINT lParam, long wParam)
{
	// Get color	
	COLORREF clrnew = (COLORREF)lParam;

  if(clrnew != m_crColorOrigin)
  {
    this->SetChanged(1);
    m_crColorOrigin = clrnew;
    // must set non liveupdates
    m_crColor=m_crColorOrigin;
  }

	// Commit changes
  CommitChanges(_changed > 0 ? true : false);

	// Update items
	if (m_otOption != NULL)
	{
		m_otOption->UpdatedItems();
	}

    return TRUE;
}

long COptionTreeItemColor::OnSelEndCancel(UINT lParam, long wParam)
{
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}

	// Update items
	if (m_otOption != NULL)
	{
		m_otOption->UpdatedItems();
	}

  // live updated colors are taken always;
  // so we have to commit
  if(GetOption(OT_COLOR_LIVEUPDATE) == TRUE )
    CommitChanges(_changed > 0 ? true : false);
  return TRUE;
}

long COptionTreeItemColor::OnCloseColorPopUp(UINT lParam, long wParam)
{
	// Get color	
	m_crColor = (COLORREF)lParam;

	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}

	// Update items
	if (m_otOption != NULL)
	{
		m_otOption->UpdatedItems();
	}

    return TRUE;
}

long COptionTreeItemColor::OnSelChange(UINT lParam, long wParam)
{
	// Get color
	if (GetOption(OT_COLOR_LIVEUPDATE) == TRUE)
	{
		m_crColor = (COLORREF)lParam;
	}

	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}

	// Update items
	if (m_otOption != NULL)
	{
		m_otOption->UpdatedItems();
	}

    return TRUE;
}

void COptionTreeItemColor::OnDeSelect()
{
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemColor::OnSelect()
{
}

BOOL COptionTreeItemColor::OnEraseBkgnd(CDC* pDC) 
{
	// Naa, we like flicker free better
	return FALSE;
}

void COptionTreeItemColor::OnPaint() 
{
	// Check focus
	if (m_bFocus == FALSE)
	{
		return;
	}

	// Declare variables
	CPaintDC dc(this);
	CRect rcClient;

	// Get client rect
	GetClientRect(rcClient);

	// Draw control
	DrawControl(&dc, rcClient);
}

void COptionTreeItemColor::SetAutomaticColor(COLORREF crAutomatic)
{
	// Save variable
	m_crAutomatic = crAutomatic;
}

COLORREF COptionTreeItemColor::GetAutomaticColor()
{
	// Return variable
	return m_crAutomatic;
}

void COptionTreeItemColor::DrawControl(CDC *pDC, const RECT &rcRect)
{
	if (m_crColor == OT_COLOR_NO_SELECTION) {
		return;
	}
	// Declare variables
	HGDIOBJ hOld;
	HGDIOBJ hOldBrush;
	COLORREF crOld;
	int nOldBack;
	CRect rcText, rcColor, rcClient;
	CString strText;
	CBrush bBrush;
	COLORREF crOldBack;

	// Get window rect
	GetClientRect(rcClient);

	// Select font
	hOld = pDC->SelectObject(m_otOption->GetNormalFont());

	// Create bush
	bBrush.CreateSolidBrush(m_crColor);
	
	// Set text color
	if (IsReadOnly() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
	{
		crOld = pDC->SetTextColor(GetSysColor(COLOR_GRAYTEXT));
	}
	else
	{
		crOld = pDC->SetTextColor(GetTextColor());
	}

	// Set background color
	crOldBack = pDC->SetBkColor(GetBackgroundColor());	

	// Set background mode
	nOldBack = pDC->SetBkMode(TRANSPARENT);

	// Select brush
	hOldBrush = pDC->SelectObject(GetSysColorBrush(COLOR_BTNSHADOW));

	// Get color rectangle
	rcColor.left  = rcRect.left + 1;
	rcColor.right = rcColor.left + (long) OT_COLOR_SIZE;
	rcColor.top = rcRect.top + ATTRIB_OFFSET - 2;
	rcColor.bottom = rcColor.top + (long) OT_COLOR_SIZE;

	// Draw color border
	rcColor.InflateRect(1, 1, 1, 1);
	pDC->PatBlt(rcColor.left, rcColor.top, rcColor.Width(), rcColor.Height(), PATCOPY);

	// Draw color
	rcColor.DeflateRect(1, 1, 1, 1);
	pDC->FillRect(rcColor, &bBrush);

	// Get text rectangle
	rcText.left  = rcColor.right + ATTRIB_OFFSET;
	rcText.right = rcRect.right;
	rcText.top = rcRect.top;
	rcText.bottom = rcRect.bottom;

	// Get text
	if (GetOption(OT_COLOR_SHOWHEX) == TRUE)
	{
		strText.Format("#%.6X", m_crColor);
	}
	else
	{
		strText.Format("RGB (%d, %d, %d)", GetRValue(m_crColor), GetGValue(m_crColor), GetBValue(m_crColor));
	}

	// Draw text
	pDC->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);
	pDC->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER | DT_CALCRECT);
	
	// Delete brush
	if (bBrush.GetSafeHandle() != NULL)
	{
		bBrush.DeleteObject();
	}

	// Restore GDI ojects
	pDC->SelectObject(hOldBrush);
	pDC->SelectObject(hOld);
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SetBkColor(crOldBack);
}
//#UC END# *470B00F7035B*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemColor::~COptionTreeItemColor () {
	//#UC START# *470B00F7035B_DESTR_BODY*
	//#UC END# *470B00F7035B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemColor, CWnd)
	//#UC START# *470B00F7035B_MESSAGE_MAP*
	ON_WM_KILLFOCUS()
	ON_WM_SETFOCUS()
	ON_WM_LBUTTONUP()
	ON_WM_ERASEBKGND()
	ON_WM_PAINT()
    ON_MESSAGE(OT_COLOR_SELENDOK, OnSelEndOK)
    ON_MESSAGE(OT_COLOR_SELENDCANCEL, OnSelEndCancel)
    ON_MESSAGE(OT_COLOR_SELCHANGE, OnSelChange)
	ON_MESSAGE(OT_COLOR_CLOSEUP, OnCloseColorPopUp)
	//#UC END# *470B00F7035B_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemColor, CWnd)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

