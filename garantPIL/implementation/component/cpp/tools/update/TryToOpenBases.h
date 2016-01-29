#if !defined(AFX_TRYTOOPENBASESDLG_H__A511D942_D9DB_44B4_BEF7_732FF5A0A3B1__INCLUDED_)
#define AFX_TRYTOOPENBASESDLG_H__A511D942_D9DB_44B4_BEF7_732FF5A0A3B1__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TryToOpenBases.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CTryToOpenBasesDlg dialog

class CTryToOpenBases;

class CTryToOpenBasesDlg : public CDialog
{
// Construction
public:
	void AddFileToCheck( CString aFileName );
	BOOL Success;
	BOOL StartChecking();
	CTryToOpenBases* pThread;
	CTryToOpenBasesDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CTryToOpenBasesDlg)
	enum { IDD = IDD_TRYOPENBASES_DIALOG };
	CProgressCtrl	m_pProgress;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTryToOpenBasesDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CTryToOpenBasesDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CStringList MoreFilesToCheck;
};



/////////////////////////////////////////////////////////////////////////////
// CTryToOpenBases thread

class CTryToOpenBases : public CWinThread
{
	DECLARE_DYNCREATE(CTryToOpenBases)

// Attributes
public:
	CTryToOpenBases();
	virtual ~CTryToOpenBases();

private:
	CTime LastCheckTime;
	BOOL IsFileOk();
	CTime StartTime;
	BOOL NextFile();
	POSITION FilesToCheckPos;
	CStringList FilesToCheck;
	BOOL IsWaiting;
	
	// Operations
public:
	CString FileNameToCheck;
	BOOL Success;
	CTryToOpenBasesDlg* m_pDlg;
	void StopChecking();
	void StartChecking();
	void AddFileToCheck( CString aFileToCheck );
	void KillThread();
	void Step();
	HANDLE m_hEventKill;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTryToOpenBases)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CTryToOpenBases)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

BOOL	TryToOpenBases( CStringList* aMoreFiles = NULL );

/////////////////////////////////////////////////////////////////////////////
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRYTOOPENBASESDLG_H__A511D942_D9DB_44B4_BEF7_732FF5A0A3B1__INCLUDED_)
