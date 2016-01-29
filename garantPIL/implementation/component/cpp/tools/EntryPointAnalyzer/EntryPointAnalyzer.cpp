//
// EntryPointAnalyzer.cpp : implementation file
//

#include "ace/ACE.h"

#include <functional>
#include <fstream>

#include "shared/ContextSearch/Common/Constants.h"

#include "EntryPointAnalyzer.h"

bool operator > (const RefwRele& x, const RefwRele& y) {
	return (x.Rele > y.Rele);
}

namespace EntryPointAnalyze {

typedef std::vector <RefwRele> RelevancyVector;

//////////////////////////////////////////////////////////////////////////////////////////

class Dump {
public:
	static void out (const char* path, const SortedCollection& collect);
	static void out (const char* path, const RelevancyVector& vect);

private:
	static void out (size_t pos, std::ofstream& ofs, const RefwRele& item);
};

//////////////////////////////////////////////////////////////////////////////////////////

EntryPointAnalyzer::RRef::RRef (): rate (0), rel_rate (0) {
}

bool EntryPointAnalyzer::RRef::operator == (const RRef& val) const {
	return (ref.DocId == val.ref.DocId && ref.Sub == val.ref.Sub);
}

bool EntryPointAnalyzer::CompareByRate::operator () (const RRef& first_, const RRef& second_) const {
	return first_.rate > second_.rate;
}

EntryPointAnalyzer::CalcRelativeRate::CalcRelativeRate (Index* corr_index) : m_index (corr_index)  {
}

void EntryPointAnalyzer::CalcRelativeRate::operator () (RRef& param_) const {
	Stream* str = m_index->Open (&param_.ref.DocId);

	if (str) {
		long count = str->Length () / sizeof (CorrRef);

		if (count > 0) {
			double val = (double) param_.rate / count;
			param_.rel_rate = (size_t) (val * 10000);
		} else {
			LOG_E (("%s : invalid stream length", GDS_CURRENT_FUNCTION));
		}

		m_index->Close (str);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

EntryPointAnalyzer::EntryPointAnalyzer (const std::string& path) : m_request (0) {
	m_base = new ToolsBase (path);

	m_request = (IndexReq*) ACE_OS::malloc (sizeof (IndexReq) + 1024);

	m_request->ItemCount = 1;
	m_request->ItemSize  = 0;
	m_request->SearchOp = SO_AND | SO_KEYS_AND | SV_MBODIES;

	ACE_OS::strcpy (m_request->Name, "Morpho");

	this->load_abolished ();
}

EntryPointAnalyzer::~EntryPointAnalyzer () {
	ACE_OS::free (m_request);
}

void EntryPointAnalyzer::execute (const Properties& properties) {
	std::ifstream ifs (properties.in.c_str ());

	if (ifs) {
		std::ofstream ofs (properties.out.c_str (), std::ios_base::trunc);

		if (ofs) {
			std::string str;

			RefVector ref_vector;
			ref_vector.reserve (1024);

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () == false) {
					if (str [0] != ';') {
						ofs << str << ": ";

						std::cout << str << std::endl;

						this->execute (str, properties.count, ref_vector);

						size_t ref_count = 0;

						RefVector::const_iterator it = ref_vector.begin (), it_end = ref_vector.end ();

						for (; it != it_end && ref_count < properties.ref_count; ++it) {
							DocInfo doc_info;

							if (m_base->FindDocInfo (it->ref.DocId, doc_info) == sizeof (DocInfo)) {
								if (doc_info.Status & DS_NODOC) {
									continue;
								}
							} else {
								LOG_W (("%s : invalid doc info", GDS_CURRENT_FUNCTION));
							}

							bool is_out = false;

							switch (properties.type) {
								case rt_Absolute:
									is_out = (it->rate >= properties.min_rate);
									break;
								case rt_Relative:
									is_out = (it->rel_rate >= properties.min_rate);
									break;
							}

							if (is_out) {
								ofs << it->ref.DocId
									<< '.'
									<< it->ref.Sub
									<< " ("
									<< it->rate
									<< ", "
									<< it->rel_rate
									<< "); ";

								++ref_count;
							}
						}

						ofs << std::endl;
					}
				}

				ref_vector.clear ();
			}

			ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
		}

		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.in.c_str ()));
	}
}

void EntryPointAnalyzer::execute (const std::string& req_str, size_t count, RefVector& ref_vector) {
	RelevancyVector result;
	{
		char* ptr = (char*)(m_request + 1);

		ACE_OS::strcpy (ptr, req_str.c_str ());

		IndexReq* reqs [1];
		reqs [0] = m_request;

		Core::Aptr <SearchResult> res = m_base->Search (
			1
			, reqs
			, 0
			, SO_AND
			, 0
			, 1
			, 0
			, false
			, true
		);

		if (res->list) {
			result.resize (res->list->ItemCount);

			long i = 0;

			for (RelevancyVector::iterator it = result.begin (); it != result.end (); ++it) {
				RefwRele* item = (RefwRele*) res->list->GetItem (i++);

				it->DocId = item->DocId;
				it->Word = item->Word;
				it->Rele = item->Rele;
			}

			res->list->FreeAll ();

			delete res->list;
		}
	}

	//
	//Dump::out ("C:\\full.t", result);
	//

	std::sort (result.begin (), result.end (), std::greater <RefwRele> ());

	result.erase (result.begin () + std::min <size_t> (count, result.size ()), result.end ());

	//
	//Dump::out ("C:\\dump1.t", result);
	//

	bool has_rate = false;

	for (RelevancyVector::const_iterator it = result.begin (); it != result.end (); ++it) {
		this->execute (*it, ref_vector, has_rate);
	}

	// сортируем найденные гиперссылки по частотности
	if (has_rate) {
		std::sort (ref_vector.begin (), ref_vector.end (), CompareByRate ());
	}

	Index* corr_index = m_base->FindIndex ("NewCorr");

	// вычисляем относительную частность
	if (corr_index && corr_index->ImmDataSize == sizeof (CorrRef)) {
		std::for_each (ref_vector.begin (), ref_vector.end (), CalcRelativeRate (corr_index));
	} else {
		LOG_E (("%s : index NewCorr not found", GDS_CURRENT_FUNCTION));
	}

#ifdef _DEBUG
	for (RefVector::const_iterator it = ref_vector.begin (); it != ref_vector.end (); ++it) {
		ACE_OS::printf ("doc:%ld, sub:%ld, rate:%d\n", it->ref.DocId, it->ref.Sub, it->rate);
	}
#endif
}

void EntryPointAnalyzer::execute (const RefwRele& item, RefVector& ref_vector, bool& has_rate) {
	long i = 0, refs_count = 0, paras_count = 0;

	IndexLoader loader (m_base.in ());

	INDEX_DATA (RespRef) resp_refs = loader.load <RespRef> (item.DocId, IDD_REFS, refs_count); 

	if (resp_refs.is_nil ()) {
		return;
	}

	INDEX_DATA (long) para_ids = loader.load <long> (item.DocId, IDD2_PARAIDS, paras_count);

	if (para_ids.is_nil ()) {
		return;
	}

	// находим параграф с первой точкой входа
	long para_id = para_ids.ptr () [m_base->find_paras_with_word (item.DocId, item.Word)];

	// пропускаем ненужные ссылки
	for (; i < refs_count && resp_refs.ptr () [i].ParaId != para_id; ++i);

	RRef ref;

	// cобираем для каждого запроса все найденные гиперссылки
	for (; i < refs_count && resp_refs.ptr () [i].ParaId == para_id; ++i) {
		const RespRef& cur = resp_refs.ptr () [i];

		if (std::binary_search (m_abolished_docs.begin (), m_abolished_docs.end (), cur.DocId) == false) {
			ref.ref.DocId = cur.DocId;
			ref.ref.Sub = cur.Sub;
			ref.rate = 1;

			RefVector::iterator find_it = std::find (ref_vector.begin (), ref_vector.end (), ref);

			if (find_it == ref_vector.end ()) {
				ref_vector.push_back (ref);
			} else {
				++(find_it->rate);
				has_rate = true;
			}
		}
	}
}

void EntryPointAnalyzer::load_abolished () {
	Index* index = m_base->FindIndex ("Status");

	if (index) {
		if (index->streams->Fat == 0) {
			index->streams->LoadFat ();
		}

		short key = DS_ABOLISHED;

		Stream* str = index->OpenN (&key, 0);

		if (str) {
			size_t type_size = sizeof (long), count = (size_t) str->Length () / type_size;

			m_abolished_docs.resize (count);

			DocVector::iterator it = m_abolished_docs.begin (), it_end = m_abolished_docs.end ();

			for (; it != it_end; ++it) {
				str->Read (&(*it), type_size);
			}

			index->Close (str);
		}
	} else {
		LOG_E (("%s: can't create object", GDS_CURRENT_FUNCTION));
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

void Dump::out (const char* path, const SortedCollection& collect) {
	std::ofstream ofs (path, std::ios_base::trunc);

	if (ofs) {
		for (long i = 0; i < collect.ItemCount; ++i) {
			Dump::out (i, ofs, *(static_cast <const RefwRele*> (collect.GetItem (i))));
		}

		ofs.close ();
	}
}

void Dump::out (const char* path, const RelevancyVector& vect) {
	std::ofstream ofs (path, std::ios_base::trunc);

	if (ofs) {
		for (RelevancyVector::const_iterator it = vect.begin (); it != vect.end (); ++it) {
			Dump::out (std::distance (vect.begin (), it), ofs, *it);
		}

		ofs.close ();
	}
}

void Dump::out (size_t pos, std::ofstream& ofs, const RefwRele& item) {
	ofs << pos << ".\t" << "\tdoc: " << item.DocId << "\trel: " << item.Rele << "\tpos: " << item.Word;
	ofs << std::endl;
}

}
