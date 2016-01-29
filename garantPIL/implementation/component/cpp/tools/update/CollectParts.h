#if !defined(AFX_COLLECTPARTS_H__280B6F44_D2ED_4CF7_8FC7_A5412D3A0143__INCLUDED_)
#define AFX_COLLECTPARTS_H__280B6F44_D2ED_4CF7_8FC7_A5412D3A0143__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

// CollectParts.h : header file
//

#include "collect.h"
#include "Collection.h"

/////////////////////////////////////////////////////////////////////////////
// CCollectPartsDlg dialog

class CCollectParts;

class CCollectPartsDlg : public CDialog
{
// Construction
public:
	BOOL WasCanceled;
	CCollectParts*	pThread;

	BOOL StartCopying();
	BOOL WasErrors;
	BOOL ThreadFinished;
	void SetDestFile( CString aDestFileName );
	CCollectPartsDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CCollectPartsDlg)
	enum { IDD = IDD_COLLECTPARTS_DIALOG };
	CButton	m_pHelp;
	CStatic	m_pPartsCount;
	CStatic	m_pArchive;
	CListCtrl	m_pParts;
	CStatic	m_pResult;
	CButton	m_pNext;
	CButton	m_pBack;
	CProgressCtrl	m_pFilesProgress;
	CProgressCtrl	m_pProgress;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCollectPartsDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	void Finalize();

	// Generated message map functions
	//{{AFX_MSG(CCollectPartsDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBack();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

class CCollectParts : public CWinThread
{
	DECLARE_DYNCREATE(CCollectParts)

// Attributes
public:
	CCollectParts();
	virtual ~CCollectParts();

// Operations
public:
	void StopCopying();
	void StartCopying();
	void KillThread();
	void SetDestFile( CString aDestFileName, DWORD aDestFileSize );
	void AddPartFile( CString aPartFileName );
	void AddFileToCheck( CString aFileToCheck );
	void Step();

	CCollectPartsDlg* m_pDlg;
	HANDLE m_hEventKill;
	BOOL WasErrors;
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCollectParts)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CCollectParts)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

private:
	BOOL	FindPhase;
	BOOL	NextFile();

	DWORD DestFileSize;
	POSITION PartFileNamesPos;
	POSITION CheckFileNamesPos;
	CStringList PartFileNames;
	CStringList FilesToCheck;
	CString PartFileName;
	CString DestFileName;
	HANDLE FileToRead;
	HANDLE FileToWrite;
	LPVOID Buffer;

public:
	TStringCollection*	MissingFileNames;
	TStringCollection*	MissingFileDescs;
private:
	TStringCollection*	CheckedFileNames;
	TStringCollection*	NeededDescs;
	TLongCollection*	NeededExtensions;
	TLongCollection*	CheckedExtensions;
	long				countCheckedFiles;

	void	CheckPartFile( char* );
	void	CheckPartFiles( char* );
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COLLECTPARTS_H__280B6F44_D2ED_4CF7_8FC7_A5412D3A0143__INCLUDED_)
