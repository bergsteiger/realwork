////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::InvbAlgorithm_i
//
// Имплементация для невидимых блочных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

//#UC START# *56C3094B0108_CUSTOM_INCLUDES*
#include "boost/bind.hpp"
#include "boost/lambda/lambda.hpp"
//#UC END# *56C3094B0108_CUSTOM_INCLUDES*

namespace ContextSearch {
namespace Relevancy_i {

//#UC START# *56C3094B0108*
Defs::Positions::const_iterator InvbAlgorithm_i::seek (
	size_t pos
	, Defs::Positions::const_iterator beg
	, Defs::Positions::const_iterator end
) {
	if (pos == 0) {
		return beg;
	} 

	Relevancy::Positions::const_iterator it = std::max_element (
		m_chain.begin (), m_chain.begin () + pos, RelevancyUtility::compare_mask_less
	);

	return std::lower_bound (
		beg, end, (*it & POS_TEXT) - m_properties.max_fragment, RelevancyUtility::compare_mask_less
	);
}

InvbAlgorithm_i::CheckRes InvbAlgorithm_i::check (size_t pos, Defs::Position val, Relevancy::Mark type) {
	if (pos == 0) {
		return cr_Valid;
	}

	Defs::Position item = m_chain [pos - 1] & POS_TEXT;

	if (type == Relevancy::mt_Strong) {
		if (item > val) {
			return cr_Skip;
		} else if (item != val - 1) {
			return cr_Invalid; // строгой связи нет 
		}
	} else if (type == Relevancy::mt_Frame) {
		if (item > val) {
			if (item - val > 2) {
				return cr_Skip;
			}
		} else {
			if (val - item > 2) {
				return cr_Invalid; // рамочной связи нет
			}
		}
	}

	Defs::Positions::const_iterator end = m_chain.begin () + pos;

	for (Defs::Positions::const_iterator it = m_chain.begin (); it != end; ++it) {
		item = *it & POS_TEXT;

		if (item == val) {
			return cr_Skip; // идентичные
		} else if (item > val) {
			if (item - val >= m_properties.max_fragment) {
				return cr_Skip; // не попали в очко (до)
			}
		} else {
			if (val - item >= m_properties.max_fragment) {
				return cr_Invalid; // не попали в очко (после)
			}
		}
	}

	return cr_Valid;
}

void InvbAlgorithm_i::build (
	  Defs::Fragments& out
	  , const Relevancy::DataVector& positions
	  , const Relevancy::BlockEntry& entry
	  , size_t pos
) {
	const Defs::Positions& rest = entry.rest;

	if (rest.empty ()) {
		return;
	}

	if (pos < rest.size ()) {
		if (pos == 0) {
			m_chain.resize (rest.size ());
		}

		const Defs::Positions& data = positions [rest [pos]];

		Defs::Positions::const_iterator it = this->seek (pos, data.begin (), data.end ());

		for (; it != data.end (); ++it) {
			if ((*it & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
				continue; // пока не заработает фильтр в ридере
			}

			Defs::Position val = *it & POS_TEXT;

			if (val < entry.pos) { // до блока еще не дошли
				continue;
			} else if (val > entry.pos + entry.len) { // вышли за границу блока
				break;
			} else { // попадание в блок [pos, pos + len]
				CheckRes res = this->check (pos, val, m_markup [rest [pos]]);

				if (res == cr_Skip) {
					continue;
				} else if (res == cr_Invalid) {
					break;
				} else {
					m_chain [pos] = *it;
					this->build (out, positions, entry, pos + 1);
				}
			} 
		}
	} else {
		Defs::RelevancyType rel_val = this->get (Defs::PositionsRel (), false);

		if (rel_val) {
			Defs::Position _pos = RelevancyUtility::get_position (m_chain);

			if ((_pos & POS_FLAGS) == POS_INVISIBLE) {
				return;
			}

			out.push_back (Defs::Fragment (rel_val, _pos & POS_TEXT));

			Relevancy::Positions& data = out.back ().data;

			data.assign (m_chain.begin (), m_chain.end ());
			std::for_each (data.begin (), data.end (), RelevancyUtility::ReceivePosition (true));
			data.erase (std::remove_if (data.begin (), data.end (), boost::lambda::_1 == 0), data.end ());
		}
	}
}

void InvbAlgorithm_i::calc (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Relevancy::BlockEntry& entry
	, const Defs::PositionsRel& rel_data
	, size_t pos
) {
	const Defs::Positions& rest = entry.rest;

	if (rest.empty ()) {
		if (m_properties.info) {
			m_param.X = 0;
			m_param.Y = 0;
			m_param.Z = Relevancy::Z_FACTOR;
			m_param.I = entry.rel;
			m_properties.info->add (m_param, entry.pos);
		}

		Defs::RelevancyType rel_val = entry.rel + Relevancy::Z_FACTOR;

		if (info.relevancy_value < rel_val) {
			info.relevancy_value = rel_val;
			info.position = entry.pos;
		}
	} else if (pos < rest.size ()) {
		if (pos == 0) {
			m_chain.resize (rest.size ());
		}

		const Defs::Positions& data = positions [rest [pos]];

		Defs::Positions::const_iterator it = this->seek (pos, data.begin (), data.end ());

		for (; it != data.end (); ++it) {
			if ((*it & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
				continue; // пока не заработает фильтр в ридере
			}

			Defs::Position val = *it & POS_TEXT;

			if (val < entry.pos) { // до блока еще не дошли
				continue;
			} else if (val > entry.pos + entry.len) { // вышли за границу блока
				break;
			} else { // попадание в блок [pos, pos + len]
				CheckRes res = this->check (pos, val, m_markup [rest [pos]]);

				if (res == cr_Skip) {
					continue;
				} else if (res == cr_Invalid) {
					break;
				} else {
					m_chain [pos] = *it;
					this->calc (info, positions, entry, rel_data, pos + 1);
				}
			} 
		}
	} else {
		Defs::RelevancyType rel_val = this->get (rel_data, true);

		if (rel_val) {
			if (m_properties.info) {
				m_param.I += entry.rel;
				m_properties.info->add (m_param, RelevancyUtility::get_position (m_chain));
			}

			rel_val += entry.rel;

			if (info.relevancy_value < rel_val) {
				info.relevancy_value = rel_val;
				info.position = RelevancyUtility::get_position (m_chain);
			}
		}
	}
}

// получить релевантность для фрагмента
Defs::RelevancyType InvbAlgorithm_i::get (const Defs::PositionsRel& rel_data, bool withZ) {
	//#UC START# *4B3A1C070021*
	GDS_ASSERT (m_properties.rcount >= m_properties.count);

	RelevancyUtility::RelevancyProperties prop;
	prop.min = POS_TEXT;
	prop.max = 0;
	prop.marked = m_properties.rcount - m_chain.size ();

	for (Relevancy::Positions::const_iterator it = m_chain.begin (); it != m_chain.end (); ++it) {
		Defs::Position val = *it & POS_TEXT;
		unsigned long flag = *it & POS_FLAGS;

		if (prop.min > val) {
			prop.min = val;
		} 
		
		if (prop.max < val) {
			prop.max = val;
		}

		if (prop.is_direct) {
			prop.is_direct = (val > (*(it - 1) & POS_TEXT));
		}

		if (flag && withZ) { // не учитываем Z при поиске в доке
			++prop.marked;
		}

		if (flag == POS_INVISIBLE && rel_data.empty () == false) {
			Defs::RelPos item;
			item.pos = val;

			Defs::PositionsRel::const_iterator _it = std::lower_bound (rel_data.begin (), rel_data.end (), item);

			if (_it != rel_data.end () && _it->pos == val) {
				prop.inv_factor += (Defs::RelevancyType) _it->rel;
			}
		}
	}

	return this->calculate (prop);
	//#UC END# *4B3A1C070021*
}
//#UC END# *56C3094B0108*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InvbAlgorithm_i::InvbAlgorithm_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties)
//#UC START# *51F68F31033B_51F6901F022B_56C3094B0108_BASE_INIT*
	: m_properties (properties)
//#UC END# *51F68F31033B_51F6901F022B_56C3094B0108_BASE_INIT*
{
	//#UC START# *51F68F31033B_51F6901F022B_56C3094B0108_BODY*
	m_markup.resize (m_properties.count, Relevancy::mt_None);

	{
		for (Relevancy::Positions::const_iterator it = req_data.strongs.begin (); it != req_data.strongs.end (); ++it) {
			m_markup [*it] = Relevancy::mt_Strong;
		}
	}

	const Relevancy::Frames& frames = req_data.frames;

	for (Relevancy::Frames::const_iterator it = frames.begin (); it != frames.end (); ++it) {
		for (size_t i = 1; i < it->count; ++i) {
			GDS_ASSERT (m_markup [it->pos + i] == Relevancy::mt_None && it->pos + i < m_markup.size ());
			m_markup [it->pos + i] = Relevancy::mt_Frame;
		}
	}

#ifdef _DEBUG
	size_t i;

	std::cout << "\nInvbAlgorithm_i:strongs: ";

	for (i = 0; i < m_markup.size (); ++i) {
		if (m_markup [i] == Relevancy::mt_Strong) {
			std::cout << i << " ";
		}
	}

	std::cout << "\nInvbAlgorithm_i:frames: ";

	for (i = 0; i < m_markup.size (); ++i) {
		if (m_markup [i] == Relevancy::mt_Frame) {
			std::cout << i << " ";
		}
	}
#endif
	//#UC END# *51F68F31033B_51F6901F022B_56C3094B0108_BODY*
}

InvbAlgorithm_i::~InvbAlgorithm_i () {
	//#UC START# *56C3094B0108_DESTR_BODY*
	//#UC END# *56C3094B0108_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// вычисление релевантности
Defs::RelevancyType InvbAlgorithm_i::calculate (const RelevancyUtility::RelevancyProperties& prop) {
	//#UC START# *56C48B3401E7*
	Defs::RelevancyType ret = (prop.is_direct)? 2 : 1;

	if (prop.marked) {
		ret += (Relevancy::Z_FACTOR * prop.marked) / m_properties.rcount;
	}

	if (m_properties.info) {
		m_param.X = (prop.is_direct)? 2 : 1;
		m_param.Y = 0;
		m_param.Z = ret - m_param.X;
		m_param.I = prop.inv_factor;
	}

	return ret + prop.inv_factor;
	//#UC END# *56C48B3401E7*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Relevancy::IBlocksAlgorithm
// список релевантных фрагментов
Defs::Fragments* InvbAlgorithm_i::get_fragments (
	const Relevancy::BlockEntries& data
	, const Relevancy::DataVector& positions
) {
	//#UC START# *51F68FC40053_56C3094B0108*
	Core::Aptr <Relevancy::Fragments> ret = new Relevancy::Fragments ();

	if (data.empty () == false) {
		GDS_ASSERT (m_markup.size () == positions.size ());

		std::for_each (data.begin (), data.end ()
			, boost::bind (&InvbAlgorithm_i::build, this, boost::ref (*ret), boost::cref (positions), _1, 0)
		);
	}

	return ret._retn ();
	//#UC END# *51F68FC40053_56C3094B0108*
}

// implemented method from Relevancy::IBlocksAlgorithm
// расчет релевантности
void InvbAlgorithm_i::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::PositionsRel& rel_data
	, const Relevancy::BlockEntries& data
) {
	//#UC START# *51F68F9703AB_56C3094B0108*
	info.relevancy_value = 0;
	info.position = 0;

	if (data.empty () == false) {
		GDS_ASSERT (m_markup.size () == positions.size ());

		std::for_each (data.begin (), data.end ()
			, boost::bind (&InvbAlgorithm_i::calc, this
			, boost::ref (info), boost::cref (positions), _1, boost::cref (rel_data), 0)
		);
	}
	//#UC END# *51F68F9703AB_56C3094B0108*
}
} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

