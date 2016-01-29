////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemComboBox.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemComboBox
//
// комбо-бокс для отображения в дереве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemComboBox.h"

//#UC START# *470B01340261_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B01340261_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B01340261*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemComboBox

COptionTreeItemComboBox::COptionTreeItemComboBox()
{
	// Initialize variables
	m_bFocus = FALSE;
	m_lDropDownHeight = OT_COMBO_DROPDOWNHEIGHT;

  _dwExStyleBuffer = 0;
  _InputMaskBuffer = "";
  _WindowTextBuffer ="";

  _changed = 0;

	// Set item type
	SetItemType(OT_ITEM_COMBOBOX);
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeItemComboBox message handlers


void COptionTreeItemComboBox::DrawAttribute(CDC *pDC, const RECT &rcRect)
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
	if (!IsWindow(GetSafeHwnd()) )
	{
    CFont *pOldFont = pDC->SelectObject(COptionTree::GetNormalFont());
    CRect arect(rcRect);
		pDC->DrawText(_WindowTextBuffer, &arect, DT_SINGLELINE | DT_VCENTER);
		pDC->DrawText(_WindowTextBuffer, &arect, DT_SINGLELINE | DT_VCENTER | DT_CALCRECT);
    pDC->SelectObject(pOldFont);
		return;
	}
  else
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}

	// Declare variables
	HGDIOBJ hOld;
	COLORREF crOld;
	int nOldBack;
	CRect rcText;
	CString strWindowText;
	COLORREF crOldBack;

	// Get window text
	GetWindowText(strWindowText);
  _WindowTextBuffer=strWindowText;

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
	pDC->DrawText(_WindowTextBuffer, rcText, DT_SINGLELINE | DT_VCENTER);

	// Restore GDI ojects
	pDC->SelectObject(hOld);
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SetBkColor(crOldBack);

}

void COptionTreeItemComboBox::OnCommit()
{
	// Hide edit control
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
    m_bActivated = FALSE;
	}
}

void COptionTreeItemComboBox::OnRefresh()
{
	// Set the window text
	if (IsWindow(GetSafeHwnd()))
	{
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());
	}
}

void COptionTreeItemComboBox::OnMove()
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

void COptionTreeItemComboBox::OnActivate()
{
  BOOL bres = TRUE;
  if (IsWindow(GetSafeHwnd()) == FALSE)
  {
    bres = this->CreateComboItem(_dwExStyleBuffer);
    this->SetWindowText(_WindowTextBuffer);
  }

	// Make sure window is valid
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_SHOW);
    m_bActivated = TRUE;

		// -- Set window position
		MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height() + m_lDropDownHeight);

		// -- Set focus
		SetFocus();
	}
}

void COptionTreeItemComboBox::OnSetFocus(CWnd* pOldWnd) 
{
	// Mark focus
	m_bFocus = TRUE;

	CComboBox::OnSetFocus(pOldWnd);	
}

void COptionTreeItemComboBox::OnKillFocus(CWnd* pNewWnd) 
{
	// Validate
	if (m_otOption == NULL)
	{
		CComboBox::OnKillFocus(pNewWnd);
    m_bActivated = FALSE;
    this->OnShow(FALSE);
		return;
	}

	// See if new window is tree of list
	if (m_otOption->IsChild(pNewWnd) == TRUE)
	{
		// -- Mark focus
		m_bFocus = FALSE;
    m_bActivated = FALSE;
    this->OnShow(FALSE);
		// -- Commit changes
		//CommitChanges();
	}

	CComboBox::OnKillFocus(pNewWnd);	
}
BOOL COptionTreeItemComboBox::PrepareComboItem(const CString& sWindowText,
                                           DWORD dwAddStyle)
{
  _WindowTextBuffer = sWindowText;
  // the edit already exists.so we assume, that it should be recreated with different
  // properties
  if (IsWindow(GetSafeHwnd()))
	{
    bool recreate=false;
    if(_dwExStyleBuffer != dwAddStyle)
    {
      _dwExStyleBuffer=dwAddStyle;
      recreate = true;
    }
    // destroy only.next click will make it
    if(recreate == true)
      this->DestroyWindow();
  }
  else
  {
    _dwExStyleBuffer=dwAddStyle;
  }
  return TRUE;
}

BOOL COptionTreeItemComboBox::CreateComboItem(DWORD dwAddStyle)
{
	// Declare variables
	DWORD dwStyle = WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST | WS_VSCROLL;
	BOOL bRet = FALSE;

	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Create edit control
	if (!IsWindow(GetSafeHwnd()))
	{
		// -- Add style
		if (dwAddStyle != 0)
		{
			dwStyle |= dwAddStyle;
		}
		
		// -- Create the combo box
		bRet = Create(dwStyle, m_rcAttribute, m_otOption->GetCtrlParent(), GetCtrlID());

		// -- Setup combo
		if (bRet == TRUE)
		{
			// -- -- Set font
			SetFont(m_otOption->GetNormalFont(), TRUE);

			// -- -- Set window position
			MoveWindow(m_rcAttribute.left, m_rcAttribute.top, m_rcAttribute.Width(), m_rcAttribute.Height());		

			// -- -- Hide window
			ShowWindow(SW_HIDE);
      m_bActivated = FALSE;
		}
	}


	return bRet;
}

void COptionTreeItemComboBox::SetDropDownHeight(long lHeight)
{
	// Save variable
	m_lDropDownHeight = lHeight;
}

long COptionTreeItemComboBox::GetDropDownHeight()
{
	// Return variable
	return m_lDropDownHeight;
}

void COptionTreeItemComboBox::CleanDestroyWindow()
{
	// Destroy window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Destroy window
		DestroyWindow();
	}
}
void COptionTreeItemComboBox::OnDeSelect()
{
	// Hide window
	if (IsWindow(GetSafeHwnd()))
	{
		// -- Show window
		ShowWindow(SW_HIDE);
    m_bActivated = FALSE;
	}
}

void COptionTreeItemComboBox::OnSelect()
{
	// Do nothing here
}

void COptionTreeItemComboBox::OnCbnSelchange()
{
  CString sCurrent("");
  this->GetWindowText(sCurrent);
  if(sCurrent != _text)
  {
    SetChanged(1);
    CommitChanges(_changed > 0 ? true : false);
  }
  _text = sCurrent;
}
LRESULT COptionTreeItemComboBox::DefWindowProc(UINT nMsg, WPARAM wParam, LPARAM lParam)
{
  if(nMsg == CB_SELECTSTRING)
  {
    LPCTSTR pString = (LPCTSTR) lParam;
    if(pString)
      _text = pString;
  }
  return CComboBox::DefWindowProc(nMsg,wParam,lParam);
}

void COptionTreeItemComboBox::OnShow(BOOL bShow)
{
  if(::IsWindow(this->GetSafeHwnd()) == TRUE)
  {
    if(bShow == TRUE && m_bActivated == TRUE)
      this->ShowWindow(SW_SHOW);
    else
      this->ShowWindow(SW_HIDE);
  }
}
CString COptionTreeItemComboBox::GetAttributeText(void) {
	CString sText(_WindowTextBuffer);
	if(::IsWindow(this->GetSafeHwnd()) == TRUE) {
		if(this->GetCurSel() != CB_ERR) {
			this->GetLBText(this->GetCurSel(),sText);
		}
	}
  
	return sText;
}

//#UC END# *470B01340261*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemComboBox::~COptionTreeItemComboBox () {
	//#UC START# *470B01340261_DESTR_BODY*
	//#UC END# *470B01340261_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeItemComboBox, CComboBox)
	//#UC START# *470B01340261_MESSAGE_MAP*
	ON_WM_SETFOCUS()
	ON_WM_KILLFOCUS()
	ON_CONTROL_REFLECT(CBN_SELCHANGE, OnCbnSelchange)
	//#UC END# *470B01340261_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeItemComboBox, CComboBox)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

