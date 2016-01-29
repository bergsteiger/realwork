//
// Cache.cpp : implementation file
//

#include "ace/ACE.h"

#include "shared/Core/GDS/StopWatch.h"

#include <iterator>

#include "ThreadManager.h"
#include "common.h"
#include "Cache.h"

namespace EndtConvertor {

int thr_func (void* arg) {
	Cache* obj = static_cast <Cache*> (arg);
	ThreadManager* manager = ThreadManager::Singleton::instance ();

	GDS_ASSERT (obj && manager);

	Core::Aptr <Base> base = manager->make ();
	while (obj->load_doc_info (base.in (), manager->get_pos ()));
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////

Cache::Cache () {
}

void Cache::init (const std::string& path) {
	try {
		m_base = new YBase (path.c_str (), O_RDONLY);
		m_base->IsOk ();
	} catch (...) {
		_msg ("%s: open base error", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	} 

	try {
		Core::GDS::StopWatch sw ("load_topics");
		m_topics = m_base->AllTopics (ID_BORDER);
	} catch (...) {
	}

	if (m_topics.is_nil () || m_topics->ItemCount <= 0) {
		_msg ("%s: topics not found", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}

	this->load_doc_info ();
	this->load_edis ();
	this->load_blob_info ();
	this->load_splash_topics ();

	GDS_ASSERT (m_doc_status.size () == m_topics->ItemCount);
}

void Cache::load_doc_info () {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	DocInfo info;
	DocCollection* topics = m_topics.in ();

	try {
		EndtTools::ProcessIndicator progress ("load_doc_info", "EndtConvertor.log");
		progress.init (topics->ItemCount);
		progress.set_wo_rt (true);

		for (size_t i = 0; i < (size_t) topics->ItemCount; ++i) {
			long doc_id = (*topics)[i];

			progress.update_ (i);

			if (m_base->FindDocInfo (doc_id, info) == sizeof (DocInfo)) {
				m_doc_status [doc_id] = info.Status;
			} 
		}
	} catch (...) {
		_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}

	/*
	// загрузка в несколько потоков
	try {
		EndtTools::ProcessIndicator progress ("load_doc_info", "EndtConvertor.log");
		progress.init (m_topics->ItemCount);
		ThreadManager::Singleton::instance ()->execute ((ACE_THR_FUNC) thr_func, this, 0, &progress);
	} catch (...) {
		_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}
	*/
}

bool Cache::load_doc_info (Base* base, size_t pos) {
	bool ret = (pos < (size_t) m_topics->ItemCount);

	if (ret) {
		long doc_id = (*m_topics)[pos];

		DocInfo info;

		if (base->FindDocInfo (doc_id, info) == sizeof (DocInfo)) {
			GUARD (m_mutex);
			m_doc_status [doc_id] = info.Status;
		}
	}

	return ret;
}

void Cache::load_blob_info () {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	try {
		for (BTIterator it (m_base->FindIndex ("Blob")); !it.End (); ++it) {
			long obj_id = *(long*)(it.Key ());

			std::pair <ObjInfo_map::iterator, bool> res = m_obj_info.insert (
				ObjInfo_map::value_type (obj_id, ObjInfo_ ())
			);

			this->load_blob_info (obj_id, res.first->second);
		}
	} catch (...) {
		_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}
}

void Cache::load_blob_info (unsigned long obj_id, ObjInfo_& info) {
	Stream* stream = m_base->FindIndex ("Blob")->Open (&obj_id);

	if (stream) {
		if (stream->Length () > 0) {
			ObjInfo obj_info;

			long name_len = -1;

			stream->Read (&obj_info, sizeof (ObjInfo));
			stream->Seek (sizeof (obj_info) + obj_info.size);
			stream->Read (&name_len, sizeof (long));

			if (name_len > 0) {
				char* buffer = new char [name_len + 1];
				stream->Read (buffer, name_len);
				buffer [name_len] = '\0';
				info.name = buffer;
				delete [] buffer;
			}

			info.type = obj_info.type;
		}

		m_base->FindIndex ("Blob")->Close (stream);
	}
}

void Cache::load_splash_topics () {
	try {
		Stream* str = m_base->FindIndex ("Aux")->Open (AUX_SPLASH);

		if (str) {
			long stream_len = str->Length ();

			if (stream_len > 0) {
				size_t count = stream_len / sizeof (long);

				long* splashes = new long [count + 1];
				str->Read (splashes, stream_len);

				m_base->FindIndex ("Aux")->Close (str);

				m_splashes.insert (m_splashes.begin (), splashes, splashes + count);
				std::sort (m_splashes.begin (), m_splashes.end ());

				delete [] splashes; 
			}
		}
	} catch (...) {
		_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
	}
}

void Cache::load_edis () {
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	try {
		Index* index = m_base->FindIndex ("Aux");
		
		if (index) {
			Stream* str = index->Open ("Edis");

			if (str) {
				long size = str->Length ();
				long* data = (long*) malloc (size), *ptr = data;

				str->Read (data, size);
				index->Close (str);

				size >>= 3;

				for (int i = 0; i < size; ++i) {
					long edition = *ptr;
					++ptr;
					long doc = *ptr;
					++ptr;
					m_editions [edition] = doc;
				}

				free (data);
			}
		}
	} catch (...) {
		_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}
}

void Cache::load_editions (const std::string& path) {
	if (path.empty () == false) {
		Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

		try {
			FILE* f = mpcxc_fopen (path.c_str (), "r");

			if (f) {
				while (!feof (f)) {
					long edition, doc;
					fscanf (f,"%ld %ld\n", &edition, &doc);
					m_editions_ext [edition] = doc;
				}
				ACE_OS::fclose (f);
			}
		} catch (...) {
			_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
			throw std::exception ();
		}
	}
}

void Cache::load_pics (const std::string& path) {
	if (path.empty () == false) {
		try {
			FILE* f = mpcxc_fopen (path.c_str (), "r");

			if (f) {
				while (!feof (f)) {
					long pic;
					fscanf (f,"%ld\n", &pic);
					m_pics.insert (pic);
				}
				ACE_OS::fclose (f);
			}
		} catch (...) {
			_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
			throw std::exception ();
		}
	}
}

short Cache::get_status (long doc_id) const {
	DocStatus::const_iterator it = m_doc_status.find (doc_id);
	return (it != m_doc_status.end ())? it->second : 0;
}

long Cache::get_active_redaction (long doc_id, short status) {
	if (status & DS_EDITION) {
		Editions::const_iterator it = m_editions.find (doc_id);
		return (it != m_editions.end ())? it->second : 0;
	} 
	return doc_id;
}

long Cache::get_active_redaction_ex (long doc_id) {
	Editions::const_iterator it = m_editions_ext.find (doc_id);
	return (it != m_editions_ext.end ())? it->second : 0;
}

void Cache::get_blob_info (long obj_id, ObjInfo_& info) {
	ObjInfo_map::const_iterator it = m_obj_info.find (obj_id);

	if (it != m_obj_info.end ()) {
		info.name = it->second.name;
		info.type = it->second.type;
	} else if (m_pics.find (obj_id) != m_pics.end ()) {
		info.type = EOT_PIC;
	} else {
		info.type = 0;
	}
}

bool Cache::is_splash (long doc_id) const {
	return std::binary_search (m_splashes.begin (), m_splashes.end (), doc_id);
}

Base* Cache::get_base () {
	return m_base.in ();
}

DocCollection* Cache::get_all_topics () {
	return m_topics.in ();
}

DocCollection* Cache::get_all_docs () {
	return m_base->AllDocs ();
}

} // namespace

