//
// Helpers.cpp : implementation file
//

#include "ace/ACE.h"

#include "shared/Core/GDS/StopWatch.h"

#include "btiter.h"
#include "Helpers.h"

namespace EndtTools {

//////////////////////////////////////////////////////////////////////////////////////////
// GeneratorData implementation

GeneratorData::GeneratorData (GeneratorHelper* helper, const char* text, long text_len, const ParaInfo* info) 
	: m_link (0)
	, m_starts (0)
	, m_link_offset (0)
	, m_text_len (text_len)
	, m_info (info)
	, m_text (text)
	, m_helper (helper) {
}

GeneratorData::~GeneratorData () {
	if (m_link) {
		delete m_link;
		m_link = 0;
	}
}

void GeneratorData::reset (const ParaInfo* info) {
	m_starts = 0;
	m_link_offset = 0;
	m_info = info;
}

//////////////////////////////////////////////////////////////////////////////////////////
// GeneratorHelper implementation

Document* GeneratorHelper::open_document (long doc_id, const DocInfo* info) {
	Document_aptr ret (m_base->GetDoc (doc_id, info));

	if (ret.ptr () == 0 || ret->IsOk () == 0) {
		throw EndtTools::TopicNotFound ();
	} else if ((ret->Stat.Status & DS_EVD) == 0) {
		throw EndtTools::NotEvdFormat ();
	}

	return ret._retn ();
}

void GeneratorHelper::log_activate (const char* path) {
	m_log = new Log (path);
}

void GeneratorHelper::log (const char* msg, const ParaInfo* info) {
	if (m_log.ptr ()) {
		m_log->out (msg, info->m_doc_id, info->m_para);
	}
}

bool GeneratorHelper::load_data (long doc_id) {
	if (m_base && m_doc_id != doc_id) {
		m_refs_count = 0;
		m_resp_refs = IndexLoader (m_base).load <RespRef> (doc_id, IDD_REFS, m_refs_count);

		m_id_count = 0;
		m_ids = IndexLoader (m_base).load <ParaId> (doc_id, IDD2_PARAIDS, m_id_count);

		m_doc_id = doc_id;
	}

	return this->is_valid ();
}

void GeneratorHelper::bad_ref_init () {
	m_bad_refs = new LongVector ();
	m_bad_refs->reserve (1024);
}

long GeneratorHelper::get_ref_count (size_t para, size_t offset, long& pos) {
	long ret = 0, i = 0;

	ParaId para_id = m_ids.ptr () [para];

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id) {
			break;
		}
	}

	pos = i;

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id) {
			if (m_resp_refs.ptr () [i].Offset == offset) {
				++ret;
			}
		} else {
			break;
		}
	}

	return ret;
}

void GeneratorHelper::add_to_vector (LongVector& vect, size_t para, size_t offset) {
	const ParaId para_id = m_ids.ptr () [para];

	long i = 0;

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id) {
			break;
		}
	}

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id) {
			if (m_resp_refs.ptr () [i].Offset == offset) {
				vect.push_back (m_resp_refs.ptr () [i].DocId);
			}
		} else {
			break;
		}
	}
}

#ifdef _DEBUG
void print_vect (const LongVector* vect) {
	LongVector::const_iterator it = vect->begin (), it_end = vect->end ();
	for (; it != it_end; ++it) {
		ACE_OS::printf ("%d ", *it);
	}
}
#endif

void GeneratorHelper::remove_bad_ref (Base* base, long doc_id) {
	GDS_ASSERT (m_bad_refs.ptr ());

	if (m_refs_count && m_bad_refs->size ()) {
		std::sort (m_bad_refs->begin (), m_bad_refs->end ());

		// Делаем unique, т.к. возможны случаи когда уникальные номера параграфов не уникальны.
		// Например в базах из регионов встречаются документы в которых есть параграфы с одинаковыми id.
		{
			LongVector::iterator it = std::unique (m_bad_refs->begin (), m_bad_refs->end ());
			m_bad_refs->resize (std::distance (m_bad_refs->begin (), it));
		}

		GDS_ASSERT ((size_t) m_refs_count >= m_bad_refs->size ());

		const size_t new_size = m_refs_count - m_bad_refs->size ();

		AttrKey key;
		key.DocId = doc_id;
		key.AttrTag = IDD_REFS;

		if (new_size) {
			Core::Aptr <RespRef> new_data = new RespRef [new_size];

			LongVector::const_iterator it = m_bad_refs->begin (), it_end = m_bad_refs->end ();

			long j = 0;
			{
				for (long i = 0; i < m_refs_count; ++i) {
					if (it != it_end && *it == i) {
						++it;
					} else {
						ACE_OS::memcpy (&(new_data.inout () [j]), &(m_resp_refs.ptr () [i]), sizeof (RespRef));
						++j;
					}
				}
			}

			new_data.ptr () [0].Offset = 0;

			for (size_t i = 1; i < new_size; ++i) {
				if (new_data.ptr () [i].ParaId == new_data.ptr () [i - 1].ParaId) {
					if (new_data.ptr () [i].Offset - new_data.ptr () [i - 1].Offset > 1) {
						new_data.ptr () [i].Offset = new_data.ptr () [i - 1].Offset + 1;
					}
				} else {
					new_data.ptr () [i].Offset = 0;
				}
			}

			Index* index = base->FindIndex ("Attrs");

			if (index) {
				Stream* str = index->Open (&key);

				if (str) {
					str->Seek (0);
					str->Write (new_data.in (), static_cast<int> (new_size) * sizeof (RespRef));
					str->Trunc ();

					index->Close (str);
				}
			}
		} else {
			base->FindIndex ("Attrs")->Delete (&key);
		}

#ifdef _DEBUG
		long refs_count = 0;
		INDEX_DATA (RespRef) resp_refs = IndexLoader (base).load <RespRef> (doc_id, IDD_REFS, refs_count); 
#endif
	}
}

void GeneratorHelper::remove_bad_ref_2 (Base* base, long doc_id) {
	if (m_refs_count) {
		std::sort (m_bad_refs->begin (), m_bad_refs->end ());

		// Делаем unique, т.к. возможны случаи когда уникальные номера параграфов не уникальны.
		// Например в базах из регионов встречаются документы в которых есть параграфы с одинаковыми id.
		if (m_bad_refs->size ()) {
			LongVector::iterator it = std::unique (m_bad_refs->begin (), m_bad_refs->end ());
			m_bad_refs->resize (std::distance (m_bad_refs->begin (), it));
		}

		GDS_ASSERT ((size_t) m_refs_count >= m_bad_refs->size ());

		const size_t new_size = m_refs_count - m_bad_refs->size ();

		AttrKey key;
		key.DocId = doc_id;
		key.AttrTag = IDD_REFS;

		if (new_size) {
			Core::Aptr <RespRef> new_data = new RespRef [new_size];

			LongVector::const_iterator it = m_bad_refs->begin (), it_end = m_bad_refs->end ();

			long j = 0;
			{
				for (long i = 0; i < m_refs_count; ++i) {
					if (it != it_end && *it == i) {
						++it;
					} else {
						void *dest = &(new_data.inout () [j]);
						ACE_OS::memcpy (dest, &(m_resp_refs.ptr () [i]), sizeof (RespRef));
						((RespRef*)dest)->Sub = 0;
						++j;
					}
				}
			}

			new_data.ptr () [0].Offset = 0;

			for (size_t i = 1; i < new_size; ++i) {
				if (new_data.ptr () [i].ParaId == new_data.ptr () [i - 1].ParaId) {
					if (new_data.ptr () [i].Offset - new_data.ptr () [i - 1].Offset > 1) {
						new_data.ptr () [i].Offset = new_data.ptr () [i - 1].Offset + 1;
					}
				} else {
					new_data.ptr () [i].Offset = 0;
				}
			}

			Index* index = base->FindIndex ("Attrs");

			if (index) {
				Stream* str = index->Open (&key);

				if (str) {
					str->Seek (0);
					str->Write (new_data.in (), static_cast<int> (new_size) * sizeof (RespRef));
					str->Trunc ();

					index->Close (str);
				}
			}
		} else {
			base->FindIndex ("Attrs")->Delete (&key);
		}

#ifdef _DEBUG
		long refs_count = 0;
		INDEX_DATA (RespRef) resp_refs = IndexLoader (base).load <RespRef> (doc_id, IDD_REFS, refs_count); 
#endif
	}
}

bool GeneratorHelper::is_ref_exist (size_t para, size_t offset) {
	long i = 0;

	const ParaId para_id = m_ids.ptr () [para];

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id && m_resp_refs.ptr () [i].Offset == offset) {
			break;
		}
	}

	long safe_pos = i, bad_ref_counter = 0;

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id && m_resp_refs.ptr () [i].Offset == offset) {
			if (this->is_doc_exist (m_resp_refs.ptr () [i].DocId) == false) {
				m_bad_refs->push_back (i);
				++bad_ref_counter;
			} 
		} else {
			break;
		}
	}

	return (safe_pos != i - bad_ref_counter);
}

bool GeneratorHelper::is_ref_exist_2 (size_t para, size_t offset) {
	long i = 0;

	const ParaId para_id = m_ids.ptr () [para];

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id && m_resp_refs.ptr () [i].Offset == offset) {
			break;
		}
	}

	long safe_pos = i, bad_ref_counter = 0;

	for (; i < m_refs_count; ++i) {
		if (m_resp_refs.ptr () [i].ParaId == para_id && m_resp_refs.ptr () [i].Offset == offset) {
			if ((m_doc_id == m_resp_refs.ptr () [i].DocId) || (this->is_doc_exist (m_resp_refs.ptr () [i].DocId) == false)) {
				m_bad_refs->push_back (i);
				++bad_ref_counter;
			} 
		} else {
			break;
		}
	}

	return (safe_pos != i - bad_ref_counter);
}

bool GeneratorHelper::is_blob_exist (long id) const {
	if (id) {
		return std::binary_search (m_doc_data.blob_ids.begin (), m_doc_data.blob_ids.end (), id);
	} else {
		return false;
	}
}

bool GeneratorHelper::is_doc_exist (long id) const {
	if (id) {
		return std::binary_search (m_doc_data.doc_ids.begin (), m_doc_data.doc_ids.end (), id);
	} else {
		return true;
	}
}

char* GeneratorHelper::get_idd_evd (long doc_id, long& size) {
	return IndexLoader (m_base).load <char> (doc_id, IDD_EVD, size, false);
}

} // namespace
