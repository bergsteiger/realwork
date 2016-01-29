#if !defined(AFX_SELECTBASEFOLDEREX_H__4697040A_B166_4FCF_B300_784AA5B73B5D__INCLUDED_)
#define AFX_SELECTBASEFOLDEREX_H__4697040A_B166_4FCF_B300_784AA5B73B5D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectBaseFolderEx.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolderEx dialog

class CSelectBaseFolderEx : public CDialog
{
// Construction
public:
	CSelectBaseFolderEx(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectBaseFolderEx)
	enum { IDD = IDD_SELECTBASEFOLDEREX_DIALOG };
	CStatic	m_pBasePath;
	CStatic	m_pSize;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectBaseFolderEx)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectBaseFolderEx)
	afx_msg void OnHelp();
	virtual BOOL OnInitDialog();
	virtual void OnCancel();
	afx_msg void OnBrowse();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTBASEFOLDEREX_H__4697040A_B166_4FCF_B300_784AA5B73B5D__INCLUDED_)
