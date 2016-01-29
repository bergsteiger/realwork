//
// ComplectsCombo.cpp : implementation file
//

#include "stdafx.h"

#include "ComplectsCombo.h"
#include "Downloader.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CComplectsCombo

CComplectsCombo::CComplectsCombo () : m_initialized (false) {
}

CComplectsCombo::~CComplectsCombo () {
}

BEGIN_MESSAGE_MAP(CComplectsCombo, CComboBox)
	//{{AFX_MSG_MAP(CComplectsCombo)
	ON_WM_CREATE()	
	ON_WM_LBUTTONDOWN()
   	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CComplectsCombo message handlers

int CComplectsCombo::OnCreate (LPCREATESTRUCT lpCreateStruct) {
	if (CComboBox::OnCreate (lpCreateStruct) == -1) {
		return -1;
	} 
	return 0;
}

void CComplectsCombo::PreSubclassWindow () {
	CComboBox::PreSubclassWindow();

	if (m_initialized == false) {
		const Complects& data = GetAppPtr ()->get_complects ();

		for (Complects::const_iterator it = data.begin (); it != data.end (); ++it) {
			if (CB_ERRSPACE == AddString (it->name.c_str ())) {
				break;
			}
		}

		long id = GetAppPtr ()->get_complect_id ();

		std::string complect_name = GetAppPtr ()->get_complect_name ((unsigned) id);
		
		int search_index = 0;

		if (id != -1 && complect_name.size ()) {
			search_index = FindStringExact (0, complect_name.c_str ());
		} 
		
		SetCurSel (search_index);
		m_initialized = true;

		{
		CString    str;
		CSize      sz;
		int        dx = 0;
		TEXTMETRIC tm;
		CDC*       pDC = GetDC ();
		CFont*     pFont = GetFont ();

		CFont* pOldFont = pDC->SelectObject (pFont);
		pDC->GetTextMetrics (&tm);

		for (int i = 0; i < GetCount (); i++) {
		   GetLBText (i, str);
		   sz = pDC->GetTextExtent (str);
		   sz.cx += tm.tmAveCharWidth;
		   if (sz.cx > dx)
			  dx = sz.cx;
		}
		pDC->SelectObject (pOldFont);
		ReleaseDC (pDC);

		dx += ::GetSystemMetrics (SM_CXVSCROLL) + 2 * ::GetSystemMetrics (SM_CXEDGE);

		SetDroppedWidth(dx);
		}
	}
}

void CComplectsCombo::OnLButtonDown (UINT nFlags, CPoint point) {	
	if (::GetFocus () != m_hWnd) {
		::SetFocus (m_hWnd);
	}
	CComboBox::OnLButtonDown (nFlags, point);
}

// end of ...

