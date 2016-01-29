#if !defined(AFX_WAITSERVER2DIALOG_H__9D51128F_52DB_486E_AC0D_D04279ADFBE5__INCLUDED_)
#define AFX_WAITSERVER2DIALOG_H__9D51128F_52DB_486E_AC0D_D04279ADFBE5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// WaitServer2Dialog.h : header file
//

#include "AnimateDlgIcon.h"

/////////////////////////////////////////////////////////////////////////////
// CWaitServer2Dialog dialog

class CWaitServer2Dialog : public CDialog
{
// Construction
public:
	CWaitServer2Dialog(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CWaitServer2Dialog)
	enum { IDD = IDD_WAITSERVER2 };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	BOOL	Create();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWaitServer2Dialog)
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
	//{{AFX_MSG(CWaitServer2Dialog)
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

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_WAITSERVER2DIALOG_H__9D51128F_52DB_486E_AC0D_D04279ADFBE5__INCLUDED_)
