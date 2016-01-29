//
// EndDownloadDlg.h : header file
//

#if !defined(AFX_DOWNLOADPROCESSDLG_H__2CFDDFCF_7474_43AA_9548_1A8D690794CB__INCLUDED_)
#define AFX_DOWNLOADPROCESSDLG_H__2CFDDFCF_7474_43AA_9548_1A8D690794CB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "resource.h"

/////////////////////////////////////////////////////////////////////////////
// CEndDownloadDlg dialog

class CEndDownloadDlg : public CDialog {
// Construction
public:
	CEndDownloadDlg (CWnd* pParent = NULL); // standard constructor

// Dialog data
public:
	//{{AFX_DATA(CEndDownloadDlg)
	enum { IDD = IDD_END_PROCESS };
	CStatic m_sFinalMessageText;
	CButton m_bCancel;
	//}}AFX_DATA

// Overrides
protected:
	//{{AFX_VIRTUAL(CEndDownloadDlg)
	virtual void DoDataExchange (CDataExchange* pDX);    // DDX/DDV support
	virtual void OnCancel ();
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CEndDownloadDlg)
	virtual BOOL OnInitDialog ();
	afx_msg void OnHelp ();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_DOWNLOADPROCESSDLG_H__2CFDDFCF_7474_43AA_9548_1A8D690794CB__INCLUDED_)
