////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/RelevancyCore/RelevancyCore.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::RelevancyCore::RelevancyCore
//
// Базовая реализация алгоритма релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyCore.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include <functional>
#include "boost/bind.hpp"
#include "boost/lambda/lambda.hpp"

//#UC START# *4B34CB2302C8_CUSTOM_INCLUDES*
//#UC END# *4B34CB2302C8_CUSTOM_INCLUDES*

namespace ContextSearch {

//#UC START# *4B34CB2302C8*
void out (const std::vector <Defs::Positions::const_iterator>& data) {
	std::vector <Relevancy::Positions::const_iterator>::const_iterator it = data.begin (), it_end = data.end ();
	for (; it != it_end; ++it) {
		std::cout << **it << " ";
	}
	std::cout << std::endl;
}

bool RelevancyCore::make_strong (const Relevancy::DataVector& data, StrongSpan& span) {
	span.first.clear ();
	span.second.clear ();

	size_t sz = POS_TEXT, _sz = POS_TEXT, total = data.size ();
	size_t i, count, point = 0, min = 0, len = span.tmp.size () + 1;

	size_t from = span.pos;
	size_t to = from + len - 1;

	if (m_index.size () != len) {
		m_index.resize (len);
	}

	for (i = 0; i < total; ++i) {
		if (i < from || i > to) {
			if (_sz > data [i].size ()) {
				_sz = data [i].size ();
				min = i;
			}
		} else {
			m_index [i - from] = data [i].begin ();

			if (sz > data [i].size ()) {
				sz = data [i].size ();
				point = i;
			}
		}
	}

#ifdef _DEBUG
	if (this->get_flags () & Relevancy::SHOW_INFO) {
		DebugInfo::print_positions (data [min]);
		std::cout << "\n\n";
	}
#endif

	Defs::Position val, max;

	Relevancy::DataVector::const_iterator min_it = data.begin () + point;

	Defs::Positions::const_iterator it = min_it->begin (), it_end = min_it->end ();
	Defs::Positions::const_iterator _it = data [min].begin (), _it_end = data [min].end ();

	for (; it != it_end; ++it) {
		count = 0;

		for (i = from; i <= to; ++i) {
			Defs::Positions::const_iterator& cur_it = m_index [i - from];

			if (i == point) {
				++count;
				cur_it = it;
			} else {
				val = (*it & POS_TEXT) + i - point;

				cur_it = std::lower_bound (cur_it, data [i].end (), val, RelevancyUtility::compare_mask_less);

				if (cur_it == data [i].end ()) {
					it = it_end - 1;
					break;
				} else if ((*cur_it & POS_TEXT) == val) {
					++count;
				} else {
					break;
				}
			}
		}

		if (count == len) {
			max = (*(m_index [len - 1])) & POS_TEXT;

			if (max > m_ext_fragment) {
				_it = std::lower_bound (_it, _it_end, max - m_ext_fragment, RelevancyUtility::compare_mask_less);
			} 

			if (_it == _it_end) {
				break;
			} else if ((*_it & POS_TEXT) < max) {
				if (max - (*_it & POS_TEXT) > m_ext_fragment) {
					continue;
				}
			} else {
				if ((*_it & POS_TEXT) - max > m_ext_fragment) {
					continue;
				}
			}

			span.first.push_back (*(m_index [0]));

			for (i = 0; i < len - 1; ++i) {
				span.tmp [i] = *(m_index [i + 1]);
			}

			span.second.push_back (span.tmp);
		}
	}

	return (span.second.empty () == false);
}

void RelevancyCore::get_relevancy_partial_strong (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& data
	, const Defs::PositionsRel& rel_data
) {
	m_is_check = false;

	std::vector <StrongSpan>::iterator it = m_spans.begin (), it_end = m_spans.end ();

	for (; it != it_end; ++it) {
		if (RelevancyCore::make_strong (data, *it) == false) {
			return;
		}
#ifdef _DEBUG
		if (this->get_flags () & Relevancy::SHOW_INFO) {
			DebugInfo::print (it->second, "chains:");
		}
#endif
	}

	Defs::RelevancyInfo cur_info;
	Defs::Position val, min, max;

	size_t len = m_spans.size (), ext_len = m_no_strong.size ();
	size_t i, pos, index_count = len + ext_len;

	if (m_index.size () != index_count) {
		m_index.resize (index_count);
	}

	if (m_chain.size () != m_count) {
		m_chain.resize (m_count);
	}

	for (i = 0; i < len; ++i) {
		m_index [i] = m_spans [i].first.begin ();
	}

	for (size_t j = 0; j < ext_len; ++j, ++i) {
		m_index [i] = data [m_no_strong [j]].begin ();
	}

	for (; ;) {
		min = (*(m_index [0])) & POS_TEXT;
		max = min;
		pos = 0;

		for (i = 1; i < index_count; ++i) {
			val = (*(m_index [i])) & POS_TEXT;

			if (min > val) {
				min = val;
				pos = i;
			} else if (max < val) {
				max = val;
			}
		}

		if (max - min < m_ext_fragment) {
			for (i = 0; i < len; ++i) {
				const StrongSpan& cur = m_spans [i];
				const Defs::Positions& part = cur.second [std::distance (cur.first.begin (), m_index [i])];

				m_chain [cur.pos] = *(m_index [i]);
				std::copy (part.begin (), part.end (), m_chain.begin () + cur.pos + 1);
			}

			for (size_t j = 0; j < ext_len; ++j, ++i) {
				m_chain [m_no_strong [j]] = *(m_index [i]);
			}

#ifdef _DEBUG
			if (this->get_flags () & Relevancy::SHOW_INFO) {
				std::cout << "CHAIN: ";
				DebugInfo::print_positions (m_chain);
			}
#endif

			this->get_relevancy_info (cur_info, m_chain, m_inv_fake, rel_data);

			if (info.relevancy_value < cur_info.relevancy_value) {
				info.relevancy_value = cur_info.relevancy_value;
				info.position = RelevancyUtility::get_position (m_chain);
			}

			++m_index [pos];

			if (pos < len) {
				if (m_index [pos] == m_spans [pos].first.end ()) {
					break;
				}
			} else {
				if (m_index [pos] == data [m_no_strong [pos - len]].end ()) {
					break;
				}
			}
		} else {
			if (info.relevancy_value) {
				if (max > m_properties.max_fragment) {
					val = max - m_properties.max_fragment;
				} else {
					val = min;
				}
			} else {
				if (max > m_ext_fragment) {
					val = std::max <Defs::Position> (max - m_ext_fragment, min);
				} else {
					val = min;
				}
			}

			Defs::Positions::const_iterator _it_end;

			for (i = 0; i < index_count; ++i) {
				if (((*(m_index [i])) & POS_TEXT) != max) {
					if (i < len) {
						_it_end = m_spans [i].first.end ();
					} else {
						_it_end = data [m_no_strong [i - len]].end ();
					}

					m_index [i] = std::upper_bound (m_index [i], _it_end, val
						, RelevancyUtility::compare_mask_less
					);

					if (m_index [i] == _it_end) {
						return;
					}
				}
			}
		}
	}
}
//#UC END# *4B34CB2302C8*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Размеры резервирования памяти
const size_t RelevancyCore::MAX_CHAINS_SIZE = 10000; // максимально допустимое количество цепочек
const size_t RelevancyCore::RESERVE_SIZE = 1000; // размер резервирования

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// вычисление значения релевантности позиции невидимого текста
Defs::RelevancyType RelevancyCore::get_inv_factor (Defs::Position pos, const Defs::InvisibleData& inv_data, const Defs::PositionsRel& rel_data) {
	//#UC START# *4CDACEAF0240*
	switch (pos & POS_FLAGS) {
		case POS_INVISIBLE_BLOCK:
			{
				Defs::InvisibleData::const_iterator it = inv_data.find (pos & POS_TEXT);

				if (it != inv_data.end ()) {
					return (Defs::RelevancyType) it->second.relevancy;
				}
			}
			break;
		case POS_INVISIBLE:
			{
				Defs::RelPos item;
				item.pos = pos & POS_TEXT;

				Defs::PositionsRel::const_iterator it = std::lower_bound (rel_data.begin (), rel_data.end (), item);

				if (it != rel_data.end () && it->pos == item.pos) {
					return (Defs::RelevancyType) it->rel;
				}
			}
			break;
	}

	return 0;
	//#UC END# *4CDACEAF0240*
}

// сокращение количества блочных цепочек
void RelevancyCore::inv_deflate (Chains& data) {
	//#UC START# *5012998E0109*
	size_t inv_count = 0, count = 0;

	Chains::const_iterator it, it_end = data.end ();

	for (it = data.begin (); it != it_end; ++it) {
		count = std::count_if (it->begin (), it->end (), RelevancyUtility::HasInvisibleBlock ());

		if (inv_count < count) {
			inv_count = count;
		}
	}

	GDS_ASSERT (inv_count);

	Chains tmp;

	for (it = data.begin (); it != it_end; ++it) {
		count = std::count_if (it->begin (), it->end (), RelevancyUtility::HasInvisibleBlock ());

		if (inv_count == count) {
			tmp.push_back (*it);
		}
	}

	data.swap (tmp);
	//#UC END# *5012998E0109*
}

// слияние цепочек
void RelevancyCore::chains_merge (Relevancy::Positions& x, const Relevancy::Positions& y, size_t pos, bool has_identical) {
	//#UC START# *559FAAEB03E2*
	Defs::Position cur_x, cur_y, delta_x, delta_y, val = (x [pos] & POS_TEXT);

	size_t sz = x.size ();

	for (size_t i = 0; i < sz; ++i) {
		if (i != pos) {
			if (x [i]) {
				cur_x = x [i] & POS_TEXT;
				cur_y = y [i] & POS_TEXT;

				delta_x = (cur_x < val) ? val - cur_x : cur_x - val;
				delta_y = (cur_y < val) ? val - cur_y : cur_y - val;

				if (delta_y < delta_x) {
					if (has_identical == false || std::find (x.begin (), x.end (), y [i]) == x.end ()) {
						x [i] = y [i];
					} 
				}
			} else if (has_identical == false || std::find (x.begin (), x.end (), y [i]) == x.end ()) {
				x [i] = y [i];
			} 
		}
	}
	//#UC END# *559FAAEB03E2*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
RelevancyCore::RelevancyCore (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties)
//#UC START# *4B34D31202AF_BASE_INIT*
	: m_properties (properties)
	, m_flags (0)
	, m_type (rt_SearchDocs)
	, m_is_check (true)
//#UC END# *4B34D31202AF_BASE_INIT*
{
	//#UC START# *4B34D31202AF_BODY*
	m_req_data = req_data;
	m_count = m_properties.count;
	m_rcount = m_properties.rcount;

	m_ext_fragment = m_properties.max_fragment + Relevancy::EXT_LEN;

	StrongSpan item;
	Defs::Positions::const_iterator it = req_data.strongs.begin (), it_end = req_data.strongs.end ();

	for (; it != it_end;) {
		item.pos = *it - 1;

		size_t count = 0;
		Defs::Position prev = item.pos;

		for (; it != it_end; ++it) {
			if (prev == *it - 1) {
				prev = *it;
				++count;
			} else {
				break;
			}
		}

		item.tmp.resize (count);
		item.first.reserve (64);
		item.second.reserve (64);
		m_spans.push_back (item);
	}

	Defs::Positions _strongs;

	for (it = req_data.strongs.begin (); it != it_end; ++it) {
		_strongs.push_back (*it - 1);
		_strongs.push_back (*it);
	}

	if (_strongs.empty () == false) {
		for (size_t i = 0; i < m_count; ++i) {
			if (std::binary_search (_strongs.begin (), _strongs.end (), i) == false) {
				m_no_strong.push_back (i);
			}
		}

#ifdef _DEBUG
		std::cout << "no strongs: ";
		DebugInfo::print_positions (m_no_strong);
#endif
	}
	//#UC END# *4B34D31202AF_BODY*
}

RelevancyCore::~RelevancyCore () {
	//#UC START# *4B34CB2302C8_DESTR_BODY*
	//#UC END# *4B34CB2302C8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// сформировать и добавить фрагмент
void RelevancyCore::add_fragment (
	Defs::RelevancyType rel
	, const Relevancy::Positions& chain
	, Relevancy::Fragments& out
) {
	//#UC START# *4D7F52B50057*
	Defs::Position pos = RelevancyUtility::get_position (chain);

	if ((pos & POS_FLAGS) == POS_INVISIBLE_BLOCK || (pos & POS_FLAGS) == POS_INVISIBLE) {
		return;
	}

	out.push_back (Defs::Fragment (rel, pos & POS_TEXT));

	Relevancy::Positions& data = out.back ().data;

	data.assign (chain.begin (), chain.end ());
	std::for_each (data.begin (), data.end (), RelevancyUtility::ReceivePosition (true));
	data.erase (std::remove_if (data.begin (), data.end (), boost::lambda::_1 == 0), data.end ());
	//#UC END# *4D7F52B50057*
}

// вычисление значения релевантности
Defs::RelevancyType RelevancyCore::calculate (const RelevancyUtility::RelevancyProperties& prop) {
	//#UC START# *4B3A3AB30393*
	Defs::RelevancyType ret;

	if (prop.is_direct) {
		size_t fragment_len = prop.max - prop.min + 1;

		if (fragment_len <= m_rcount + 2) {
			ret = (Relevancy::BASE_FACTOR << 2) / 3;
		} else {
			ret = (m_properties.max_fragment << 2) / (fragment_len * 3);
		}
	} else {
		ret = m_properties.max_fragment / (prop.max - prop.min + 1);
	}

	if (m_properties.info) {
		m_param.X = ret;
	}

	if (m_type == rt_SearchDocs && prop.marked) {
		ret += (Relevancy::Z_FACTOR * prop.marked) / m_count;
	} 

	if (m_properties.info) {
		m_param.Y = 0;
		m_param.Z = ret - m_param.X;
		m_param.I = prop.inv_factor;
	}

	return ret + prop.inv_factor;
	//#UC END# *4B3A3AB30393*
}

// вычисление значения релевантности для невидимой блочной перестановки
Defs::RelevancyType RelevancyCore::calculate_invb (const RelevancyUtility::RelevancyProperties& prop) {
	//#UC START# *530C7C9A0045*
	Defs::RelevancyType ret = (prop.is_direct)? 2 : 1;

	if (m_type == rt_SearchDocs && prop.marked) {
		ret += (Relevancy::Z_FACTOR * prop.marked) / m_count;
	} 

	if (m_properties.info) {
		m_param.X = (prop.is_direct)? 2 : 1;
		m_param.Y = 0;
		m_param.Z = ret - m_param.X;
		m_param.I = prop.inv_factor;
	}

	return ret + prop.inv_factor;
	//#UC END# *530C7C9A0045*
}

// контейнер цепочек (перестановок)
RelevancyCore::Chains& RelevancyCore::chains () {
	//#UC START# *4B34D4DA01F8*
	return m_chains;
	//#UC END# *4B34D4DA01F8*
}

// проверка на устойчивость и рамочность
bool RelevancyCore::check (const Relevancy::Positions& vect) {
	//#UC START# *4B3A43FD0329*
	if (m_req_data.strongs.empty () == false) {
		Relevancy::Positions::const_iterator it, it_end = m_req_data.strongs.end (), v_it = vect.begin ();

		for (it = m_req_data.strongs.begin (); it != it_end; ++it) {
			if (((*(v_it + *it) - 1) & POS_TEXT) != (*(v_it + *it - 1) & POS_TEXT)) {
				return false;
			}
		}
	}

	if (m_req_data.frames.empty () == false) {
		Relevancy::Frames::const_iterator it = m_req_data.frames.begin (), it_end = m_req_data.frames.end ();

		size_t first, last;

		Defs::Position item, max_value = std::numeric_limits <Defs::Position>::max ();

		for (; it != it_end; ++it) {
			Relevancy::Positions::const_iterator _it = vect.begin () + it->pos, _it_end = _it + it->count;

			first = max_value;
			last = 0;

			for (; _it != _it_end; ++_it) {
				if ((*_it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
					item = *_it & POS_TEXT;

					if (first > item) {
						first = item;
					}
					if (last < item) {
						last = item;
					}
				}
			}

			if (first != max_value && last - first > it->count + 2) {
				return false;
			}
		}
	}

	return true;
	//#UC END# *4B3A43FD0329*
}

// сокращение количества цепочек
void RelevancyCore::deflate (Chains& data, const Relevancy::Positions& min_data, size_t pos, bool has_identical) {
	//#UC START# *4E7C925C024F*
	Chains tmp (min_data.size ());

	size_t len = data [0].size ();

	for (size_t i = 0; i < min_data.size (); ++i) {
		tmp [i].resize (len, 0);
		tmp [i].at (pos) = min_data [i];
	}

	Chains::iterator it = tmp.begin (), it_end = tmp.end ();

	for (; it != it_end; ++it) {
		Chains::const_iterator _it = data.begin (), _it_end = data.end ();

		Defs::Position val = it->at (pos);

		bool was_merge = false;

		for (; _it != _it_end; ++_it) {
			if (_it->front () != POS_TEXT && _it->back () != POS_TEXT) {
				if (val == _it->at (pos)) {
					chains_merge (*it, *_it, pos, has_identical);
					was_merge = true;
				}
			}
		}

		if (was_merge == false) {
			it->front () = POS_TEXT;
		}
	}

	tmp.erase (std::remove_if (tmp.begin (), tmp.end (), RelevancyUtility::HasBadChain ()), tmp.end ());
	data.swap (tmp);
	//#UC END# *4E7C925C024F*
}

// получить фрагменты
Relevancy::Fragments* RelevancyCore::get_fragments (const Relevancy::Positions& vect, size_t point) {
	//#UC START# *4B3AF2E8000F*
	GDS_ASSERT (vect.empty () == false);

	Core::Aptr <Relevancy::Fragments> ret = new Relevancy::Fragments ();

	m_type = rt_SearchInDoc;

	{
		CachedFragments tmp (vect.size ());
		m_cached.swap (tmp);
	}

	Defs::RelevancyInfo info;
	Defs::PositionsRel rel_data;
	Defs::InvisibleData inv_data;

	Defs::Position min, max;

	size_t i = 0, location = 0;

	Relevancy::Positions::const_iterator v_it, v_begin = vect.begin (), v_end = vect.end ();
	{
		for (Chains::const_iterator it = m_chains.begin (); it != m_chains.end (); ++it, ++i) {
			this->get_relevancy_info (info, *it, inv_data, rel_data);

			if (info.relevancy_value) {
				v_it = std::lower_bound (v_begin, v_end, (*it) [point], RelevancyUtility::compare_mask_less);

				if (v_it != v_end) {
					location = v_it - v_begin;

					CachedFragment& cur = m_cached [location];

					if (info.relevancy_value > cur.rel || info.relevancy_value == cur.rel) {
						min = *(std::min_element (it->begin (), it->end (), RelevancyUtility::compare_mask_less));
						min &= POS_TEXT;
						max = *(std::max_element (it->begin (), it->end (), RelevancyUtility::compare_mask_less));
						max &= POS_TEXT;

						GDS_ASSERT (min <= max);

						if (info.relevancy_value > cur.rel) {
							cur.rel = info.relevancy_value;
							cur.pos = i;
							cur.len = max - min;
						} else if (cur.rel && max - min < cur.len) {
							cur.pos = i;
							cur.len = max - min;
						}
					}
				}
			}
		}
	}

	for (CachedFragments::const_iterator it = m_cached.begin (); it != m_cached.end (); ++it) {
		if (it->rel) {
			this->add_fragment (it->rel, m_chains [it->pos], *(ret.inout ()));
		}
	}

#ifdef _DEBUG
	if (m_flags & Relevancy::SHOW_INFO) {
		DebugInfo::print (*(ret.in ()));
	}
#endif

	return ret._retn ();
	//#UC END# *4B3AF2E8000F*
}

// получить фрагменты приписанные к блокам
Relevancy::Fragments* RelevancyCore::get_fragments_invb (const Defs::InvisibleData& data) {
	//#UC START# *4D7910080088*
	Core::Aptr <Relevancy::Fragments> ret = new Relevancy::Fragments ();

	m_type = rt_SearchInDoc;

	Defs::PositionsRel rel_data;
	Defs::RelevancyInfo info;

	for (Chains::const_iterator it = m_chains.begin (); it != m_chains.end (); ++it) {
		this->get_relevancy_info_invb (info, *it, data, rel_data);

		if (info.relevancy_value) {
			this->add_fragment (info.relevancy_value, *it, *(ret.inout ()));
		}
	}

#ifdef _DEBUG
	if (m_flags & Relevancy::SHOW_INFO) {
		DebugInfo::print (*(ret.in ()));
	}
#endif

	return ret._retn ();
	//#UC END# *4D7910080088*
}

// получить инфо о релевантности документа
void RelevancyCore::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
	, bool has_block
) {
	//#UC START# *4B34FF2C0139*
	if (m_chains.empty ()) {
		return;
	}

	m_is_check = true;

	Defs::RelevancyInfo cur_info;

	Chains::const_iterator it = m_chains.begin (), it_end = m_chains.end (), safe_it = it;

	for (; it != it_end; ++it) {
		if (has_block) {
			this->get_relevancy_info_invb (cur_info, *it, inv_data, rel_data);
		} else {
			this->get_relevancy_info (cur_info, *it, inv_data, rel_data);
		}

		if (info.relevancy_value < cur_info.relevancy_value) {
			info.relevancy_value = cur_info.relevancy_value;
			safe_it = it;
		} 
	}

	info.position = RelevancyUtility::get_position (*safe_it);
	//#UC END# *4B34FF2C0139*
}

// получить релевантность для фрагмента
void RelevancyCore::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::Positions& vect
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *4B3A1C070021*
	info.relevancy_value = 0;

	if (m_is_check) {
		if (vect.front () == POS_TEXT || vect.back () == POS_TEXT || this->check (vect) == false) {
			return;
		}
	}

	Relevancy::Positions::const_iterator it, it_begin = vect.begin (), it_end = vect.end ();

	Defs::Position val;

	RelevancyUtility::RelevancyProperties prop;
	prop.min = *it_begin;
	prop.max = prop.min & POS_TEXT;

	for (it = it_begin + 1; it != it_end; ++it) {
		val = *it & POS_TEXT;

		if ((prop.min & POS_TEXT) > val) {
			prop.min = *it;
		} else if (prop.max < val) {
			prop.max = val;
		}

		if (prop.max - (prop.min & POS_TEXT) >= m_ext_fragment) {
			return;
		}

		if (prop.is_direct) {
			prop.is_direct = (val > (*(it - 1) & POS_TEXT));
		}
	}

	if (prop.max - (prop.min & POS_TEXT) < m_properties.max_fragment) {
		//накапливаем счетчики слов, только если первая позиция в заголовке, или в невидимом тексте
		bool is_words_count = ((prop.min & POS_FLAGS) != 0);

		prop.min &= POS_TEXT;

		if (m_type == rt_SearchDocs) {
			for (it = it_begin; it != it_end; ++it) {
				if (*it & POS_FLAGS) {
					if ((*it & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
						return;
					}

					prop.inv_factor += get_inv_factor (*it, inv_data, rel_data);

					if (is_words_count) {
						++prop.marked;
					}
				}
			}
		}

		info.relevancy_value = this->calculate (prop);
	} else if (prop.max - (prop.min & POS_TEXT) < m_ext_fragment) {
		info.relevancy_value = 1;

		if (m_properties.info) {
			m_param.X = 1;
			m_param.Y = 0;
			m_param.Z = 0;
			m_param.I = 0;
		}
	}

	if (m_properties.info && info.relevancy_value) {
		m_properties.info->add (m_param, RelevancyUtility::get_position (vect));
	}
	//#UC END# *4B3A1C070021*
}

// получить релевантность для блочного фрагмента
void RelevancyCore::get_relevancy_info_invb (
	Defs::RelevancyInfo& info
	, const Relevancy::Positions& vect
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *543293BD0373*
	info.relevancy_value = 0;

	if (m_is_check) {
		if (vect.front () == POS_TEXT || vect.back () == POS_TEXT || this->check (vect) == false) {
			return;
		}
	}

	Relevancy::Positions::const_iterator it_begin = vect.begin (), it_end = vect.end ();

	Defs::Position min_pos = *(std::min_element (it_begin, it_end, RelevancyUtility::compare_mask_less));

	if ((min_pos & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
		Defs::InvisibleData::const_iterator _it = inv_data.find (min_pos & POS_TEXT);

		if (_it == inv_data.end ()) {
			return;
		}

		RelevancyUtility::RelevancyProperties prop;
		prop.min = POS_TEXT;
		prop.max = 0;

		Defs::Position val;

		for (Relevancy::Positions::const_iterator it = it_begin; it != it_end; ++it) {
			if ((*it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
				val = *it & POS_TEXT;

				if (prop.min > val) {
					prop.min = val;
				}

				if (prop.max < val) {
					prop.max = val;
				}

				if (prop.max - prop.min >= m_properties.max_fragment) {
					return;
				}

				if (prop.max - (min_pos & POS_TEXT) >= _it->second.length) {
					return;
				}

				if (prop.is_direct && it != it_begin) {
					prop.is_direct = (val > (*(it - 1) & POS_TEXT));
				}
			}

			if (m_type == rt_SearchDocs) {
				if (*it & POS_FLAGS) {
					prop.inv_factor += get_inv_factor (*it, inv_data, rel_data);
					++prop.marked;
				}
			} 
		}

		info.relevancy_value = this->calculate_invb (prop);

		if (m_properties.info && info.relevancy_value) {
			m_properties.info->add (m_param, RelevancyUtility::get_position (vect));
		}
	} 
	//#UC END# *543293BD0373*
}

// параметры алгоритма релевантности
const Relevancy::AlgorithmProperties& RelevancyCore::properties () const {
	//#UC START# *4B34CD000132*
	return m_properties;
	//#UC END# *4B34CD000132*
}

// позиции устойчивых словосочетаний
const Relevancy::Positions& RelevancyCore::strongs () const {
	//#UC START# *4B72CB290000*
	return m_req_data.strongs;
	//#UC END# *4B72CB290000*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

unsigned long RelevancyCore::get_flags () const {
	//#UC START# *4B3A4A990063_GET_ACCESSOR*
	return m_flags;
	//#UC END# *4B3A4A990063_GET_ACCESSOR*
}

void RelevancyCore::set_flags (unsigned long flags) {
	//#UC START# *4B3A4A990063_SET_ACCESSOR*
	m_flags = flags;
	//#UC END# *4B3A4A990063_SET_ACCESSOR*
}


} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

