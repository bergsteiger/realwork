//
// InternetFileDownload.cpp: implementation of the DownloadManager class.
//

#include "stdafx.h"

#include <boost/thread.hpp>
#include "boost/lexical_cast.hpp"

#include "shared/Internet/impl/Inet_i/Utility.h"
#include "shared/GCL/str/str_conv.h"
#include "shared/jsoncpp/json.h"

#include "LogFile.h"
#include "ServerConnect.h"
#include "DownloadProcess.h"
#include "InternetFileDownload.h"

/////////////////////////////////////////////////////////////////////////////////////

static const unsigned long BUFF_SIZE = 16 * 1024;

static double get_size_Mb (__int64 val) {
	return val / (1024. * 1024.);
}

struct FileDestructor {
	static void destroy (CFile* p) {
		if (p) {
			p->Close ();
			delete p;
		}
	}
};

struct FreeSpaceChecker {
	static bool check (__int64 file_size, char drive) {
		struct _diskfree_t df = {0};

		if (drive >= 'A' && drive <= 'Z' && _getdiskfree ((unsigned)(drive - 'A' + 1), &df) == 0) {
			__int64 free_bytes = (__int64) df.avail_clusters * (__int64) df.sectors_per_cluster	* (__int64) df.bytes_per_sector;
			return file_size < free_bytes;
		}

		return true;
	}
};

/////////////////////////////////////////////////////////////////////////////////////

class Watcher {
public:
	Watcher () {
		this->reset ();
	}

	void reset () {
		m_limit = 0; 
		m_start = 0; 
		m_count = 0;
	}

	void activate (int limit) {
		if (m_limit == 0) {
			m_limit = limit * 60000;
			m_start = GetTickCount ();
		}
	}

	bool execute (unsigned int sec) {
		if (m_count < m_limit) {
			m_count = GetTickCount () - m_start;
			ACE_OS::sleep (sec);
			return true;
		}
		return false;
	}

	bool execute (const ACE_Time_Value& tv) {
		if (m_count < m_limit) {
			m_count = GetTickCount () - m_start;
			ACE_OS::sleep (tv);
			return true;
		}
		return false;
	}

	bool is_active () const {
		return (m_limit != 0);
	}

private:
	DWORD m_limit;
	DWORD m_start; 
	DWORD m_count;
};

/////////////////////////////////////////////////////////////////////////////////////
// thread functions

static void connect_ (void* param) {
	DownloadManager* obj = static_cast <DownloadManager*> (param);

	GDS_ASSERT (obj);

	try {
		obj->connect ();
		obj->set_ex_value (ev_None);
	} catch (BreakConnection&) {
		obj->set_ex_value (ev_BreakConnection);
	} catch (NoUpdate&) {
		obj->set_ex_value (ev_NoUpdate);
	} catch (ErrorProcess&) {
		obj->set_ex_value (ev_Error);
	} catch (CancelProcess&) {
		obj->set_ex_value (ev_CancelProcess);
	} catch (...) {
		obj->set_ex_value (ev_Error);
	}
}

static void download_ (void* param) {
	DownloadManager* obj = static_cast <DownloadManager*> (param);

	GDS_ASSERT (obj);

	try {
		obj->download ();
	} catch (...) {
	}
}

/////////////////////////////////////////////////////////////////////////////////////

DownloadManager::DownloadManager (const std::string& path) 
	: m_mode (dm_None)
	, m_path (path)
	, m_event_id (0)
	, m_indicator_count (0)
{
	if (m_path.empty () == false) {
		try {
			CreateDirectory (m_path.c_str (), NULL);
		} catch (...) {
			DLOG->out_t ("%s: CreateDirectory fail: %s", GDS_CURRENT_FUNCTION, path);
		}
	} else {
		DLOG->out_t ("%s: invalid path: %s", GDS_CURRENT_FUNCTION, path);
	}
}

DownloadManager::~DownloadManager () {
}

/////////////////////////////////////////////////////////////////////////////////////
// TODO:
// - не выбрасывается exception при обрыве связи и в wininet не реализован INTERNET_OPTION_DISCONNECTED_TIMEOUT
// - непонятки с таймаутами (один раз выставляем и больше изменить не получается)

/////////////////////////////////////////////////////////////////////////////////////

DownloadState DownloadManager::execute (long id, const std::string& from, const std::string& to, long order_id) {
	DownloadState ret = ds_Success;

	m_obj = ScriptManagerSingleton::instance ()->create_order (id, from, to, order_id);

	DLOG->out_t_ext ("OBJ: %s", m_obj.c_str ());

	boost::thread dlg_thread (boost::bind (&DownloadManager::do_modal, this));

	m_dlg.wait ();

	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	try {
		m_file_params = new DownloadFileParams (id, from, to, GetAppPtr ()->get_ini_file (), m_path);

		this->run ();
	} catch (CancelProcess&) {
		ret = ds_Cancel;
	} catch (ErrorProcess&) {
		ret = ds_Error;
	} catch (AbortedProcess&) {
		ret = ds_Abort;
	} catch (NoUpdate&) {
		ret = ds_NoUpdate;
	} catch (TerminateConnection&) {
		ret = ds_Error;
	} catch (...) {
		ret = ds_Error;
	}

	std::string str = boost::lexical_cast <std::string> (ret);
	DLOG->out_t_ext ("CODE: %s", str.c_str ());

	if (ret != ds_NoUpdate) {
		if (m_err_value) {
			ret = ds_Repeat;

			std::string str = m_err_msg;

			if (str.empty () == false && *(str.end () - 1) == '\n') {
				str.erase (str.end () - 1);
			}

			CString str_err;

			if (m_err_value == PS_ERROR_NOT_ENOUGH_SPACE) {
				str_err.Format (IDS_NOT_ENOUGH_SPACE);
			} else if (m_err_value == PS_ERROR_GET_INFO) {
				str_err.Format (IDS_ERROR_HTTP_GETINFO, GetAppPtr ()->is_english () ? "date interval is too big" : str.c_str ());
			} else if (m_err_value == PS_ERROR_GET_INFO_STATUS4) {
				str_err.Format (IDS_ATTENTION_COLON, str.c_str ());
			} else if (m_err_value == PS_ERROR_HTTP_REQUEST) {
				str_err.Format (IDS_ERROR_HTTP_ERROR);
			} else if (m_err_value == PS_TERMINATE_DOWNLOAD_THREAD) {
				str_err.Format (IDS_INTERNET_NOT_FOUND);
			}

			if (str_err.IsEmpty () == false) {
				DLOG->out_t (str_err);

				CString msg;
				msg.Format (IDS_MSG_STOP_DOWNLOAD);

				if (m_err_value == PS_TERMINATE_DOWNLOAD_THREAD) {
					if (GetAppPtr ()->is_auto () == false) {
						ret = ds_Close;
					}
					DLOG->out_t (msg);
				}

				if (GetAppPtr ()->is_auto () == false) {
					m_dlg.set_status_text ("");
					m_dlg.set_comment_text (msg.GetBuffer ());
					m_dlg.message_box (str_err.GetBuffer (), MB_OK | MB_ICONINFORMATION | MB_APPLMODAL);
				}
			}
		} 
	}

	DLOG->out_t_ext ("%s: end_dialog", GDS_CURRENT_FUNCTION);

	try {
		m_dlg.EndDialog (IDOK);
	} catch (...) {
		DLOG->out_t_ext ("%s: end_dialog error", GDS_CURRENT_FUNCTION);
	}

	DLOG->out_t_ext ("%s: dlg_thread_join", GDS_CURRENT_FUNCTION);

	dlg_thread.join ();

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);

	return ret;
}

void DownloadManager::check_connect () {
	Watcher watcher;

	m_is_check = 1;

	while (m_is_check == 1) {
		if (Internet::Inet_i::Utility::has_internet_connection () == false) {
			if (watcher.is_active () == false) {
				m_dlg.lock (true);
				watcher.activate (1); // 1 мин.
			}

			if (watcher.execute (ACE_Time_Value (0, 100000)) == false) {
				//AfxThrowInternetException (1);
				m_dlg.terminate (); // если в течении минуты связь не восстановилась, срубаем тред
				m_err_value = PS_TERMINATE_DOWNLOAD_THREAD;
				break;
			}
		} else if (watcher.is_active ()) {
			m_dlg.lock (false);
			watcher.reset ();
		} else {
			ACE_OS::sleep (ACE_Time_Value (0, 100000)); // 0.1 секунды
		}
	}
}

void DownloadManager::do_modal () {
	m_dlg.DoModal ();
}

void DownloadManager::run () {
	m_err_value = PS_ERROR_HTTP_REQUEST;
	m_file_length = 0;
	m_err_msg = "";

	CDownloaderApp* ptr_app = GetAppPtr ();

	Watcher watcher;

	do {
		bool is_reconnect = (m_file_params->get_length ())? true : watcher.is_active ();

		DLOG->out_t_ext ("%s: 1", GDS_CURRENT_FUNCTION);

		try {
			if (ptr_app->server_connect (is_reconnect)) {
				m_is_restore = watcher.is_active ();

				DLOG->out_t_ext ("%s: 2", GDS_CURRENT_FUNCTION);

				m_dlg.execute ((LPTHREAD_START_ROUTINE) connect_, static_cast <void*> (this), true); //ACE_THR_FUNC

				if (m_dlg.is_cancel ()) {
					m_err_value = PS_SUCCESS;
					break;
				} 

				DLOG->out_t_ext ("%s: 3", GDS_CURRENT_FUNCTION);

				switch (m_ex_value) {
					case ev_None:
						break;
					case ev_BreakConnection:
						throw BreakConnection ();
					case ev_NoUpdate:
						throw NoUpdate ();
					case ev_Error:
						throw ErrorProcess ();
					case ev_CancelProcess:
						throw CancelProcess ();
					default:
						throw std::exception ();
				}

				watcher.reset ();

				DLOG->out_t_ext ("%s: 4", GDS_CURRENT_FUNCTION);

				{
					boost::thread check_thr (boost::bind (&DownloadManager::check_connect, this));

					m_dlg.execute ((LPTHREAD_START_ROUTINE) download_, static_cast <void*> (this), false);
					m_dlg.hide ();

					m_is_check = 0;

					check_thr.join ();
				}

				DLOG->out_t_ext ("%s: 5", GDS_CURRENT_FUNCTION);

				if (m_err_value == PS_SUCCESS || m_err_value == PS_ERROR_NOT_ENOUGH_SPACE) {
					break;
				}

				DLOG->out_t_ext ("%s: 6", GDS_CURRENT_FUNCTION);

				if (m_err_value == PS_TERMINATE_DOWNLOAD_THREAD) {
					throw TerminateConnection ();
				}
			}
		} catch (BreakConnection&) {
		}

		DLOG->out_t_ext ("%s: 7", GDS_CURRENT_FUNCTION);

		// Attempt to renew connection for download in an automatic/manual mode.

		if (watcher.is_active () == false) {
			if (this->is_reconnect ()) {
				CString str;
				str.Format (IDS_ATTEMPT_RENEW_CONNECTION);
				DLOG->out_t (str);

				watcher.activate (ptr_app->get_time_limit_connect ());
			} else {
				throw ErrorProcess ();
			}
		}

		DLOG->out_t_ext ("%s: 8", GDS_CURRENT_FUNCTION);

	} while (watcher.execute (5));

	DLOG->out_t_ext ("%s: 9", GDS_CURRENT_FUNCTION);

	if (m_dlg.is_cancel ()) {
		throw AbortedProcess ();
	}

	DLOG->out_t_ext ("%s: 10", GDS_CURRENT_FUNCTION);
}

void DownloadManager::receive_file_name () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	try {
		m_connection->get_info (HTTP_QUERY_CONTENT_DISPOSITION, m_file_name);
	} catch (CInternetException* ex) {
		m_err_msg = InetException::what (ex);
	} catch (Internet::ConnectException&) {
		m_err_msg = "receive_file_name: unknown exception";
	} 

	if (m_file_name.empty () == false) {
		std::string str = "filename=";

		size_t pos = m_file_name.find (str);

		if (pos != std::string::npos) {
			m_file_name = m_file_name.substr (pos + str.size ());
		}
	} 

	if (m_file_name.empty ()) {
		if (m_err_msg.empty ()) {
			m_err_msg = "invalid file name"; //IDS_ERROR_EMPTY_FILE_NAME
		}
		m_err_value = PS_ERROR_GET_INFO;
		throw ErrorProcess ();
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void DownloadManager::receive_file_length () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	try {
		std::string content_lenght;
		m_connection->get_info (HTTP_QUERY_CONTENT_LENGTH, content_lenght);
		m_file_length = boost::lexical_cast <__int64> (content_lenght.c_str ());
	} catch (CInternetException* ex) {
		m_err_msg = InetException::what (ex);
	} catch (Internet::ConnectException&) {
		m_err_msg = "receive_file_length: unknown exception";
	} 

	if (m_file_length == 0) {
		m_err_value = PS_ERROR_GET_INFO;
		throw ErrorProcess ();
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void DownloadManager::header_analysis () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	std::string header;

	try {
		m_connection->get_info (HTTP_QUERY_RAW_HEADERS_CRLF, header);
	} catch (CInternetException* ex) {
		m_err_msg = InetException::what (ex);
	} catch (...) {
	} 

	if (header.empty ()) {
		m_err_value = PS_ERROR_GET_INFO;
		throw ErrorProcess ();
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void DownloadManager::connect () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	m_dlg.animate (true);

	Internet::IConnect_var connect = Internet::ConnectManager::instance ()->get_connect ();
	m_connection = connect->get_connection ();

	Connection obj (m_connection.in ());

	char buf [2048];

	// Формирование заказа на дельту

	Json::UInt order_id = 0;

	if (obj.open_request (m_obj.c_str ())) {
		m_file_params->out_info ();

		if (obj.send_request ()) {
			unsigned int bytes = m_connection->read (static_cast <void*> (buf), sizeof (buf));

			if (bytes) {
				buf [bytes] = 0;

				Json::Value root; // will contains the root value after parsing
				Json::Reader reader;

				if (reader.parse (buf, root) == false) {
					DLOG->out_t ("%s: failed to parse configuration", GDS_CURRENT_FUNCTION);
				} else if (root ["success"].asBool ()) {
					order_id = root ["order_id"].asUInt ();
					m_event_id = root ["event_id"].asUInt ();
					DConfigManager::instance ()->set ("OrderId", order_id);
				} else {
					m_err_msg = GCL::utf8_to_win1251 (root ["message"].asString ());
				}
			}

			if (order_id == 0) {
				m_err_value = PS_ERROR_GET_INFO;
				throw ErrorProcess ();
			}
		} else {
			m_err_msg = obj.get_err_msg ();
			throw BreakConnection ();
		}
	}

	// Проверка статуса заказа

	ACE_OS::sleep (10);

	Json::UInt status = 0;

	while (1) {
		if (obj.execute_request (ScriptManagerSingleton::instance ()->check_order (order_id))) {
			unsigned int bytes = m_connection->read (static_cast <void*> (buf), sizeof (buf));

			if (bytes) {
				buf [bytes] = 0;

				Json::Value root; // will contains the root value after parsing
				Json::Reader reader;

				if (reader.parse (buf, root) == false) {
					DLOG->out_t ("%s: failed to parse configuration", GDS_CURRENT_FUNCTION);
					throw ErrorProcess ();
				} else if (root ["success"].asBool ()) {
					status = root ["status"].asUInt ();

					if (status == 3) {
						std::string file_size = root ["size"].asString ();
						if (file_size.empty () == false) {
							m_file_name = root ["name"].asString ();
							m_file_length = boost::lexical_cast <__int64> (file_size);
						}
						break;
					} else if (status == 4) {
						m_err_msg = GCL::utf8_to_win1251 (root ["message"].asString ());
						m_err_value = PS_ERROR_GET_INFO_STATUS4;
						throw ErrorProcess ();
					} else if (status > 4) {
						m_err_msg = "Неизвестный статус";
						m_err_value = PS_ERROR_GET_INFO;
						throw ErrorProcess ();
					}
				} else {
					m_err_msg = GCL::utf8_to_win1251 (root ["message"].asString ());
					m_err_value = PS_ERROR_GET_INFO;
					throw ErrorProcess ();
				}
			}
		} else {
			m_err_msg = obj.get_err_msg ();
			throw BreakConnection ();
		}

		ACE_OS::sleep (60);
	}

	if (m_file_name.empty () || m_file_length == 0) {
		m_err_msg = "invalid file info";
		m_err_value = PS_ERROR_GET_INFO;
		throw ErrorProcess ();
	}

	m_dlg.animate (false);

	bool is_rewrite = this->set_mode ();

	// Получение ссылки на загрузку

	std::string header;

	if (is_rewrite == false) {
		size_t offset = m_file_params->get_length ();

		if (offset) {
			header += "Range: bytes=";
			header += boost::lexical_cast <std::string> (offset);
			header += "-\r\n";
		} 
	}

	std::string str_obj = ScriptManagerSingleton::instance ()->download_link (order_id);

	if (obj.open_request (str_obj.c_str (), (header.empty ()) ? 0 : header.c_str ()) && obj.send_request ()) {
		if (is_rewrite) {
			m_indicator_count = 0;
		} else {
			this->receive_file_length ();
		}
	} else {
		m_err_msg = obj.get_err_msg ();
		throw BreakConnection ();
	}

	m_file_params->clear ();

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void DownloadManager::download () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	if (FreeSpaceChecker::check (m_file_length, m_path [0]) == false) {
		m_err_value = PS_ERROR_NOT_ENOUGH_SPACE;
		return;
	}

	double size_Mb = get_size_Mb (m_file_length) + .1;

	m_file_params->set (m_file_name);
	m_file_params->out_info (m_mode, size_Mb, m_file_name);

	int range_val = (int) (m_file_length / BUFF_SIZE) + 1;

	// To display the information about downloaded file

	m_dlg.init ((m_mode == dm_Rewrite)? IDS_DOWNLOAD_FILE : IDS_DOWNLOAD_FILE_PLUS, m_file_name, size_Mb, range_val);

	// Downloading of required file

	UINT size = 0, count = m_indicator_count;
	UINT open_flags = CFile::modeWrite | CFile::typeBinary;

	if (m_mode == dm_Rewrite) {
		open_flags |= CFile::modeCreate;
	}

	char buf [BUFF_SIZE];

	__int64 total_bytes = 0;

    try	{
		std::string full_path = this->get_full_path ();

		Core::Aptr <CFile, FileDestructor> file = new CFile (full_path.c_str (), open_flags);

		if (m_mode == dm_Add) {
			file->SeekToEnd ();
		}

		do {
			size = m_connection->read (static_cast <void*> (buf), sizeof (buf));

			if (size) { 
				if (m_dlg.is_cancel ()) {
					break;
				}

				file->Write (static_cast <const void*> (buf), size);

				m_dlg.set_position (count++);
				total_bytes += size;
			} 
		} while (size);

		if (m_dlg.is_cancel () == false) {
			if (total_bytes != m_file_length) {
				throw std::exception ();
			}
			m_file_params->clear ();
		}

		if (m_file_length == total_bytes) {
			std::string script = ScriptManagerSingleton::instance ()->successful_complete (m_event_id);

			if (Connection (m_connection.in ()).execute_request (script) == false) {
				m_err_msg = "?";
			}
		}

		m_err_value = PS_SUCCESS;
	} catch (CInternetException* ex) {
		ex->GetErrorMessage (buf, sizeof (buf));
		ex->Delete ();
		m_err_msg = buf;
		m_err_value = PS_ERROR_HTTP_REQUEST;
	} catch (CFileException* ex) {
		ex->GetErrorMessage (buf, sizeof (buf));
		ex->Delete ();
		m_err_msg = buf;
		m_err_value = PS_FILE_EXCEPTION;
	} catch (...) {
		m_err_msg = "unknown exception";
		m_err_value = PS_ERROR_GET_INFO;
	}

	if (m_err_value != PS_SUCCESS) {
		m_indicator_count = count; // save by last position on progress indicator

		if (total_bytes == 0) {
			m_file_params->clear ();
		}
	} 

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

bool DownloadManager::set_mode () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	double offset = get_size_Mb (m_file_params->get_length ());

	std::string full_path = this->get_full_path ();

	bool is_exist = (ACE_OS::access (full_path.c_str (), R_OK) != -1);

	if (m_indicator_count && is_exist) {
		m_mode = dm_Add;
	} else if (GetAppPtr ()->is_auto () == false) {
		CString str;

		UINT type = MB_OKCANCEL;

		double file_length = get_size_Mb (m_file_length) + .1;

		if (is_exist == false) {
			str.Format (IDS_DOWNLOAD_QUERY, m_file_name.c_str (), file_length);
		} else if (offset == 0.) {
			str.Format (IDS_QUEST_FILE_ALREADY_EXIST, m_file_name.c_str (), file_length);
		} else {
			str.Format (IDS_QUEST_ABORTED_FILE_ALREADY_EXIST, m_file_name.c_str (), offset, file_length);
			type = MB_YESNOCANCEL;
		}

		switch (m_dlg.message_box (str.GetBuffer (), type | MB_ICONQUESTION | MB_APPLMODAL)) {
		case IDYES:
			m_mode = dm_Add;
			break;
		case IDNO:
		case IDOK:
			m_mode = dm_Rewrite;
			break;
		case IDCANCEL:
			DConfigManager::instance ()->set ("OrderId", 0);
			m_err_value = PS_SUCCESS;
			throw CancelProcess ();
		}
	} else if (is_exist && offset != 0.) {
		m_mode = dm_Add;
	} else {
		m_mode = dm_Rewrite;
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);

	return (offset && m_mode == dm_Rewrite);
}

bool DownloadManager::is_reconnect () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	CDownloaderApp* ptr_app = GetAppPtr ();

	bool is_safe_connection = (ptr_app->get_time_limit_connect () > 0);

	CString str_err;

	if (is_safe_connection) {
		str_err.Format (IDS_ERROR_DOWNLOAD_DATA, m_err_msg.c_str ());
	} else {
		str_err.Format (IDS_FATAL_ERROR_DOWNLOAD_DATA, m_err_msg.c_str ());
	}

	DLOG->out_t (m_err_msg.c_str ());

	bool is_redownload = ptr_app->is_auto ();

	if (is_redownload == false) {
		UINT type = (is_safe_connection)? (MB_YESNO | MB_ICONSTOP) : (MB_OK | MB_ICONSTOP);

		is_redownload = (m_dlg.message_box (str_err.GetBuffer (), type) == IDYES);
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);

	return (is_safe_connection && is_redownload);
}

std::string DownloadManager::get_full_path () {
	std::string ret = m_path;
	if (ret [ret.size () - 1] != '\\') {
		ret += '\\';
	}
	ret += m_file_name;
	return ret;
}

// end of...
