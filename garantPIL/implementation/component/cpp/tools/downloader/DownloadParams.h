//
// DownloadParams.h : header file
//

#ifndef __DOWNLOAD_PARAMS_H__
#define __DOWNLOAD_PARAMS_H__

#include "Config.h"

enum DownloadMode { dm_None, dm_Rewrite, dm_Add };

///////////////////////////////////////////////////////////////////////////////

class DownloadFileParams 
	: virtual public ConfigManager {
public:
	DownloadFileParams::DownloadFileParams (
		long id
		, const std::string& from
		, const std::string& to
		, const std::string& ini_file
		, const std::string& work_dir
	);

	virtual ~DownloadFileParams ();

public:
	inline size_t get_length () const {
		return m_length;
	}

	void set (const std::string& file_name);
	void clear ();

	void out_info ();
	void out_info (DownloadMode mode, double file_length, const std::string& file_name);

private:
	struct ComplectInfo {
		unsigned long id;

		std::string begin_date;
		std::string end_date;
	};

private:
	std::string m_file_name;
	std::string m_key; 

	size_t m_length;

	ComplectInfo m_info;
};

#endif // #ifndef __DOWNLOAD_PARAMS_H__

