// NewName.cpp : implementation file
//

#include "stdafx.h"
#include "testbreeder32.h"
#include "NewName.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CNewName dialog


CNewName::CNewName(CWnd* pParent /*=NULL*/)
	: CDialog(CNewName::IDD, pParent)
{
	//{{AFX_DATA_INIT(CNewName)
	m_pName = _T("");
	//}}AFX_DATA_INIT
}


void CNewName::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CNewName)
	DDX_Text(pDX, IDC_EDIT1, m_pName);
	DDV_MaxChars(pDX, m_pName, 8);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CNewName, CDialog)
	//{{AFX_MSG_MAP(CNewName)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNewName message handlers
