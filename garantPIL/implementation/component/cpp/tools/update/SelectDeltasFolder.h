#if !defined(AFX_SELECTDELTASFOLDER_H__72A3B60C_FAAD_4B0D_A47B_289F90A2A550__INCLUDED_)
#define AFX_SELECTDELTASFOLDER_H__72A3B60C_FAAD_4B0D_A47B_289F90A2A550__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectDeltasFolder.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectDeltasFolderDlg dialog

class CSelectDeltasFolderDlg : public CDialog
{
// Construction
public:
	CSelectDeltasFolderDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectDeltasFolderDlg)
	enum { IDD = IDD_SELECTDELTASFOLDER_DIALOG };
	CButton	m_pOk;
	CStatic	m_pDeltasFolder;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectDeltasFolderDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CSelectDeltasFolderDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnBack();
	afx_msg void OnBrowse();
	virtual void OnCancel();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTDELTASFOLDER_H__72A3B60C_FAAD_4B0D_A47B_289F90A2A550__INCLUDED_)
