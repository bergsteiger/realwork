//
// LoginDlg.h : header file
//

#if !defined(AFX_LOGINDLG_H__A01CA568_50A1_4A63_8E23_F945692E53D8__INCLUDED_)
#define AFX_LOGINDLG_H__A01CA568_50A1_4A63_8E23_F945692E53D8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "resource.h"

/////////////////////////////////////////////////////////////////////////////
// CLoginDlg dialog

class CLoginDlg : public CDialog {
// Construction
public:
	CLoginDlg (CWnd* pParent = NULL);   // standard constructor
	virtual ~CLoginDlg ();

//Operations
public:

// Implementation
public:

// Dialog Data
	//{{AFX_DATA(CLoginDlg)
	enum { IDD = IDD_LOGIN };
	CEdit m_edtLogin;
	CEdit m_edtPassword;
	//}}AFX_DATA

// Overrides
	//{{AFX_VIRTUAL(CLoginDlg)
	protected:
	virtual void DoDataExchange (CDataExchange* pDX);    // DDX/DDV support
	virtual void OnOK ();
	virtual void OnCancel ();
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CLoginDlg)
	virtual BOOL OnInitDialog ();
	afx_msg void OnInetSettings ();
	afx_msg void OnHelp ();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

private:
	void authorization (const char* login, const char* password);
};

//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_LOGINDLG_H__A01CA568_50A1_4A63_8E23_F945692E53D8__INCLUDED_)
