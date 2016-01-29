#if !defined(AFX_PILOTLOGINDLG_H__D26D1EF8_2399_494B_BCB5_81EF319205FB__INCLUDED_)
#define AFX_PILOTLOGINDLG_H__D26D1EF8_2399_494B_BCB5_81EF319205FB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// PilotLoginDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CPilotLoginDlg dialog

class CPilotLoginDlg : public CDialog
{
// Construction
public:
	CPilotLoginDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CPilotLoginDlg)
	enum { IDD = IDD_LOGIN_DLG };
	CString	m_Login;
	CString	m_Password;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPilotLoginDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CPilotLoginDlg)
	virtual void OnCancel();
	afx_msg void OnNext();
	afx_msg void OnHelp();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PILOTLOGINDLG_H__D26D1EF8_2399_494B_BCB5_81EF319205FB__INCLUDED_)
