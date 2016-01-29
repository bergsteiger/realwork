#if !defined(AFX_PATHMSGDLG_H__CF48DC29_D342_4752_8ADF_7C3C0A3A51E7__INCLUDED_)
#define AFX_PATHMSGDLG_H__CF48DC29_D342_4752_8ADF_7C3C0A3A51E7__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// PathMsgDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CPathMsgDlg dialog

class CPathMsgDlg : public CDialog
{
// Construction
public:
	CPathMsgDlg(CWnd* pParent = NULL);   // standard constructor

	CString m_NewPath;

// Dialog Data
	//{{AFX_DATA(CPathMsgDlg)
	enum { IDD = IDD_BROWSEDLG };
	CString	m_Message;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPathMsgDlg)
	public:
	virtual BOOL OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CPathMsgDlg)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PATHMSGDLG_H__CF48DC29_D342_4752_8ADF_7C3C0A3A51E7__INCLUDED_)
