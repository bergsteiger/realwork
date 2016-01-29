////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeItemStatic.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::COptionTreeItemStatic
//
// static
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeItemStatic.h"

//#UC START# *470B0C3F0167_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "shared/WinGUI/OptionTreeControls/COptionTree.h"
//#UC END# *470B0C3F0167_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B0C3F0167*
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

COptionTreeItemStatic::COptionTreeItemStatic()
{
	// Initialize variables
	m_strStaticText = _T("");
	m_dwOptions = NULL;

	// Set item type
	SetItemType(OT_ITEM_STATIC);
   m_hIcon = NULL; // hb
   m_pBitmap = NULL;
}

void COptionTreeItemStatic::DrawAttribute(CDC *pDC, const RECT &rcRect)
{
	// Make sure option is not NULL
	if (m_otOption == NULL)
	{
		return;
	}

	// Declare variables
	HGDIOBJ hOld;
	COLORREF crOld;
	int nOldBack;
	CRect rcText;
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

	// Get rectangle
	rcText = rcRect;
   // hb - if we have a valid icon handle - draw the icon
   if (m_hIcon != NULL)
   {
      ICONINFO info;
      if (::GetIconInfo (m_hIcon, &info))
      {
         pDC->DrawIcon(rcText.left, rcText.top, m_hIcon);
         rcText.left += info.xHotspot * 5;
      }
   }
   // hb - if we have a bitmap - draw it
   if (m_pBitmap != NULL)
   {
	   CDC dcImage;
	   if (dcImage.CreateCompatibleDC(pDC))
      {
	      BITMAP bm;
	      m_pBitmap->GetBitmap(&bm);
	      // draw bitmap
         int dy = (rcText.Height() - bm.bmHeight) / 2;
         if (dy < 0) 
            dy = 0;
	      CBitmap* pOldBitmap = dcImage.SelectObject(m_pBitmap);
	      pDC->BitBlt(rcText.left + ATTRIB_OFFSET, rcText.top+dy, bm.bmWidth, bm.bmHeight, &dcImage, 0, 0, SRCCOPY);
	      dcImage.SelectObject(pOldBitmap);
         rcText.left += ATTRIB_OFFSET + bm.bmWidth + ATTRIB_OFFSET;
      }
   }
	// Draw text
	pDC->DrawText(m_strStaticText, rcText, DT_SINGLELINE | DT_VCENTER);

	// Restore GDI ojects
	pDC->SelectObject(hOld);
	pDC->SetTextColor(crOld);
	pDC->SetBkMode(nOldBack);
	pDC->SetBkColor(crOldBack);
}	

CString COptionTreeItemStatic::GetStaticText()
{
	// Return text
	return m_strStaticText;
}

void COptionTreeItemStatic::SetStaticText(CString strStaticText)
{
	// Set variables
	m_strStaticText = strStaticText;
}

void COptionTreeItemStatic::CleanDestroyWindow()
{
	// Do nothing here
}

void COptionTreeItemStatic::OnCommit()
{
	// Do nothing here
}

void COptionTreeItemStatic::OnRefresh()
{
	// Do nothing here
}

void COptionTreeItemStatic::OnMove()
{
}

void COptionTreeItemStatic::OnActivate()
{
	// Do nothing here
}

void COptionTreeItemStatic::OnDeSelect()
{
	// Do nothing here
}

void COptionTreeItemStatic::OnSelect()
{
	// Do nothing here
}


BOOL COptionTreeItemStatic::CreateStaticItem(DWORD dwOptions)
{
	// Make sure options is not NULL
	if (m_otOption == NULL)
	{
		return FALSE;
	}

	// Save options
	m_dwOptions = dwOptions;

	// Always return TRUE
	return TRUE;
}

CString COptionTreeItemStatic::GetAttributeText(void)
{
  return this->GetStaticText();
}

//#UC END# *470B0C3F0167*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeItemStatic::~COptionTreeItemStatic () {
	//#UC START# *470B0C3F0167_DESTR_BODY*
	if (m_pBitmap != NULL)
      delete m_pBitmap;
	m_pBitmap = NULL;
	//#UC END# *470B0C3F0167_DESTR_BODY*
}


} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

