////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemSpinner.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemSpinner
//
// spinner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemSpinner.h"

//#UC START# *470B0CA60271_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B0CA60271_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B0CA60271*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemSpinner

COptionTreeItemSpinner::COptionTreeItemSpinner()
{
	// Initialize variables
	m_bFocus = FALSE;

	// Set item type
	SetItemType(OT_ITEM_SPINNER);

}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemSpinner message handlers

void COptionTreeItemSpinner::OnKillFocus(CWnd* pNewWnd) 
{
	// Validate
	if (m_otOption == NULL)
	{
		COptionTreeSpinnerButton::OnKillFocus(pNewWnd);
		return;
	}

	// See if new window is tree of list
	if (m_otOption->IsChild(pNewWnd) == FALSE)
	{
		COptionTreeSpinnerButton::OnKillFocus(pNewWnd);
		return;
	}

	// If new focus is edit, we really aren't loosing focus
	if (pNewWnd->GetSafeHwnd() != GetEdit()->GetSafeHwnd())
	{
		// Mark focus
		m_bFocus = FALSE;

		// Commit changes
    CommitChanges(_changed > 0 ? true : false);
	}
	
	COptionTreeSpinnerButton::OnKillFocus(pNewWnd);	
}

void COptionTreeItemSpinner::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_bFocus = TRUE;

	COptionTreeSpinnerButton::OnSetFocus(pOldWnd);	
}

void COptionTreeItemSpinner::OnActivate()
{
	// Make sure window is valid
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_SHOW);

		// -- Set window position
		SetWindowPos(NULL, m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height(), SWP_NOZORDER | SWP_SHOWWINDOW);

		// -- Set focus
		SetFocus();
	}
}

void COptionTreeItemSpinner::DrawAttribute(CDC *pDC, const RECT &rcRect)
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
		SetWindowPos(NULL, m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height(), SWP_NOZORDER | SWP_NOACTIVATE | SWP_HIDEWINDOW);
	}

	// Declare variables
	HGDIOBJ hOld;
	COLORREF crOld;
	int nOldBack;
	CRect rcText;
	CString strText;
	COLORREF crOldBack;

	// Get window text
	strText = GetEditText();

	// Select font
	hOld = pDC->SelectObject(m_otOption->GetNormalFont());
	
	// Set text color
	if (IsReadOnly() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
	{
		crOld = pDC->SetTextColor(GetSysColor(COLOR_GRAYTEXT));
	}
	else
	{
		crOld = pDC->SetTextColor(GetTextColor());
	}

	// Set background mode
	nOldBack = pDC->SetBkMode(TRANSPARENT);

	// Set background color
	crOldBack = pDC->SetBkColor(GetBackgroundColor());

	// Get rectangle
	rcText = rcRect;

	// Draw text
	pDC->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);

	// Restore GDI ojects
	pDC->SelectObject(hOld);
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SetBkColor(crOldBack);
}

void COptionTreeItemSpinner::OnCommit()
{
	// Hide edit control
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemSpinner::OnRefresh()
{
	// Set the window positiion
	if (IsWindow(GetSafeHwnd()))
	{
		SetWindowPos(NULL, m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height(), SWP_NOZORDER | SWP_NOACTIVATE);
	}
}

void COptionTreeItemSpinner::OnMove()
{
	// Set window position
	if (IsWindow(GetSafeHwnd()))
	{
		SetWindowPos(NULL, m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height(), SWP_NOZORDER | SWP_NOACTIVATE);
	}

	// Hide window
	if (m_bFocus == FALSE && IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemSpinner::CleanDestroyWindow()
{
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
}


BOOL COptionTreeItemSpinner::CreateSpinnerItem(DWORD dwOptions, double dValue, double dRangeBottom, double dRangeTop)
{
	// Declare variables
	DWORD dwStyle = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
	BOOL bRet = FALSE;
	CString strText;

	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Create edit control
	if (IsWindow(GetSafeHwnd()) == FALSE)
	{
		// -- Create the edit view
		bRet = Create(AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW, ::LoadCursor(NULL, IDC_ARROW)), _T(""), dwStyle, m_rcAttribute, m_otOption->GetCtrlParent(), GetCtrlID());

		// -- Setup window
		if (bRet == TRUE)
		{
			// -- -- Save options
      COptionTreeSpinnerButton::m_dwOptions = dwOptions;

			// -- -- Set range
			SetRange(dRangeBottom, dRangeTop);

			// -- -- Set value
			SetEditDouble(dValue);

			// -- -- Set options owner
			SetSpinnerOptionsOwner(m_otOption);

			// -- -- Set font
			SetFont(m_otOption->GetNormalFont(), TRUE);
			
			// -- -- Set window position
			SetWindowPos(NULL, m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height(), SWP_NOZORDER | SWP_SHOWWINDOW);

			// -- -- Hide window
			ShowWindow(SW_HIDE);

		}
	}

	return bRet;
}

LRESULT COptionTreeItemSpinner::WM_CommitChanges(WPARAM wParam, LPARAM lParam)
{
	// Mark focus
	m_bFocus = FALSE;

	// Commit changes
  CommitChanges(_changed > 0 ? true : false);
	return 0;
}
LRESULT COptionTreeItemSpinner::WM_TextChanged(WPARAM wParam, LPARAM lParam)
{
  SetChanged((int) wParam);

	return 0;
}


void COptionTreeItemSpinner::OnDeSelect()
{
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemSpinner::OnSelect()
{
	// Do nothing here
}

//#UC END# *470B0CA60271*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemSpinner::~COptionTreeItemSpinner () {
	//#UC START# *470B0CA60271_DESTR_BODY*
	//#UC END# *470B0CA60271_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemSpinner, COptionTreeSpinnerButton)
	//#UC START# *470B0CA60271_MESSAGE_MAP*
	ON_WM_KILLFOCUS()
	ON_WM_SETFOCUS()
	ON_MESSAGE(OT_NOTIFY_COMMITCHANGES, WM_CommitChanges)
	ON_MESSAGE(OT_TEXTCHANGED, WM_TextChanged)
	//#UC END# *470B0CA60271_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemSpinner, COptionTreeSpinnerButton)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

