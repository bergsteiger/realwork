//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include <iostream>

#include "shared/GCL/str/str_conv.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include "SearchProfiler.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) {
		Core::ParamManagerInitData id;
		id.application_name = "SearchProfiler";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);

		if (Core::ParamManagerFactory::get ().is_exist ("-ini")) {
			m_ini_file = Core::ParamManagerFactory::get ().get_string ("-ini");
		}

		m_is_etalon = Core::ParamManagerFactory::get ().is_exist ("-etalon");

		std::cout 
			<< std::endl
			<< "SearchProfiler "
			<< "("
			<< __DATE__
			<< ", "
			<< __TIME__
			<< ")"
			<< std::endl
			<< std::endl
			<< "ini : " << m_ini_file
			<< std::endl 
			<< std::endl;
	}

	virtual ~Executor () {
	}

	void execute () {
		if (m_ini_file.empty ()) {
			LOG_E (("%s: path to ini is not initialized", GDS_CURRENT_FUNCTION));
			return;
		}

		try {
			SearchProfiler::Profiler (m_ini_file, m_is_etalon).execute ();
		} catch (std::exception&) {
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		std::cout << std::endl;
	}

public:
	bool m_is_etalon;
	std::string m_ini_file;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

int main (int argc, char* argv []) {
	Core::AutoInit init;

	ExecuteStatus ret = es_Success;

	try {
		Executor (argc, argv).execute ();
	} catch (...) {
		std::cout << std::endl << "Abnormal canceled.." << std::endl << std::endl;
		ret = es_Error;
	}

	return (int) ret;
}

