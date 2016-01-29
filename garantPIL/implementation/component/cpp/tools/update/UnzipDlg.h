#if !defined(AFX_UNZIPDLG_H__39FE6FFC_2D5E_4A9E_9B30_AAAF777CB229__INCLUDED_)
#define AFX_UNZIPDLG_H__39FE6FFC_2D5E_4A9E_9B30_AAAF777CB229__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// UnzipDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CUnzipDlg dialog

class CUnzipFiles;

class CUnzipDlg : public CDialog
{
// Construction
public:
	BOOL StartUnzip();
	BOOL WasCanceled;
	BOOL ThreadFinished;
	BOOL WasErrors;
	CUnzipFiles*	pThread;
	void Finalize();
	BOOL CheckForZips();
	
	CUnzipDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CUnzipDlg)
	enum { IDD = IDD_UNZIP_DIALOG };
	CButton	m_pHelp;
	CProgressCtrl	m_pProgress;
	CStatic	m_pCount;
	CStatic	m_pError;
	CListCtrl	m_pBadZips;
	CButton	m_pNext;
	CButton	m_pBack;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUnzipDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CUnzipDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBack();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};



/////////////////////////////////////////////////////////////////////////////
// CUnzipFiles thread

class CUnzipFiles : public CWinThread
{
	DECLARE_DYNCREATE(CUnzipFiles)

// Attributes
public:
	CUnzipFiles();
	virtual ~CUnzipFiles();

// Operations
public:
	BOOL WasErrors;
	BOOL AddZip( CString aZipFileName );
	TStringCollection* BadZips;
	void Step();
	void StopUnzip();
	void StartUnzip();
	void KillThread();
	CUnzipDlg* m_pDlg;
	HANDLE m_hEventKill;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUnzipFiles)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
private:
	POSITION ZipsPos;
	CStringList Zips;

protected:

	// Generated message map functions
	//{{AFX_MSG(CUnzipFiles)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_UNZIPDLG_H__39FE6FFC_2D5E_4A9E_9B30_AAAF777CB229__INCLUDED_)
