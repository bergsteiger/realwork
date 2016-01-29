//
// RelCalculator.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/bind.hpp"
#include "boost/lexical_cast.hpp"
#include "boost/lambda/lambda.hpp"

#include "RelCalculator.h"
#include "RelevancyInfo_i.h"
#include "SortAttrCache.h"

namespace RelCalculate {

static const std::string header = "исходный запрос;запрос;метка;позици€ в списке;релевантность;CODE;TYPE;INFORM;X;Y;Z;I;RCHANGE";

//////////////////////////////////////////////////////////////////////////////////////////

struct CompareRel : public std::binary_function <Defs::Detail, Defs::Detail, bool> {
	bool operator () (const Defs::Detail& x, const Defs::Detail& y) const {
		if (x.info.relevancy_value == y.info.relevancy_value) {
			return SortAttrCache::instance ()->compare (x.doc_id, y.doc_id) < 0;
		}
		return x.info.relevancy_value > y.info.relevancy_value;
	}
};

//////////////////////////////////////////////////////////////////////////////////////////

RelCalculator::RelCalculator (const std::string& path) : m_count (1) {
	m_base = new CachedBaseRO (path.c_str ());
	m_base->IsOk ();
	m_base->check_version ();

	m_searcher = Search::Factory::make_searcher (m_base.in ());
}

RelCalculator::~RelCalculator () {
}

void RelCalculator::execute (const Properties& properties) {
	std::cout << "start.." << std::endl << std::endl;

	std::string str;

	// «агрузка списка документов

	if (properties.docs_path.empty ()) {
		m_docs = m_base->AllDocs ();
	} else {
		std::ifstream ifs (properties.docs_path.c_str ());

		if (ifs) {
			m_docs = new DocCollection ();

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () == false && str [0] != ';') {
					m_docs->Add (boost::lexical_cast <long> (str));
				}
			}

			ifs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.docs_path.c_str ()));
		}
	}

	SortAttrCache::instance ()->load (m_base.in ());

	// «агрузка списка запросов, поиск по ним и вывод в результирующий файл

	std::ifstream ifs (properties.in.c_str ());

	if (ifs) {
		m_ofs.open (properties.out.c_str (), std::ios_base::trunc);

		if (m_ofs) {
			m_info = new RelevancyInfo_i (properties.in_details);

			m_prop.init = m_docs.in ();
			m_prop.info_collector = m_info.in ();

			Defs::DetailInfo data;

			m_out_prop = properties.out_prop;

			m_header = header;

			m_ofs << m_header << std::endl;

			while (!ifs.eof ()) {
				std::getline (ifs, str);

				if (str.empty () || str [0] == ';') {
					continue;
				}

				std::cout << str << std::endl;

				try {
					this->search (str);
				} catch (...) {
					LOG_E (("%s: search", GDS_CURRENT_FUNCTION));
				}

				try {
					data = m_info->get_info ();
					this->out (data, properties.req_count, properties.in_details);
				} catch (...) {
					LOG_E (("%s: out", GDS_CURRENT_FUNCTION));
				}

				m_info->clear ();

				m_count = 1;

				m_ofs << std::endl;
			}
			m_ofs.close ();
		} else {
			LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.out.c_str ()));
		}
		ifs.close ();
	} else {
		LOG_E (("%s: can't open %s", GDS_CURRENT_FUNCTION, properties.in.c_str ()));
	}
}

void RelCalculator::search (const std::string& req_str) {
	m_request = req_str;

	Search::IQuery_var query = Search::Factory::make_query (Search::BODY_TYPE, req_str);

	Core::Aptr <Search::SearchResult> res = m_searcher->execute (query.in (), m_prop);
}

long RelCalculator::find_sub_or_block_with_word (long doc_id, long word) {
	IndexLoader loader (m_base.in ());

	long para = m_base->find_paras_with_word (doc_id, word), subs_count = 0, best_para = 0, i = 0, best_sub = 0;

	INDEX_DATA (SubDesc) subs = loader.load <SubDesc> (doc_id, IDD_SUBS, subs_count);

	for (SubDesc* ptr = subs.ptr (); i < subs_count; ++i, ++ptr) {
		if (ptr->Para <= para && ptr->Para > best_para) {
			best_sub = ptr->Sub;
			best_para = ptr->Para;
		}
	}
	return best_sub;
}

void RelCalculator::out (Defs::DetailInfo& data, size_t req_count, bool in_detail) {
	if (data.empty ()) {
		std::string str (std::count_if (m_header.begin (), m_header.end (), boost::lambda::_1 == ';'), ';');
		m_ofs << m_request << str;
	} else {
		size_t count = (req_count == 0)?  data.size () : std::min <size_t> (data.size (), req_count);

		std::sort (data.begin (), data.end (), CompareRel ());

		if (in_detail) {
			std::for_each (data.begin (), data.begin () + count
				, boost::bind (&RelCalculator::out_detail, this, _1)
			);
		} else {
			std::for_each (data.begin (), data.begin () + count
				, boost::bind (&RelCalculator::out, this, _1)
			);
		}
	}
}

void RelCalculator::out_info (const std::string& req, long doc_id, long pos) {
	m_ofs << m_request << ';' << req << ';' << doc_id;

	if (m_out_prop.out_label) {
		try {
			m_ofs << '.' << this->find_sub_or_block_with_word (doc_id, pos);
		} catch (...) {
			LOG_E (("%s: label", GDS_CURRENT_FUNCTION));
		}
	}

	if (m_out_prop.out_pos) {
		m_ofs << '.' << pos;
	}
}

void RelCalculator::out_detail (const Defs::Detail& data) {
	const Defs::RelDetail& info = data.rel_detail;
	const Defs::ParamDetail& params = data.params;
	const GCL::StrVector& reqs = data.reqs;

	GDS_ASSERT (info.size () == data.params.size ());
	GDS_ASSERT (info.size () == reqs.size ());

	for (size_t i = 0; i < info.size (); ++i) {
		this->out_info (reqs [i], (long) data.doc_id, (long) info [i].position);

		m_ofs << ';'
			<< m_count << ';'
			<< info [i].relevancy_value << ';'
			<< data.code_factor << ';'
			<< data.type_factor << ';'
			<< data.inform_factor << ';'
			<< params [i].X << ';'
			<< params [i].Y << ';'
			<< params [i].Z << ';'
			<< params [i].I << ';'
			<< data.rch_factor << ';'
			<< std::endl;

		++m_count;
	}
}

void RelCalculator::out (const Defs::Detail& data) {
	this->out_info (data.req, (long) data.doc_id, (long) data.info.position);

	m_ofs << ';'
		<< m_count << ';'
		<< data.info.relevancy_value << ';'
		<< data.code_factor << ';'
		<< data.type_factor << ';'
		<< data.inform_factor << ';'
		<< data.param.X << ';'
		<< data.param.Y << ';'
		<< data.param.Z << ';'
		<< data.param.I << ';'
		<< data.rch_factor << ';'
		<< std::endl;

	++m_count;
}

}
