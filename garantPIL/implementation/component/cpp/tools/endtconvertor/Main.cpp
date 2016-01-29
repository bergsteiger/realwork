//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"

#include "Interfaces.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Executor implementation

class Executor {
public:
	Executor (int argc, char* argv []) : m_doc_id (0), m_type (EndtConvertor::ct_None) {
		Core::ParamManagerInitData id;
		id.application_name = "EndtConvertor";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		try {
			Core::ParamsImpl::ParamManagerImpl_factory_var f = new Core::ParamsImpl::ParamManagerImpl_factory ();
			f->registrate_me (0);
		} catch (Core::Root::DuplicatedFactoryKey&) {
		}

		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		if (Core::ParamManagerFactory::get ().is_exist ("-from")) {
			m_prop.path_src = Core::ParamManagerFactory::get ().get_string ("-from");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-to")) {
			m_prop.path_dst = Core::ParamManagerFactory::get ().get_string ("-to");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-editions")) {
			m_prop.path_editions = Core::ParamManagerFactory::get ().get_string ("-editions");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-pics")) {
			m_prop.path_pics = Core::ParamManagerFactory::get ().get_string ("-pics");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-id")) {
			m_doc_id = Core::ParamManagerFactory::get ().get_ulong ("-id");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-thr")) {
			m_prop.thr_count = Core::ParamManagerFactory::get ().get_ulong ("-thr");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-type")) {
			std::string type = Core::ParamManagerFactory::get ().get_string ("-type");

			if (type == "all") {
				m_type = EndtConvertor::ct_All;
			} else if (type == "docs") {
				m_type = EndtConvertor::ct_Docs;
			} else if (type == "doc") {
				m_type = EndtConvertor::ct_Doc;
			} else if (type == "fromdoc") {
				m_type = EndtConvertor::ct_From;
			}
		}
	}

	void execute () {
		if (m_prop.path_src.empty ()) {
			LOG_E (("%s: path to source base was not initialized", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		if (m_prop.path_dst.empty ()) {
			LOG_E (("%s: path to destination base was not initialized", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		if (m_type == EndtConvertor::ct_None) {
			LOG_E (("%s: unknown convertation type", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}

		try {
			EndtConvertor::IConvertor_var convertor = EndtConvertor::IConvertorFactory::make (m_prop);

			switch (m_type) {
				case EndtConvertor::ct_From:
					convertor->convert_from (m_doc_id);
					break;
				case EndtConvertor::ct_Doc:
					convertor->convert (m_doc_id);
					break;
				case EndtConvertor::ct_All:
				case EndtConvertor::ct_Docs:
					convertor->convert (m_type);
					break;
				default:
					break;
			}
		} catch (...) {
			LOG_UEX (("%s: canceled", GDS_CURRENT_FUNCTION));
			throw std::exception ();
		}
	}

private:
	unsigned long m_doc_id;

	EndtConvertor::Properties m_prop;
	EndtConvertor::ConvertType m_type;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main (int argc, char* argv []) {
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;

	try {
		Executor (argc, argv).execute ();
	} catch (...) {
		return 1;
	}

	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//command line: -from "C:\data\data" -to "C:\Program Files\Garant\data2\data" -type doc -id 28101766
/////////////////////////////////////////////////////////////////////////////////////////////////////////
