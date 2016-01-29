#if !defined(AFX_SELECTSERVERUPDATETYPE_H__678C7C25_CDB5_4614_951F_93B6F51A31A3__INCLUDED_)
#define AFX_SELECTSERVERUPDATETYPE_H__678C7C25_CDB5_4614_951F_93B6F51A31A3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectServerUpdateType.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectServerUpdateTypeDlg dialog

class CSelectServerUpdateTypeDlg : public CDialog
{
// Construction
public:
	bool remoteType;
	CSelectServerUpdateTypeDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectServerUpdateTypeDlg)
	enum { IDD = IDD_SELECTSERVERTYPE_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectServerUpdateTypeDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectServerUpdateTypeDlg)
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnHelp();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTSERVERUPDATETYPE_H__678C7C25_CDB5_4614_951F_93B6F51A31A3__INCLUDED_)
