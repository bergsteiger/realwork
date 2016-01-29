////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeCheckButton
//
// кнопка выбора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeCheckButton.h"

//#UC START# *470AFD4802FD_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470AFD4802FD_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470AFD4802FD*
/////////////////////////////////////////////////////////////////////////////
// COptionTreeCheckButton

COptionTreeCheckButton::COptionTreeCheckButton()
{
	// Initialize variables
	m_strUnChecked = OT_CHECKBOX_DEFUNCHECKTEXT;
	m_strChecked = OT_CHECKBOX_DEFCHECKTEXT;
	m_bShowText = FALSE;
	m_bCheck = FALSE;
	m_bShowCheck = FALSE;
	m_rcCheck = CRect(0, 0, 0, 0);
	m_otOption = NULL;
  m_dwOptions = 0;
}

/////////////////////////////////////////////////////////////////////////////
// COptionTreeCheckButton message handlers

void COptionTreeCheckButton::SetCheckText(CString strChecked, CString strUnChecked)
{
	// Save variables
	m_strChecked = strChecked;
	m_strUnChecked = strUnChecked;
}

CString COptionTreeCheckButton::GetCheckedText() const
{
	// Return variables
	return m_strChecked;
}

CString COptionTreeCheckButton::GetUnCheckedText() const
{
	// Return variables
	return m_strUnChecked;
}

void COptionTreeCheckButton::OnPaint() 
{
	// Make sure options aren't NULL
	if (m_otOption == NULL)
	{
		return;
	}

	// Declare variables
	CPaintDC dc(this);
	CDC* pDCMem = new CDC;
	CBitmap bpMem;
	CBitmap *bmOld;
	COLORREF crOld;
	HGDIOBJ hOldBrush;
	int nOldBack;
	CRect rcText, rcCheck, rcClient;
	CString strText;
	HGDIOBJ hOld;

	// Get client rectangle
	GetClientRect(rcClient);

	// Create DC
	pDCMem->CreateCompatibleDC(&dc);
	
	// Create bitmap
	bpMem.CreateCompatibleBitmap(&dc, rcClient.Width(), rcClient.Height());

	// Select bitmap
	bmOld = pDCMem->SelectObject(&bpMem);

	// Set background mode
	nOldBack = pDCMem->SetBkMode(TRANSPARENT);

	// Set text color
	//crOld = pDCMem->SetTextColor(GetSysColor(COLOR_WINDOWTEXT));
  // ce
  if(m_bCheck == TRUE)
    crOld = pDCMem->SetTextColor(_CLR_CHECKED);
  else
    crOld = pDCMem->SetTextColor(_CLR_UNCHECKED);

	// Select font
	hOld = pDCMem->SelectObject(m_otOption->GetNormalFont());

	// Draw control background
	if (m_otOption->IsWindowEnabled() == FALSE)
	{
		hOldBrush = pDCMem->SelectObject(GetSysColorBrush(COLOR_BTNFACE));
	}
	else
	{
		hOldBrush = pDCMem->SelectObject(GetSysColorBrush(COLOR_WINDOW));
	}
	pDCMem->PatBlt(rcClient.left, rcClient.top, rcClient.Width(), rcClient.Height(), PATCOPY);

  if(GetOption(OT_CHECKBOX_SHOWCHECK) == TRUE)
  {
	  // Get rectangle
	  rcCheck.left  = rcClient.left + 1;
	  rcCheck.right = rcCheck.left + (long) OT_CHECKBOX_SIZE;
	  rcCheck.top = rcClient.top + ATTRIB_OFFSET - 1;
	  rcCheck.bottom = rcCheck.top + (long) OT_CHECKBOX_SIZE;
  		
	  // Draw check
	  if (GetCheck() == TRUE)
	  {
		  pDCMem->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_BUTTONCHECK | DFCS_CHECKED);
	  }
	  else
	  {
		  pDCMem->DrawFrameControl(&rcCheck, DFC_BUTTON, DFCS_BUTTONCHECK);
	  }
  }
  else
  {
    rcCheck.left  = rcClient.left + 1;
    rcCheck.right = rcCheck.left;
    rcCheck.top = rcClient.top + ATTRIB_OFFSET - 1;
    rcCheck.bottom = rcCheck.top + (long) OT_CHECKBOX_SIZE;
  }
	// Draw text
	if (GetOption(OT_CHECKBOX_SHOWTEXT) == TRUE)
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
		rcText.left  = rcCheck.right + ATTRIB_OFFSET;
		rcText.right = rcClient.right;
		rcText.top = rcClient.top;
		rcText.bottom = rcClient.bottom;

		// -- Draw text
		pDCMem->DrawText(strText, rcText, DT_SINGLELINE | DT_VCENTER);
	}

	// Save check rectangle
	m_rcCheck = rcCheck;
	if (GetOption(OT_CHECKBOX_SHOWTEXT) == TRUE)
	{
		m_rcCheck.right = rcText.right;
	}

	// Copy to screen
	dc.BitBlt(0, 0, rcClient.Width(), rcClient.Height(), pDCMem, 0, 0, SRCCOPY);

	// Restore GDI ojects
	pDCMem->SelectObject(bmOld);
	pDCMem->SelectObject(hOldBrush);
	pDCMem->SetBkMode(nOldBack);
	pDCMem->SelectObject(hOld);
	pDCMem->SetTextColor(crOld);	

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
}

BOOL COptionTreeCheckButton::OnEraseBkgnd(CDC* pDC) 
{
	// Naa, we like flicker free better
	return FALSE;
}

void COptionTreeCheckButton::SetCheck(BOOL bCheck,const bool bcommit)
{
	// Set variable
	m_bCheck = bCheck;
}


BOOL COptionTreeCheckButton::GetCheck()
{
	// Return check
	return m_bCheck;
}

void COptionTreeCheckButton::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// See if check was pressed
	if (m_rcCheck.PtInRect(point) == TRUE)
	{
		// -- Reverse check
		SetCheck(!GetCheck(),true);
		// -- Force redraw
		Invalidate();

		// -- Update window
		UpdateWindow();
	}
	
	CWnd::OnLButtonUp(nFlags, point);
}

void COptionTreeCheckButton::SetCheckOptionsOwner(COptionTree *otOption)
{
	// Save pointer
	m_otOption = otOption;
}


BOOL COptionTreeCheckButton::GetOption(DWORD dwOption)
{
	// Return option
	return (m_dwOptions & dwOption) ? TRUE : FALSE;
}

void COptionTreeCheckButton::SetOption(DWORD dwOption, BOOL bSet)
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
//#UC END# *470AFD4802FD*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeCheckButton::~COptionTreeCheckButton () {
	//#UC START# *470AFD4802FD_DESTR_BODY*
	//#UC END# *470AFD4802FD_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeCheckButton, CWnd)
	//#UC START# *470AFD4802FD_MESSAGE_MAP*
	ON_WM_PAINT()
	ON_WM_ERASEBKGND()
	ON_WM_LBUTTONUP()
	//#UC END# *470AFD4802FD_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeCheckButton, CWnd)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

