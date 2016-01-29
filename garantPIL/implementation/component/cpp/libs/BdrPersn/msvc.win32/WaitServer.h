#if !defined(AFX_WAITSERVER_H__B08FF523_B344_4161_9922_ADC107AF75FD__INCLUDED_)
#define AFX_WAITSERVER_H__B08FF523_B344_4161_9922_ADC107AF75FD__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// WaitServer.h : header file
//

#include "../../../tools/update/AnimateDlgIcon.h"
#include "TestBreeder32.h"

/////////////////////////////////////////////////////////////////////////////
// CWaitServer dialog

class CWaitServer : public CDialog
{
// Construction
public:
	CWaitServer(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitServer)
	enum { IDD = IDD_WAITSERVER };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitServer)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	HANDLE	hThread;
	CAnimateDlgIcon m_animIcon;
	UINT m_timerID;
	CStatic m_sImageProgress;

	// Generated message map functions
	//{{AFX_MSG(CWaitServer)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	virtual void OnOK();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnDestroy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	void	NextIcon();
};

class CWaitUsers: public CDialog
{
// Construction
public:
	CWaitUsers(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitServer)
	enum { IDD = IDD_WAITUSERS };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitUsers)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	HANDLE	hThread;
	CAnimateDlgIcon m_animIcon;
	UINT m_timerID;
	CStatic m_sImageProgress;

	// Generated message map functions
	//{{AFX_MSG(CWaitUsers)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	virtual void OnOK();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnDestroy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	void	NextIcon();
};

class CWaitXml: public CDialog
{
// Construction
public:
	CWaitXml(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitXml)
	enum { IDD = IDD_WAITXML };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitXML)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	HANDLE	hThread;
	CAnimateDlgIcon m_animIcon;
	UINT m_timerID, m_timerIDXml;
	CStatic m_sImageProgress;
	CString m_Login, m_Password;
	UpdateRunner* update_runner;
	long	sleep_time;

	// Generated message map functions
	//{{AFX_MSG(CWaitXML)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	virtual void OnOK();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnDestroy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	void	NextIcon();
	void	SetUpdateRunner (UpdateRunner* ur) { update_runner = ur; }
	void	SetLoginPassword (CString aLogin, CString aPassword) { m_Login = aLogin; m_Password = aPassword; }
};

class CWaitServerStart : public CDialog
{
// Construction
public:
	CWaitServerStart(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitXml)
	enum { IDD = IDD_WAITSERVERSTART };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitServerStart)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	HANDLE	hThread;
	CAnimateDlgIcon m_animIcon;
	UINT m_timerID, m_timerIDServerStart;
	CStatic m_sImageProgress;
	CString m_Login, m_Password;
	UpdateRunner* update_runner;
	long	sleep_time;

	// Generated message map functions
	//{{AFX_MSG(CWaitXML)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	virtual void OnOK();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnDestroy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	void	NextIcon();
	void	SetUpdateRunner (UpdateRunner* ur) { update_runner = ur; }
	void	SetLoginPassword (CString aLogin, CString aPassword) { m_Login = aLogin; m_Password = aPassword; }
};

class CUpdateComplete : public CDialog
{
// Construction
public:
	CUpdateComplete(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CUpdateComplect)
	enum { IDD = IDD_UPDATECOMPLETE };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUpdateComplete)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CUpdateComplete)
	virtual void OnCancel();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

class CWaitDatasetupGarantRu : public CDialog
{
// Construction
public:
	CWaitDatasetupGarantRu(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitDatasetupGarantRu)
	enum { IDD = IDD_WAITGARANTRU};
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitDatasetupGarantRu)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CWaitDatasetupGarantRu)
	virtual void OnCancel();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

class CWaitServerStart2 : public CDialog
{
// Construction
public:
	CWaitServerStart2(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitServerStart2)
	enum { IDD = IDD_WAITSERVERSTART2};
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitServerStart2)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CWaitServerStart2)
	virtual void OnCancel();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_WAITSERVER_H__B08FF523_B344_4161_9922_ADC107AF75FD__INCLUDED_)
