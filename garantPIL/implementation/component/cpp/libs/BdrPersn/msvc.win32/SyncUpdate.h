#if !defined(AFX_SYNCUPDATE_H__EAB14C0E_6ED3_4E92_975A_6C1C58CB7635__INCLUDED_)
#define AFX_SYNCUPDATE_H__EAB14C0E_6ED3_4E92_975A_6C1C58CB7635__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SyncUpdate.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSyncUpdate dialog

class CSyncUpdate : public CDialog
{
// Construction
public:
	CSyncUpdate(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSyncUpdate)
	enum { IDD = IDD_SYNCUPDATE };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSyncUpdate)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSyncUpdate)
	afx_msg void OnHelp();
	virtual void OnCancel();
	virtual BOOL OnInitDialog();
	afx_msg void OnNext();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
public:
	UINT	bSync;
#ifdef	_GCD_CLIENT
    UpdateRunner* pUR;
#endif
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SYNCUPDATE_H__EAB14C0E_6ED3_4E92_975A_6C1C58CB7635__INCLUDED_)
