//
// InternetFileDownload.h: interface for the DownloadManager class.
//

#ifndef __INTERNET_FILE_DOWNLOAD_H__
#define __INTERNET_FILE_DOWNLOAD_H__

#include "shared/Internet/Inet/Inet.h"

#include "Downloader.h"
#include "DownloadParams.h"
#include "StatusProcessDlg.h"

#define PS_SUCCESS                    0
#define PS_ERROR_GET_INFO             1
#define PS_ERROR_HTTP_REQUEST         2
#define PS_ERROR_NOT_ENOUGH_SPACE     3
#define PS_TERMINATE_DOWNLOAD_THREAD  4
#define PS_FILE_EXCEPTION             5
#define PS_ERROR_GET_INFO_STATUS4     6

enum ExValue { ev_None, ev_BreakConnection, ev_NoUpdate, ev_Error, ev_CancelProcess };

/////////////////////////////////////////////////////////////////////////////////////
// Download exceptions definitions

class CancelProcess
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "download canceled";
	}
};

class ErrorProcess
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "download error";
	}
};

class AbortedProcess
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "download aborted";
	}
};

class NoUpdate
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "no update";
	}
};

class BreakConnection
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "break connection";
	}
};

class TerminateConnection
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "terminate connection";
	}
};

/////////////////////////////////////////////////////////////////////////////////////
// DownloadManager class definition

class DownloadManager {
public:
	DownloadManager (const std::string& path);

	virtual ~DownloadManager ();
	
public:
	DownloadState execute (long id, const std::string& from, const std::string& to, long order_id);

	void download ();
	void connect ();

	inline void set_ex_value (const ExValue& value) {
		m_ex_value = value;
	}

private:
	std::string get_full_path ();

	bool set_mode ();
	bool is_reconnect ();

	void header_analysis ();
	void receive_file_name ();
	void receive_file_length ();

	void do_modal ();
	void end_download ();
	void check_connect ();
	void run ();

private:
	WORD m_err_value;

	ExValue m_ex_value;

	DownloadMode m_mode;

	CStatusProcessDlg m_dlg;

	std::string m_obj;
	std::string m_path;
	std::string m_err_msg;
	std::string m_file_name;

	Core::AtomicOp <long> m_is_check;

	Core::Aptr <DownloadFileParams> m_file_params;

	Internet::IConnection_var m_connection;

	__int64 m_file_length;

	unsigned long m_indicator_count;
	unsigned long m_event_id;

	bool m_is_restore;
};

#endif // __INTERNET_FILE_DOWNLOAD_H__
