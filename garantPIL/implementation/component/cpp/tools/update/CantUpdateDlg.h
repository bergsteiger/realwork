#if !defined(AFX_CANTUPDATEDLG_H__15AA8D87_051E_420C_B4CE_3FF36F5AF806__INCLUDED_)
#define AFX_CANTUPDATEDLG_H__15AA8D87_051E_420C_B4CE_3FF36F5AF806__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// CantUpdateDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CCantUpdateDlg dialog

class CCantUpdateDlg : public CDialog
{
// Construction
public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	CCantUpdateDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CCantUpdateDlg)
	enum { IDD = IDD_CANTUPDATE_DIALOG };
	CButton	m_pE;
	CListCtrl	m_pDeltas;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCantUpdateDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	CToolTipCtrl m_tooltip;
	// Generated message map functions
	//{{AFX_MSG(CCantUpdateDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBack();
	afx_msg void OnE();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CANTUPDATEDLG_H__15AA8D87_051E_420C_B4CE_3FF36F5AF806__INCLUDED_)
