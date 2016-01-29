//
// DownloaderDlg.h : header file
//

#if !defined(AFX_DOWNLOADERDLG_H__CE310074_3312_4DE2_8A8D_79A0D9713EE9__INCLUDED_)
#define AFX_DOWNLOADERDLG_H__CE310074_3312_4DE2_8A8D_79A0D9713EE9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "resource.h"
#include "ComplectsCombo.h"

/////////////////////////////////////////////////////////////////////////////
// CDownloaderDlg dialog

class CDownloaderDlg : public CDialog {
// Construction
public:
	CDownloaderDlg (CWnd* pParent = NULL);	// standard constructor
	virtual ~CDownloaderDlg ();
		
// Operations
public:
	
// Implementation
public:

// Dialog Data
	//{{AFX_DATA(CDownloaderDlg)
	enum { IDD = IDD_DOWNLOADER_DIALOG };
	COleDateTime m_ctBeginDate;
	COleDateTime m_ctEndDate;
	CButton	m_pBack;
	CComplectsCombo m_cbComplect;
	//}}AFX_DATA

// Overrides
protected:
	//{{AFX_VIRTUAL(CDownloaderDlg)
	virtual void DoDataExchange (CDataExchange* pDX);	// DDX/DDV support
	virtual void UpdateWindow ();
	virtual void OnOK ();
	virtual void OnCancel ();
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CDownloaderDlg)
	virtual BOOL OnInitDialog ();
	afx_msg void OnSysCommand (UINT nID, LPARAM lParam);
	afx_msg void OnPaint ();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnShowWindow (BOOL bShow, UINT nStatus);
	afx_msg void OnSetFocus (CWnd* pOldWnd);
	afx_msg void OnActivate (UINT nState, CWnd* pWndOther, BOOL bMinimized);
	afx_msg void OnSetPath ();
	afx_msg void OnBack ();
	afx_msg void OnHelp ();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

private:
	bool is_valid ();
	bool choose_dir (const char* title);

	void init_dates ();
	unsigned get_complect_id ();

	DownloadState download ();

private:
	HICON m_hIcon;

	std::string m_path;
};

//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_DOWNLOADERDLG_H__CE310074_3312_4DE2_8A8D_79A0D9713EE9__INCLUDED_)
