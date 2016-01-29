//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include <iostream>

#include "shared/GCL/str/str_conv.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/Query_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/SynManager_i_factory.h"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include "InformDict.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// FactoryRegistrator implementation

class FactoryRegistrator {
public:
	static void execute () {
		FactoryRegistrator::registrate <ContextSearch::Manage_i::RequestTransformer_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::SynManager_i_factory> ();
		FactoryRegistrator::registrate <ContextSearch::Manage_i::Query_i_factory> ();
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
		id.application_name = "InformDict";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		m_properties.remove_syn_repetition = Core::ParamManagerFactory::get ().is_exist ("-rsr");
		m_properties.remove_syn_repetition_2 = Core::ParamManagerFactory::get ().is_exist ("-rsr2");

		if (m_properties.remove_syn_repetition && m_properties.remove_syn_repetition_2) {
			LOG_E (("%s invalid args", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-in")) {
			m_properties.in = Core::ParamManagerFactory::get ().get_string ("-in");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-out")) {
			m_properties.out = Core::ParamManagerFactory::get ().get_string ("-out");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-req")) {
			m_properties.req_in = Core::ParamManagerFactory::get ().get_string ("-req");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-path")) {
			m_path = Core::ParamManagerFactory::get ().get_string ("-path");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-count")) {
			m_properties.count = Core::ParamManagerFactory::get ().get_ulong ("-count");
		}

		std::string name = "InformDict ";

		if (m_properties.remove_syn_repetition || m_properties.remove_syn_repetition_2) {
			name += "(Remove syn repetition) ";
		} else if (m_properties.in.empty ()) {
			name += "(Construction of pairs) ";
		} else if (m_properties.req_in.empty ()) {
			name += "(To make the data for the panel of informers) ";
		} else {
			name += "(Construction of the panel of informers) ";
		}

		std::cout 
			<< std::endl
			<< name
			<< "("
			<< __DATE__
			<< ", "
			<< __TIME__
			<< ")"
			<< std::endl
			<< std::endl;

		if (m_properties.req_in.empty () == false) {
			std::cout << "req  : " << m_properties.req_in << std::endl;
		}

		if (m_properties.in.empty () == false) {
			std::cout << "in   : " << m_properties.in << std::endl;
		}

		std::cout 
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

			InformersDictionary::InformDictBuilder (m_path).execute (m_properties);
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		std::cout << std::endl;
	}

public:
	std::string m_path;

	InformersDictionary::Properties m_properties;
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

//-in "C:\in.txt" -out "C:\out.txt" -req "C:\req.txt" -path "C:\Program Files\Garant\data2\data"
