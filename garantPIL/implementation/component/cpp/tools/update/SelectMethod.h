#if !defined(AFX_SELECTMETHOD_H__BD490B91_32F5_4A5B_A67E_6D8A4F108FA5__INCLUDED_)
#define AFX_SELECTMETHOD_H__BD490B91_32F5_4A5B_A67E_6D8A4F108FA5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectMethod.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectMethodDlg dialog

class CSelectMethodDlg : public CDialog
{
// Construction
public:
	bool bExtended;
	CSelectMethodDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectMethodDlg)
	enum { IDD = IDD_METHOD_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectMethodDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectMethodDlg)
	virtual void OnOK();
	afx_msg void OnHelp();
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBack();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTMETHOD_H__BD490B91_32F5_4A5B_A67E_6D8A4F108FA5__INCLUDED_)
