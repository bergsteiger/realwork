////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "CompileConfig.h"

#ifndef __COMPILER__COMPILE_CONFIG_H__
#define __COMPILER__COMPILE_CONFIG_H__

#include "ace/Configuration.h"

#include "shared/Core/sys/std_inc.h"

namespace Compiler {

	static const unsigned long OPT_ENABLE_STDOUT     = 0x0001;
	static const unsigned long OPT_NDT_COMPRESS      = 0x0002;
	static const unsigned long OPT_CHECK_VINCLUDED   = 0x0004;
	static const unsigned long OPT_CHECK_NAME_LENGHT = 0x0008;

	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	class FileNotFound : public ::Core::Exception {
	public:
		const char* what () const throw () {
			return "File not found";
		}
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	class CantReadFile : public ::Core::Exception {
	public:
		const char* what () const throw () {
			return "Can't read file";
		}
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	class FileImportError : public ::Core::Exception {
	public:
		const char* what () const throw () {
			return "File import error";
		}
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	class InvalidBelongs : public ::Core::Exception {
	public:
		const char* what () const throw () {
			return "Invalid belongs";
		}
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	class InvalidDateFormat : public ::Core::Exception {
	public:
		const char* what () const throw () {
			return "Invalid date format";
		}
	private:
		const char* uid () const /*throw ()*/ {
			return 0;
		}
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	class BelongsInfo {
	public:
		BelongsInfo ();

		virtual ~BelongsInfo ();

	public:
		typedef std::vector <unsigned> BelongsVector;

		void init (const ACE_TString& belongs, const ACE_TString& ignore_belongs);

		inline const BelongsVector& get_belongs () const {
			return m_belongs;
		}

		inline const BelongsVector& get_ignore_belongs () const {
			return m_ignore_belongs;
		}

	private:
		void init (const ACE_TString& in, BelongsVector& out);
		void check ();
	
	private:
		BelongsVector m_belongs;
		BelongsVector m_ignore_belongs;
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	struct InpharmData {
		ACE_TString firms_file;
		ACE_TString atcs_file;
		ACE_TString reg_statuses_file;
		ACE_TString lek_forms_file;
		ACE_TString countries_file;
		ACE_TString pharm_groups_file;
		ACE_TString pharm_effects_file;
		ACE_TString chapters_file;
		ACE_TString mkbs_file;
	};

	struct Date	{
		unsigned short year;
		unsigned char day;
		unsigned char mon;

		Date () : year (0), day (0), mon (0) {
		}

		inline Date& operator = (const Date& d) {
			year = d.year;
			day = d.day;
			mon = d.mon;
			return *this;
		}
	};

	struct Dates {
		Date revision;
		Date today;
		Date sat;
	};

	struct ConfigData {
		Dates dates;
		BelongsInfo belongs_info;
		InpharmData inpharm_data;

		ACE_TString anno_user_file;
		ACE_TString anno_organization_file;
		ACE_TString anno_tax_file;
		ACE_TString anno_interest_file;
		ACE_TString anno_kind_file;

		ACE_TString cat_file;
		ACE_TString types_file;
		ACE_TString territory_file;
		ACE_TString sources_file;
		ACE_TString pub_source_file;
		ACE_TString warnings_file;
		ACE_TString priority_table_file;
		ACE_TString obj_types_file;
		ACE_TString norm_file;
		ACE_TString belong_file;
		ACE_TString class_file;
		ACE_TString key_word_file;
		ACE_TString service_info_file;

		/*
		ACE_TString sat_date;
		ACE_TString today_date;
		ACE_TString revision_date;
		*/

		ACE_TString out_name;
		ACE_TString obj_root;

		ACE_TString weights_table_file;
		ACE_TString out_ref_table_file;
		ACE_TString out_obj_table_file;

		/*
		int NDT_compress;
		int check_vincluded;
		int check_name_length;
		int enable_stdout; //do_stdout
		*/

		int MF_compress_level;

		unsigned long flags;

		ConfigData () : flags (0), MF_compress_level (0) {
		}
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////////////

	class ConfigReader {
	public:
		ConfigReader (const std::string& ini_path);

		virtual ~ConfigReader ();

		void read (ConfigData& out);
		
	private:
		int get_int_value (ACE_Configuration_Section_Key& key, const char* name);

	private:
		std::string m_ini_path;

		ACE_Configuration_Heap m_config;
	};

	/*
	FStringSplaySet* inRTFile;
	FStringSplaySet* inOFile;

	int ref_table_gen;
	int obj_table_gen;
	int ref_doc_check;
	int iniSbrf;
	int text_command_check;
	int print_prefix_ex;
	int sub_title_check;
	int extrn_ref_fatal;
	int printRU;

	short TopicRanges;

	int32_t*	LoTopicRanges;
	int32_t*	HiTopicRanges;
	*/

} // namespace Compiler

#endif //__COMPILER__COMPILE_CONFIG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////