////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/PartialAlgorithm_i_QueryData.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::PartialAlgorithm_i::QueryData
//
// Данные синонимичного запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Search_i/PartialAlgorithm_i.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/join.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/split.hpp"
#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/MorphoBase/RequestBuilder.h"

//#UC START# *521207E7010D_CUSTOM_INCLUDES*
#include "shared/ContextSearch/RelevancyCore/DebugInfo.h"
//#UC END# *521207E7010D_CUSTOM_INCLUDES*

namespace ContextSearch {
namespace Search_i {
class PartialAlgorithm_i;
//#UC START# *521207E7010D*
struct Helper {
	static void out (bool flag, const Relevancy::DataVector& data) {
#ifdef _DEBUG
		if (flag) {
			std::cout << std::endl << "size:" << data.size () << std::endl;

			Relevancy::DataVector::const_iterator it = data.begin (), it_end = data.end ();

			for (; it != it_end; ++it) {
				std::copy (it->begin (), it->end (), std::ostream_iterator <long> (std::cout, ","));
				std::cout << std::endl << std::endl;
			}
		}
#endif
	}
};

bool compare_mask_less_ (unsigned long x, unsigned long y) {
	return (x & POS_TEXT) < (y & POS_TEXT);
}
//#UC END# *521207E7010D*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool PartialAlgorithm_i::QueryData::CompareSpans::operator () (const SortAttr& first_param_, const SortAttr& second_param_) const {
	//#UC START# *528CA60F0148_IMPL*
	if (first_param_.sz == second_param_.sz) {
		return first_param_.len < second_param_.len;
	}
	return (first_param_.sz < second_param_.sz);
	//#UC END# *528CA60F0148_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PartialAlgorithm_i::QueryData::QueryData (
	const GCL::StrVector& in
	, const Spans& spans
	, const Search::AlgorithmProperties& properties
)
//#UC START# *5212083C0314_BASE_INIT*
	: m_communicator (properties.comm)
	, m_collector (properties.collector)
//#UC END# *5212083C0314_BASE_INIT*
{
	//#UC START# *5212083C0314_BODY*

	// TODO: a если запрос из одинаковых слов (НК НК)?
	// TODO: при сортировке спанов нужно проверять есть ли они в memcache
	// TODO: не искать идентичные спаны

	std::string context;

	size_t count = 0;

	for (size_t i = 0; i < in.size (); ++i) {
		Spans::const_iterator it = spans.begin (), it_end = spans.end ();

		for (; it != it_end; ++it) {
			if ((**it) == in [i]) {
				break;
			}
		}

		GDS_ASSERT (it != it_end);

		m_spans.push_back (*it);
		m_span_pos.push_back (count);
		count += (*it)->get_size ();
		(*it)->add_to (context);
	}

	m_data.resize (count);
	m_sort_attr.resize (in.size ());
	m_index.resize (in.size ());
	m_ends.resize (in.size ());

	m_context = boost::join (in, " ");

	Relevancy::Data data;
	RequestBuilder::make (context, data);

#ifdef _DEBUG
	std::cout << "\n\n" << m_context << "\nstrongs: ";
	std::copy (data.strongs.begin (), data.strongs.end (), std::ostream_iterator <long> (std::cout, " "));
	std::cout << std::endl;
#endif

	Relevancy::AlgorithmProperties prop;
	prop.count = count;
	prop.rcount = std::count_if (m_context.begin (), m_context.end (), boost::is_any_of (" -~")) + 1;
	prop.info = properties.collector;

	if (properties.max_fragment) {
		prop.max_fragment = properties.max_fragment;
		m_offset = ((long) prop.max_fragment);
	} else {
		prop.max_fragment = Relevancy::BASE_FACTOR * std::min <size_t> (count, Search::WORDS_LIMIT);

		m_offset = ((long) prop.max_fragment) + Relevancy::EXT_LEN;

		if (prop.rcount != count) {
			m_offset += prop.rcount;
		}
	}

	{
		GCL::StrVector parts;
		boost::split (parts, context, boost::is_any_of (" -~"));

		Search::PhraseEx phrase (parts.size ());

		for (size_t i = 0; i < parts.size (); ++i) {
			boost::split (phrase [i], parts [i], boost::is_any_of (","));
		}

		properties.normalizer->init_identical (phrase, prop.identical);
	}

	Relevancy::AlgorithmSelector selector = Relevancy::as_Default;

	if (count == 1) {
		selector = Relevancy::as_Single; // однословный запрос
	} else if (prop.identical.empty () && data.strongs.empty () && data.frames.empty ()) {
		selector = Relevancy::as_Simple; // простой запрос без разметки
	} else if (data.strongs.size () == count - 1) {
		selector = Relevancy::as_Strong; // полностью строгий запрос
	}

	m_algorithm = Relevancy::IAlgorithmFactory::make (data, prop, selector);
	//#UC END# *5212083C0314_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// счетчики использования спанов
void PartialAlgorithm_i::QueryData::check (DBComm::DocId doc_id) {
	//#UC START# *5256B92C0306*
	Spans::const_iterator it, it_end = m_spans.end ();

	// Предварительная проверка спанов запроса на то, что они целиком удовлетворяют нужному id 
	// в противном случае прочитаем лишние позиции (и не один раз)

	for (it = m_spans.begin (); it != it_end; ++it) {
		if ((*it)->check (doc_id) == false) {
			return;
		}
	}

	// Счетчики использования

	for (it = m_spans.begin (); it != it_end; ++it) {
		(*it)->inc ();
	}
	//#UC END# *5256B92C0306*
}

// проверка на наличие пересечения между спанами
bool PartialAlgorithm_i::QueryData::check_intersect () {
	//#UC START# *52A7368602F5*
	Defs::Position val, min, max;

	size_t count = m_spans.size ();
	size_t i, max_pos, max_fragment = m_offset;

	for (i = 0; i < count; ++i) {
		const Relevancy::Positions& cur = m_spans [i]->get_first ();
		m_index [i] = cur.begin ();
		m_ends [i] = cur.end ();
	}

	for (Relevancy::IndexChain::const_iterator it = m_index.begin (); ;) {
		min = (**it) & POS_TEXT;
		max = min;
		max_pos = 0;

		for (i = 1; i < count; ++i) {
			val = (*(m_index [i])) & POS_TEXT;

			if (min > val) {
				min = val;
			} else if (max < val) {
				max = val;
				max_pos = i;
			}
		}

		if (max - min < max_fragment) {
			return true;
		} else {
			if (max > max_fragment) {
				val = max - max_fragment;
			} else {
				val = min;
			}

			for (i = 0; i < count; ++i) {
				if (i != max_pos) {
					m_index [i] = std::upper_bound (m_index [i], m_ends [i], val, compare_mask_less_);

					if (m_index [i] == m_ends [i]) {
						return false;
					}
				}
			}
		}
	}

	return false;
	//#UC END# *52A7368602F5*
}

// получить фрагменты
void PartialAlgorithm_i::QueryData::get_fragments (Relevancy::Fragments& out, DBComm::DocId doc_id) {
	//#UC START# *538C9BBE034F*
	bool has_block = false;

	if (this->load (doc_id, has_block)) {
		Core::Aptr <Relevancy::Fragments> data = m_algorithm->get_fragments (m_data);

		if (data.is_nil () == false) {
			out.insert (out.end (), data->begin (), data->end ());
		}

		const Defs::InvisibleBlocks& blocks = m_communicator->get_invisible_blocks ();

		Defs::InvisibleBlocks::const_iterator it = blocks.find (doc_id);

		if (it != blocks.end ()) {
			data = m_algorithm->get_block_fragments (m_data, it->second);

			if (data.is_nil () == false) {
				out.insert (out.end (), data->begin (), data->end ());
			}
		}
	}
	//#UC END# *538C9BBE034F*
}

// расчет релевантности
void PartialAlgorithm_i::QueryData::get_relevancy (Relevancy::RelevancyDocInfo& out) {
	//#UC START# *52120BDA0353*
	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);
	bool has_block = false;

	if (this->load (out.doc_id, has_block)) {
		//Helper::out (out.doc_id == 12180849, m_data);

		const Defs::InvisibleRel& r_data = m_communicator->get_invisible_rel ();
		Defs::InvisibleRel::const_iterator r_it = r_data.find (out.doc_id);

		const Defs::InvisibleBlocks& b_data = m_communicator->get_invisible_blocks ();
		Defs::InvisibleBlocks::const_iterator b_it = b_data.find (out.doc_id);

		static const Defs::InvisibleData def;
		static const Defs::PositionsRel rel_def;

		Defs::RelevancyInfo info;

		//Core::Aptr <DebugInfo> di = (DebugInfo*) DebugInfo::make (out.doc_id == 12181735, m_algorithm.in ());

		if (m_collector) {
			m_collector->add (m_context);
		}

		m_algorithm->get_relevancy_info (
			info
			, m_data
			, (b_it != b_data.end ())? b_it->second : def
			, (r_it != r_data.end ())? r_it->second : rel_def
			, has_block
		);

		if (info != 0) {
			if (m_collector) {
				m_collector->add (out.doc_id, info);
			}

			if (out.info.relevancy_value < info.relevancy_value) {
				out.info = info;
			} else if (out.info.relevancy_value == info.relevancy_value) {
				if ((info.position & POS_TEXT) < (out.info.position & POS_TEXT)) {
					out.info = info;
				}
			}
		}
	}
	//#UC END# *52120BDA0353*
}

// загрузка позиций
bool PartialAlgorithm_i::QueryData::load (DBComm::DocId doc_id, bool& has_block) {
	//#UC START# *538DE5630003*

	// Предварительная проверка спанов запроса на то, что они целиком удовлетворяют нужному id 
	// в противном случае прочитаем лишние позиции (и не один раз)
	{
		Spans::const_iterator it = m_spans.begin (), it_end = m_spans.end ();

		for (; it != it_end; ++it) {
			if ((*it)->check (doc_id) == false) {
				return false;
			}
		}
	}

	DBCore::ExtrPair extr;

	size_t i, pos, spans_size = m_spans.size ();

	for (i = 0; i < spans_size; ++i) {
		m_sort_attr [i].pos = i;
		m_sort_attr [i].len = m_spans [i]->get_size ();
		m_sort_attr [i].sz = m_spans [i]->get_sort_attr (doc_id);
	}

	std::sort (m_sort_attr.begin (), m_sort_attr.end (), CompareSpans ());

	// Предварительная загрузка

	for (i = 0; i < spans_size; ++i) {
		pos = m_sort_attr [i].pos;

		if (m_spans [pos]->prev_load (doc_id, extr, m_offset, has_block) == false) {
			return false;
		}

		if (m_spans [pos]->is_load ()) {
			m_sort_attr [i].sz = 0;
		}
	}

	if (has_block == false) {
		if (this->check_intersect () == false) {
			return false;
		}
	} 

	std::sort (m_sort_attr.begin (), m_sort_attr.end (), CompareSpans ());

	// Финальная загрузка

	for (i = 0; i < spans_size; ++i) {
		pos = m_sort_attr [i].pos;

		SpanQuery* span = m_spans [pos];

		if (span->load (doc_id, extr, m_offset, has_block) == false) {
			return false;
		}

		const Relevancy::DataVector& data = span->get ();

		if (has_block == false) {
			GDS_ASSERT (extr.max > 0);

			Relevancy::DataVector::const_iterator it = data.begin (), it_end = data.end ();

			Relevancy::DataVector::iterator __it = m_data.begin () + m_span_pos [pos];

			Relevancy::Positions::const_iterator _it, first_it;

			for (;it != it_end; ++it, ++__it) {
				first_it = it->end ();

				for (_it = it->begin (); _it != it->end (); ++_it) {
					long val = *_it & POS_TEXT;

					if (extr.min > val) {
						continue;
					} else if (extr.max < val) {
						break;
					}

					if (first_it == it->end ()) {
						first_it = _it;
					}
				}

				if (first_it == it->end ()) {
					return false;
				}

				__it->assign (first_it, _it);
			}
		} else {
			std::copy (data.begin (), data.end (), m_data.begin () + m_span_pos [pos]);
		}
	}

	return true;
	//#UC END# *538DE5630003*
}

} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

