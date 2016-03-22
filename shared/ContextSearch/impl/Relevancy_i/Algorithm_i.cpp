////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Relevancy_i/Algorithm_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::Algorithm_i
//
// Сервант реализующий алгоритм расчета релевантности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Relevancy_i/Algorithm_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "boost/bind.hpp"

//#UC START# *45165B0202CE_CUSTOM_INCLUDES*
//#UC END# *45165B0202CE_CUSTOM_INCLUDES*

namespace ContextSearch {
namespace Relevancy_i {

//#UC START# *45165B0202CE*
struct PosFinder : public std::unary_function <Defs::Position, bool> {
	PosFinder (Defs::Position point) : m_point (point) {}

	bool operator () (Defs::Position val) const {
		return (val & POS_TEXT) > m_point;
	}


	Defs::Position m_point;
};

void Algorithm_i::calc (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::PositionsRel& rel_data
	, size_t pos
) {
	if (pos < positions.size ()) {
		if (pos == m_point) {
			if (m_markup [pos] != Relevancy::mt_None) {
				GDS_ASSERT (pos);

				Defs::Position prev = m_chain [pos - 1] & POS_TEXT;
				Defs::Position point = m_chain [pos] & POS_TEXT;

				if (m_markup [pos] == Relevancy::mt_Strong) {
					if (prev + 1 != point) {
						return;
					}
				} else if (m_markup [pos] == Relevancy::mt_Frame) {
					if (prev > point) {
						if (prev - point > 2) {
							return;
						}
					} else {
						if (point - prev > 2) {
							return;
						}
					}
				}
			} 

			this->calc (info, positions, rel_data, pos + 1);
			return;
		}

		const Defs::Positions& data = positions [pos];

		Defs::Positions::const_iterator it = data.begin (), it_end = data.end ();

		if (m_markup [pos] == Relevancy::mt_Strong) {
			GDS_ASSERT (pos);

			Defs::Position prev = m_chain [pos - 1] & POS_TEXT;

			it = std::lower_bound (it, it_end, prev + 1, RelevancyUtility::compare_mask_less);

			if (it != it_end && (*it & POS_TEXT) == prev + 1) {
				if ((*it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
					m_chain [pos] = *it;
					this->calc (info, positions, rel_data, pos + 1);
				}
			}

			return;
		} 

		Defs::Position min, max;

		if (pos == 0) {
			min = m_chain [m_point] & POS_TEXT;
			max = min;
		} else if (pos == 1) {
			Defs::Position point = m_chain [m_point] & POS_TEXT;
			Defs::Position val = m_chain.front () & POS_TEXT;

			if (point > val) {
				min = val;
				max = point;
			} else {
				min = point;
				max = val;
			}
		} else {
			min = m_chain.front () & POS_TEXT;
			max = min;

			for (Defs::Positions::const_iterator _it = m_chain.begin () + 1; _it != m_chain.begin () + pos; ++_it) {
				if (min > (*_it & POS_TEXT)) {
					min = (*_it & POS_TEXT);
				} else if (max < (*_it & POS_TEXT)) {
					max = (*_it & POS_TEXT);
				}
			}
		} 

		//it = std::upper_bound (it, it_end, max - m_ext_fragment, RelevancyUtility::compare_mask_less);
		m_index [pos] = std::find_if (m_index [pos], it_end, PosFinder (max - m_ext_fragment));

		bool no_strong = (pos && pos + 1 < positions.size () && m_markup [pos + 1] == Relevancy::mt_None);

		size_t count = 0;

		for (it = m_index [pos]; it != it_end; ++it) {
			if ((*it & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
				continue; // пока не заработает фильтр в ридере
			}

			Defs::Position val = *it & POS_TEXT;

			if (val < max) {
				if (max - val >= m_ext_fragment) {
					continue;
				}
			} else {
				if (val - min >= m_ext_fragment) {
					break;
				}
			}

			if (val == (m_chain [m_point] & POS_TEXT)) {
				continue; // идентичная
			}

			if (pos) {
				if (m_markup [pos] == Relevancy::mt_Frame) {
					Defs::Position item = m_chain [pos - 1] & POS_TEXT;

					if (item > val) {
						if (item - val > 2) {
							continue;
						}
					} else {
						if (val - item > 2) {
							break;
						}
					}
				}

				if (std::find (m_chain.begin (), m_chain.begin () + pos, *it) != m_chain.begin () + pos) {
					continue; // идентичная
				}

				if (count && no_strong) {
					if (val < min) {
						m_chain [pos] = *it;
						continue;
					} else {
						Defs::Position prev = m_chain [pos] & POS_TEXT;
						if (prev >= min) {
							break;
						}
					}
				}
			} 
		
			m_chain [pos] = *it;
			this->calc (info, positions, rel_data, pos + 1);
			++count;
		}

	} else {
		//std::copy (m_chain.begin (), m_chain.end (), std::ostream_iterator <long> (std::cout, ","));
		//std::cout << std::endl;

		static const Defs::InvisibleData empty;

		Defs::RelevancyInfo cur_info;
		RelevancyCore::get_relevancy_info (cur_info, m_chain, empty, rel_data);

		if (info.relevancy_value < cur_info.relevancy_value) {
			info.relevancy_value = cur_info.relevancy_value;
			info.position = RelevancyUtility::get_position (m_chain);
		} 
	}
}
//#UC END# *45165B0202CE*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// получить позиции для заданного блока
bool Algorithm_i::get_block_positions (const Relevancy::DataVector& in, const Defs::InvisibleData& inv_data, Relevancy::DataVector& out, Defs::Position mask, size_t point) {
	//#UC START# *4D6BB24202E2*
	Defs::Position pos = mask & POS_TEXT;

	size_t length = Algorithm_i::get_block_len (pos, inv_data);

	if (length) {
		out.resize (in.size ());

		Relevancy::Positions::const_iterator it, it_end;

		for (size_t i = 0; i < in.size (); ++i) {
			if (i != point) {
				it_end = in [i].end ();
				it = std::upper_bound (in [i].begin (), it_end, pos, RelevancyUtility::compare_mask_less);

				if (it == it_end || (*it & POS_TEXT) - pos >= length) {
					return false;
				}

				out [i].assign (it, std::lower_bound (it, it_end, pos + length, RelevancyUtility::compare_mask_less));
			}
		}

		return true;
	} else {
		GDS_ASSERT (0);
	}

	return false;
	//#UC END# *4D6BB24202E2*
}

// добавить позицию в цепочку
void Algorithm_i::put (Relevancy::Positions& data, size_t pos, Defs::Position value) {
	//#UC START# *4D6BC00E0399*
	*(data.begin () + pos) = value;
	//#UC END# *4D6BC00E0399*
}

// определение наименее встречающегося в блоке слова (позиция в запросе)
size_t Algorithm_i::get_point (const Relevancy::DataVector& in, size_t block_point) {
	//#UC START# *4D6BC0F500D6*
	size_t ret = 0, min_size = POS_TEXT;

	for (size_t i = 0; i < in.size (); ++i) {
		if (i != block_point) {
			if (in [i].size () < min_size) {
				min_size = in [i].size ();
				ret = i;
			}
		}
	}

	return ret;
	//#UC END# *4D6BC0F500D6*
}

// длина блока
size_t Algorithm_i::get_block_len (Defs::Position pos, const Defs::InvisibleData& data) {
	//#UC START# *56A62D1C009B*
	Defs::InvisibleData::const_iterator it = data.find (pos);
	return (it == data.end ())? 0 : it->second.length;
	//#UC END# *56A62D1C009B*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Algorithm_i::Algorithm_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties)
//#UC START# *451659E800BB_45165C3A01A5_45165B0202CE_BASE_INIT*
	: RelevancyCore (req_data, properties)
	, m_point (0)
	, m_max_frame_len (0)
//#UC END# *451659E800BB_45165C3A01A5_45165B0202CE_BASE_INIT*
{
	//#UC START# *451659E800BB_45165C3A01A5_45165B0202CE_BODY*

	//
	{
	m_markup.resize (properties.count, Relevancy::mt_None);

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
	}
	//

	m_ext_fragment = (unsigned long) (properties.max_fragment + Relevancy::EXT_LEN);

	if (req_data.frames.empty () == false) {
		Relevancy::Frames::const_iterator it = req_data.frames.begin (), it_end = req_data.frames.end ();

		m_frames.reserve (16);

		for (; it != it_end; ++it) {
			for (size_t i = 1; i < it->count; ++i) {
				m_frames.push_back (it->pos + i);
			}

			if (m_max_frame_len < it->count) {
				m_max_frame_len = it->count;
			}
		}

		m_max_frame_len += 2;
	}

	Relevancy::Positions::const_iterator it;

	for (it = req_data.strongs.begin (); it != req_data.strongs.end (); ++it) {
		m_strongs.push_back (*it - 1);
		m_strongs.push_back (*it);
	}

	for (it = m_frames.begin (); it != m_frames.end (); ++it) {
		m_strongs.push_back (*it - 1);
		m_strongs.push_back (*it);
	}

	std::sort (m_strongs.begin (), m_strongs.end ());
	m_strongs.erase (std::unique (m_strongs.begin (), m_strongs.end ()), m_strongs.end ());

#ifdef _DEBUG
	if (m_strongs.empty () == false) {
		std::cout << "frames: ";
		RelevancyCore::DebugInfo::print_positions (m_frames);
		std::cout << "all strongs: ";
		RelevancyCore::DebugInfo::print_positions (m_strongs);
		std::cout << std::endl;
	}
#endif
	//#UC END# *451659E800BB_45165C3A01A5_45165B0202CE_BODY*
}

Algorithm_i::~Algorithm_i () {
	//#UC START# *45165B0202CE_DESTR_BODY*
	//#UC END# *45165B0202CE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// сделать цепочку не валидной
void Algorithm_i::chain_destruction (Relevancy::Positions& out) {
	//#UC START# *4DA42E080191*
	if (m_point) {
		out.front () = POS_TEXT;
	} else {
		out.back () = POS_TEXT;
	}
	//#UC END# *4DA42E080191*
}

// проверка на существование невидимой блочной позиции
bool Algorithm_i::has_block_position (const Relevancy::DataVector& positions) {
	//#UC START# *4D9DD8C800BE*
	bool ret = false;

	Relevancy::Positions::const_iterator _it;

	for (Relevancy::DataVector::const_iterator it = positions.begin (); it != positions.end (); ++it) {
		_it = std::find_if (it->begin (), it->end (), RelevancyUtility::HasInvisibleBlock ());
		if (_it != it->end ()) {
			ret = true;
			break;
		}
	}

	return ret;
	//#UC END# *4D9DD8C800BE*
}

// инициализация контейнера цепочек
void Algorithm_i::init (const Relevancy::Positions& vect, RelevancyCore::Chains& chains, size_t count) {
	//#UC START# *4517DA57007D*
	size_t sz = vect.size ();

	GDS_ASSERT (sz);

	chains.resize (sz);

	Chains::iterator it = chains.begin ();

	Relevancy::Positions::const_iterator v_it = vect.begin (), it_end = vect.end ();

	for (; v_it != it_end; ++v_it, ++it) {
		it->resize (count);
		std::fill (it->begin (), it->end (), 0);
		*(it->begin () + m_point) = *v_it;
	}

	m_ext_chains_generator.init (count);

	this->set_direction (count);
	//#UC END# *4517DA57007D*
}

// вычисление оптимальных позиций и добавление их к цепочкам
bool Algorithm_i::intersection (
	const Relevancy::Positions& vect
	, const Relevancy::IntersectProp& prop
	, Defs::Position pos
	, RelevancyCore::Chains& chains
) {
	//#UC START# *4517E8C000BB*
	bool in_center, ret = false;

	unsigned long cur_pos, min, max, b_min;

	Chains::iterator it = chains.begin (), it_end = chains.end ();

	Relevancy::Positions::iterator _it, _it_end;
	Relevancy::Positions::const_iterator safe_it, v_it, v_end = vect.end ();

	for (; it != it_end; ++it) {
		if (it->front () == POS_TEXT || it->back () == POS_TEXT) {
			continue;
		}

		v_it = vect.begin ();

		min = POS_TEXT;
		max = 0;

		b_min = min;

		_it_end = it->end ();

		for (_it = it->begin (); _it != _it_end; ++_it) {
			if (*_it) {
				cur_pos = *_it & POS_TEXT;

				if ((*_it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
					if (min > cur_pos) {
						min = cur_pos;
					}

					if (max < cur_pos) {
						max = cur_pos;
					}
				} else if (prop.is_block_chain == false) {
					break; // игнорим позиции из невидимого блочного (они обрабатываются отдельно)
				} else if (b_min > cur_pos) {
					b_min = cur_pos;
				}
			}
		}

		if (prop.is_block_chain == false && _it != _it_end) {
			this->chain_destruction (*it);
			continue;
		}

		// Цепочки, длина которых превышает длину максимального фрагмента, не рассматриваем
		if (max > min && max - min + 1 > m_ext_fragment) {
			this->chain_destruction (*it);
			continue;
		}

		safe_it = v_end;

		if (prop.is_block_chain == false && (*v_it & POS_TEXT) + m_ext_fragment < max) {
			v_it = std::lower_bound (v_it, v_end, max - m_ext_fragment, RelevancyUtility::compare_mask_less);
		} 

		in_center = false;

		for (; v_it != v_end; ++v_it) {
			cur_pos = *v_it & POS_TEXT;

			if ((*v_it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
				if (max > 0) {
					if (cur_pos > min) {
						if (cur_pos - min >= m_ext_fragment) {
							break;
						}
					} else if (max - cur_pos >= m_ext_fragment) {
						continue;
					}
				}
			} else if (prop.is_block_chain == false) {
				// Позиции из невидимого блочного текста игнорируем, ибо они обрабатываются отдельно
				continue;
			} else if (b_min < cur_pos) {
				// Блочные позици, в блочной цепочке, наиболее приоритетны
				safe_it = v_it;
				break;
			}

			if (prop.is_identical) {
				// Eсли нашли уже найденную ранее позицию, то пропускаем ее
				if (std::find (it->begin (), it->end (), *v_it) != it->end ()) {
					continue;
				}
			}

			if (prop.is_block_chain == false) {
			} else if (max == 0) {
				if (safe_it == v_end) {
					safe_it = v_it;
				} else {
					m_ext_chains_generator.generate (*it, *v_it, pos, false);
				}
				continue;
			}

			if (prop.is_strong) {
				if (safe_it == v_end) {
					safe_it = v_it;
				} else {
					m_ext_chains_generator.generate (*it, *v_it, pos, false);
				}
			} else if (cur_pos < min) { // если запрос без устойчивости и рамочности, то все перестановки не нужны
				safe_it = v_it;
			} else if (in_center == false || cur_pos > max) {
				if (safe_it == v_end) {
					safe_it = v_it;
				} else {
					m_ext_chains_generator.generate (*it, *v_it, pos, false);
				}

				if (prop.is_block_chain == false && cur_pos > max) {
					break;
				}

				in_center = true;
			}
		}

		if (safe_it != v_end) {
			(*it) [pos] = *safe_it;
			ret = true;
		} else {
			this->chain_destruction (*it);
		}
	}

	return ret;
	//#UC END# *4517E8C000BB*
}

// генерация перестановок
bool Algorithm_i::intersection (
	const Relevancy::Positions& vect
	, const Relevancy::IntersectProp& prop
	, Defs::Position pos
	, Defs::Position min_pos
	, RelevancyCore::Chains& chains
) {
	//#UC START# *559FB1F003E3*
	GDS_ASSERT (prop.is_block_chain == false);

	bool ret = false;

	unsigned long cur_pos, min, max;

	Chains::iterator it = chains.begin (), it_end = chains.end ();

	Relevancy::Positions::iterator _it, _it_end;
	Relevancy::Positions::const_iterator v_it, v_end = vect.end ();

	for (; it != it_end; ++it) {
		if (it->front () == POS_TEXT || it->back () == POS_TEXT) {
			continue;
		}

		min = POS_TEXT;
		max = 0;

		_it_end = it->end ();

		for (_it = it->begin (); _it != _it_end; ++_it) {
			if (*_it) {
				if ((*_it & POS_FLAGS) != POS_INVISIBLE_BLOCK) {
					cur_pos = *_it & POS_TEXT;

					if (min > cur_pos) {
						min = cur_pos;
					}
					if (max < cur_pos) {
						max = cur_pos;
					}
				} else {
					break; // блочные перестановки обрабатываются отдельно
				} 
			}
		}

		// Блочные цепочки игнорируем
		if (_it != _it_end) {
			this->chain_destruction (*it);
			continue;
		}

		// Цепочки, длина которых превышает длину максимального фрагмента, тоже игнорируем
		if (max > min && max - min + 1 > m_ext_fragment) {
			this->chain_destruction (*it);
			continue;
		}

		GDS_ASSERT (max > 0);

		v_it = vect.begin ();

		if ((*v_it & POS_TEXT) + m_ext_fragment < max) {
			v_it = std::lower_bound (v_it, v_end, max - m_ext_fragment, RelevancyUtility::compare_mask_less);
		} 

		Defs::Position base_val = (*it) [min_pos] & POS_TEXT;

		bool is_break = false;

		for (; v_it != v_end; ++v_it) {
			if ((*v_it & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
				continue; // позиции из невидимого блочного текста обрабатываются отдельно
			} 

			cur_pos = *v_it & POS_TEXT;
				
			if (cur_pos > min) {
				if (cur_pos - min >= m_ext_fragment) {
					break;
				}
			} else if (max - cur_pos >= m_ext_fragment) {
				continue;
			}

			if (prop.is_identical) {
				if (std::find (it->begin (), it->end (), *v_it) != it->end ()) {
					continue; // нашли найденную ранее позицию
				}
			}

			Defs::Position delta = (cur_pos < base_val) ? base_val - cur_pos : cur_pos - base_val;

			if ((*it) [pos]) {
				if (prop.is_strong) {
					m_ext_chains_generator.generate (*it, *v_it, pos, false); // для строгости нужны все перестановки
				} else if (cur_pos < max) {
					Defs::Position s_val = (*it) [pos] & POS_TEXT;
					Defs::Position s_delta = (s_val < base_val) ? base_val - s_val : s_val - base_val;

					if (delta <= s_delta) {
						if (min > s_val && delta < s_delta) {
							(*it) [pos] = *v_it;
						} else if (cur_pos > base_val) {
							if (pos > min_pos) {
								(*it) [pos] = *v_it;
							}
						} else {
							if (pos < min_pos) {
								(*it) [pos] = *v_it;
							} 
						}
					}
				} else {
					if (is_break == false || (*v_it & POS_FLAGS)) {
						m_ext_chains_generator.generate (*it, *v_it, pos, false);
					}
					break;
				}
			} else if (delta < m_ext_fragment) {
				(*it) [pos] = *v_it;
				ret = true;
				is_break = (cur_pos > max && prop.is_identical == false);
			}
		}

		if ((*it) [pos] == 0) {
			this->chain_destruction (*it);
		}
	}

	return ret;
	//#UC END# *559FB1F003E3*
}

// генератор цепочек привязынных к невидимому блочному тексту
bool Algorithm_i::make_block_chains (const Relevancy::DataVector& positions, const Defs::InvisibleData& inv_data) {
	//#UC START# *4D6BBE7C01EA*
	bool ret = false;

	const Relevancy::Positions& identical = RelevancyCore::properties ().identical;

	Relevancy::Positions::const_iterator _it, _it_end;

	Relevancy::DataVector::const_iterator it = positions.begin (), it_end = positions.end ();

	for (; it != it_end; ++it) {
		_it_end = it->end ();
		_it = std::find_if (it->begin (), _it_end, RelevancyUtility::HasInvisibleBlock ());

		for (; _it != _it_end; ++_it) {
			if ((*_it & POS_FLAGS) == POS_INVISIBLE_BLOCK) { // нашли реперную точку
				Relevancy::DataVector data;

				size_t b_point = it - positions.begin ();

				// Собираем позиции находящиеся внутри заданного блока
				if (Algorithm_i::get_block_positions (positions, inv_data, data, *_it, b_point) == false) {
					continue;
				} 

				size_t i = 0, cur = 0, count = positions.size ();

				m_point = get_point (data, b_point);

				RelevancyCore::Chains chains;

				// Инициализация
				this->init (data [m_point], chains, count);

				// Привязываем цепочки к блоку
				std::for_each (chains.begin (), chains.end (), boost::bind (&put, _1, b_point, *_it));

#ifdef _DEBUG
				if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
					RelevancyCore::DebugInfo::print (data, "data vector:");
					RelevancyCore::DebugInfo::print (chains, "init block chains:");
				}
#endif

				bool res = true;

				const Relevancy::Positions& strongs = RelevancyCore::strongs ();

				Relevancy::Positions::const_iterator i_begin = identical.begin (), i_end = identical.end ();
				Relevancy::Positions::const_iterator s_begin = strongs.begin (), s_end = strongs.end ();
				Relevancy::Positions::const_iterator f_begin = m_frames.begin (), f_end = m_frames.end ();
				Relevancy::Positions::const_iterator pos_it = m_positions.begin ();

				Relevancy::IntersectProp prop;
				prop.is_block_chain = true;

				for (; i < count && res; ++i) {
					cur = *(pos_it + i);

					if (cur != b_point && cur != m_point) {
						prop.is_identical = (i_begin != i_end)? std::binary_search (i_begin, i_end, cur) : false;
						prop.is_first = cur < m_point;

						if (std::binary_search (s_begin, s_end, prop.is_first? cur + 1 : cur)) {
							res = this->strong_intersection (data [cur], prop, cur, chains, false);
						} else if (std::binary_search (f_begin, f_end, prop.is_first? cur + 1 : cur)) {
							res = this->strong_intersection (data [cur], prop, cur, chains, true);
						} else {
							prop.is_strong = std::binary_search (m_strongs.begin (), m_strongs.end (), cur);
							res = this->intersection (data [cur], prop, cur, chains);
						}

						if (res) {
							m_ext_chains_generator.merge (chains);
						}

						if (chains.size () > RelevancyCore::MAX_CHAINS_SIZE) {
							RelevancyCore::inv_deflate (chains);

							if (chains.size () > RelevancyCore::MAX_CHAINS_SIZE) {
								RelevancyCore::deflate (chains, data [m_point], m_point, i_begin != i_end);
							}
						}
					}
				}

#ifdef _DEBUG
				if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
					RelevancyCore::DebugInfo::print (chains, "block chains:");
				}
#endif

				// Мердж контейнера цепочек для блока с основным контейнером цепочек
				if (res) {
					RelevancyCore::Chains& main_chains = RelevancyCore::chains ();

					if (ret) {
						main_chains.insert (main_chains.end (), chains.begin (), chains.end ());
					} else {
						main_chains = chains;
						ret = true;
					}
				}
			}
		}
	}

#ifdef _DEBUG
	if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
		RelevancyCore::DebugInfo::print (RelevancyCore::chains (), "final block chains:");
	}
#endif

	return ret;
	//#UC END# *4D6BBE7C01EA*
}

// генерация контейнера цепочек
bool Algorithm_i::make_chains (const Relevancy::DataVector& positions) {
	//#UC START# *4517E82A036B*
	bool ret = true;

	Relevancy::DataVector::const_iterator min_it = std::min_element (positions.begin (), positions.end ()
		, boost::bind (std::less <size_t> ()
		, boost::bind (&Relevancy::Positions::size, _1)
		, boost::bind (&Relevancy::Positions::size, _2))
	);

	m_point = std::distance (positions.begin (), min_it);

	RelevancyCore::Chains& chains = RelevancyCore::chains ();

	size_t i = 0, cur = 0, count = positions.size ();

	this->init (*min_it, chains, count); // инициализация

	const Relevancy::Positions& strongs = RelevancyCore::strongs ();
	const Relevancy::Positions& identical = RelevancyCore::properties ().identical;

#ifdef _DEBUG
	if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
		std::cout << "identical: ";
		RelevancyCore::DebugInfo::print_positions (identical);
		std::cout << "direct: ";
		RelevancyCore::DebugInfo::print_positions (m_positions);
		std::cout << std::endl;
		RelevancyCore::DebugInfo::print (chains, "init chains:");
	}
#endif

	Relevancy::Positions::const_iterator i_begin = identical.begin (), i_end = identical.end ();
	Relevancy::Positions::const_iterator s_begin = strongs.begin (), s_end = strongs.end ();
	Relevancy::Positions::const_iterator f_begin = m_frames.begin (), f_end = m_frames.end ();
	Relevancy::Positions::const_iterator pos_it = m_positions.begin ();

	Relevancy::DataVector::const_iterator it = positions.begin ();

	Relevancy::IntersectProp prop;

	for (i = 1; i < count && ret; ++i) {
		cur = *(pos_it + i);

#ifdef _DEBUG
		if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
			RelevancyCore::DebugInfo::print_positions (*(it + cur));
			std::cout << "\ndata size: " << (it + cur)->size () << std::endl << std::endl;
		}
#endif
		prop.is_identical = (i_begin != i_end)? std::binary_search (i_begin, i_end, cur) : false;
		prop.is_first = cur < m_point;

		if (std::binary_search (s_begin, s_end, prop.is_first? cur + 1 : cur)) {
			ret = this->strong_intersection (*(it + cur), prop, cur, chains, false);
		} else if (std::binary_search (f_begin, f_end, prop.is_first? cur + 1 : cur)) {
			ret = this->strong_intersection (*(it + cur), prop, cur, chains, true);
		} else {
			prop.is_strong = std::binary_search (m_strongs.begin (), m_strongs.end (), cur);
			ret = this->intersection (*(it + cur), prop, cur, m_point, chains);
		}

		if (ret) {
			m_ext_chains_generator.merge (chains);
		}

#ifdef _DEBUG
		if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
			RelevancyCore::DebugInfo::print (chains, "chains:");
		}
#endif

		if (chains.size () > RelevancyCore::MAX_CHAINS_SIZE && min_it->size () < chains.size ()) {
			RelevancyCore::deflate (chains, positions [m_point], m_point, i_begin != i_end);

#ifdef _DEBUG
			if (RelevancyCore::get_flags () & Relevancy::SHOW_INFO) {
				RelevancyCore::DebugInfo::print (chains, "deflate chains:");
			}
#endif
		}
	}

	return ret;
	//#UC END# *4517E82A036B*
}

// инициализация вектора, задающего порядок обхода слов
void Algorithm_i::set_direction (size_t count) {
	//#UC START# *4D90793102DC*
	m_positions.resize (count);

	GDS_ASSERT (m_point < count);

	size_t i = 0;

	for (; i <= m_point; ++i) {
		m_positions [m_point - i] = i;
	}

	for (; i < count; ++i) {
		m_positions [i] = i;
	}
	//#UC END# *4D90793102DC*
}

// вычисление устойчивых позиций и добавление их к цепочкам
bool Algorithm_i::strong_intersection (
	const Relevancy::Positions& vect
	, const Relevancy::IntersectProp& prop
	, Defs::Position pos
	, RelevancyCore::Chains& chains
	, bool is_frame
) {
	//#UC START# *4D9B0CB00018*
	bool ret = false, res;

	if (is_frame) {
		GDS_ASSERT (m_max_frame_len);
	}

	unsigned long value, prev_value, cur, _val, delta;

	Chains::iterator it = chains.begin (), it_end = chains.end ();

	Relevancy::Positions::const_iterator _it, v_it, v_begin = vect.begin (), v_end = vect.end ();

	for (; it != it_end; ++it) {
		if (it->front () == POS_TEXT || it->back () == POS_TEXT) {
			continue;
		}

		if (prop.is_first) {
			prev_value = (*it) [pos + 1];
		} else if (pos) {
			prev_value = (*it) [pos - 1];
		} else {
			GDS_ASSERT (pos);
		}

		GDS_ASSERT (prev_value);

		if (prop.is_block_chain == false && (prev_value & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
			prev_value = POS_TEXT; // игнорируем невидимые блочные позиции, ибо обрабатываем их отдельно
		}

		res = (prev_value != POS_TEXT);

		if (res) {
			value = prev_value & POS_TEXT;

			if (prop.is_first == false) {
				++value;
			} else if (value) {
				--value;
			}

			if (is_frame) {
				res = false;

				value = prev_value & POS_TEXT;

				_val = (value > m_max_frame_len)? value - m_max_frame_len : 0;

				_it = std::lower_bound (v_begin, v_end, _val, RelevancyUtility::compare_mask_less);

				for (; _it != v_end; ++_it) {
					cur = *_it & POS_TEXT;

					if (cur != value) {
						delta = (value > cur)? value - cur : cur - value;

						if (delta > m_max_frame_len) {
							break;
						} else if (res) {
							m_ext_chains_generator.generate (*it, *_it, pos, prop.is_identical);
						} else {
							v_it = _it;
							res = true;
						}
					}
				}
			} else {
				v_it = std::lower_bound (v_begin, v_end, value, RelevancyUtility::compare_mask_less);
				res = (v_it != v_end && (*v_it & POS_TEXT) == value);
			}

			if (res && prop.is_block_chain == false) {
				res = ((*v_it & POS_FLAGS) != POS_INVISIBLE_BLOCK);
			}
		}

		if (res && prop.is_identical) {
			res = (std::find (it->begin (), it->end (), *v_it) == it->end ()); // проверка на идентичность
		}

		if (res) {
			(*it) [pos] = *v_it; // найдена подходящая позиция
			ret = true;
		} else {
			this->chain_destruction (*it);
		}
	}

	return ret;
	//#UC END# *4D9B0CB00018*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Relevancy::IAlgorithm
// сбросить свойство
void Algorithm_i::clear_property (unsigned long value) {
	//#UC START# *46827622031C_45165B0202CE*
	RelevancyCore::set_flags (RelevancyCore::get_flags () & ~value);
	//#UC END# *46827622031C_45165B0202CE*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов приписанных к блочному невидимому тексту
Relevancy::Fragments* Algorithm_i::get_block_fragments (
	const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
) {
	//#UC START# *4D7A15810054_45165B0202CE*
	return (this->make_block_chains (positions, inv_data))? 
		RelevancyCore::get_fragments_invb (inv_data) : 0;
	//#UC END# *4D7A15810054_45165B0202CE*
}

// implemented method from Relevancy::IAlgorithm
// получить список релевантных фрагментов
Relevancy::Fragments* Algorithm_i::get_fragments (const Relevancy::DataVector& positions) {
	//#UC START# *4516619C0203_45165B0202CE*
	return (this->make_chains (positions))? 
		RelevancyCore::get_fragments (positions [m_point], m_point) : 0;
	//#UC END# *4516619C0203_45165B0202CE*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности для невидимого блочного
void Algorithm_i::get_inv_block_relevancy (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
) {
	//#UC START# *51FFC0600198_45165B0202CE*
	info.relevancy_value = 0;
	info.position = 0;

	/*
	if (this->make_block_chains (positions, inv_data)) {
		RelevancyCore::get_relevancy_info (info, inv_data, rel_data, true);
	}
	*/
	//#UC END# *51FFC0600198_45165B0202CE*
}

// implemented method from Relevancy::IAlgorithm
// расчет релевантности
void Algorithm_i::get_relevancy_info (
	Defs::RelevancyInfo& info
	, const Relevancy::DataVector& positions
	, const Defs::InvisibleData& inv_data
	, const Defs::PositionsRel& rel_data
	, bool has_block
) {
	//#UC START# *45165A6600FA_45165B0202CE*
	info.relevancy_value = 0;
	info.position = 0;

	//Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);

	/**
	size_t data_size = positions.size ();
	size_t sz = std::numeric_limits <size_t>::max ();

	m_chain.resize (data_size);
	m_index.resize (data_size);

	for (size_t i = 0; i < data_size; ++i) {
		m_index [i] = positions [i].begin ();

		if (sz > positions [i].size ()) {
			sz = positions [i].size ();
			m_point = i;
		}
	}

	Relevancy::Positions::const_iterator it = positions [m_point].begin (), it_end = positions [m_point].end ();

	for (; it != it_end; ++it) {
		m_chain [m_point] = *it;
		this->calc (info, positions, rel_data, 0);
	}

	return;
	/**/

	if (RelevancyCore::properties ().identical.empty () && m_frames.empty ()) {
		RelevancyCore::get_relevancy_partial_strong (info, positions, rel_data);
	} else if (this->make_chains (positions)) {
		RelevancyCore::get_relevancy_info (info, m_fake, rel_data, false);
	}

	if (has_block) {
		Defs::RelevancyInfo _info;
		this->get_inv_block_relevancy (_info, positions, inv_data, rel_data);

		if (_info.relevancy_value > info.relevancy_value) {
			info = _info;
		}
	}
	//#UC END# *45165A6600FA_45165B0202CE*
}

// implemented method from Relevancy::IAlgorithm
// установить свойство
void Algorithm_i::set_property (unsigned long value) {
	//#UC START# *4682736F0119_45165B0202CE*
	RelevancyCore::set_flags (RelevancyCore::get_flags () | value);
	//#UC END# *4682736F0119_45165B0202CE*
}
} // namespace Relevancy_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

