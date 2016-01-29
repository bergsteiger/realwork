////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::StrongAlgorithm_i
//
// Реализация расчета релевантности для послностью строгого запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyUtility.h"

namespace ContextSearch {
namespace Relevancy_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StrongAlgorithm_i::StrongAlgorithm_i (
	const Relevancy::Data& req_data
	, const Relevancy::AlgorithmProperties& properties
)
//#UC START# *451659E800BB_45165C3A01A5_51F139A300AB_BASE_INIT*
	: m_search_in_doc (false)
//#UC END# *451659E800BB_45165C3A01A5_51F139A300AB_BASE_INIT*
{
	//#UC START# *451659E800BB_45165C3A01A5_51F139A300AB_BODY*
	m_count = properties.count;
	m_collector = properties.info;
	m_base_rel = (Relevancy::BASE_FACTOR << 2) / 3;

	m_index.resize (m_count);
	//#UC END# *451659E800BB_45165C3A01A5_51F139A300AB_BODY*
}

StrongAlgorithm_i::~StrongAlgorithm_i () {
	//#UC START# *51F139A300AB_DESTR_BODY*
	//#UC END# *51F139A300AB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// релевантность для фрагмента
Defs::RelevancyType StrongAlgorithm_i::get_relevancy (
	const Defs::PositionsRel& data
	, const Defs::InvisibleData& inv_data
) {
	//#UC START# *51F13F990144*
	Defs::RelevancyType ret = m_base_rel;

	// накапливаем счетчики слов только если первая позиция в заголовке, или в невидимом тексте

	unsigned short mark_count = 0;

	if ((*(m_index.front ()) & POS_FLAGS) && m_search_in_doc == false) {
		unsigned long flag;

		Relevancy::IndexChain::const_iterator it = m_index.begin (), it_end = m_index.end ();

		for (; it != it_end; ++it) {
			flag = (**it) & POS_FLAGS;

			if (flag) {
				++mark_count;

				if (flag == POS_INVISIBLE) {
					Defs::Position pos = **it;

					Defs::RelPos item;
					item.pos = pos & POS_TEXT;

					Defs::PositionsRel::const_iterator _it = std::lower_bound (data.begin (), data.end (), item);

					if (_it != data.end () && _it->pos == item.pos) {
						ret += (Defs::RelevancyType) _it->rel;
					}
				} else if (flag == POS_INVISIBLE_BLOCK) {
					Defs::Position pos = **it;

					Defs::InvisibleData::const_iterator _it = inv_data.find (pos & POS_TEXT);

					if (_it != inv_data.end ()) {
						ret += (Defs::RelevancyType) _it->second.relevancy;
					}
				}
			}
		}

		ret += (Relevancy::Z_FACTOR * mark_count) / m_count;
	}

	if (m_collector) {
		Defs::RelevancyParam param;
		param.X = m_base_rel;
		param.Y = 0;
		param.Z = (Relevancy::Z_FACTOR * mark_count) / m_count;
		param.I = ret - param.X - param.Z;
		m_collector->add (param, *(m_index.front ()));
	}

	return ret;
	//#UC END# *51F13F990144*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Relevancy::IAlgorithm
// сбросить свойство
void StrongAlgorithm_i::clear_property (unsigned long value) {
	//#UC START# *46827622031C_51F139A300AB*
	//#UC END# *46827622031C_51F139A300AB*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов приписанных к блочному невидимому тексту
Relevancy::Fragments* StrongAlgorithm_i::get_block_fragments (
	const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
) {
	//#UC START# *4D7A15810054_51F139A300AB*
	return 0;
	//#UC END# *4D7A15810054_51F139A300AB*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов
Relevancy::Fragments* StrongAlgorithm_i::get_fragments (const Relevancy::DataVector& positions) {
	//#UC START# *4516619C0203_51F139A300AB*
	m_search_in_doc = true;

	Defs::RelevancyInfo info;
	Defs::PositionsRel rel_data;
	Defs::InvisibleData inv_data;

	Core::Aptr <Defs::Fragments> ret = new Defs::Fragments ();
	ret->reserve (positions [0].size ());
	m_fragments = ret.inout ();

	this->get_relevancy_info (info, positions, inv_data, rel_data, false);

	return (ret->empty ())? 0 : ret._retn ();
	//#UC END# *4516619C0203_51F139A300AB*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности для невидимого блочного
void StrongAlgorithm_i::get_inv_block_relevancy (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *51FFC0600198_51F139A300AB*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *51FFC0600198_51F139A300AB*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности
void StrongAlgorithm_i::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
	, bool has_block
) {
	//#UC START# *45165A6600FA_51F139A300AB*
	info.relevancy_value = 0;
	info.position = 0;

	size_t sz = POS_TEXT;
	size_t i, count, min_pos = 0;

	for (i = 0; i < m_count; ++i) {
		m_index [i] = positions [i].begin ();

		if (sz > positions [i].size ()) {
			sz = positions [i].size ();
			min_pos = i;
		}
	}

	Relevancy::IndexChain::const_iterator _it_begin = m_index.begin (), _it_end = m_index.end ();

	Defs::Position val;
	Defs::RelevancyType rel;

	Relevancy::DataVector::const_iterator min_it = positions.begin () + min_pos;
	Defs::Positions::const_iterator it = min_it->begin (), it_end = min_it->end ();

	for (; it != it_end; ++it) {
		count = 0;

		for (i = 0; i < m_count; ++i) {
			if (i == min_pos) {
				++count;
				m_index [i] = it;
			} else {
				Defs::Positions::const_iterator& _it = m_index [i];

				val = (*it & POS_TEXT) + i - min_pos;

				_it = std::lower_bound (_it, positions [i].end (), val, RelevancyUtility::compare_mask_less);

				if (_it == positions [i].end ()) {
					return;
				} else if ((*_it & POS_TEXT) == val) {
					++count;
				} else {
					break;
				}
			}
		}

		if (count == m_count) {
			if (m_search_in_doc) {
				Defs::Fragment fragment (m_base_rel);
				fragment.data.reserve (m_count);

				for (Relevancy::IndexChain::const_iterator _it = _it_begin; _it != _it_end; ++_it) {
					const Defs::Position& cur = **_it;

					if ((cur & POS_FLAGS) != POS_INVISIBLE_BLOCK && (cur & POS_FLAGS) != POS_INVISIBLE) {
						fragment.data.push_back (cur & POS_TEXT);

						if (fragment.info.position == 0) {
							fragment.info.position = cur & POS_TEXT;
						}
					}
				}

				if (fragment.data.empty () == false) {
					m_fragments->push_back (fragment);
				}
			} else {
				rel = this->get_relevancy (rel_data, inv_data);

				if (info.relevancy_value < rel) {
					info.relevancy_value = rel;
					info.position = *(m_index.back ());

					for (Relevancy::IndexChain::const_iterator _it = _it_begin; _it != _it_end - 1; ++_it) {
						if ((**_it & POS_FLAGS) != POS_INVISIBLE_BLOCK && (**_it & POS_FLAGS) != POS_INVISIBLE) {
							info.position = **_it;
							break;
						}
					}
				}
			}
		}
	}
	//#UC END# *45165A6600FA_51F139A300AB*
}

// implemented method from Relevancy::IAlgorithm
// установить свойство
void StrongAlgorithm_i::set_property (unsigned long value) {
	//#UC START# *4682736F0119_51F139A300AB*
	//#UC END# *4682736F0119_51F139A300AB*
}
} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

