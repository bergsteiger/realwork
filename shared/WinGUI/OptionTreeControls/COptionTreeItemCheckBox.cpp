////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemCheckBox.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemCheckBox
//
// чек-бокс
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemCheckBox.h"

//#UC START# *470B00C00138_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B00C00138_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B00C00138*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemCheckBox

COptionTreeItemCheckBox::COptionTreeItemCheckBox()
{
	// Initialize variables
	m_bFocus = FALSE;
	m_rcCheck = CRect(0, 0, 0, 0);

	// Set item type
	SetItemType(OT_ITEM_CHECKBOX);
}


/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemCheckBox message handlers

void COptionTreeItemCheckBox::DrawAttribute(CDC *pDC, const RECT &rcRect)
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

	// Declare variables
	HGDIOBJ hOld;
	COLORREF crOld;
	int nOldBack;
	CRect rcText, rcCheck;
	CString strText;
	COLORREF crOldBack;

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

	// Draw check box
  if (COptionTreeCheckButton::GetOption(OT_CHECKBOX_SHOWCHECK) == TRUE)
	{
		// -- Get rectangle
		rcCheck.left  = rcRect.left;
		rcCheck.right = rcCheck.left + (long) OT_CHECKBOX_SIZE;
		rcCheck.top = rcRect.top + ATTRIB_OFFSET - 2;
		rcCheck.bottom = rcCheck.top + (long) OT_CHECKBOX_SIZE;
		
		// -- Draw check
		if (GetCheck() == TRUE)
		{
			pDC->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTONCHECK | DFCS_CHECKED);
		}
		else
		{
			pDC->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_FLAT | DFCS_BUTTONCHECK);
		}
	}

	// Draw text
	if (COptionTreeCheckButton::GetOption(OT_CHECKBOX_SHOWTEXT) == TRUE)
	{
		// -- Get text
		if (GetCheck() == TRUE)
		{
			strText = GetCheckedText();
		}
		else
		{
			strText = GetUnCheckedText();
		}

		// -- Get rectangle
    if (COptionTreeCheckButton::GetOption(OT_CHECKBOX_SHOWCHECK) == TRUE)
		{
			rcText.left  = rcCheck.right + ATTRIB_OFFSET;
			rcText.right = rcRect.right;
			rcText.top = rcRect.top;
			rcText.bottom = rcRect.bottom;
		}
		else
		{
			rcText  = rcRect;
		}

		// -- Draw text
		pDC->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);
	}

	// Restore GDI ojects
	pDC->SelectObject(hOld);
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SetBkColor(crOldBack);
}

void COptionTreeItemCheckBox::OnCommit()
{
	// Hide edit control
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
}

void COptionTreeItemCheckBox::OnRefresh()
{
	// Set the window positiion
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}
}

void COptionTreeItemCheckBox::OnMove()
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

void COptionTreeItemCheckBox::OnActivate()
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

void COptionTreeItemCheckBox::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_bFocus = TRUE;	
	
	COptionTreeCheckButton::OnSetFocus(pOldWnd);	
}

void COptionTreeItemCheckBox::OnKillFocus(CWnd* pNewWnd) 
{	
	// Validate
	if (m_otOption == NULL)
	{
		COptionTreeCheckButton::OnKillFocus(pNewWnd);
		return;
	}

	// See if new window is tree of list
	if (m_otOption->IsChild(pNewWnd) == TRUE)
	{
		// -- Mark focus
		m_bFocus = FALSE;

		// -- Commit changes
		//CommitChanges();
	}

	COptionTreeCheckButton::OnKillFocus(pNewWnd);	
}


void COptionTreeItemCheckBox::CleanDestroyWindow()
{
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
}


BOOL COptionTreeItemCheckBox::CreateCheckBoxItem(BOOL bChecked, DWORD dwOptions)
{
	// Declare variables
	DWORD dwStyle = WS_CHILD | WS_VISIBLE | WS_CLIPSIBLINGS | WS_CLIPCHILDREN;
	BOOL bRet = FALSE;

	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Create edit control
	if (!IsWindow(GetSafeHwnd()))
	{
		// -- Create the edit view
		bRet = Create(AfxRegisterWndClass(CS_HREDRAW | CS_VREDRAW, ::LoadCursor(NULL, IDC_ARROW)), _T(""), dwStyle, m_rcAttribute, m_otOption->GetCtrlParent(), GetCtrlID());

		// -- Setup window
		if (bRet == TRUE)
		{
			// -- -- Set font
			SetFont(m_otOption->GetNormalFont(), TRUE);

			// -- -- Save options
      COptionTreeCheckButton::m_dwOptions = dwOptions;

			// -- -- Set check
			SetCheck(bChecked);

			// -- Set check options owner
			SetCheckOptionsOwner(m_otOption);

			// -- -- Set window position
			MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

			// -- -- Hide window
			ShowWindow(SW_HIDE);
		}
	}

	return bRet;
}

void COptionTreeItemCheckBox::OnDeSelect()
{
	// Commit changes
  // ce!
	//CommitChanges(false);
}

void COptionTreeItemCheckBox::OnSelect()
{
	// Commit changes
  // ce!
  //CommitChanges(false);
}
void COptionTreeItemCheckBox::SetCheck(BOOL bCheck,const bool bcommit)
{
  COptionTreeCheckButton::SetCheck(bCheck);
  if(m_bCheck == TRUE)
    m_crText = _CLR_CHECKED;
  else
    m_crText = _CLR_UNCHECKED;
  if(bcommit == true)
    CommitChanges();
}

//#UC END# *470B00C00138*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemCheckBox::~COptionTreeItemCheckBox () {
	//#UC START# *470B00C00138_DESTR_BODY*
	//#UC END# *470B00C00138_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemCheckBox, COptionTreeCheckButton)
	//#UC START# *470B00C00138_MESSAGE_MAP*
	ON_WM_KILLFOCUS()
	ON_WM_SETFOCUS()
	//#UC END# *470B00C00138_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemCheckBox, COptionTreeCheckButton)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

