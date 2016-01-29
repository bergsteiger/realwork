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
		id.application_name = "EndtRefFilter2";
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

			printf ("tune index Respondent\n");
			{
			Index* respondents = safe_base->ptr()->FindIndex ("Respondent");
			for (BTIterator it (respondents); !it.End (); ++it) {
				Stream* str = respondents->Open (it.Key ());
				if (str) {
					int length = str->Length (), count = length / sizeof (Ref);
					RefCollection refcoll;
					Ref *refs = new Ref [count], *ptr = refs;
					str->Read (refs, length);
					for (int i = 0; i < count; i++, ptr++) {
						ptr->Sub = 0;
						refcoll.Add (*ptr);
					}

					str->Seek (0);
					refcoll.Put (str);
					str->Trunc ();
					respondents->Close (str);
					delete [] refs;
				}
			}
			}

			printf ("tune index NewCorr\n");
			{
			Index* newcorrs = safe_base->ptr()->FindIndex ("NewCorr");
			long perc_step = newcorrs->KeyCount / 100, perc = 0, cur = 0;
			std::map<long,long*> map_doc_ids;
			std::map<long,long> map_doc_size;
			long total_size = 0;

			for (BTIterator it (newcorrs); !it.End (); ++it) {
				if (++cur == perc_step) {
					printf ("%ld%%\r", ++perc);
					cur = 0;
				}
				Stream* str = newcorrs->Open (it.Key ());
				if (str) {
					int length = str->Length (), count = length / sizeof (CorrRef);
					CorrRef *refs = new CorrRef [count], *ptr = refs;
					str->Read (refs, length);

					for (int i = 0; i < count; i++,ptr++) {
						long id = ptr->DocId, size, *ids;						
						if (map_doc_ids.find (id) == map_doc_ids.end ()) {
							if (total_size > 1024 * 1024 * 1024) {
								map_doc_size.clear ();
								for (std::map<long,long*>::iterator map_it = map_doc_ids.begin (); map_it != map_doc_ids.end (); map_it++)
									gk_free (map_it->second);
								map_doc_ids.clear ();
								total_size = 0;
							}
							ids = (long*) safe_base->ptr()->LoadAttrEx (id, IDD2_PARAIDS, size);
							total_size += size;
							size >>= 2;
							map_doc_ids.insert (std::map<long,long*>::value_type (id, ids));
							map_doc_size.insert (std::map<long,long>::value_type (id, size));
						} else {
							ids = map_doc_ids.find (id)->second;
							size = map_doc_size.find (id)->second;
						}
						long *ids_ptr = ids;
						for (int j = 0; j < size; j++, ids_ptr++) {
							if (*ids_ptr) {
								ptr->RealPara = j;
								ptr->Para = *ids_ptr;
								break;
							}
						}
					}

					str->Seek (0);
					str->Write (refs, length);
					newcorrs->Close (str);
					delete [] refs;
				}
			}
			}

			EndtTools::EndtParser (base.in ()).remove_bad_ref_2 (safe_base->ptr (), data, m_doc_id);
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
