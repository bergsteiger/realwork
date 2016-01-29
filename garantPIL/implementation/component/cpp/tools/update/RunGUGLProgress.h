#if !defined(AFX_RUNGUGLPROGRESS_H__1C324D0F_3C9D_4844_A639_863D398EDEE6__INCLUDED_)
#define AFX_RUNGUGLPROGRESS_H__1C324D0F_3C9D_4844_A639_863D398EDEE6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "pscreen.h"
#include "AnimateDlgIcon.h"

class RunGUGLProgress;

class UpdateScreen : public ProgressScreen
{
protected:
    virtual void RealInitScreen( const char* );
	virtual void ShowMessage( const char *, int sub = 0 );
	virtual void ShowProgress( void );

public:
	UpdateScreen( code_t i, code_t o ) : ProgressScreen( i, o ) {};

	virtual void CloseScreen();

public:
	RunGUGLProgress *m_pDlg;
};


/////////////////////////////////////////////////////////////////////////////
// RunGUGLProgress dialog

class RunGUGLProgress : public CDialog
{
// Construction
public:
	RunGUGLProgress( bool aRemote, BOOL aGU, char* aParam1, char* aParam2 = "", CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(RunGUGLProgress)
	enum { IDD = IDD_RUNGUGL };
	CStatic	m_pMessage2;
	CStatic	m_pMessage;
	CProgressCtrl	m_pProgress;
	//}}AFX_DATA

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(RunGUGLProgress)
	public:
	virtual BOOL OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

// Implementation
protected:
	HANDLE	hThread;
	CAnimateDlgIcon m_animIcon;
	UINT m_timerID;

	// Generated message map functions
	//{{AFX_MSG(RunGUGLProgress)
	virtual BOOL OnInitDialog();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnDestroy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

public:
	UpdateScreen* updateScreen;
	BOOL	GU;
	CString	Param1, Param2;
	bool	remote;

	BOOL	Create();
};


typedef void (*DoGLFunction)( char*, char*, ProgressScreen *screen );
typedef void (*DoGL_lFunction)( char*, char*, ProgressScreen *screen, int );
typedef void (*DoGUFunction)( char*, ProgressScreen *screen );

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_RUNGUGLPROGRESS_H__1C324D0F_3C9D_4844_A639_863D398EDEE6__INCLUDED_)
