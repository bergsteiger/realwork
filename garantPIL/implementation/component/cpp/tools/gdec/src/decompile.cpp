//
// decompile.cpp : implementation file
//

#include "ace/ACE.h"

#include "garantPIL/implementation/component/cpp/libs/endt/Common.h"

#include "main.h"
#include "decompile.h"

Document* Decompile::open_evd_document (const long doc_id, const DocInfo* info) {
	Document_aptr ret (m_base->GetDoc (doc_id, info));
	if (!ret.ptr () || !ret->IsOk ()) {
		Log.printf (lt_info, "Decompile::open_evd_document: topic %d not found\n", doc_id);
		throw std::exception ();
	}
	return ret._retn ();
}

bool Decompile::check_here (Document* doc) {
	bool ret = false;
	long count = 0;

	Core::Aptr <short, DataDestructor> index_data (
		IndexDataLoader <short> ().load (m_base, doc->DocId, IDD_BASES, count)
	);

	if (index_data.ptr ()) {
		for (long i = 0; i < count; ++i) {
			for (size_t j = 0; j < m_here_count; ++j) {
				if (index_data.ptr () [i] == m_here [j]) {
					ret = true;
					i = count;
					break;
				}
			}
		}
	}
    return ret;
}

void Decompile::load_here () {
	ContextIndex* context_index = (ContextIndex*) m_base->FindIndex ("Aux");
	Stream* str = context_index->Open ("Here");

	if (str) {
		long size = str->Length ();

		if (size > 0) {
			m_here_count = size / sizeof (short);
			m_here = new short [m_here_count];

			str->Read (m_here, size);

			Log.printf (lt_info, "Total Belongs     - %d : ", m_here_count);

			size_t n = m_here_count;
			short* ptr = m_here;

			while (n > 0) {
				Log.printf (lt_info, "%d ", *ptr);
				++ptr;
				--n;
			}

			Log.printf (lt_info, "\n");
		}

		context_index->Close (str);
	}
}

void Decompile::decompile_documents (const char* dir, long from_doc) {
	long i = 0, doc_id = 0, count = 0;

	ace_os_mkdir (dir);

	try {
		DocCollection_aptr topics = m_base->AllTopics (); // collecting all topics
		if (from_doc) {
			i = topics->IndexOf (&from_doc);
			if (i == -1)
				i = 0;
		}

		count = topics->DocCount ();

		Log.printf (lt_info, "Total Documents   - %d\n\n", count);

		EndtTools::ProcessIndicator indicator ("decompiling topics");
		indicator.init (count);

		for (; i < count; ++i) {
			doc_id = topics->GetItem (i);
			indicator.update (i, doc_id);

			if (doc_id > 100000) {
				Document_aptr doc (this->open_evd_document (doc_id));
				if (doc.ptr ()) {
					if (doc->Stat.Status & DS_EVD) {
						if (m_is_full || this->check_here (doc.in ())) {
							Log.printf (lt_info, "Decompiling topic %ld\n", doc_id);
							out_doc (doc.in (), m_parser.in ());
						} else {
							Log.printf (lt_info, "Skip topic %ld\n", doc_id);
						}
					} 
				}
			}
		}
	} catch (...) {
		LOG_UEX (("Decompile::decompile_documents: canceled, topic %d, iteration %d", doc_id, i));
	}

	Log.printf (lt_info, "\n");
}

std::map<long,std::string> map_blob_name;

void Decompile::decompile_blobs (const char* dir) {
	long i = 0, count = 0;

	ace_os_mkdir (dir);

	try {
		count = m_base->FindIndex ("Blob")->KeyCount;

		Log.printf (lt_info, "Total Blobs       - %d\n", count);

		EndtTools::ProcessIndicator indicator ("decompiling blob");
		indicator.init (count);

		char* blob_name_str = strdup (blob_name.c_str ());
		change_slashes (blob_name_str);
		FILE_aptr blob_file = ACE_OS::fopen (blob_name_str, "w");

		if (blob_file.ptr ()) {
			for (; i < count; ++i) {
				indicator.update (i);
				Log.printf (lt_info, "Decompiling blob - %ld\n", i);
				char fname [MAX_PATH];
				long blob = 0;
				out_blob (m_base, blob_file.in (), i, fname, blob);
				char* blobfilename = strrchr (fname, '/');
				if (blobfilename) 
					blobfilename++;
				else {
					blobfilename = strrchr (fname, '\\');
					if (blobfilename)
						blobfilename++;
					else
						blobfilename = fname;
				}
				map_blob_name.insert (std::map<long,std::string>::value_type (blob, blobfilename));
			}
		}
	} catch (...) {
		LOG_UEX (("Decompile::decompile_blobs: canceled, iteration %d", i));
	}
}
