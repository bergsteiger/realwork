#if !defined(AFX_SCROLLINFO_H__AB001BBA_7227_4AF8_BF00_19D649AB9E0C__INCLUDED_)
#define AFX_SCROLLINFO_H__AB001BBA_7227_4AF8_BF00_19D649AB9E0C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Scrollinfo.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CScrollinfo window

class CScrollinfo : public CListBox
{
// Construction
public:
	CScrollinfo();

// Attributes
public:

// Operations
public:
	void SetText(LPCTSTR);
	int LocalAddString(LPCTSTR lpszItem);

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CScrollinfo)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CScrollinfo();

	// Generated message map functions
protected:
	//{{AFX_MSG(CScrollinfo)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SCROLLINFO_H__AB001BBA_7227_4AF8_BF00_19D649AB9E0C__INCLUDED_)
