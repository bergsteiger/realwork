//
// InetAccessSettings.h : header file
//

#if !defined (AFX_INETACCESSSETTINGS_H__25251FE4_44D1_48E0_BE97_45E82456808E__INCLUDED_)
#define AFX_INETACCESSSETTINGS_H__25251FE4_44D1_48E0_BE97_45E82456808E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "shared/Internet/Inet/Inet.h"

/////////////////////////////////////////////////////////////////////////////
// CInetAccessSettingsDlg dialog

class CInetAccessSettingsDlg : public CDialog {
// Construction
public:
	CInetAccessSettingsDlg (CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CInetAccessSettingsDlg)
	enum { IDD = IDD_INTERNET_ACCESS_SETTINGS };
	CButton m_rbOpenTypeDirect;
	CButton m_rbOpenTypeProxy;
	CButton m_rbOpenTypePreconfig;

	CButton m_cbUseReloadCache;
	CButton m_cbNoCacheWrite;
	CButton m_cbProxyAuthentication;

	CEdit m_edtProxyAddress;
	CEdit m_edtProxyPort;
	CEdit m_edtProxyLogin;
	CEdit m_edtProxyPassword;
	//}}AFX_DATA

// Overrides
protected:
	//{{AFX_VIRTUAL(CInetAccessSettingsDlg)
	virtual void DoDataExchange (CDataExchange* pDX); // DDX/DDV support
	virtual void OnOK ();
	virtual void OnCancel ();
	//}}AFX_VIRTUAL

// Implementation
public:
	void set_settings (const Internet::InternetAccessInfo& info);
	void get_settings (Internet::InternetAccessInfo& info);

// Implementation
protected:
	// Generated message map functions
	//{{AFX_MSG(CInetAccessSettingsDlg)
	virtual BOOL OnInitDialog ();
	afx_msg void OnRbTypeDirect ();
	afx_msg void OnRbTypeProxy ();
	afx_msg void OnRbTypePreconfig ();
	afx_msg void OnCbReloadCache ();
	afx_msg void OnCbNoCacheWrite ();
	afx_msg void OnCbProxyAuthentication ();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP ()

private:
	void SetProxyGroupState (BOOL bState);
	void SetProxyAuthGroupState (BOOL bState);
	void SetProxyParamGroupState (BOOL bState);

private:
	DWORD m_open_type;
	DWORD m_open_query_flags;

	CString m_proxy_address;
	CString m_proxy_port;
	CString m_proxy_login;
	CString m_proxy_password;

	BOOL m_is_proxy_authentication;
};

//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_INETACCESSSETTINGS_H__25251FE4_44D1_48E0_BE97_45E82456808E__INCLUDED_)
