#if !defined(AFX_BADDELTASDLG_H__90A35A92_3B51_4516_A606_CC9BD6AEC291__INCLUDED_)
#define AFX_BADDELTASDLG_H__90A35A92_3B51_4516_A606_CC9BD6AEC291__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// BadDeltasDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CBadDeltasDlg dialog

class CCheckDeltas;

class CBadDeltasDlg : public CDialog
{
// Construction
public:
	BOOL StartChecking();
	CCheckDeltas*	pThread;
	CBadDeltasDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CBadDeltasDlg)
	enum { IDD = IDD_BADDELTAS_DIALOG };
	CButton	m_pHelp;
	CButton	m_pBack;
	CButton	m_pNext;
	CStatic	m_pResult;
	CStatic	m_pCount;
	CProgressCtrl	m_pProgress;
	CListCtrl	m_pDeltas;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CBadDeltasDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CBadDeltasDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBack();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////
// CCheckDeltas thread

class CCheckDeltas : public CWinThread
{
	DECLARE_DYNCREATE(CCheckDeltas)

public:
	CCheckDeltas();
	virtual ~CCheckDeltas();

// Operations
public:
	void AddDeltaToCheck( CString aDeltaFileName );
	void StopChecking();
	void StartChecking();
	void Step();
	void KillThread();
	HANDLE m_hEventKill;
	CBadDeltasDlg* m_pDlg;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCheckDeltas)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CCheckDeltas)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	BOOL NextDelta();
	CStringList DeltasToCheck;
	POSITION DeltasToCheckPos;
};

/////////////////////////////////////////////////////////////////////////////
//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_BADDELTASDLG_H__90A35A92_3B51_4516_A606_CC9BD6AEC291__INCLUDED_)
