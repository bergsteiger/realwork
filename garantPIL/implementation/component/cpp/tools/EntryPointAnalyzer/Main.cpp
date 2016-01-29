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

#include "EntryPointAnalyzer.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) {
		Core::ParamManagerInitData id;
		id.application_name = "EntryPointAnalyzer";
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
			m_properties.count = Core::ParamManagerFactory::get ().get_ulong ("-docs");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-min")) {
			m_properties.min_rate = Core::ParamManagerFactory::get ().get_ulong ("-min");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-count")) {
			m_properties.ref_count = Core::ParamManagerFactory::get ().get_ulong ("-count");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-type")) {
			std::string str = Core::ParamManagerFactory::get ().get_string ("-type");

			GCL::to_upper (str);

			if (str == "ABS") {
				m_properties.type = EntryPointAnalyze::rt_Absolute;
			} else if (str == "REL") {
				m_properties.type = EntryPointAnalyze::rt_Relative;
			} 
		}

		if (m_properties.type == EntryPointAnalyze::rt_None) {
			LOG_E (("Unknown type!"));
			throw std::exception ();
		}

		std::cout 
			<< std::endl
			<< "EntryPointAnalyzer "
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
			<< "in    : " << m_properties.in.c_str () 
			<< std::endl
			<< "out   : " << m_properties.out.c_str () 
			<< std::endl
			<< "path  : " << m_path.c_str () 
			<< std::endl
			<< "docs  : " << m_properties.count 
			<< std::endl
			<< "min   : " << m_properties.min_rate 
			<< std::endl
			<< "count : " << m_properties.ref_count
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
			Core::GDS::StopWatch sw ("total");
			EntryPointAnalyze::EntryPointAnalyzer (m_path).execute (m_properties);
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		std::cout << std::endl;
	}

public:
	EntryPointAnalyze::Properties m_properties;

	std::string m_path;
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

//-in "C:\in.txt" -out "C:\out.txt" -path "C:\Program Files\Garant\data2\data" -docs 50 -min 0 -count 6 -type abs
