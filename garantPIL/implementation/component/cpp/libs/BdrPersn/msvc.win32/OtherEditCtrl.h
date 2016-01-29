#if !defined(AFX_OTHEREDITCTRL_H__93960C18_9661_402B_928B_014E881C981B__INCLUDED_)
#define AFX_OTHEREDITCTRL_H__93960C18_9661_402B_928B_014E881C981B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// OtherEditCtrl.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// COtherEditCtrl window

class COtherEditCtrl : public CEdit
{
// Construction
public:
	COtherEditCtrl();

// Attributes
public:
	CDialog *pParentDlg;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COtherEditCtrl)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~COtherEditCtrl();

	// Generated message map functions
protected:
	//{{AFX_MSG(COtherEditCtrl)
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_OTHEREDITCTRL_H__93960C18_9661_402B_928B_014E881C981B__INCLUDED_)
