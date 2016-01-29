#if !defined(AFX_SELCTTREECTRL_H__FC9B8B53_ECD2_4688_BD37_06BEB43E08F9__INCLUDED_)
#define AFX_SELCTTREECTRL_H__FC9B8B53_ECD2_4688_BD37_06BEB43E08F9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// selcttreectrl.h : header file
//

class CTestBreeder32Dlg;
/////////////////////////////////////////////////////////////////////////////
// CSelctTreeCtrl window

class CSelctTreeCtrl : public CTreeCtrl
{
// Construction
public:
	CSelctTreeCtrl();

// Attributes
public:
	CTestBreeder32Dlg *pDlg;

// Operations
public:
	void SelectOrUnselect(HTREEITEM hTreeItem, BOOL bAddSel= FALSE);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelctTreeCtrl)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSelctTreeCtrl();

	// Generated message map functions
protected:
	void OnMyClick(NMHDR* pNMHDR, LRESULT* pResult, int left= 0);
	//{{AFX_MSG(CSelctTreeCtrl)
	afx_msg void OnKeydown(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnRclick(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnClick(NMHDR* pNMHDR, LRESULT* pResult);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELCTTREECTRL_H__FC9B8B53_ECD2_4688_BD37_06BEB43E08F9__INCLUDED_)
