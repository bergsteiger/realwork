//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include <iostream>

#include "shared/Core/sys/start_stop.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include "Generate.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////

struct CoreInit {
	CoreInit () {
		Core::init ();
	}

	~CoreInit () {
		Core::fini ();
	}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) {
		Core::ParamManagerInitData id;
		id.application_name = "RDict";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		if (Core::ParamManagerFactory::get ().is_exist ("-file")) {
			m_file = Core::ParamManagerFactory::get ().get_string ("-file");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-in")) {
			m_src = Core::ParamManagerFactory::get ().get_string ("-in");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-out")) {
			m_dst = Core::ParamManagerFactory::get ().get_string ("-out");
		}

		m_is_instrumentalis = Core::ParamManagerFactory::get ().is_exist ("-instr");

		std::cout 
			<< std::endl
			<< "RDIC generator "
			<< "("
			<< __DATE__
			<< ", "
			<< __TIME__
			<< ")"
			<< std::endl
			<< std::endl;

		std::string default_path = argv [0];

		const char* slash = ACE_OS_String::strrchr (default_path.c_str (), '\\');

		size_t pos = default_path.find (slash);

		if (pos != std::string::npos) {
			default_path = default_path.substr (0, pos);
		}

		if (m_src.empty ()) {
			m_src = default_path;
		}

		if (m_dst.empty ()) {
			m_dst = default_path;
		}

		std::cout << "in : " << m_src.c_str () << std::endl;
		std::cout << "out: " << m_dst.c_str () << std::endl << std::endl;
		std::cout << "-----------------------" << std::endl << std::endl;
	}

	virtual ~Executor () {
	}

	void execute () {
		Core::GDS::StopWatch sw ("total");

		try {
			DictGenerator::Generator generator (m_src, m_dst, m_is_instrumentalis);

			if (m_file.empty ()) {
				generator.execute ();
			} else {
				generator.execute (m_file.c_str ());
			}
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		std::cout << std::endl;
	}

public:
	std::string m_src;
	std::string m_dst;
	std::string m_file;

	bool m_is_instrumentalis;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

int main (int argc, char* argv []) {
	CoreInit init;

	ExecuteStatus ret = es_Success;

	try {
		Executor (argc, argv).execute ();
	} catch (...) {
		std::cout << std::endl << "Abnormal canceled.." << std::endl << std::endl;
		ret = es_Error;
	}

	return (int) ret;
}
