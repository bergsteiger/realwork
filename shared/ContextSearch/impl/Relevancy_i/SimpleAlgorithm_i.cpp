////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::SimpleAlgorithm_i
//
// Реализация расчета релевантности для простого запроса (без рамочных/строгих связей)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "boost/bind.hpp"

namespace ContextSearch {
namespace Relevancy_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SimpleAlgorithm_i::SimpleAlgorithm_i (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
)
//#UC START# *451659E800BB_45165C3A01A5_51FBC0C40059_BASE_INIT*
	: RelevancyCore (req_data, properties)
	, m_search_in_doc (false)
	, m_max_rel ((Relevancy::BASE_FACTOR << 2) / 3)
//#UC END# *451659E800BB_45165C3A01A5_51FBC0C40059_BASE_INIT*
{
	//#UC START# *451659E800BB_45165C3A01A5_51FBC0C40059_BODY*
	m_count = properties.count;
	m_rcount = properties.rcount;
	m_collector = properties.info;
	m_max_fragment = properties.max_fragment;

	m_index.resize (m_count);

	m_def_algo = Relevancy::IAlgorithmFactory::make (req_data, properties, Relevancy::as_Default);
	//#UC END# *451659E800BB_45165C3A01A5_51FBC0C40059_BODY*
}

SimpleAlgorithm_i::~SimpleAlgorithm_i () {
	//#UC START# *51FBC0C40059_DESTR_BODY*
	//#UC END# *51FBC0C40059_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить перестановку
void SimpleAlgorithm_i::add_chain () {
	//#UC START# *520240E201E1*
	Defs::Positions chain (m_count);

	for (size_t i = 0; i < m_count; ++i) {
		chain [i] = *(m_index [i]);
	}

	RelevancyCore::chains ().push_back (chain);
	//#UC END# *520240E201E1*
}

// расчет релевантности
Defs::RelevancyType SimpleAlgorithm_i::get_relevancy (const Defs::PositionsRel& rel_data, size_t point, size_t max) {
	//#UC START# *51FBD02D0181*
	Defs::RelevancyType ret = 0;

	Defs::Position min_val = *(m_index [point]), last_val = *(m_index.back ());

	size_t fragment_len = max - (min_val & POS_TEXT) + 1;

	if (point == 0 && max == (last_val & POS_TEXT)) { // is direct
		if (fragment_len <= m_rcount + 2) {
			ret = m_max_rel;
		} else {
			ret = (m_max_fragment << 2) / (fragment_len * 3);
		}
	} else {
		ret = m_max_fragment / fragment_len;
	}

	if (m_collector) {
		m_param.X = ret;
		m_param.Y = 0;
	}

	unsigned short mark_count = 0;

	if (m_search_in_doc == false) {
		// накапливаем счетчики слов только если первая позиция в заголовке, или в невидимом тексте
		bool is_words_count = ((min_val & POS_FLAGS) != 0);

		if (rel_data.empty ()) {
			if (is_words_count) {
				Relevancy::IndexChain::const_iterator it = m_index.begin (), it_end = m_index.end ();

				for (; it != it_end; ++it) {
					if ((**it) & POS_FLAGS) {
						++mark_count;
					}
				}

				ret += (Relevancy::Z_FACTOR * mark_count) / m_count;
			}
		} else {
			Relevancy::IndexChain::const_iterator it = m_index.begin (), it_end = m_index.end ();

			for (; it != it_end; ++it) {
				if ((**it) & POS_FLAGS) {
					if (is_words_count) {
						++mark_count;
					}

					if (((**it) & POS_FLAGS) == POS_INVISIBLE) {
						Defs::RelPos item;
						item.pos = (**it) - POS_INVISIBLE;

						Defs::PositionsRel::const_iterator _it = std::lower_bound (rel_data.begin (), rel_data.end (), item);

						if (_it != rel_data.end () && _it->pos == item.pos) {
							ret += (Defs::RelevancyType) _it->rel;
						}
					} 
				}
			}

			if (mark_count) {
				ret += (Relevancy::Z_FACTOR * mark_count) / m_count;
			}
		}
	}

	if (m_collector) {
		m_param.Z = (Relevancy::Z_FACTOR * mark_count) / m_count ;
		m_param.I = ret - m_param.X - m_param.Z;
		m_collector->add (m_param, min_val);
	}

	return ret;
	//#UC END# *51FBD02D0181*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Relevancy::IAlgorithm
// сбросить свойство
void SimpleAlgorithm_i::clear_property (unsigned long value) {
	//#UC START# *46827622031C_51FBC0C40059*
	//#UC END# *46827622031C_51FBC0C40059*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов приписанных к блочному невидимому тексту
Relevancy::Fragments* SimpleAlgorithm_i::get_block_fragments (
	const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
) {
	//#UC START# *4D7A15810054_51FBC0C40059*
	return m_def_algo->get_block_fragments (positions, inv_data);
	//#UC END# *4D7A15810054_51FBC0C40059*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов
Relevancy::Fragments* SimpleAlgorithm_i::get_fragments (const Relevancy::DataVector& positions) {
	//#UC START# *4516619C0203_51FBC0C40059*
	m_search_in_doc = true;

	Relevancy::DataVector::const_iterator it = std::min_element (positions.begin (), positions.end ()
		, boost::bind (std::less <size_t> ()
		, boost::bind (&Relevancy::Positions::size, _1)
		, boost::bind (&Relevancy::Positions::size, _2))
	);

	size_t point = std::distance (positions.begin (), it);

	Defs::RelevancyInfo info;
	Defs::PositionsRel rel_data;
	Defs::InvisibleData inv_data;

	this->get_relevancy_info (info, positions, inv_data, rel_data, false);

	return (RelevancyCore::chains ().empty ())? 
		0 : RelevancyCore::get_fragments (positions [point], point);
	//#UC END# *4516619C0203_51FBC0C40059*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности для невидимого блочного
void SimpleAlgorithm_i::get_inv_block_relevancy (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *51FFC0600198_51FBC0C40059*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *51FFC0600198_51FBC0C40059*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности
void SimpleAlgorithm_i::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
	, bool has_block
) {
	//#UC START# *45165A6600FA_51FBC0C40059*
	info.relevancy_value = 0;
	info.position = 0;

	if (has_block && m_search_in_doc == false) {
		m_def_algo->get_inv_block_relevancy (info, positions, inv_data, rel_data);

		if (info.relevancy_value >= m_max_rel + Relevancy::Z_FACTOR) {
			return;
		}
	}

	Defs::Position val, min, max;
	Defs::RelevancyType rel;

	size_t i, pos, max_pos;

	for (i = 0; i < m_count; ++i) {
		m_index [i] = positions [i].begin ();
	}

	Relevancy::IndexChain::const_iterator it, it_begin = m_index.begin (), it_end = m_index.end ();

	for (; ;) {
		min = (**it_begin) & POS_TEXT;
		max = min;
		pos = 0;
		max_pos = 0;

		for (i = 1; i < m_count; ++i) {
			val = (*(m_index [i])) & POS_TEXT;

			if (min > val) {
				min = val;
				pos = i;
			} else if (max < val) {
				max = val;
				max_pos = i;
			}
		}

		if (max - min < m_max_fragment) {
			if (m_search_in_doc) {
				this->add_chain ();
			} else {
				rel = this->get_relevancy (rel_data, pos, max);

				if (info.relevancy_value < rel) {
					info.relevancy_value = rel;

					if (min == *(m_index [pos])) {
						info.position = min;
					} else {
						info.position = *(m_index [max_pos]);

						for (it = it_begin; it != it_end; ++it) {
							if ((**it & POS_FLAGS) != POS_INVISIBLE_BLOCK && (**it & POS_FLAGS) != POS_INVISIBLE) {
								if ((**it & POS_TEXT) < (info.position & POS_TEXT)) {
									info.position = **it;
								}
							}
						}
					}
				}
			}

			++m_index [pos];

			if (m_index [pos] == positions [pos].end ()) {
				return;
			}
		} else {
			if (info.relevancy_value == 0 && max - min < m_max_fragment + Relevancy::EXT_LEN) {
				if (m_search_in_doc) {
					this->add_chain ();
				} else {
					info.relevancy_value = 1;
					info.position = *(m_index [pos]);
				}
			}

			if (info.relevancy_value) {
				if (max > m_max_fragment) {
					val = max - m_max_fragment;
				} else {
					val = min;
				}
			} else {
				if (max > m_max_fragment + Relevancy::EXT_LEN) {
					val = max - m_max_fragment - Relevancy::EXT_LEN;

					if (val < min) {
						val += Relevancy::EXT_LEN;
					}
				} else {
					val = min;
				}
			}

			for (i = 0; i < m_count; ++i) {
				if (i != max_pos) {
					m_index [i] = std::upper_bound (m_index [i], positions [i].end (), val
						, RelevancyUtility::compare_mask_less
					);

					if (m_index [i] == positions [i].end ()) {
						return;
					}
				}
			}
		}
	}
	//#UC END# *45165A6600FA_51FBC0C40059*
}

// implemented method from Relevancy::IAlgorithm
// установить свойство
void SimpleAlgorithm_i::set_property (unsigned long value) {
	//#UC START# *4682736F0119_51FBC0C40059*
	//#UC END# *4682736F0119_51FBC0C40059*
}
} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

