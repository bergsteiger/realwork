//
// InetAccessSettings.cpp : implementation file
//

#include "stdafx.h"

#include <wininet.h>

#include "Downloader.h"
#include "InetAccessSettings.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CInetAccessSettingsDlg dialog

CInetAccessSettingsDlg::CInetAccessSettingsDlg (CWnd* pParent /*=NULL*/)
	: CDialog (CInetAccessSettingsDlg::IDD, pParent) {
	//{{AFX_DATA_INIT(CInetAccessSettingsDlg)
	//}}AFX_DATA_INIT

	m_open_type = INTERNET_OPEN_TYPE_PRECONFIG;
	m_is_proxy_authentication = FALSE;
	m_open_query_flags = 0;
	m_proxy_address = "";
	m_proxy_port = "";
	m_proxy_login = "";
	m_proxy_password = "";
}

void CInetAccessSettingsDlg::DoDataExchange (CDataExchange* pDX) {
	CDialog::DoDataExchange (pDX);
	//{{AFX_DATA_MAP(CInetAccessSettingsDlg)
	DDX_Control (pDX, IDC_RADIO_OPEN_TYPE_DIRECT,     m_rbOpenTypeDirect);
	DDX_Control (pDX, IDC_RADIO_OPEN_TYPE_PROXY,      m_rbOpenTypeProxy);
	DDX_Control (pDX, IDC_RADIO_OPEN_TYPE_PRECONFIG,  m_rbOpenTypePreconfig);
	DDX_Control (pDX, IDC_CHECK_RELOAD_CACHE,         m_cbUseReloadCache);
	DDX_Control (pDX, IDC_CHECK_NO_CACHE_WRITE,       m_cbNoCacheWrite);
	DDX_Control (pDX, IDC_CHECK_PROXY_AUTHENTICATION, m_cbProxyAuthentication);
	DDX_Control (pDX, IDC_EDIT_PROXY_NAME,            m_edtProxyAddress);
	DDX_Control (pDX, IDC_EDIT_PROXY_PORT,            m_edtProxyPort);
	DDX_Control (pDX, IDC_EDIT_PROXY_LOGIN,           m_edtProxyLogin);
	DDX_Control (pDX, IDC_EDIT_PROXY_PASSWORD,        m_edtProxyPassword);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP (CInetAccessSettingsDlg, CDialog)
	//{{AFX_MSG_MAP(CInetAccessSettingsDlg)
	ON_BN_CLICKED (IDC_RADIO_OPEN_TYPE_DIRECT,     OnRbTypeDirect)
	ON_BN_CLICKED (IDC_RADIO_OPEN_TYPE_PROXY,      OnRbTypeProxy)
	ON_BN_CLICKED (IDC_RADIO_OPEN_TYPE_PRECONFIG,  OnRbTypePreconfig)
	ON_BN_CLICKED (IDC_CHECK_RELOAD_CACHE,         OnCbReloadCache)
	ON_BN_CLICKED (IDC_CHECK_NO_CACHE_WRITE,       OnCbNoCacheWrite)
	ON_BN_CLICKED (IDC_CHECK_PROXY_AUTHENTICATION, OnCbProxyAuthentication)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP ()

/////////////////////////////////////////////////////////////////////////////
// CInetAccessSettingsDlg message handlers

BOOL CInetAccessSettingsDlg::OnInitDialog () {
	CDialog::OnInitDialog ();

	SetIcon (GetAppPtr ()->LoadIcon (IDR_MAINFRAME), TRUE);

	m_cbProxyAuthentication.SetCheck (m_is_proxy_authentication);

	if (m_open_type == INTERNET_OPEN_TYPE_PROXY) {
		this->SetProxyParamGroupState (TRUE);
		this->SetProxyAuthGroupState (m_is_proxy_authentication);
	} else {
		this->SetProxyGroupState (FALSE);
	}

	switch (m_open_type) {
		case INTERNET_OPEN_TYPE_PROXY:
			m_rbOpenTypeProxy.SetCheck (1);
			break;
		case INTERNET_OPEN_TYPE_DIRECT:
			m_rbOpenTypeDirect.SetCheck (1);
			break;
		case INTERNET_OPEN_TYPE_PRECONFIG:
			m_rbOpenTypePreconfig.SetCheck (1);
			break;
		default:
			m_rbOpenTypePreconfig.SetCheck (1);
			break;
	}

	if ((m_open_query_flags & INTERNET_FLAG_RELOAD) || (m_open_query_flags & INTERNET_FLAG_PRAGMA_NOCACHE)) {
		m_cbUseReloadCache.SetCheck (1);
	} 

	if (m_open_query_flags & INTERNET_FLAG_NO_CACHE_WRITE) {
		m_cbNoCacheWrite.SetCheck (1);
	}
		
	m_edtProxyAddress.SetWindowText (m_proxy_address);
	m_edtProxyPort.SetWindowText (m_proxy_port);
	m_edtProxyLogin.SetWindowText (m_proxy_login);
	m_edtProxyPassword.SetWindowText (m_proxy_password);
	
	return FALSE;  // return TRUE unless you set the focus to a control
}

void CInetAccessSettingsDlg::OnOK () {
	UpdateWindow ();

	m_edtProxyAddress.GetWindowText (m_proxy_address);
	m_edtProxyPort.GetWindowText (m_proxy_port);
	m_edtProxyLogin.GetWindowText (m_proxy_login);
	m_edtProxyPassword.GetWindowText (m_proxy_password);

	if (m_rbOpenTypeProxy.GetCheck ()) {
		m_open_type = INTERNET_OPEN_TYPE_PROXY;

		CString str_err;

		try {
			if (m_proxy_address.IsEmpty ()) {
				str_err.Format (IDS_ERROR_PROXY_ADDR_EMPTY);
				throw std::exception ();
			} 

			if (m_proxy_port.IsEmpty ()) {
				str_err.Format (IDS_ERROR_PROXY_PORT_EMPTY);
				throw std::exception ();
			} else {
				CString digits = m_proxy_port.SpanIncluding ("0123456789");
				if (digits != m_proxy_port) {
					str_err.Format (IDS_BAD_PROXYPORT);
					throw std::exception ();
				}
			}

			if (m_cbProxyAuthentication.GetCheck ()) {
				if (m_proxy_login.IsEmpty ()) {
					str_err.Format (IDS_ERROR_PROXY_LOGIN_EMPTY);
					throw std::exception ();
				}
				if (m_proxy_password.IsEmpty ()) {
					str_err.Format (IDS_ERROR_PROXY_PASSWORD_EMPTY);
					throw std::exception ();
				}
			}
		} catch (...) {
			CString title;
			title.LoadString (IDS_ATTENTION);
			MessageBox (str_err.GetBuffer (), title.GetBuffer ());
			return;
		}
	} else if (m_rbOpenTypeDirect.GetCheck ()) {
		m_open_type = INTERNET_OPEN_TYPE_DIRECT;
	} else if (m_rbOpenTypePreconfig.GetCheck ()) {
		m_open_type = INTERNET_OPEN_TYPE_PRECONFIG;
	}

	m_open_query_flags = 0;

	if (m_cbUseReloadCache.GetCheck ()) {
		m_open_query_flags |= INTERNET_FLAG_RELOAD | INTERNET_FLAG_PRAGMA_NOCACHE;
	}
	if (m_cbNoCacheWrite.GetCheck ()) {
		m_open_query_flags |= INTERNET_FLAG_NO_CACHE_WRITE;
	}

	CDialog::OnOK ();
}

void CInetAccessSettingsDlg::OnCancel () {
	CDialog::OnCancel ();
}

void CInetAccessSettingsDlg::OnRbTypeDirect () {
	m_edtProxyAddress.EnableWindow (FALSE);
	m_edtProxyPort.EnableWindow (FALSE);
}

void CInetAccessSettingsDlg::OnRbTypeProxy () {
	m_cbProxyAuthentication.EnableWindow (TRUE);
	this->SetProxyAuthGroupState (m_cbProxyAuthentication.GetCheck ());
	this->SetProxyParamGroupState (TRUE);
}

void CInetAccessSettingsDlg::OnRbTypePreconfig () {
	this->SetProxyGroupState (FALSE);
}

void CInetAccessSettingsDlg::OnCbReloadCache () {
}

void CInetAccessSettingsDlg::OnCbNoCacheWrite () {
}

void CInetAccessSettingsDlg::OnCbProxyAuthentication () {
	m_is_proxy_authentication = !m_is_proxy_authentication;
	this->SetProxyAuthGroupState (m_is_proxy_authentication);
}

void CInetAccessSettingsDlg::SetProxyAuthGroupState (BOOL bState) {
	m_edtProxyLogin.EnableWindow (bState);
	m_edtProxyPassword.EnableWindow (bState);
}

void CInetAccessSettingsDlg::SetProxyParamGroupState (BOOL bState) {
	m_edtProxyAddress.EnableWindow (bState);
	m_edtProxyPort.EnableWindow (bState);
}

void CInetAccessSettingsDlg::SetProxyGroupState (BOOL bState) {
	m_cbProxyAuthentication.EnableWindow (bState);
	this->SetProxyParamGroupState (bState);
	this->SetProxyAuthGroupState (bState);
}

void CInetAccessSettingsDlg::set_settings (const Internet::InternetAccessInfo& info) {
	m_open_type = info.access_type; 
	m_open_query_flags = info.open_query_flags; 

	m_proxy_address = info.proxy_info.host.c_str ();
	m_proxy_port = info.proxy_info.port.c_str ();
	m_proxy_login = info.proxy_info.login.c_str ();
	m_proxy_password = info.proxy_info.password.c_str ();
	m_is_proxy_authentication = (info.proxy_info.is_authentication)? TRUE : FALSE;
}

void CInetAccessSettingsDlg::get_settings (Internet::InternetAccessInfo& info) {
	info.access_type = m_open_type; 
	info.open_query_flags = m_open_query_flags; 

	info.proxy_info.host = m_proxy_address.GetBuffer ();
	info.proxy_info.port = m_proxy_port.GetBuffer ();
	info.proxy_info.login = m_proxy_login.GetBuffer ();
	info.proxy_info.password = m_proxy_password.GetBuffer ();
	info.proxy_info.is_authentication = (m_is_proxy_authentication == TRUE);
}

// end of...

