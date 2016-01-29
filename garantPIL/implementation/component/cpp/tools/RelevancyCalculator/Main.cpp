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

#include "RelCalculator.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) {
		Core::ParamManagerInitData id;
		id.application_name = "RelCalculator";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		if (Core::ParamManagerFactory::get ().is_exist ("-in")) {
			m_properties.in = Core::ParamManagerFactory::get ().get_string ("-in");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-out")) {
			m_properties.out = Core::ParamManagerFactory::get ().get_string ("-out");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-path")) {
			m_path = Core::ParamManagerFactory::get ().get_string ("-path");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-docs")) {
			m_properties.docs_path = Core::ParamManagerFactory::get ().get_string ("-docs");
		} else if (Core::ParamManagerFactory::get ().is_exist ("-count")) {
			m_properties.req_count = Core::ParamManagerFactory::get ().get_ulong ("-count");
		}

		m_properties.in_details = Core::ParamManagerFactory::get ().is_exist ("-d");
		m_properties.out_prop.out_pos = Core::ParamManagerFactory::get ().is_exist ("-pos");
		m_properties.out_prop.out_label = Core::ParamManagerFactory::get ().is_exist ("-label");

		std::cout 
			<< std::endl
			<< "RelCalculator "
			<< "("
			<< __DATE__
			<< ", "
			<< __TIME__
			<< ")"
			<< std::endl
			<< std::endl;

		std::string default_path = argv [0];

		const char* slash = ACE_OS_String::strrchr (default_path.c_str (), '\\');

		if (slash) {
			size_t pos = default_path.find (slash);

			if (pos != std::string::npos) {
				default_path = default_path.substr (0, pos);
			}

			if (m_properties.in.empty ()) {
				m_properties.in = default_path;
			}

			if (m_properties.out.empty ()) {
				m_properties.out = default_path;
			}
		}

		std::cout 
			<< "in   : " << m_properties.in
			<< std::endl
			<< "out  : " << m_properties.out
			<< std::endl
			<< "path : " << m_path
			<< std::endl
			<< "docs : " << m_properties.docs_path
			<< std::endl
			<< "count: " << m_properties.req_count
			<< std::endl
			<< std::endl;
	}

	virtual ~Executor () {
	}

	void execute () {
		if (m_path.empty ()) {
			LOG_E (("%s: path to base is not initialized", GDS_CURRENT_FUNCTION));
			return;
		}

		try {
			RelCalculate::RelCalculator (m_path).execute (m_properties);
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		std::cout << std::endl;
	}

public:
	std::string m_path;

	RelCalculate::Properties m_properties;
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

//-in "C:\in.txt" -out "C:\out.txt" -path "C:\Program Files\Garant\data2\data" -docs "C:\docs.txt"

