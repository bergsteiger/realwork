//
// Downloader.h : main header file for the DOWNLOADER application
//

#if !defined (AFX_DOWNLOADER_H__A7CDB7FD_5F9D_4BB3_A749_609EC2305F0C__INCLUDED_)
#define AFX_DOWNLOADER_H__A7CDB7FD_5F9D_4BB3_A749_609EC2305F0C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "shared/GCL/os/DllLoader.h"
#include "shared/Internet/Inet/Inet.h"

#include "resource.h"
#include <vector>

struct Complect {
	unsigned id;
	std::string name;

	bool operator < (const Complect& val) const {
		return name < val.name;
	}
};

typedef std::vector <Complect> Complects;

// Статус авторизации
enum AuthStatus { as_Succesful, as_InvalidLogin, as_InvalidData, as_Error };

// Значения кода возврата
enum ReturnCode { rc_Succesful, rc_NoUpdate, rc_Error };

// Состояние процесса загрузки
enum DownloadState {
	ds_None
	, ds_Success
	, ds_Abort
	, ds_Cancel
	, ds_NoUpdate
	, ds_Repeat
	, ds_Error
	, ds_Close
};

/////////////////////////////////////////////////////////////////////////////
// CDownloaderApp class 

class CDownloaderApp : public CWinApp {
public:
	CDownloaderApp ();

	~CDownloaderApp ();

// Overrides
	//{{AFX_VIRTUAL(CDownloaderApp)
public:
	virtual BOOL InitInstance ();
	virtual int ExitInstance ();
	//}}AFX_VIRTUAL

private:
	// Константы определяющие язык ресурсов
	enum ResourceLanguage { rs_Russian, rs_English };

// Implementation
public:
	void execute ();

	AuthStatus authorization (const char* login, const char* password, bool is_strong);

	bool server_connect ();
	bool server_connect (bool is_reconnect);

	void write_inet_settings (const Internet::InternetAccessInfo& info);
	void read_inet_settings ();

	std::string get_path ();
	std::string get_complect_name (unsigned id);

	long get_complect_id ();

	void show_help (const char* page_htm);

// Inline implementation
public:
	inline bool is_auto () const {
		return m_is_auto;
	}

	inline bool is_rewrite () const {
		return m_is_rewrite;
	}

	inline void set_etalon_value (bool value) {
		m_is_etalon = value;
	}

	inline void set_state (DownloadState value) {
		m_state = value;
	}

	inline void set_personification_key (const std::string& key) {
		m_personification_key = key;
	}

	inline DownloadState get_state () const {
		return m_state;
	}

	inline int get_time_limit_connect () const {
		return m_time_limit_connect;
	}

	inline Internet::InternetAccessInfo& get_internet_access_info () {
		return m_access_info;
	}

	inline const std::string& get_ini_file () const {
		return m_ini_name;
	}

	inline const std::string& get_date_from () const {
		return m_date_from;
	}

	inline const std::string& get_date_to () const {
		return m_date_to;
	}

	inline const Complects& get_complects () const {
		return m_complects;
	}

	inline COleDateTime& get_revision () {
		return m_revision_date;
	}

	inline void set_init () {
		m_has_init = 1;
	}

	// Generated message map functions
	//{{AFX_MSG(CDownloaderApp)
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP ()

// Implementation
private:
	bool is_first_application ();

	void initialize ();
	void init_params ();

	void set_local_resource (const char* dll_name);

	void start_corba_client ();
	void start_auto ();         // start in automatic mode
	void start_manual ();       // start in manual mode
	void start_update ();       // start update

	AuthStatus init_complects (Internet::IConnection* connection); // init user's complect

private:
	HANDLE m_app_handle;

	Internet::InternetAccessInfo m_access_info; // internet access settings

	Core::Aptr <GCL::DllLoader> m_res_loader;   // resource loader
	Core::AtomicOp <long> m_has_init;

	bool m_is_auto;                    // auto mode flag
	bool m_is_week;                    // only week
	bool m_is_strong;                  // mode of the run application
	bool m_is_run_update;              // run of update utilite
	bool m_is_rewrite;                 // rewrite mode flag (only for auto mode)
	bool m_is_etalon;

	long m_complect_id;                // complect's id
	long m_time_limit_connect;         // time limit of attempts of connections

	DownloadState m_state;             // download state
	ReturnCode m_return_value;         // return code
	Complects m_complects;             // user's complects (initialized by the data from server)
	COleDateTime m_revision_date;      // revision date (initialized by the data from nemesis server)

	std::string m_module_path;         // module path
	std::string m_ini_name;            // ini file name
	std::string m_default_server;      // default server name
	std::string m_default_path;        // default path
	std::string m_date_from;           // default begin date
	std::string m_date_to;             // default end date
	std::string m_user_agent;          // user agent value
	std::string m_personification_key; // personification key
};

static inline CDownloaderApp* GetAppPtr () {
	return (static_cast <CDownloaderApp*> (AfxGetApp ()));
}

/////////////////////////////////////////////////////////////////////////////
//{{AFX_INSERT_LOCATION}}

#endif // !defined(AFX_DOWNLOADER_H__A7CDB7FD_5F9D_4BB3_A749_609EC2305F0C__INCLUDED_)
