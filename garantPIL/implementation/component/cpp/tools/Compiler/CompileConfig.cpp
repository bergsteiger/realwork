//
// CompileConfig.cpp : implementation file
//

#include "ace/ACE.h"
#include "ace/OS.h"
#include "ace/Configuration_Import_Export.h"

#include "shared/GCL/str/str_op.h"
#include "CompileConfig.h"
#include "Log.h"

#include "gardefs.h"

namespace Compiler {

struct DateInit {
	static void init (Date& today/*, Date& prev_sat, Date& sat*/) {
		time_t now = time (0);

		struct tm* cur = localtime (&now);

		today.year = cur->tm_year + 1900;
		today.mon = cur->tm_mon + 1;
		today.day = cur->tm_mday + 1;

		/*
		int n = (cur->tm_wday + 1) % 7;
		now -= n * 3600 * 24;
		cur = localtime (&now);

		prev_sat.year = cur->tm_year + 1900;
		prev_sat.mon = cur->tm_mon + 1;
		prev_sat.day = cur->tm_mday;

		now += 7 * 3600 * 24;
		cur = localtime (&now);

		sat.year = cur->tm_year + 1900;
		sat.mon = cur->tm_mon + 1;
		sat.day = cur->tm_mday;
		*/
	}

	static void init (const char* in, const char* str_date, Date& out) {
		GDS_ASSERT (in);

		std::string tmp, str = in;

		size_t pos = 0, first = 0;

		pos = str.find ('/', first);

		if (pos != std::string::npos) {
			out.day = (char) ACE_OS::atoi (str.substr (first, pos).c_str ());
			first = pos + 1;

			pos = str.find ('/', first);

			if (pos != std::string::npos) {
				out.mon = (char) ACE_OS::atoi (str.substr (first, pos).c_str ());
				first = pos + 1;

				if (pos != std::string::npos) {
					std::string sss = str.substr (first);

					out.year = (unsigned short) ACE_OS::atoi (str.substr (first, pos).c_str ());
					return;
				}
			}
		}

		LogSingleton::instance ()->out_e (cp_Win, "Unknown date format %s.\n", str_date);
		throw InvalidDateFormat ();
	}
};

struct ConfigChecker {
	static void check_file (const char* name) {
		if (ACE_OS::access (name, R_OK) == -1) {
			LogSingleton::instance ()->out_e (cp_Win, "Can't read data from %s: %s.\n", name, strerror (errno));
			throw CantReadFile ();
		}
	}

	static void check (const ConfigData& data) {
		ConfigChecker::check_file (data.belong_file.c_str ());
		ConfigChecker::check_file (data.weights_table_file.c_str ());
		ConfigChecker::check_file (data.class_file.c_str ());
		ConfigChecker::check_file (data.types_file.c_str ());
		ConfigChecker::check_file (data.service_info_file.c_str ());
		ConfigChecker::check_file (data.territory_file.c_str ());
		ConfigChecker::check_file (data.sources_file.c_str ());
		ConfigChecker::check_file (data.pub_source_file.c_str ());
		ConfigChecker::check_file (data.warnings_file.c_str ());
		ConfigChecker::check_file (data.norm_file.c_str ());
		ConfigChecker::check_file (data.cat_file.c_str ());
		ConfigChecker::check_file (data.priority_table_file.c_str ());

#ifdef	VERSION62
		ConfigChecker::check_file (data.inpharm_data.firms_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.countries_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.pharm_groups_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.pharm_effects_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.mkbs_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.chapters_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.atcs_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.reg_statuses_file.c_str ());
		ConfigChecker::check_file (data.inpharm_data.lek_forms_file.c_str ());

		ConfigChecker::check_file (data.anno_user_file.c_str ());
		ConfigChecker::check_file (data.anno_organization_file.c_str ());
		ConfigChecker::check_file (data.anno_tax_file.c_str ());
		ConfigChecker::check_file (data.anno_interest_file.c_str ());
		ConfigChecker::check_file (data.anno_kind_file.c_str ());
#endif
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////

ConfigReader::ConfigReader (const std::string& ini_path) : m_ini_path (ini_path) {
	m_config.open ();
}

ConfigReader::~ConfigReader () {
}

void ConfigReader::read (ConfigData& out) {
	const char* MAIN_SECTION = "Generic";

	ACE_Ini_ImpExp import (m_config);

	if (ACE_OS::access (m_ini_path.c_str (), R_OK) == -1) {
		throw FileNotFound ();
	}

	if (import.import_config (m_ini_path.c_str ()) || ACE_OS::last_error () != ENOENT) {
		throw FileImportError ();
	}

	ACE_Configuration_Section_Key section_key;
	m_config.open_section (m_config.root_section (), MAIN_SECTION, 0, section_key);

	// Read configuration
	{
		m_config.get_string_value (section_key, "BelongFile", out.belong_file);
		m_config.get_string_value (section_key, "ComplectInfo", out.weights_table_file);
		m_config.get_string_value (section_key, "ClassFile", out.class_file);
		m_config.get_string_value (section_key, "SourcesFile", out.sources_file);
		m_config.get_string_value (section_key, "TerritoryFile", out.territory_file);
		m_config.get_string_value (section_key, "TypesFile", out.types_file);
		m_config.get_string_value (section_key, "NormFile", out.norm_file);
		m_config.get_string_value (section_key, "PublicationSourceFile", out.pub_source_file);
		m_config.get_string_value (section_key, "KeywordFile", out.key_word_file);
		m_config.get_string_value (section_key, "WarningsFile", out.warnings_file);
		m_config.get_string_value (section_key, "PriorityTableFile", out.priority_table_file);
		m_config.get_string_value (section_key, "ObjTypesFile", out.obj_types_file);
		m_config.get_string_value (section_key, "AnnoUserFile", out.anno_user_file);
		m_config.get_string_value (section_key, "AnnoOrganizationFile", out.anno_organization_file);
		m_config.get_string_value (section_key, "AnnoTaxFile", out.anno_tax_file);
		m_config.get_string_value (section_key, "AnnoInterestFile", out.anno_interest_file);
		m_config.get_string_value (section_key, "AnnoKindFile", out.anno_kind_file);
		m_config.get_string_value (section_key, "ServiceInfoFile", out.service_info_file);

		m_config.get_string_value (section_key, "OutFiles", out.out_name);
		m_config.get_string_value (section_key, "CatFile", out.cat_file);

		m_config.get_string_value (section_key, "ObjectRootPath", out.obj_root);
		m_config.get_string_value (section_key, "OutReferenceTableFile", out.out_ref_table_file);
		m_config.get_string_value (section_key, "OutObjectTableFile", out.out_obj_table_file);
	}
	// Read log encoding
	{
		ACE_TString log_file, log_encoding;

		m_config.get_string_value (section_key, "LogFile", log_file);
		m_config.get_string_value (section_key, "LogEncoding", log_encoding);

		if (log_file.length ()) {
			LogSingleton::instance ()->init (log_file.c_str (), log_encoding.c_str ());
		} else {
			char buf [1024];
			ACE_OS::sprintf (buf, "%s.log", out.out_name.c_str ());
			LogSingleton::instance ()->init (buf, log_encoding.c_str ());
		}
	}
	// Read dates
	{
		Date today /*, prev_sat, sat*/;
		DateInit::init (today /*, prev_sat, sat*/);

		ACE_TString revision_date, today_date, sat_date;

		m_config.get_string_value (section_key, "RevisionDate", revision_date);

		if (revision_date.length ()) {
			DateInit::init (revision_date.c_str (), "RevisionDate", out.dates.revision);
		} else {
			out.dates.revision = today;
		}

		m_config.get_string_value (section_key, "SatDate", sat_date);

		if (sat_date.length ()) {
			DateInit::init (sat_date.c_str (), "SatDate", out.dates.sat);
		} else {
		}

		m_config.get_string_value (section_key, "TodayDate", today_date);

		if (today_date.length ()) {
			DateInit::init (today_date.c_str (), "TodayDate", out.dates.today);
		} else {
		}
	}
	// Read inpharm configuration
	{
		InpharmData& data = out.inpharm_data;

		m_config.get_string_value (section_key, "InpharmFirmsFile", data.firms_file);
		m_config.get_string_value (section_key, "InpharmCountriesFile", data.countries_file);
		m_config.get_string_value (section_key, "InpharmPharmGroupsFile", data.pharm_groups_file);
		m_config.get_string_value (section_key, "InpharmPharmEffectsFile", data.pharm_effects_file);
		m_config.get_string_value (section_key, "InpharmChaptersFile", data.chapters_file);
		m_config.get_string_value (section_key, "InpharmAtcsFile", data.atcs_file);
		m_config.get_string_value (section_key, "InpharmRegStatusesFile", data.reg_statuses_file);
		m_config.get_string_value (section_key, "InpharmLekFormsFile", data.lek_forms_file);
		m_config.get_string_value (section_key, "InpharmMKbsFile", data.mkbs_file);
	}
	// Read integer data
	{
		out.MF_compress_level = this->get_int_value (section_key, "MFCompressLevel");

		if (out.MF_compress_level < 0 || out.MF_compress_level > 9 ){
			LOG_I (("MFCompress level must be in range 0-9. Setting to 3."));
			out.MF_compress_level = 3;
		}

		if (this->get_int_value (section_key, "EnableStdout")) {
			out.flags |= OPT_ENABLE_STDOUT;
		}

		if (this->get_int_value (section_key, "NDTCompress")) {
			out.flags |= OPT_NDT_COMPRESS;
		}

		if (this->get_int_value (section_key, "CheckVIncluded")) {
			out.flags |= OPT_CHECK_VINCLUDED;
		}

		if (this->get_int_value (section_key, "CheckNameLength")) {
			out.flags |= OPT_CHECK_NAME_LENGHT;
		}
	}
	// Read belongs data
	{
		ACE_TString belongs, ignore_belongs;

		m_config.get_string_value (section_key, "BelongsList", belongs);
		m_config.get_string_value (section_key, "IgnoreBelongsList", ignore_belongs);

		out.belongs_info.init (belongs, ignore_belongs);
	}

	// Check configuration
	{
		ConfigChecker::check (out);
	}
}

int ConfigReader::get_int_value (ACE_Configuration_Section_Key& key, const char* name) {
	int ret = 0;

	ACE_TString tmp;

	m_config.get_string_value (key, name, tmp);

	std::string str = tmp.c_str ();

	GCL::to_upper (str);

	if (str [0] == 'O' || str [0] == 'Y' || str [0] == 'N') {
		if (str.compare ("ON") == 0 || str.compare ("YES") == 0) {
			ret = 1;
		} 
	} else {
		ret = ACE_OS::atoi (tmp.c_str ());
	}

	return ret;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

BelongsInfo::BelongsInfo () {
}

BelongsInfo::~BelongsInfo () {
}

void BelongsInfo::init (const ACE_TString& belongs, const ACE_TString& ignore_belongs) {
	this->init (belongs, m_belongs);
	this->check ();
	this->init (ignore_belongs, m_ignore_belongs);
}

void BelongsInfo::init (const ACE_TString& in, BelongsInfo::BelongsVector& out) {
	size_t len = in.length ();

	if (len) {
		out.reserve (32);

		std::string word, str = in.c_str ();

		for (size_t pos = 0, first = 0; pos != std::string::npos; first = pos + 1) {
			pos = str.find (" ", first);

			if (pos == std::string::npos) {
				word = str.substr (first, len - first);
			} else {
				word = str.substr (first, pos - first);
			}

			unsigned val = (unsigned) ACE_OS::atoi (word.c_str ());

			out.push_back (val);
		}
	}
}

void BelongsInfo::check () {
	if (m_belongs.empty ()) {
		LOG_E (("%s: no here bases", GDS_CURRENT_FUNCTION));
		throw InvalidBelongs ();
	}

	//ACE_OS::printf ("{%d, %d}\n", m_belongs.size (), m_ignore_belongs.size ());

	BelongsVector::const_iterator it = m_belongs.begin (), it_end = m_belongs.end ();

	for (; it != it_end; ++it) {
		//ACE_OS::printf ("%d ", *it);

		unsigned value = *it;

		if (value < 1 || value >= MAX_BASES ){
			LOG_E (("%s: bad base id %d", GDS_CURRENT_FUNCTION, value));
			throw InvalidBelongs ();
		}
	}
}

}
