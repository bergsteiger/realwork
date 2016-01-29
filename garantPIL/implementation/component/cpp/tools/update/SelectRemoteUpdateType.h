#if !defined(AFX_SELECTREMOTEUPDATETYPE_H__B3486912_0736_4BA4_B6BA_B83B04378AD3__INCLUDED_)
#define AFX_SELECTREMOTEUPDATETYPE_H__B3486912_0736_4BA4_B6BA_B83B04378AD3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectRemoteUpdateType.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectRemoteUpdateTypeDlg dialog

class CSelectRemoteUpdateTypeDlg : public CDialog
{
// Construction
public:
	CSelectRemoteUpdateTypeDlg(CWnd* pParent = NULL);   // standard constructor

	int	updateType;

// Dialog Data
	//{{AFX_DATA(CSelectRemoteUpdateTypeDlg)
	enum { IDD = IDD_SELECTUPDATETYPE_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectRemoteUpdateTypeDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectRemoteUpdateTypeDlg)
	virtual void OnOK();
	afx_msg void OnHelp();
	virtual void OnCancel();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTREMOTEUPDATETYPE_H__B3486912_0736_4BA4_B6BA_B83B04378AD3__INCLUDED_)
