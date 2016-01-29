#if !defined(AFX_SELECTREMOTETYPE_H__85521439_CCFD_402B_BB5A_CAAD525B6817__INCLUDED_)
#define AFX_SELECTREMOTETYPE_H__85521439_CCFD_402B_BB5A_CAAD525B6817__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectRemoteType.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectRemoteTypeDlg dialog

class CSelectRemoteTypeDlg : public CDialog
{
// Construction
public:
	int	remoteType;
	CSelectRemoteTypeDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectRemoteTypeDlg)
	enum { IDD = IDD_SELECTREMOTETYPE_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectRemoteTypeDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectRemoteTypeDlg)
	afx_msg void OnHelp();
	virtual void OnCancel();
	virtual void OnOK();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTREMOTETYPE_H__85521439_CCFD_402B_BB5A_CAAD525B6817__INCLUDED_)
