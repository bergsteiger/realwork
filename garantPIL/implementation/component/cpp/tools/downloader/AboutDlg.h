//
// AboutDlg.h : header file
//

#if !defined(AFX_ABOUTDLG_H__1DB2545C_0649_4F35_8185_DE335AF83467__INCLUDED_)
#define AFX_ABOUTDLG_H__1DB2545C_0649_4F35_8185_DE335AF83467__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Resource.h"

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog {
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_ABOUTDLG_H__1DB2545C_0649_4F35_8185_DE335AF83467__INCLUDED_)
