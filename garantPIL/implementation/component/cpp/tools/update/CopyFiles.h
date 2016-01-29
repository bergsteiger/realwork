#if !defined(AFX_COPYFILES_H__C3ADF666_C10C_4346_AB90_76B944043CFC__INCLUDED_)
#define AFX_COPYFILES_H__C3ADF666_C10C_4346_AB90_76B944043CFC__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CCopyFilesDlg dialog

class CCopyFilesDlg;

class CCopyFiles : public CWinThread
{
public:
	DECLARE_DYNCREATE(CCopyFiles)

	CCopyFiles();           // protected constructor used by dynamic creation
	virtual ~CCopyFiles();

// Attributes
public:
	CCopyFilesDlg* m_pDlg;
	BOOL	WasErrors;
	HANDLE	m_hEventKill;
	int TitleID;

// Operations
public:
	void	KillThread();
	void	Step();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCopyFiles)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
public:
	void StopCopying();
	void StartCopying();
	void AddDestFile( CString aFileName );
	void AddSourceFile( CString aFileName );

protected:
	// Generated message map functions
	//{{AFX_MSG(CCopyFiles)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

private:
	DWORD ProgressPos;
	CString DestFileName;
	CString SourceFileName;
	LPVOID Buffer;
	BOOL NextFile();
	HANDLE FileToWrite;
	HANDLE FileToRead;
	POSITION SourceFileNamesPos;
	POSITION DestFileNamesPos;
	CStringList DestFileNames;
	CStringList SourceFileNames;

	BOOL	YesNoBox( UINT, UINT aTitleID = IDS_CONFIRM, UINT aIconID = IDI_BEWARNING, CString aAdd = "" );
};

class CCopyFilesDlg : public CDialog
{
// Construction
public:
	CStringList OkFiles;
	CStringList RenamedFiles;
	CStringList CanBeNewFiles;
	CCopyFiles*	pThread;

	CCopyFilesDlg( int aTitleID = IDS_COPYINGFILE, CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CCopyFilesDlg)
	enum { IDD = IDD_COPYFILES_DIALOG };
	CProgressCtrl	m_pProgress;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCopyFilesDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CCopyFilesDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	BOOL	StartCopying();
	void	AddDestFile( CString aFileName );
	void	AddSourceFile( CString aFileName );
	void	AddCanBeNewFile( CString aFileName );

private:
	int TitleID;
	CStringList DestFileNames;
	CStringList SourceFileNames;

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COPYFILES_H__C3ADF666_C10C_4346_AB90_76B944043CFC__INCLUDED_)
