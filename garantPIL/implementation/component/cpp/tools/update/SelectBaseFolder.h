#if !defined(AFX_SelectBaseFOLDER_H__6F2E1F09_5455_4A06_A09D_1B97E45A1474__INCLUDED_)
#define AFX_SelectBaseFOLDER_H__6F2E1F09_5455_4A06_A09D_1B97E45A1474__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectBaseFolder.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolder dialog

class CSelectBaseFolder : public CDialog
{
// Construction
public:
	CSelectBaseFolder(CWnd* pParent = NULL);   // standard constructor

	int	updateType;
	//CString originalBaseName; //ses: not used param

// Dialog Data
	//{{AFX_DATA(CSelectBaseFolder)
	enum { IDD = IDD_SELECTBASEFOLDER_DIALOG };
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectBaseFolder)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CSelectBaseFolder)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	virtual void OnOK();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SelectBaseFOLDER_H__6F2E1F09_5455_4A06_A09D_1B97E45A1474__INCLUDED_)
