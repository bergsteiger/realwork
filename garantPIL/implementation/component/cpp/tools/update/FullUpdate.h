#if !defined(AFX_FULLUPDATE_H__5BAAC575_D1F2_4A56_BF36_184E298088C6__INCLUDED_)
#define AFX_FULLUPDATE_H__5BAAC575_D1F2_4A56_BF36_184E298088C6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FullUpdate.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFullUpdateDlg dialog

class CFullUpdateDlg : public CDialog
{
// Construction
public:
	CFullUpdateDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CFullUpdateDlg)
	enum { IDD = IDD_FULLUPDATE_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFullUpdateDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CFullUpdateDlg)
	virtual void OnCancel();
	afx_msg void OnBack();
	virtual BOOL OnInitDialog();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FULLUPDATE_H__5BAAC575_D1F2_4A56_BF36_184E298088C6__INCLUDED_)
