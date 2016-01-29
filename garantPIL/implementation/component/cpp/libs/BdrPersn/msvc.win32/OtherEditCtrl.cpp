// OtherEditCtrl.cpp : implementation file
//

#include "stdafx.h"
#include "TestBreeder32.h"
#include "OtherEditCtrl.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// COtherEditCtrl

COtherEditCtrl::COtherEditCtrl()
{
}

COtherEditCtrl::~COtherEditCtrl()
{
}


BEGIN_MESSAGE_MAP(COtherEditCtrl, CEdit)
	//{{AFX_MSG_MAP(COtherEditCtrl)
	ON_WM_KEYDOWN()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// COtherEditCtrl message handlers

void COtherEditCtrl::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	if(nChar == VK_INSERT){
		pParentDlg->PostMessage(WM_ON_INSTALL);
		return;
	}
	CEdit::OnKeyDown(nChar, nRepCnt, nFlags);
}
