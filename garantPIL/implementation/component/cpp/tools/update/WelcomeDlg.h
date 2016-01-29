// WelcomeDlg.h : header file
//

#if !defined(AFX_WELCOMEDLG_H__AE77A0D2_5329_4EF5_ACD1_474968415E6C__INCLUDED_)
#define AFX_WELCOMEDLG_H__AE77A0D2_5329_4EF5_ACD1_474968415E6C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CWelcomeDlg dialog

class CWelcomeDlg : public CDialog
{
// Construction
public:
	CWelcomeDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CWelcomeDlg)
	enum { IDD = IDD_WELCOME_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWelcomeDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CWelcomeDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_WELCOMEDLG_H__AE77A0D2_5329_4EF5_ACD1_474968415E6C__INCLUDED_)
