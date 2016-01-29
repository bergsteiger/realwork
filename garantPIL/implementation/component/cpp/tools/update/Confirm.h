#if !defined(AFX_CONFIRM_H__0607D57D_6224_4E08_B65D_7E5679E269E9__INCLUDED_)
#define AFX_CONFIRM_H__0607D57D_6224_4E08_B65D_7E5679E269E9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Confirm.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CConfirmDlg dialog

class CConfirmDlg : public CDialog
{
// Construction
public:
	UINT	MessageID;
	UINT	TitleID;
	UINT	IconID;
	CString	Add;

	CConfirmDlg( UINT aMessageID, UINT aTitleID = IDS_CONFIRM, UINT aIconID = IDI_BEWARNING, CString aAdd = "", CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CConfirmDlg)
	enum { IDD = IDD_CONFIRM_DIALOG };
	CStatic	m_pText;
	CStatic	m_pIcon;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CConfirmDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CConfirmDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnYes();
	afx_msg void OnNo();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONFIRM_H__0607D57D_6224_4E08_B65D_7E5679E269E9__INCLUDED_)
