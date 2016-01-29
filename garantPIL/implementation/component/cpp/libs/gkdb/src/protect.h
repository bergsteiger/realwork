#include "shared/Core/fix/mpcxc.h"
#include "gardefs.h"

class BasesOrgProtection {
public:
	enum Errors {
		OK = 0
		, NO_ORG_FILE = 1
		, BAD_HARDWARE_ID = 2
		, INVALID_KEY_SIZE = 4
		, INVALID_NDT_SIZE = 8
		, INVALID_STR_SIZE = 16
		, BAD_MEDIA_TYPE = 32
		, BAD_NETWORK_VERSION = 64
	};

	enum BaseVersion {
		LOCAL,		// Десктоп
		NET,		// КС
		NET_ONEUSER,	// ФС
		DONT_CHECK	// не проверять
	};

public:
	BasesOrgProtection ();
public:
	int check_protection (const char* base_path, bool check_hardware_id = true, bool check_work_cd = true, BasesOrgProtection::BaseVersion base_version = DONT_CHECK);
	int write_protection (const char* base_path, bool is_base_exist = true);
	int tune_protection (const char* base_path);
	int get_company_and_regnumber (const char* base_path, ::std::string& company, ::std::string& regnum, bool removeEx = true );
	int get_company_regnumber_crc (const char* base_path, ::std::string& company, ::std::string& regnum, ::std::string& crc);
	long get_region (const char* base_path);
	int is_work_cd (const char* base_path, bool& work_cd);
	bool get_base_version (const char* base_path, BaseVersion& base_version, bool& is_work_cd);
	int is_noncommercial (const char* base_path, bool& is_noncommercial);
	int is_trial (const char* base_path, bool& is_trial);
	int is_supermobile (const char* base_path, bool& is_supermobile);
	int get_flash_id (const char* base_path, std::string &unique_id);

	int get_hardware_id (const char* base_path, short& hardware_id);
	void	write_company (const char* base_path, const char* company);

	unsigned short get_hardware_id_fs (const char* path);

private:
	char m_bases_origin_path [MPCXC_MAX_PATH];
};
