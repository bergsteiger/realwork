//
// StatusProcessDlg.h : header file
//

#if !defined(AFX_STATUSPROCESSDLG_H__6018C55D_3511_44DB_88E1_0AE20FE841C5__INCLUDED_)
#define AFX_STATUSPROCESSDLG_H__6018C55D_3511_44DB_88E1_0AE20FE841C5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "resource.h"
#include "AnimateDlgIcon.h"

#include "shared/Core/sys/AtomicOp.h"
#include <string>

/////////////////////////////////////////////////////////////////////////////
// CStatusProcessDlg dialog

class CStatusProcessDlg : public CDialog {
// Construction
public:
	CStatusProcessDlg (CWnd* pParent = NULL);  // standard constructor

	virtual ~CStatusProcessDlg ();

// Dialog data
	//{{AFX_DATA(CStatusProcessDlg)
	enum { IDD = IDD_DOWNLOAD_PROCESS };
	CStatic m_sStatusText;
	CStatic m_sComment;
	CStatic m_sImageProgress;
	CButton m_bCancel;
	CProgressCtrl m_pProgress;
	//}}AFX_DATA

// Overrides
protected:
	//{{AFX_VIRTUAL(CStatusProcessDlg)
	virtual void DoDataExchange (CDataExchange* pDX); // DDX/DDV support
	virtual void OnCancel ();
	//}}AFX_VIRTUAL

// Implementation
public:
	//void execute (ACE_THR_FUNC func, void* obj, bool is_connect);
	void execute (LPTHREAD_START_ROUTINE func, void* obj, bool is_connect);
	void terminate ();
	void wait ();

	void hide ();
	void lock (bool val);
	void set_status_text (LPCTSTR text);
	void set_comment_text (LPCTSTR text);
	void set_position (int pos);
	void animate (bool is_begin);
	void init (UINT format_id, const std::string& file_name, double file_length, int range_val);

	int message_box (const char* text, UINT type);

	inline bool is_cancel () const { 
		return m_is_cancel; 
	} 

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CStatusProcessDlg)
	virtual BOOL OnInitDialog ();
	afx_msg void OnTimer (UINT nIDEvent);
	afx_msg void OnShowWindow (BOOL bShow, UINT nStatus);
	afx_msg void OnKeyDown (UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()

// Attributes
private:
	enum TimerType {tt_None, tt_Animate, tt_Counter};

	CAnimateDlgIcon m_animate_icon;

	HANDLE m_handle;
	//ACE_thread_t m_tid;
	//ACE_hthread_t m_thandle;

	UINT m_timer_id;
	TimerType m_timer_type;
	
	std::string m_file_name;

	int m_upper;

	bool m_is_cancel;
	bool m_is_connect;

	Core::AtomicOp <long> m_has_init;
};

//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_STATUSPROCESSDLG_H__6018C55D_3511_44DB_88E1_0AE20FE841C5__INCLUDED_)
