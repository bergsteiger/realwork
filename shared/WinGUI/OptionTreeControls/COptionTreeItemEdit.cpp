////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemEdit.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemEdit
//
// поле ввода для отображения в дереве контролов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemEdit.h"

//#UC START# *470B0202007D_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"

//#UC END# *470B0202007D_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B0202007D*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemEdit

COptionTreeItemEdit::COptionTreeItemEdit()
{
	// Initialize variables
	m_bFocus = FALSE;
	m_dwOptions = 0;	
  _dwExStyleBuffer = 0;
  _InputMaskBuffer = "";
  _WindowTextBuffer ="";
  m_maximum_height = OT_EDIT_MLHEIGHT*4;
	// Set item type
	SetItemType(OT_ITEM_EDIT);
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemEdit message handlers

void COptionTreeItemEdit::OnActivate()
{
  BOOL bres = TRUE;
  if (IsWindow(GetSafeHwnd()) == FALSE)
  {
    bres = this->CreateEditItem(m_dwOptions, _dwExStyleBuffer,_InputMaskBuffer);
    this->SetWindowText(_WindowTextBuffer);
    m_otOption->RefreshItem(this,_D_REFRESH_LABEL);
  }
  // Make sure window is valid
	if (bres && IsWindow(GetSafeHwnd()))
	{
		Fit ();
		// -- Show window
		ShowWindow(SW_SHOW);
    m_bActivated = TRUE;

		// -- Set selection
		SetSel(0, 0);

		// -- Set window position
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

		// -- Set focus
		SetFocus();
	}
}

UINT COptionTreeItemEdit::OnGetDlgCode() 
{
	return CEdit::OnGetDlgCode() | DLGC_WANTALLKEYS;
}

void COptionTreeItemEdit::DrawAttribute(CDC *pDC, const RECT &rcRect)
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

	// without edit window draw text only
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
  else
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
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

void COptionTreeItemEdit::OnCommit()
{
	// Hide edit control
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
    m_bActivated = FALSE;
	}

}

void COptionTreeItemEdit::OnRefresh()
{
	// Set the window text
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}
}

void COptionTreeItemEdit::OnMove()
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
    m_bActivated = FALSE;
	}
}
BOOL COptionTreeItemEdit::PreTranslateMessage(MSG* pMsg)
{
  if (pMsg->message == WM_KEYDOWN && pMsg->wParam == VK_RETURN)
  {
		// -- Commit changes
    if((GetStyle() & ES_WANTRETURN) == FALSE)
    {
      OnCommit();
      _changed=0;
		  return TRUE;
    }
    else
    {
		this->ReplaceSel("\r\n");
		Fit ();
		OnRefresh ();
	
      return TRUE;//return CEdit::PreTranslateMessage(pMsg);
    }
  }
  if (pMsg->message == WM_KEYDOWN && pMsg->wParam == VK_ESCAPE)
  {
		// -- Commit changes
		CommitChanges(_changed > 0 ? true : false);
		return TRUE;
  }
  return CEditMask::PreTranslateMessage(pMsg);
}

void COptionTreeItemEdit::set_maximum_height (int height) {
	m_maximum_height = height;
	this->Fit ();
}

void COptionTreeItemEdit::Fit() {
	// Get text
	if (m_otOption == NULL || GetOption(OT_EDIT_MULTILINE) == FALSE || this->GetLineCount() <= 0) {
		return;
	}
	
	CClientDC oDC(this);
	CFont* pOldFont = oDC.SelectObject(GetFont());
	//Determine the line Height
	CSize sz = oDC.GetTextExtent(CString(_T(" ")));
	oDC.SelectObject(pOldFont);

	int logicHeight = this->GetLineCount()*sz.cy;
	logicHeight += this->GetLineCount() > 1 ? (int)ceilf (OT_DEFHEIGHT/2.0): 0;

	logicHeight = std::max(logicHeight, OT_DEFHEIGHT);

	if (logicHeight > m_maximum_height) {
		logicHeight = m_maximum_height;
		ShowScrollBar(SB_VERT, TRUE);
	} else {
		ShowScrollBar(SB_VERT, FALSE);
	}
	
	CRect rect;
	GetRect(&rect);
	if (rect.Height () != logicHeight) {
		SetItemHeight (logicHeight);
		m_otOption->RefreshItems(this);
	}
}

void COptionTreeItemEdit::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
  
	CEdit::OnKeyDown(nChar, nRepCnt, nFlags);
	Fit ();
	SetChanged(1);
}

void COptionTreeItemEdit::OnKillFocus(CWnd* pNewWnd) 
{
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
		
		SetItemHeight (OT_DEFHEIGHT);
		// -- Commit changes
		CommitChanges(_changed > 0 ? true : false);
	}
	
	CEdit::OnKillFocus(pNewWnd);	
}

BOOL COptionTreeItemEdit::IsStringNumeric(CString strString)
{
	// See if string is numeric or not
	if (strString.FindOneOf("1234567890") == -1 || strString.FindOneOf("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~[]{}-_=+\\|'/?>,<") != -1)
	{
		return FALSE;
	}

	return TRUE;
}

BOOL COptionTreeItemEdit::GetEditFloat(float &fReturn)
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

BOOL COptionTreeItemEdit::GetEditDouble(double &dReturn)
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

BOOL COptionTreeItemEdit::GetEditLong(long &lReturn)
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

BOOL COptionTreeItemEdit::GetEditInt(int &nReturn)
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

BOOL COptionTreeItemEdit::GetEditDword(DWORD &dwReturn)
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

void COptionTreeItemEdit::CleanDestroyWindow()
{
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
}

void COptionTreeItemEdit::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_bFocus = TRUE;
	CEdit::OnSetFocus(pOldWnd);
}
BOOL COptionTreeItemEdit::PrepareEditItem(const CString& sWindowText,
                                          DWORD dwOptions, 
                                          DWORD dwAddStyle,
                                          const CString& inputmask)
{
  _WindowTextBuffer = sWindowText;
  // the edit already exists.so we assume, that it should be recreated with different
  // properties
  if (IsWindow(GetSafeHwnd()))
	{
    bool recreate=false;
    if(m_dwOptions != dwOptions)
    {
      m_dwOptions=dwOptions;
      recreate = true;
    }
    if(_dwExStyleBuffer != dwAddStyle)
    {
      _dwExStyleBuffer=dwAddStyle;
      recreate = true;
    }
    if(_InputMaskBuffer != inputmask)
    {
      _InputMaskBuffer=inputmask;
      recreate = true;
    }
    // destroy only.next click will make it
    if(recreate == true)
      this->DestroyWindow();
  }
  else
  {
    m_dwOptions=dwOptions;
    _dwExStyleBuffer=dwAddStyle;
    _InputMaskBuffer=inputmask;
  }
  return TRUE;
}

BOOL COptionTreeItemEdit::CreateEditItem(DWORD dwOptions, 
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
			dwStyle &= ~ES_AUTOHSCROLL;
			dwStyle |= ES_MULTILINE;
			dwStyle |= ES_AUTOVSCROLL;
			dwStyle |= WS_VSCROLL;
			dwStyle |= ES_WANTRETURN;
		}
		// -- -- Password
		if (dwOptions & OT_EDIT_PASSWORD)
		{
			dwStyle |= ES_PASSWORD;
		}
		// -- -- Numerical unsigned int
		if (dwOptions & OT_EDIT_NUMERICAL)
		{
      if(inputmask.GetLength() == 0)
        this->SetInputMask(INT_MASK);
			  //dwStyle |= ES_NUMBER;
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
				//SetItemHeight(OT_EDIT_MLHEIGHT);
				ShowScrollBar(SB_VERT, FALSE);
			}

			// -- -- Set window position
			MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());

			// -- -- Hide window
			ShowWindow(SW_HIDE);
      m_bActivated = FALSE;
		}
	}

	return bRet;
}
void    COptionTreeItemEdit::SetEditText(const CString& sText)
{
  _WindowTextBuffer = sText;
	if (::IsWindow(GetSafeHwnd()))
	{
		SetWindowText(_WindowTextBuffer);
	}
  // force redraw of attribute
  else if(m_otOption != NULL)
  {
		m_otOption->RefreshItem(this);
    /*
    if(this->CreateEditItem(m_dwOptions, _dwExStyleBuffer,_InputMaskBuffer) == TRUE)
		  SetWindowText(_WindowTextBuffer);
    */
    //this->OnRefresh();
  }
}

void COptionTreeItemEdit::SetEditDouble(double dValue)
{
	// Declare variables
	CString strText;

	// Convert string
	strText.Format("%.0f", dValue);
  this->SetEditText(strText);
}

void COptionTreeItemEdit::SetEditInt(int nValue)
{
	// Declare variables
	CString strText;

	// Convert string
	strText.Format("%d", nValue);

  this->SetEditText(strText);
}

void COptionTreeItemEdit::SetEditFloat(float fValue)
{
	// Declare variables
	CString strText;

	// Convert string
	strText.Format("%.0f", fValue);
  this->SetEditText(strText);
}

void COptionTreeItemEdit::SetEditDword(DWORD dwValue)
{
	// Declare variables
	CString strText;

	// Convert string
	strText.Format("%d", dwValue);
  this->SetEditText(strText);
}

void COptionTreeItemEdit::SetEditLong(long lValue)
{
	// Declare variables
	CString strText;

	// Convert string
	strText.Format("%.0f", lValue);
  this->SetEditText(strText);
}

void COptionTreeItemEdit::OnDeSelect()
{
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
    m_bActivated = FALSE;
	}
}

void COptionTreeItemEdit::OnSelect()
{
	// Do nothing here
}


void COptionTreeItemEdit::SetOption(DWORD dwOption, BOOL bSet)
{
  COptionTreeItem::SetOption(dwOption,bSet);
	// Options changed
	OptionsChanges();
}

void COptionTreeItemEdit::OptionsChanges()
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

	Fit ();
}

void COptionTreeItemEdit::OnEnChange()
{
  // TODO:  If this is a RICHEDIT control, the control will not
  // send this notification unless you override the __super::OnInitDialog()
  // function and call CRichEditCtrl().SetEventMask()
  // with the ENM_CHANGE flag ORed into the mask.
	
  SetChanged(1);
}

void COptionTreeItemEdit::OnShow(BOOL bShow)
{
  if(::IsWindow(this->GetSafeHwnd()) == TRUE)
  {
    if(bShow == TRUE && m_bActivated == TRUE)
      this->ShowWindow(SW_SHOW);
    else
      this->ShowWindow(SW_HIDE);
  }
}
CString COptionTreeItemEdit::GetAttributeText(void)
{
  CString sText("");
  if(::IsWindow(this->GetSafeHwnd()) == TRUE)    
    this->GetWindowText(sText);
  return sText;
}

//#UC END# *470B0202007D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemEdit::~COptionTreeItemEdit () {
	//#UC START# *470B0202007D_DESTR_BODY*
	//#UC END# *470B0202007D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemEdit, CEditMask)
	//#UC START# *470B0202007D_MESSAGE_MAP*
	ON_WM_GETDLGCODE()
	ON_WM_KEYDOWN()
	ON_WM_KILLFOCUS()
	ON_WM_SETFOCUS()
	ON_CONTROL_REFLECT(EN_CHANGE, OnEnChange)
	//#UC END# *470B0202007D_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemEdit, CEditMask)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

