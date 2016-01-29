//
// Config.h : header file
//

#ifndef __DOWNLOAD_CONFIG_H__
#define __DOWNLOAD_CONFIG_H__

#include "ace/Configuration.h"
#include "ace/Singleton.h"

#include "shared/Core/sys/synch.h"

#include <string>

class ConfigManager {
public:
	ConfigManager ();

public:
	void init (const std::string& ini_file, const char* sub_section);

	std::string get (const std::string& key);
	u_int get_int (const std::string& key);

	void set (const std::string& key, const std::string& value);
	void set (const std::string& key, u_int value);

	void clear (const std::string& key);

private:
	void update ();

private:
	std::string m_ini_file;

	ACE_Configuration_Heap m_config;
	ACE_Configuration_Section_Key m_section_key;
};

typedef ACE_Singleton <ConfigManager, Core::NullMutex> DConfigManager;

#endif // #ifndef __DOWNLOAD_CONFIG_H__
