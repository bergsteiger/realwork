#if !defined(AFX_SELECTBASEFOLDER_H__2573A039_791B_466A_A474_004FB18339FF__INCLUDED_)
#define AFX_SELECTBASEFOLDER_H__2573A039_791B_466A_A474_004FB18339FF__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelectBaseFolder.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolder dialog

class CSelectBaseFolder : public CDialog
{
// Construction
public:
	char selectedPath[ MAX_PATH ];
	CSelectBaseFolder(long aSplit, long aPacked, long aUnpacked, CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelectBaseFolder)
	enum { IDD = IDD_SELECTBASEFOLDER };
	CStatic	m_pFree;
	CStatic	m_pNeed;
	CStatic	m_pPath;

	long split, packed, unpacked;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelectBaseFolder)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelectBaseFolder)
	afx_msg void OnHelp();
	virtual void OnCancel();
	afx_msg void OnNext();
	afx_msg void OnBrowse();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

	void	ShowFree();
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELECTBASEFOLDER_H__2573A039_791B_466A_A474_004FB18339FF__INCLUDED_)
