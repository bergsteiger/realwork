////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/COptionTreeFontSelColorButton.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<GuiControl::Class>> shared::WinGUI::OptionTreeControls::COptionTreeFontSelColorButton
//
// кнопка выбора шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/COptionTreeFontSelColorButton.h"

//#UC START# *470AFF120290_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
// Static
void AFXAPI DDX_ColorButton(CDataExchange *pDX, int nIDC, COLORREF& crColor)
{
	// Declare variables
    HWND hWndCtrl = pDX->PrepareCtrl(nIDC);

	// Validate
    ASSERT (hWndCtrl != NULL);                
    
	WinGUI::COptionTreeFontSelColorButton* pColorButton = (WinGUI::COptionTreeFontSelColorButton*) CWnd::FromHandle(hWndCtrl);
    if (pDX->m_bSaveAndValidate)
    {
		crColor = pColorButton->GetColor();
    }
    else
    {
		pColorButton->SetColor(crColor);
    }
}
const int g_ciArrowSizeX = 4 ;
const int g_ciArrowSizeY = 2 ;
//#UC END# *470AFF120290_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470AFF120290*
COptionTreeFontSelColorButton::COptionTreeFontSelColorButton(): _Inherited()
{
	// Initialize variables
	m_crColor = CLR_DEFAULT;
	m_crDefaultColor = ::GetSysColor(COLOR_APPWORKSPACE);
	m_strDefaultText = _T("Automatic");
	m_strCustomText = _T("More Colors...");
	m_bPopupActive = FALSE;
	m_bTrackSelection = FALSE;
}

COLORREF COptionTreeFontSelColorButton::GetColor() const
{
	return m_crColor;
}


void COptionTreeFontSelColorButton::SetColor(COLORREF crColor)
{
	// Save color
	m_crColor = crColor;

	// Force redraw
	if (::IsWindow(m_hWnd)) 
	{
        RedrawWindow();
	}
}

COLORREF COptionTreeFontSelColorButton::GetDefaultColor() const
{
	return m_crDefaultColor;
}

void COptionTreeFontSelColorButton::SetDefaultColor(COLORREF crColor)
{
	m_crDefaultColor = crColor;
}

void COptionTreeFontSelColorButton::SetCustomText(LPCTSTR tszText)
{
	m_strCustomText = tszText;
}

void COptionTreeFontSelColorButton::SetDefaultText(LPCTSTR tszText)
{
	m_strDefaultText = tszText;
}

void COptionTreeFontSelColorButton::SetTrackSelection(BOOL bTrack)
{
	m_bTrackSelection = bTrack;
}

BOOL COptionTreeFontSelColorButton::GetTrackSelection() const
{
	return m_bTrackSelection;
}

void COptionTreeFontSelColorButton::PreSubclassWindow() 
{
	// Owner drawn
    ModifyStyle(0, BS_OWNERDRAW);      

	// Subclass
    _Inherited::PreSubclassWindow();
}


long COptionTreeFontSelColorButton::OnSelEndOK(UINT lParam, long wParam)
{
	// Active popup
	m_bPopupActive = FALSE;

	// Declare variables
    COLORREF crOldColor = m_crColor;
	CWnd *pParent = GetParent();
	
	// Get new color
	m_crColor = (COLORREF)lParam;

	// Send messages to parent    
    if (pParent) 
	{
        pParent->SendMessage(OT_COLOR_CLOSEUP, lParam, (WPARAM) GetDlgCtrlID());
        pParent->SendMessage(OT_COLOR_SELENDOK, lParam, (WPARAM) GetDlgCtrlID());
    }
    if (crOldColor != m_crColor)
	{
        if (pParent) pParent->SendMessage(OT_COLOR_SELCHANGE, m_crColor, (WPARAM) GetDlgCtrlID());
	}

    return TRUE;
}

long COptionTreeFontSelColorButton::OnSelEndCancel(UINT lParam, long wParam)
{
	// Active popup
	m_bPopupActive = FALSE;
	
	// Get new color
	m_crColor = (COLORREF)lParam;

	// Declare variables
    CWnd *pParent = GetParent();

	// Send messages to parent  
    if (pParent) 
	{
        pParent->SendMessage(OT_COLOR_CLOSEUP, lParam, (WPARAM) GetDlgCtrlID());
        pParent->SendMessage(OT_COLOR_SELENDCANCEL, lParam, (WPARAM) GetDlgCtrlID());
    }

    return TRUE;
}

long COptionTreeFontSelColorButton::OnSelChange(UINT lParam, long /*wParam*/)
{
    // Track selection
	if (m_bTrackSelection) 
	{
		// Get new color
		m_crColor = (COLORREF)lParam;
	}

	// Force redraw
	if (::IsWindow(m_hWnd)) 
	{
        RedrawWindow();
	}

	// Declare variables
    CWnd *pParent = GetParent();

	// Send messages to parent  
    if (pParent) 
	{
		pParent->SendMessage(OT_COLOR_SELCHANGE, lParam, (WPARAM) GetDlgCtrlID());
	}

    return TRUE;
}

int COptionTreeFontSelColorButton::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
    // Create
	if (CButton::OnCreate(lpCreateStruct) == -1)
	{
        return -1;
	}

    return 0;
}

BOOL COptionTreeFontSelColorButton::OnClicked()
{
	// Active popup
	m_bPopupActive = TRUE;

	// Declare variables
    CRect rDraw;
	CWnd *pParent = GetParent();

	// Get window rectangle
    GetWindowRect(rDraw);

    new COptionTreeColorPopUp(CPoint(rDraw.left, rDraw.bottom), m_crColor, m_crDefaultColor, this, m_strDefaultText, m_strCustomText);

	// Send messages to parent  
    if (pParent)
	{
        pParent->SendMessage(OT_COLOR_DROPDOWN, (LPARAM)m_crColor, (WPARAM) GetDlgCtrlID());
	}

    return TRUE;
}

void COptionTreeFontSelColorButton::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) 
{
	// Validate
	ASSERT(lpDrawItemStruct);

	// Declare variables
	CDC* pDC  = CDC::FromHandle(lpDrawItemStruct->hDC);
	UINT state = lpDrawItemStruct->itemState;
    CRect rDraw = lpDrawItemStruct->rcItem;
	CRect rArrow;
	UINT uFrameState;

	// Active popup
	if (m_bPopupActive)
	{
		state |= ODS_SELECTED | ODS_FOCUS;
	}

	// Frame state
	uFrameState = DFCS_BUTTONPUSH | DFCS_ADJUSTRECT;

	// Selected
	if (state & ODS_SELECTED)
	{
		uFrameState |= DFCS_PUSHED;
	}

	// Disabled
	if (state & ODS_DISABLED)
	{
		uFrameState |= DFCS_INACTIVE;
	}
	
	// Draw frame
	pDC->DrawFrameControl(&rDraw, DFC_BUTTON, uFrameState);


	// Offset rectangle if selected
	if (state & ODS_SELECTED)
	{
		rDraw.OffsetRect(1,1);
	}

	// Draw focus
	if (state & ODS_FOCUS) 
    {
		RECT rFocus = {rDraw.left, rDraw.top, rDraw.right - 1, rDraw.bottom};
  
        pDC->DrawFocusRect(&rFocus);
    }
	rDraw.DeflateRect(::GetSystemMetrics(SM_CXEDGE), ::GetSystemMetrics(SM_CYEDGE));

	// Draw arrow
	rArrow.left = rDraw.right - g_ciArrowSizeX - ::GetSystemMetrics(SM_CXEDGE) /2;
	rArrow.right = rArrow.left + g_ciArrowSizeX;
	rArrow.top = (rDraw.bottom + rDraw.top)/2 - g_ciArrowSizeY / 2;
	rArrow.bottom = (rDraw.bottom + rDraw.top)/2 + g_ciArrowSizeY / 2;
	DrawArrow(pDC, &rArrow, 0,(state & ODS_DISABLED) ? ::GetSysColor(COLOR_GRAYTEXT) : RGB(0,0,0));
	rDraw.right = rArrow.left - ::GetSystemMetrics(SM_CXEDGE)/2;

	// Draw seperator
	pDC->DrawEdge(&rDraw, EDGE_ETCHED, BF_RIGHT);
	rDraw.right -= (::GetSystemMetrics(SM_CXEDGE) * 2) + 1 ;
				  
	// Draw color
	if ((state & ODS_DISABLED) == 0)
	{
		pDC->FillSolidRect(&rDraw, (m_crColor == CLR_DEFAULT) ? m_crDefaultColor : m_crColor);

		::FrameRect(pDC->m_hDC, &rDraw, (HBRUSH)::GetStockObject(BLACK_BRUSH));
	}
}


void COptionTreeFontSelColorButton::DrawArrow(CDC* pDC, RECT* pRect, int nDirection, COLORREF crArrow)
{
	POINT ptsArrow[3];

	switch (nDirection)
	{
		// -- Down
		case 0 :
		{
			ptsArrow[0].x = pRect->left;
			ptsArrow[0].y = pRect->top;
			ptsArrow[1].x = pRect->right;
			ptsArrow[1].y = pRect->top;
			ptsArrow[2].x = (pRect->left + pRect->right)/2;
			ptsArrow[2].y = pRect->bottom;
			break;
		}

		// -- Up
		case 1 :
		{
			ptsArrow[0].x = pRect->left;
			ptsArrow[0].y = pRect->bottom;
			ptsArrow[1].x = pRect->right;
			ptsArrow[1].y = pRect->bottom;
			ptsArrow[2].x = (pRect->left + pRect->right)/2;
			ptsArrow[2].y = pRect->top;
			break;
		}
		
		// -- Left
		case 2 :
		{
			ptsArrow[0].x = pRect->right;
			ptsArrow[0].y = pRect->top;
			ptsArrow[1].x = pRect->right;
			ptsArrow[1].y = pRect->bottom;
			ptsArrow[2].x = pRect->left;
			ptsArrow[2].y = (pRect->top + pRect->bottom)/2;
			break;
		}

		// -- Right
		case 3 :
		{
			ptsArrow[0].x = pRect->left;
			ptsArrow[0].y = pRect->top;
			ptsArrow[1].x = pRect->left;
			ptsArrow[1].y = pRect->bottom;
			ptsArrow[2].x = pRect->right;
			ptsArrow[2].y = (pRect->top + pRect->bottom)/2;
			break;
		}
	}
	
	// Draw
	CBrush brsArrow(crArrow);
	CPen penArrow(PS_SOLID, 1 , crArrow);
	CBrush* pOldBrush = pDC->SelectObject(&brsArrow);
	CPen*   pOldPen   = pDC->SelectObject(&penArrow);	
	pDC->SetPolyFillMode(WINDING);
	pDC->Polygon(ptsArrow, 3);
	pDC->SelectObject(pOldBrush);
	pDC->SelectObject(pOldPen);
}

//#UC END# *470AFF120290*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

COptionTreeFontSelColorButton::~COptionTreeFontSelColorButton () {
	//#UC START# *470AFF120290_DESTR_BODY*
	//#UC END# *470AFF120290_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(COptionTreeFontSelColorButton, CButton)
	//#UC START# *470AFF120290_MESSAGE_MAP*
	ON_CONTROL_REFLECT_EX(BN_CLICKED, OnClicked)
    ON_WM_CREATE()
    ON_MESSAGE(OT_COLOR_SELENDOK, OnSelEndOK)
    ON_MESSAGE(OT_COLOR_SELENDCANCEL, OnSelEndCancel)
    ON_MESSAGE(OT_COLOR_SELCHANGE, OnSelChange)
	//#UC END# *470AFF120290_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(COptionTreeFontSelColorButton, CButton)



} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

