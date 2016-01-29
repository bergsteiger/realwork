//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include <iostream>

#include "shared/GCL/str/str_conv.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "shared/ContextSearch/impl/Manage_i/SynManager_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.h"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include "PairsBuilder.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// FactoryRegistrator implementation

class FactoryRegistrator {
public:
	static void execute () {
		FactoryRegistrator::registrate <ContextSearch::Manage_i::RequestTransformer_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::SynManager_i_factory> ();
	}

private:
	template <typename Type>
	static void registrate () {
		Core::Var <Type> obj = new Type ();
		obj->registrate_me (0);
	}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) {
		Core::ParamManagerInitData id;
		id.application_name = "ConnectedContexts";
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

		std::cout 
			<< std::endl
			<< "ConnectedContexts "
			<< "("
			<< __DATE__
			<< ", "
			<< __TIME__
			<< ")"
			<< std::endl
			<< std::endl
			<< "in   : " << m_properties.in 
			<< std::endl
			<< "out  : " << m_properties.out 
			<< std::endl
			<< "path : " << m_path
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
			FactoryRegistrator::execute ();

			ConnectedContexts::PairsBuilder (m_path).execute (m_properties);
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		std::cout << std::endl;
	}

public:
	std::string m_path;

	ConnectedContexts::Properties m_properties;
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

//-in "C:\in.txt" -out "C:\out.txt" -path "C:\Program Files\Garant\data2\data"