////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemEditButton.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemEditButton
//
// непонятный контрол...
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemEditButton.h"

//#UC START# *470B029301E4_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B029301E4_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B029301E4*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemEditButton

COptionTreeItemEditButton::COptionTreeItemEditButton()
{
	// Initialize variables
	m_bFocus = FALSE;
	m_dwOptions = 0;	

	// Set item type
	SetItemType(OT_ITEM_EDIT);
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemEditButton message handlers

void COptionTreeItemEditButton::OnActivate()
{
  BOOL bres = TRUE;
  if (IsWindow(GetSafeHwnd()) == FALSE)
  {
    bres = this->CreateEditItem(m_dwOptions, _dwExStyleBuffer,_InputMaskBuffer);
    this->SetWindowText(_WindowTextBuffer);
    m_otOption->RefreshItem(this,_D_REFRESH_LABEL);
  }
	// Make sure window is valid
	if (IsWindow(m_ctrlButton.GetSafeHwnd()))
	{
		// -- Show window
		m_ctrlButton.ShowWindow(SW_SHOW);
    m_bActivated = TRUE;

		// -- Set window position of button
		m_ctrlButton.MoveWindow(m_rcAttribute.right-20, m_rcAttribute.top, 20, m_rcAttribute.Height());

   }
	// Make sure window is valid
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_SHOW);
    m_bActivated = TRUE;

		// -- Set selection
		SetSel(0, 0);

		// -- Set window position
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width() - 20, m_rcAttribute.Height());

		// -- Set focus
		SetFocus();
	}
}

UINT COptionTreeItemEditButton::OnGetDlgCode() 
{
	return CEdit::OnGetDlgCode() | DLGC_WANTALLKEYS;
}

void COptionTreeItemEditButton::DrawAttribute(CDC *pDC, const RECT &rcRect)
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
    COLORREF crOld=0;
	  if (IsReadOnly() == TRUE || m_otOption->IsWindowEnabled() == FALSE)
	  {
		  crOld = pDC->SetTextColor(GetSysColor(COLOR_GRAYTEXT));
	  }
	  else
	  {
		  crOld = pDC->SetTextColor(GetTextColor());
	  }

    CFont *pOldFont = pDC->SelectObject(COptionTree::GetNormalFont());
    CRect arect(rcRect);
	  if (GetOption(OT_EDIT_MULTILINE) == FALSE)
	  {
		  pDC->DrawText(_WindowTextBuffer, &arect, DT_SINGLELINE | DT_VCENTER);
		  pDC->DrawText(_WindowTextBuffer, &arect, DT_SINGLELINE | DT_VCENTER | DT_CALCRECT);
    }
    else
    {
      pDC->DrawText(_WindowTextBuffer, &arect, DT_TOP);
		  pDC->DrawText(_WindowTextBuffer, &arect, DT_TOP | DT_CALCRECT);
    }
    pDC->SelectObject(pOldFont);
		return;
	}

	// Set window position
	if (IsWindow(m_ctrlButton.GetSafeHwnd())) 
	{
		// -- Set window position of button
		m_ctrlButton.MoveWindow(m_rcAttribute.right-20, m_rcAttribute.top, 20, m_rcAttribute.Height());
   }
	// Set window position
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Set window position
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width() - 20, m_rcAttribute.Height());
	}

	// Declare variables
	HGDIOBJ hOld;
	COLORREF crOld;
	int nOldBack;
	CRect rcText;
	CString strText, strWindowText;
	COLORREF crOldBack;

	// Get window text
	GetWindowText(strWindowText);

	// Make text
	// -- Password
	if (GetOption(OT_EDIT_PASSWORD) == TRUE)
	{
		strText = "";
		for (int i = 0; i < strWindowText.GetLength(); i++)
		{
			strText += _T("*");
		}
	}
	// -- No password
	else
	{
		strText = strWindowText;
	}

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
	// -- Single line
	if (GetOption(OT_EDIT_MULTILINE) == FALSE)
	{
		pDC->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);
	}
	// -- Mutliline
	else
	{
		pDC->DrawText(strText, rcText, DT_TOP);
	}

	// Restore GDI ojects
	pDC->SelectObject(hOld);
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SetBkColor(crOldBack);
}

void COptionTreeItemEditButton::OnCommit()
{
	// Hide button control
	if (IsWindow(m_ctrlButton.GetSafeHwnd()))
	{
		// -- Show window
		m_ctrlButton.ShowWindow(SW_HIDE);
	}
	// Hide edit control
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
  m_bActivated = FALSE;
}

void COptionTreeItemEditButton::OnRefresh()
{
	// move button
	if (IsWindow(m_ctrlButton.GetSafeHwnd()))
	{
		m_ctrlButton.MoveWindow(m_rcAttribute.right-20, m_rcAttribute.top, 20, m_rcAttribute.Height());
	}
	// Set the window text
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width()-20, m_rcAttribute.Height());
	}
}

void COptionTreeItemEditButton::OnMove()
{
	// move button
	if (IsWindow(m_ctrlButton.GetSafeHwnd()))
	{
		m_ctrlButton.MoveWindow(m_rcAttribute.right-20, m_rcAttribute.top, 20, m_rcAttribute.Height());
	}
	// Set window position
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width()-20, m_rcAttribute.Height());
  }


	// Hide window
	if (m_bFocus == FALSE && IsWindow(GetSafeHwnd()))
	{
		// -- Show window
    m_bActivated = FALSE;
    this->OnShow(FALSE);
	}
}

BOOL COptionTreeItemEditButton::PreTranslateMessage(MSG* pMsg)
{
  return COptionTreeItemEdit::PreTranslateMessage(pMsg);
}

void COptionTreeItemEditButton::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{

	COptionTreeItemEdit::OnKeyDown(nChar, nRepCnt, nFlags);
}

void COptionTreeItemEditButton::OnKillFocus(CWnd* pNewWnd) 
{
   if (pNewWnd == &m_ctrlButton) // hb - if the focus switches to button dont commit changes
   {
		  CEdit::OnKillFocus(pNewWnd);
      return;
   }
	// Validate
	if (m_otOption == NULL)
	{
		CEdit::OnKillFocus(pNewWnd);
		return;
	}

	// See if new window is tree of list
	if (m_otOption->IsChild(pNewWnd) == TRUE)
	{
		// -- Mark focus
		m_bFocus = FALSE;

		// -- Commit changes
		CommitChanges(_changed > 0 ? true : false);
	}
	
	CEdit::OnKillFocus(pNewWnd);	
}

BOOL COptionTreeItemEditButton::IsStringNumeric(CString strString)
{
	// See if string is numeric or not
	if (strString.FindOneOf("1234567890") == -1 || strString.FindOneOf("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~[]{}-_=+\\|'/?>,<") != -1)
	{
		return FALSE;
	}

	return TRUE;
}

BOOL COptionTreeItemEditButton::GetEditFloat(float &fReturn)
{
	// Declare variables
	CString strWindowText;

	// Set blank
	fReturn = 0;

	// Get window text
	if (IsWindow(GetSafeHwnd()))
	{
		GetWindowText(strWindowText);
	}
	else
	{
		return FALSE;
	}

	// First see if we are in numerical mode
	if (GetOption(OT_EDIT_NUMERICAL) == FALSE)
	{
		return FALSE;
	}

	// See if string is numeric
	if (IsStringNumeric(strWindowText) == FALSE)
	{
		return FALSE;
	}

	// Convert string
	fReturn = (float) atof(strWindowText);

	return TRUE;
}

BOOL COptionTreeItemEditButton::GetEditDouble(double &dReturn)
{
	// Declare variables
	CString strWindowText;

	// Set blank
	dReturn = 0;

	// Get window text
	if (IsWindow(GetSafeHwnd()))
	{
		GetWindowText(strWindowText);
	}
	else
	{
		return FALSE;
	}

	// First see if we are in numerical mode
	if (GetOption(OT_EDIT_NUMERICAL) == FALSE)
	{
		return FALSE;
	}

	// See if string is numeric
	if (IsStringNumeric(strWindowText) == FALSE)
	{
		return FALSE;
	}

	// Convert string
	dReturn = atof(strWindowText);

	return TRUE;
}

BOOL COptionTreeItemEditButton::GetEditLong(long &lReturn)
{
	// Declare variables
	CString strWindowText;

	// Set blank
	lReturn = 0;

	// Get window text
	if (IsWindow(GetSafeHwnd()))
	{
		GetWindowText(strWindowText);
	}
	else
	{
		return FALSE;
	}

	// First see if we are in numerical mode
	if (GetOption(OT_EDIT_NUMERICAL) == FALSE)
	{
		return FALSE;
	}

	// See if string is numeric
	if (IsStringNumeric(strWindowText) == FALSE)
	{
		return FALSE;
	}

	// Convert string
	lReturn = atol(strWindowText);

	return TRUE;
}

BOOL COptionTreeItemEditButton::GetEditInt(int &nReturn)
{
	// Declare variables
	CString strWindowText;

	// Set blank
	nReturn = 0;

	// Get window text
	if (IsWindow(GetSafeHwnd()))
	{
		GetWindowText(strWindowText);
	}
	else
	{
		return FALSE;
	}

	// First see if we are in numerical mode
	if (GetOption(OT_EDIT_NUMERICAL) == FALSE)
	{
		return FALSE;
	}

	// See if string is numeric
	if (IsStringNumeric(strWindowText) == FALSE)
	{
		return FALSE;
	}

	// Convert string
	nReturn = atoi(strWindowText);

	return TRUE;
}

BOOL COptionTreeItemEditButton::GetEditDword(DWORD &dwReturn)
{
	// Declare variables
	CString strWindowText;

	// Set blank
	dwReturn = 0;

	// Get window text
	if (IsWindow(GetSafeHwnd()))
	{
		GetWindowText(strWindowText);
	}
	else
	{
		return FALSE;
	}

	// First see if we are in numerical mode
	if (GetOption(OT_EDIT_NUMERICAL) == FALSE)
	{
		return FALSE;
	}

	// See if string is numeric
	if (IsStringNumeric(strWindowText) == FALSE)
	{
		return FALSE;
	}

	// Convert string
	dwReturn = (DWORD) atoi(strWindowText);

	return TRUE;
}

void COptionTreeItemEditButton::CleanDestroyWindow()
{
	// Destroy button
	if (IsWindow(m_ctrlButton.GetSafeHwnd()))
	{
		// -- Destroy window
		m_ctrlButton.DestroyWindow();
	}
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
}

void COptionTreeItemEditButton::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_bFocus = TRUE;
	
	CEdit::OnSetFocus(pOldWnd);	
}

BOOL COptionTreeItemEditButton::CreateEditItem( DWORD dwOptions, 
                                                DWORD dwAddStyle,
                                                const CString& inputmask)
{
	// Declare variables
	DWORD dwStyle = WS_CHILD | WS_VISIBLE | ES_AUTOHSCROLL;
	BOOL bRet = FALSE;


	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

  if(inputmask.GetLength() > 0)
    this->SetInputMask(inputmask);

	// Create edit control
	if (!IsWindow(GetSafeHwnd()))
	{
		// -- Create edit style
		// -- -- Multiline
		if (dwOptions & OT_EDIT_MULTILINE)
		{
			dwStyle |= ES_MULTILINE;
		}
		// -- -- Password
		if (dwOptions & OT_EDIT_PASSWORD)
		{
			dwStyle |= ES_PASSWORD;
		}
		// -- -- Numeical
		if (dwOptions & OT_EDIT_NUMERICAL)
		{
			dwStyle |= ES_NUMBER;
		}
		// -- -- Additional style
		if (dwAddStyle != 0)
		{
			dwStyle |= dwAddStyle;
		}

		// -- Create the edit view
		bRet = Create(dwStyle, m_rcAttribute, m_otOption->GetCtrlParent(), GetCtrlID());

		// -- Setup edit
		if (bRet == TRUE)
		{
			// -- -- Set font
			SetFont(m_otOption->GetNormalFont(), TRUE);

			// -- -- Modify style
			ModifyStyleEx(0, WS_EX_CLIENTEDGE, SWP_FRAMECHANGED);

			// -- -- Save options
			m_dwOptions = dwOptions;

			// -- -- Set selection
			SetSel(0, 0);

			// -- -- Set multiline
			if (GetOption(OT_EDIT_MULTILINE) == TRUE)
			{
				SetItemHeight(OT_EDIT_MLHEIGHT);
			}

			// -- -- Set window position
			MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

			// -- -- Hide window
			ShowWindow(SW_HIDE);
      m_bActivated = FALSE;
	      // Create button control
	      if (!IsWindow(m_ctrlButton.GetSafeHwnd()))
	      {
            if (!m_ctrlButton.Create(_T("..."), WS_CHILD | BS_PUSHBUTTON, CRect(0,0,0,0),m_otOption->GetCtrlParent(), GetCtrlID()))
               TRACE(_T("COptionTreeItemEditButton::CreateEditItem() - CreateButton failed\n"));
         }
		}
	}

	return bRet;
}

void COptionTreeItemEditButton::SetEditDouble(double dValue)
{
  COptionTreeItemEdit::SetEditDouble(dValue);
}

void COptionTreeItemEditButton::SetEditInt(int nValue)
{
  COptionTreeItemEdit::SetEditInt(nValue);
}

void COptionTreeItemEditButton::SetEditFloat(float fValue)
{
  COptionTreeItemEdit::SetEditFloat(fValue);
}

void COptionTreeItemEditButton::SetEditDword(DWORD dwValue)
{
  COptionTreeItemEdit::SetEditDword(dwValue);
}

void COptionTreeItemEditButton::SetEditLong(long lValue)
{
  COptionTreeItemEdit::SetEditLong(lValue);
}

void COptionTreeItemEditButton::OnDeSelect()
{
	// Hide button
	if (IsWindow(m_ctrlButton.GetSafeHwnd()))
	{
		// -- Show window
		m_ctrlButton.ShowWindow(SW_HIDE);
	}
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
	}
  m_bActivated = FALSE;
}

void COptionTreeItemEditButton::OnSelect()
{
	// Do nothing here
}

void COptionTreeItemEditButton::SetOption(DWORD dwOption, BOOL bSet)
{
  COptionTreeItem::SetOption(dwOption,bSet);
	// Options changed
	OptionsChanges();
}

void COptionTreeItemEditButton::OptionsChanges()
{
	// Multiline
	SetDrawMultiline(GetOption(OT_EDIT_MULTILINE));
	if (GetOption(OT_EDIT_MULTILINE) == TRUE)
	{
		SetItemHeight(OT_EDIT_MLHEIGHT);

		if (IsWindow(GetSafeHwnd()))
		{
			ModifyStyle(0, ES_MULTILINE, 0);
		}
	}
	else
	{
		SetItemHeight(OT_DEFHEIGHT);

		if (IsWindow(GetSafeHwnd()))
		{
			ModifyStyle(ES_MULTILINE, 0, 0);
		}
	}

	// Password
	if (GetOption(OT_EDIT_PASSWORD) == TRUE)
	{
		if (IsWindow(GetSafeHwnd()))
		{
			ModifyStyle(0, ES_PASSWORD, 0);
		}
	}
	else
	{
		if (IsWindow(GetSafeHwnd()))
		{
			ModifyStyle(ES_PASSWORD, 0, 0);
		}
	}

	// Numerical
	SetDrawMultiline(GetOption(OT_EDIT_NUMERICAL));
	if (GetOption(OT_EDIT_NUMERICAL) == TRUE)
	{
		SetItemHeight(OT_EDIT_MLHEIGHT);

		if (IsWindow(GetSafeHwnd()))
		{
			ModifyStyle(0, ES_MULTILINE, 0);
		}
	}
	else
	{
		SetItemHeight(OT_DEFHEIGHT);

		if (IsWindow(GetSafeHwnd()))
		{
			ModifyStyle(ES_MULTILINE, 0, 0);
		}
	}
}

void COptionTreeItemEditButton::OnEnChange()
{
  // TODO:  If this is a RICHEDIT control, the control will not
  // send this notification unless you override the COptionTreeItemEdit::OnInitDialog()
  // function and call CRichEditCtrl().SetEventMask()
  // with the ENM_CHANGE flag ORed into the mask.

  SetChanged(1);
}
void COptionTreeItemEditButton::OnShow(BOOL bShow)
{
  if(::IsWindow(this->GetSafeHwnd()) == TRUE)
  {
    if(bShow == TRUE && m_bActivated == TRUE)
    {
      this->ShowWindow(SW_SHOW);
      m_ctrlButton.ShowWindow(SW_SHOW);
    }
    else
    {
      this->ShowWindow(SW_HIDE);
      m_ctrlButton.ShowWindow(SW_HIDE);
    }
  }
}

//#UC END# *470B029301E4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemEditButton::~COptionTreeItemEditButton () {
	//#UC START# *470B029301E4_DESTR_BODY*
	//#UC END# *470B029301E4_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemEditButton, COptionTreeItemEdit)
	//#UC START# *470B029301E4_MESSAGE_MAP*
	ON_WM_GETDLGCODE()
	ON_WM_KEYDOWN()
	ON_WM_KILLFOCUS()
	ON_WM_SETFOCUS()
	ON_CONTROL_REFLECT(EN_CHANGE, OnEnChange)
	//#UC END# *470B029301E4_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemEditButton, COptionTreeItemEdit)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

