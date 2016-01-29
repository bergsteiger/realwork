//
// EndtRefFilter.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtWriter.h"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class FilterRunner {
public:
	FilterRunner (int argc, char* argv []) : m_doc_id (0) {
		Core::ParamManagerInitData id;
		id.application_name = "EndtRefFilter";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		if (Core::ParamManagerFactory::get ().is_exist ("-from")) {
			m_src = Core::ParamManagerFactory::get ().get_string ("-from");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-to")) {
			m_dst = Core::ParamManagerFactory::get ().get_string ("-to");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-id")) {
			m_doc_id = Core::ParamManagerFactory::get ().get_ulong ("-id");
		}
	}

	void load (Base* base, EndtTools::DocData& out) {
		Core::Aptr <DocCollection> topics = base->AllTopics (ID_BORDER);

		if (topics.ptr () && topics->ItemCount > 0) {
			out.doc_ids.resize (topics->ItemCount);

			long i = 0;

			for (EndtTools::LongVector::iterator it = out.doc_ids.begin (); it != out.doc_ids.end (); ++it) {
				*it = (*topics)[i++];
			}
		} else {
			LOG_E (("%s: topics not found", GDS_CURRENT_FUNCTION));
		}

		out.blob_ids.resize (base->FindIndex ("Blob")->KeyCount);

		for (BTIterator it (base->FindIndex ("Blob")); !it.End (); ++it) {
			out.blob_ids.push_back (*(long*)(it.Key ()));
		}
	}

	int execute () {
		if (m_src.empty () || m_dst.empty ()) {
			LOG_E (("%s: paths to bases was not initialized", GDS_CURRENT_FUNCTION));
			return 0;
		}

		try {
			Core::Aptr <Base> base = new YBase (m_src.c_str (), O_RDONLY);
			base->IsOk ();

			EndtTools::SafeBase* safe_base = EndtTools::SafeBase::Singleton::instance ();
			safe_base->init (m_dst);

			EndtTools::DocData data;
			this->load (base.in (), data);

			EndtTools::EndtParser (base.in ()).remove_bad_ref (safe_base->ptr (), data, m_doc_id);

		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}

		return 0;
	}

private:
	std::string m_src;
	std::string m_dst;

	unsigned long m_doc_id;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

int main (int argc, char* argv []) {
	Core::AutoInit init;

	return FilterRunner (argc, argv).execute ();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

//-from C:\Program Files\Garant\data2.safe\data -to C:\Program Files\Garant\data2\data -id 1155344
