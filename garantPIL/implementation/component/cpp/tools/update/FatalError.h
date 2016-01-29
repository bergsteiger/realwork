#if !defined(AFX_FATALERROR_H__2B52175E_ED03_4B30_AD40_D35EF57B0C0D__INCLUDED_)
#define AFX_FATALERROR_H__2B52175E_ED03_4B30_AD40_D35EF57B0C0D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FatalError.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFatalErrorDlg dialog

class CFatalErrorDlg : public CDialog
{
public:
	CString	Add, Message;
	UINT	MessageID;
	UINT	TitleID;
	UINT	IconID;

// Construction
public:
	CFatalErrorDlg( UINT aMessageID, CString aAdd = "", UINT aTitleID = IDS_ERROR, UINT aIconID = IDI_BESTOP, CWnd* pParent = NULL);   // standard constructor
	CFatalErrorDlg( CString Message );
	CFatalErrorDlg( CString Message, UINT aTitleID, UINT aIconID );

// Dialog Data
	//{{AFX_DATA(CFatalErrorDlg)
	enum { IDD = IDD_FATALERROR_DIALOG };
	CStatic	m_pIcon;
	CStatic	m_pText;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFatalErrorDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CFatalErrorDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FATALERROR_H__2B52175E_ED03_4B30_AD40_D35EF57B0C0D__INCLUDED_)
