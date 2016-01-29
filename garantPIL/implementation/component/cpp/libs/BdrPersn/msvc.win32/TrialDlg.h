#if !defined(AFX_TRIALDLG_H__49AFEE38_E839_4A74_9CB4_CF0849B43130__INCLUDED_)
#define AFX_TRIALDLG_H__49AFEE38_E839_4A74_9CB4_CF0849B43130__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TrialDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// TrialDlg dialog

class TrialDlg : public CDialog
{
// Construction
public:
	TrialDlg(CWnd* pParent = NULL);   // standard constructor

	UINT m_prevCustomVl;

/*
#ifdef NEW_INRFC
		IDD_TRIAL_DLG1
#else
		IDD_TRIAL_DLG
#endif
*/
// Dialog Data
	//{{AFX_DATA(TrialDlg)
	enum { IDD = IDD_TRIAL_DLG };
	CStatic	m_Add1;
	CStatic	m_Add0;
	CEdit	m_EditCtrl;
	CButton	m_BttnNext;
	CButton	m_BttnHlp;
	int		m_iTrialType;
	CString	m_retVal;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(TrialDlg)
	public:
	virtual BOOL OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(TrialDlg)
	afx_msg void OnNext();
	afx_msg void OnChangeEditAnswer();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRIALDLG_H__49AFEE38_E839_4A74_9CB4_CF0849B43130__INCLUDED_)
