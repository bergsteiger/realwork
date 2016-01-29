//
// DownloadParams.cpp : inplementation file
//

#include "ace/ACE.h"
#include "ace/Configuration_Import_Export.h"

#include "shared/Core/sys/Logs.h"
#include "boost/lexical_cast.hpp"

#include "Config.h"

/////////////////////////////////////////////////////////////////////////////////////

ConfigManager::ConfigManager () {
}

void ConfigManager::init (const std::string& ini_file, const char* sub_section) {
	m_ini_file = ini_file;

	if (m_config.open (32) != 0) {
		LOG_E (("%s: can't open ACE_Configuration_Heap", GDS_CURRENT_FUNCTION));

		throw std::exception ();
	}
	if (ACE_OS::access (m_ini_file.c_str (), R_OK) == -1) {
		LOG_E (("%s: file %s not found", GDS_CURRENT_FUNCTION, m_ini_file.c_str ()));
		throw std::exception ();
	}

	ACE_Ini_ImpExp import (m_config);

	if (import.import_config (m_ini_file.c_str ()) || ACE_OS::last_error () != ENOENT) {
		LOG_E (("%s: import file error", GDS_CURRENT_FUNCTION));
		throw std::exception ();
	}

	if (m_config.open_section (m_config.root_section (), (ACE_TCHAR*) sub_section, 1, m_section_key)) {
		LOG_E (("%s: can't open '[%s]' section", GDS_CURRENT_FUNCTION, sub_section));
		throw std::exception ();
	}
}

std::string ConfigManager::get (const std::string& key) {
	std::string ret;

	ACE_TString val;
	m_config.get_string_value (m_section_key, (ACE_TCHAR*) key.c_str (), val);

	if (val.length ()) {
		ret = val.c_str ();
	}

	return ret;
}

u_int ConfigManager::get_int (const std::string& key) {
	std::string res = this->get (key);
	return (res.empty ())? 0 : boost::lexical_cast <u_int> (res);
}

void ConfigManager::set (const std::string& key, const std::string& value) {
	if (value.empty () == false) {
		m_config.set_string_value (m_section_key, (ACE_TCHAR*) key.c_str (), value.c_str ());
		this->update ();
	}
}

void ConfigManager::set (const std::string& key, u_int value) {
	std::string str = boost::lexical_cast <std::string> (value);
	this->set (key, str);
	this->update ();
}

void ConfigManager::clear (const std::string& key) {
	m_config.remove_value (m_section_key, (ACE_TCHAR*) key.c_str ());
	this->update ();
}

void ConfigManager::update () {
	if (ACE_Ini_ImpExp (m_config).export_config (m_ini_file.c_str ()) != 0) {
		LOG_E (("%s: export file error", GDS_CURRENT_FUNCTION));
	}
}

