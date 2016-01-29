#include <string>
#include <fstream>

#include "ace/ACE.h"
#include "ace/Process.h"

#include "boost/algorithm/string.hpp"

#include "PostgresBaseChanger.h"

#include "Tests/GoogleFramework/server.h"

namespace {
	std::string get_postgres_params (const std::string& ini_name) {
		const static std::string ini_postgres_params_option ("-postgresinitparams=");

		std::ifstream ini_stream (ini_name.c_str ());
		if (!ini_stream) {
			throw std::runtime_error (("can't find path to ini file: " + ini_name).c_str ());
		}

		std::string string_from_ini;
		while (ini_stream) {
			std::getline (ini_stream, string_from_ini);
			std::string string_from_ini_in_lower_case (string_from_ini);
			boost::algorithm::to_lower (string_from_ini_in_lower_case);
			if (boost::algorithm::starts_with (string_from_ini_in_lower_case, ini_postgres_params_option)) {
				return string_from_ini.substr (ini_postgres_params_option.length ());
			}
		}

		throw std::runtime_error (("can't find -PostgresInitParams option in file" + ini_name).c_str ());
	}

	std::string get_value (const std::string& param, const std::string& ini_params) {
		size_t begin = ini_params.find (param);
		if (begin == std::string::npos) {
			return "";
		}
		size_t end = ini_params.find (" ", begin);
		begin += param.length ();
		return ini_params.substr (begin, end - begin);
	}

	struct PostgresCommandLine {
		PostgresCommandLine () : m_path (make_path ()), m_options (make_options ()) {
		}

		std::string get_path () const {
			return m_path.c_str ();
		}

		std::string get_options () const {
			return m_options;
		}

	private:
		std::string make_path () {
			std::string result ("C:\\Program Files\\PostgreSQL\\9.1\\bin\\");

			const std::string path_to_postgres_utils ("POSTGRES");
			char* path = ACE_OS::getenv (path_to_postgres_utils.c_str ());
			if (path) {
				result = path;
				if (result[result.size () - 1] != ACE_DIRECTORY_SEPARATOR_CHAR) {
					path += ACE_DIRECTORY_SEPARATOR_CHAR;
				}
			}

			return result;
		}

		std::string make_options () {
			const static std::string ini_name (".//garant.ini");
			const std::string& ini_postgres_params = get_postgres_params (ini_name);

			std::string host = get_value ("host=", ini_postgres_params);
			if (host.empty ()){
				host = "127.0.0.1";
			}

			return 
				std::string ("-U ")
				+ get_value ("user=", ini_postgres_params)
				+ std::string (" -w -h ")
				+ host;
		}

	private:
		std::string m_path;
		std::string m_options;
	};
	typedef ACE_Singleton<PostgresCommandLine, ACE_SYNCH_MUTEX> CommandLine;

	void run (const std::string& command, const std::string& options){
		std::string command_line = CommandLine::instance ()->get_path () + command + " " + options;
		ACE_Process_Options process_options;
		process_options.command_line (command_line.c_str ());
		ACE_Process utility;
		pid_t pid = utility.spawn (process_options);
		if (pid <= 0) {
			throw std::runtime_error ("can`t run program: check variable POSTGRES");
		}
		utility.wait ();
		int result = utility.exit_code ();
		if (result != 0) {
			throw std::runtime_error (("bad return code from: " + command).c_str ());
		}
	}
}


namespace postgres {
	PostgresBaseChooser::PostgresBaseChooser (const char* file_bd) : m_file_db (file_bd) {
		create_bd ();
		restore_db ();

		internet_tests::Server::instance ()->user_manager ()->change_postgres_base ("testBase");
	}

	PostgresBaseChooser::~PostgresBaseChooser (){
		try {
			internet_tests::Server::instance ()->user_manager ()->change_postgres_base (0);
			const std::string& options = CommandLine::instance ()->get_options () + " testBase";
			run ("dropdb.exe", options);
		}
		catch (...) {
			LOG_E (("%s: exception", GDS_CURRENT_FUNCTION));
		}
	}

	void PostgresBaseChooser::create_bd (){
		const std::string& options = CommandLine::instance ()->get_options () + " testBase";
		run ("createdb.exe", options);
	}

	void PostgresBaseChooser::restore_db (){
		const std::string& options = CommandLine::instance ()->get_options () + " -dtestBase " + m_file_db;
		run ("pg_restore.exe", options);
	}
}