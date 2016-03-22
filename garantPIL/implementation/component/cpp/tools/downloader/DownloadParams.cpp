//
// DownloadParams.cpp : inplementation file
//

#include "stdafx.h"

#include "boost/lexical_cast.hpp"

#include "LogFile.h"
#include "Downloader.h"
#include "DownloadParams.h"

DownloadFileParams::DownloadFileParams (
	long id
	, const std::string& from
	, const std::string& to
	, const std::string& ini_file
	, const std::string& work_dir
) 
	: ConfigManager ()
	, m_length (0)
{ 
	//ConfigManager::init (ini_file, "Download_Aborted");

	m_info.id = (unsigned long) id;
	m_info.begin_date = from;
	m_info.end_date = to;

	if (GetAppPtr ()->is_auto ()) {
		m_key = boost::lexical_cast <std::string> (id) + ":auto";
	} else {
		m_key = boost::lexical_cast <std::string> (id) + ":" + from + ":" + to;
	}
	//m_file_name = ConfigManager::get (m_key);
	m_file_name = DConfigManager::instance ()->get (m_key);

	if (m_file_name.empty () == false) {
		std::string full_name = work_dir;

		if (full_name.size ()) {
			if (full_name [full_name.size () - 1] != '\\') {
				full_name += '\\';
			}
		}

		full_name += m_file_name;

		if (ACE_OS::access (full_name.c_str (), R_OK) != -1) {
			int	file = ace_os_open (full_name.c_str (), ACE_OS_O_RDONLY | ACE_OS_O_BINARY);

			if (file != -1) {
				m_length = ace_os_filesize (file);
				ace_os_close (file);	
			}
		}
	}
}

DownloadFileParams::~DownloadFileParams () {
}

void DownloadFileParams::out_info () {
	CDownloaderApp* ptr_app = GetAppPtr ();

	int day = 0, month = 0, year = 0;

	char beg_buf [16];
	char end_buf [16];

	if (m_info.begin_date.empty () == false)
		sscanf (m_info.begin_date.c_str (), "%d-%d-%d", &month, &day, &year);
	sprintf (beg_buf, "%d-%d-%d", day, month, year);

	sscanf (m_info.end_date.c_str (), "%d-%d-%d", &month, &day, &year);
	sprintf (end_buf, "%d-%d-%d", day, month, year);

	std::string complect_name = ptr_app->get_complect_name (m_info.id);

	CString info;
	info.Format (IDS_CHECK_INFO, complect_name.c_str (), beg_buf, end_buf);

	DLOG->out_t (info);
}

void DownloadFileParams::out_info (DownloadMode mode, double file_length, const std::string& file_name) {
	CDownloaderApp* ptr_app = GetAppPtr ();

	CString info;

	std::string name_str = ptr_app->get_complect_name (m_info.id);

	double length = m_length / (1024. * 1024.);

	if (mode == dm_Rewrite) {
		info.Format (IDS_DOWNLOAD_INFO, name_str.c_str (), file_name.c_str (), file_length);
	} else {
		info.Format (IDS_ADD_DOWNLOAD_INFO, name_str.c_str (), file_name.c_str (), length + file_length, file_length);
	}

	DLOG->out_t (info);
}

void DownloadFileParams::set (const std::string& file_name) {
	m_file_name = file_name;
	//ConfigManager::set (m_key, m_file_name);
	DConfigManager::instance ()->set (m_key, m_file_name);

}

void DownloadFileParams::clear () {
	m_file_name.clear ();
	//ConfigManager::clear (m_key);
	DConfigManager::instance ()->clear (m_key);
}

// end of...
