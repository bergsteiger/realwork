#if !defined(AFX_PARTUPDATE_H__B0003779_CD41_4D54_AC97_71B947C741DB__INCLUDED_)
#define AFX_PARTUPDATE_H__B0003779_CD41_4D54_AC97_71B947C741DB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// PartUpdate.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CPartUpdateDlg dialog

class CPartUpdateDlg : public CDialog
{
// Construction
public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	CPartUpdateDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CPartUpdateDlg)
	enum { IDD = IDD_PARTUPDATE_DIALOG };
	CButton	m_pE;
	CStatic	m_pText;
	CListCtrl	m_pDeltas;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPartUpdateDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	CToolTipCtrl m_tooltip;
	// Generated message map functions
	//{{AFX_MSG(CPartUpdateDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnBack();
	virtual void OnCancel();
	afx_msg void OnE();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PARTUPDATE_H__B0003779_CD41_4D54_AC97_71B947C741DB__INCLUDED_)
