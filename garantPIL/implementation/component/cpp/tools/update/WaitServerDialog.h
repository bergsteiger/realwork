#if !defined(AFX_WAITSERVERDIALOG_H__CC74911E_8EA0_470A_9677_ED9FC85F5D0C__INCLUDED_)
#define AFX_WAITSERVERDIALOG_H__CC74911E_8EA0_470A_9677_ED9FC85F5D0C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// WaitServerDialog.h : header file
//

#include "AnimateDlgIcon.h"

/////////////////////////////////////////////////////////////////////////////
// CWaitServerDialog dialog

class CWaitServerDialog : public CDialog
{
// Construction
public:
	CWaitServerDialog(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitServerDialog)
	enum { IDD = IDD_WAITSERVER };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitServerDialog)
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
	//{{AFX_MSG(CWaitServerDialog)
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

/////////////////////////////////////////////////////////////////////////////
// CWaitServerDialog dialog

class CWaitServer1Dialog : public CDialog
{
// Construction
public:
	CWaitServer1Dialog(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWait1ServerDialog)
	enum { IDD = IDD_WAITSERVER1 };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitServer1Dialog)
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
	//{{AFX_MSG(CWaitServer1Dialog)
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

class CWaitXmlDialog : public CDialog
{
// Construction
public:
	CWaitXmlDialog(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitXmlDialog)
	enum { IDD = IDD_WAITXML};
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitXmlDialog)
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
	//{{AFX_MSG(CWaitXmlDialog)
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

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_WAITSERVERDIALOG_H__CC74911E_8EA0_470A_9677_ED9FC85F5D0C__INCLUDED_)
