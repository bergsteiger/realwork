#if !defined(AFX_SELECTBACKUPFOLDER_H__457668FD_12B7_4124_BB7D_5429E121A83D__INCLUDED_)
#define AFX_SELECTBACKUPFOLDER_H__457668FD_12B7_4124_BB7D_5429E121A83D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectBackupFolder.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectBackupFolderDlg dialog

class CSelectBackupFolderDlg : public CDialog
{
// Construction
public:
	CSelectBackupFolderDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectBackupFolderDlg)
	enum { IDD = IDD_SELECTBACKUPFOLDER_DIALOG };
	CButton	m_pCheck;
	CStatic	m_pNoDisks;
	CStatic	m_pFolder;
	CButton	m_pBrowse;
	CButton	m_pGroup;
	CStatic	m_pHelp;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectBackupFolderDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CSelectBackupFolderDlg)
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBrowse();
	virtual void OnOK();
	afx_msg void OnDoBackup();
	afx_msg void OnHelp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	BOOL isCheck;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTBACKUPFOLDER_H__457668FD_12B7_4124_BB7D_5429E121A83D__INCLUDED_)
