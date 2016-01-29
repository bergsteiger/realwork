//////////////////////////////////////////////////////////////////////////////////////////
// ћодуль: "RelevancyInfo_i.cpp"

#include "boost/algorithm/string/classification.hpp"
#include "RelevancyInfo_i.h"

// ¬ычисление релевантности
struct Calculate : public std::unary_function <Defs::Detail, void> {
	Calculate (bool in_detail_) : in_detail (in_detail_) {
	}

	void operator () (Defs::Detail& param_) const {
		long rel = param_.code_factor + param_.type_factor + param_.inform_factor + param_.rch_factor;

		if (in_detail) {
			Defs::RelDetail& data = param_.rel_detail;

			try {
				for (Defs::RelDetail::iterator it = data.begin (); it != data.end (); ++it) {
					long rel_ = rel + it->relevancy_value;
					it->relevancy_value = (rel_ < 0)? 0 : (Defs::RelevancyType) rel_;
				}
			} catch (...) {
				LOG_UEX ((GDS_CURRENT_FUNCTION));
			}
		}

		rel += (long) param_.info.relevancy_value;

		param_.info.relevancy_value = (rel < 0)? 0 : (Defs::RelevancyType) rel;
	}

private:
	bool in_detail;
};

// расчет релевантности цепочки
Defs::RelevancyType RelevancyInfo_i::get_chain_relevancy (const Defs::RelevancyParam& in) {
	return in.X + in.Y + in.Z + in.I;
}

//////////////////////////////////////////////////////////////////////////////////////////

RelevancyInfo_i::RelevancyInfo_i (bool in_detail) {
	m_in_detail = in_detail;

	m_data.reserve (64 * 1024);
	m_sizes.reserve (64);
}

RelevancyInfo_i::~RelevancyInfo_i () {
}

// найти элемент в контейнере с информацией о релевантности
const Defs::DetailInfo::iterator RelevancyInfo_i::find (unsigned long doc_id) {
	Defs::Detail detail;
	detail.doc_id = doc_id;

	Defs::DetailInfo::iterator ret = m_data.end ();

	SizeIndex::const_iterator it = m_sizes.begin (), it_end = m_sizes.end ();

	for (size_t offset = 0; it != it_end; ++it) {
		ret = std::lower_bound (m_data.begin () + offset, m_data.begin () + offset + *it, detail);
		offset += *it;

		if (ret != m_data.end () && ret->doc_id == doc_id) {
			break;
		}
	}

	return ret;
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// добавить запрос
void RelevancyInfo_i::add (const std::string& req) {
	if (std::find (req.begin (), req.end (), ',') != req.end ()) {
		if (std::find (req.begin (), req.end (), '(') == req.end ()) {
			m_detail.req.clear ();

			std::string::const_iterator f_it, it = req.begin ();

			for (; ; ++it) {
				it = std::find_if (f_it = it, req.end (), boost::is_any_of (" -~"));

				if (std::find (f_it, it, ',') != it) {
					m_detail.req += '(';
					m_detail.req.append (f_it, it);
					m_detail.req += ')';
				} else {
					m_detail.req.append (f_it, it);
				}

				if (it != req.end ()) {
					m_detail.req += *it;
				} else {
					break;
				}
			}

			return;
		}
	}

	m_detail.req = req;
}

// добавить документ и его релевантность
void RelevancyInfo_i::add (unsigned long doc_id, const Defs::RelevancyInfo& info) {
	m_detail.doc_id = doc_id;
	m_detail.info = info;

	Defs::DetailInfo::iterator it = this->find (doc_id);

	if (it == m_data.end () || it->doc_id != doc_id) {
		if (m_data.empty () || m_data.back ().doc_id > doc_id) {
			m_sizes.push_back (0);
		}

		m_data.push_back (m_detail);
		++m_sizes.back ();
	} else {
		if (it->doc_id == doc_id) {
			if (it->info.relevancy_value < info.relevancy_value) {
				it->req = m_detail.req;
				it->doc_id = m_detail.doc_id;
				it->param = m_detail.param;
				it->info = m_detail.info;
				it->code_factor = m_detail.code_factor;
				it->type_factor = m_detail.type_factor;
				it->inform_factor = m_detail.inform_factor;
				it->rch_factor = m_detail.rch_factor;
			}

			if (m_in_detail) {
				it->rel_detail.insert (it->rel_detail.end (), m_detail.rel_detail.begin (), m_detail.rel_detail.end ());
				it->params.insert (it->params.end (), m_detail.params.begin (), m_detail.params.end ());
				it->reqs.insert (it->reqs.end (), m_detail.reqs.begin (), m_detail.reqs.end ());
			}
		}
	}

	::memset (&m_detail.param, 0, sizeof (Defs::RelevancyParam));

	if (m_in_detail) {
		m_detail.reqs.clear ();
		m_detail.params.clear ();
		m_detail.rel_detail.clear ();
	}
}

// добавить базовые параметры в формуле релевантности
void RelevancyInfo_i::add (const Defs::RelevancyParam& param, unsigned long pos) {
	Defs::RelevancyType rel = get_chain_relevancy (param);

	if (rel > get_chain_relevancy (m_detail.param)) {
		m_detail.param = param;
	}

	if (m_in_detail && rel) {
		Defs::RelevancyInfo item;
		item.relevancy_value = rel;
		item.position = pos;

		m_detail.rel_detail.push_back (item);
		m_detail.params.push_back (param);
		m_detail.reqs.push_back (m_detail.req);
	}
}

// добавить значение релевантности дл€ определенного типа
void RelevancyInfo_i::add (unsigned long doc_id, Defs::TuneDocType type, short value) {
	Defs::DetailInfo::iterator it = this->find (doc_id);

	if (it != m_data.end ()) {
		switch (type) {
			case Defs::dt_CODE:
				it->code_factor = value;
				break;
			case Defs::dt_TYPE:
				it->type_factor = value;
				break;
			case Defs::dt_INFORM:
				it->inform_factor = value;
				break;
			case Defs::dt_RCH:
				it->rch_factor = value;
				break;
		}
	} else {
		GDS_ASSERT (0);
	}
}

// очистить кэш
void RelevancyInfo_i::clear () {
	{
		Defs::DetailInfo tmp;
		m_data.swap (tmp);
		m_data.reserve (64 * 1024);
	} {
		SizeIndex tmp;
		m_sizes.swap (tmp);
		m_sizes.reserve (64);
	}
}

// получить информацию о релевантности
const Defs::DetailInfo& RelevancyInfo_i::get_info () {
	std::for_each (m_data.begin (), m_data.end (), Calculate (m_in_detail));
	return m_data;
}

