////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/SpanQuery.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::SpanQuery
//
// SpanQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Search_i/SpanQuery.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "shared/ContextSearch/Common/Constants.h"

namespace ContextSearch {
namespace Search_i {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// сравнение позиций
bool SpanQuery::compare_mask_less (unsigned long x, unsigned long y) {
	//#UC START# *5485A13C01CB*
	return (x & POS_TEXT) < (y & POS_TEXT);
	//#UC END# *5485A13C01CB*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SpanQuery::SpanQuery (const std::string& key, const Search::AlgorithmProperties& prop)
//#UC START# *52050CF1032D_BASE_INIT*
	: m_status (SpanQuery::st_None)
	, m_key (key)
	, m_count (0)
	, m_pos (0)
	, m_id (1)
	, m_deflated (false)
	, m_has_block (false)
//#UC END# *52050CF1032D_BASE_INIT*
{
	//#UC START# *52050CF1032D_BODY*
	m_searcher = new Searcher (prop);

	GCL::StrVector parts;
	boost::split (parts, key, boost::is_any_of (" -~"));

	m_size = parts.size ();
	m_offset = (prop.max_fragment)? prop.max_fragment : 100; // TODO: пока по максимуму

	if (m_size == 1) {
		m_offset = m_size;
	} else if (prop.flags & Search::SP_STRONG_DEFLATE) {
		size_t frame_count = 0, strong_count = 0, space_count = 0;
		{
			for (std::string::const_iterator it = key.begin (); it != key.end (); ++it) {
				if (*it == ' ') {
					++space_count;
				} else if (*it == '~') {
					++frame_count;
				} else if (*it == '-') {
					++strong_count;
				} 
			}
		}

		if (frame_count == 0) {
			if (space_count == 0) {
				if (m_searcher->add (key, 0)) {
					m_size = 1;
				} else {
					m_deflated = true;
					m_index.resize (m_size);
					m_deflate_data.resize (1);
					m_deflate_data [0].reserve (64);
				}

				m_new_key = key.substr (0, key.find ('-'));
				m_offset = m_size;
			} else if (strong_count) {
				GCL::StrVector spans;
				boost::split (spans, key, boost::is_space ());

				if (m_searcher->set (spans)) {
					m_size = spans.size ();

					for (GCL::StrVector::const_iterator it = spans.begin (); it != spans.end (); ++it) {
						if (m_new_key.empty () == false) {
							m_new_key += ' ';
						}
						m_new_key += it->substr (0, it->find ('-'));
					}

					m_offset = parts.size () * Relevancy::BASE_FACTOR;
				}
			}
		} 
	}

	m_data.resize (m_size);

	if (m_new_key.empty () || m_deflated) {
		Search::PhraseEx context (m_size);

		for (size_t i = 0; i < m_size; ++i) {
			boost::split (context [i], parts [i], boost::is_any_of (","));
		}

		m_searcher->set (context);
	}
	//#UC END# *52050CF1032D_BODY*
}

SpanQuery::~SpanQuery () {
	//#UC START# *52050BE7010D_DESTR_BODY*
	//#UC END# *52050BE7010D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить ключ к контексту
void SpanQuery::add_to (std::string& context) {
	//#UC START# *5485994703AC*
	if (context.empty () == false) {
		context += ' ';
	}

	if (m_new_key.empty () == false) {
		context += m_new_key;
	} else {
		context += m_key;
	}
	//#UC END# *5485994703AC*
}

// проверка на валидность
bool SpanQuery::check (DBComm::DocId doc_id) const {
	//#UC START# *524301E10139*
	return (doc_id == m_id && m_status != SpanQuery::st_Bad);
	//#UC END# *524301E10139*
}

// очистить кэш
void SpanQuery::clear () {
	//#UC START# *52373473038C*
	m_extr.min = 0;
	m_extr.max = 0;
	m_count = 0;
	m_has_block = false;
	m_status = SpanQuery::st_None;
	//#UC END# *52373473038C*
}

// сжатие строгой фразы
bool SpanQuery::deflate () {
	//#UC START# *548597F20063*
	size_t i, count, pos = 0, sz = POS_TEXT;

	for (i = 0; i < m_size; ++i) {
		m_index [i] = m_data [i].begin ();

		if (sz > m_data [i].size ()) {
			sz = m_data [i].size ();
			pos = i;
		}
	}

	Defs::Positions& data = m_deflate_data [0];
	data.clear (); // TODO: !

	Defs::Position val;

	Relevancy::DataVector::const_iterator min_it = m_data.begin () + pos;
	Defs::Positions::const_iterator it = min_it->begin (), it_end = min_it->end ();

	for (; it != it_end; ++it) {
		count = 0;

		for (i = 0; i < m_size; ++i) {
			if (i == pos) {
				++count;
				m_index [i] = it;
			} else {
				val = (*it & POS_TEXT) + i - pos;

				Defs::Positions::const_iterator& _it = m_index [i];
				Defs::Positions::const_iterator _it_end = m_data [i].end ();

				_it = std::lower_bound (_it, _it_end, val, SpanQuery::compare_mask_less);

				if (_it == m_data [i].end ()) {
					return (data.empty () == false);
				} else if ((*_it & POS_TEXT) == val) {
					++count;
				} else {
					break;
				}
			}
		}

		if (count == m_size) {
			data.push_back (*(m_index.front ()));
		}
	}

	return (data.empty () == false);
	//#UC END# *548597F20063*
}

// данные
const Relevancy::DataVector& SpanQuery::get () const {
	//#UC START# *524D713A0311*
	return (m_deflated)? m_deflate_data : m_data;
	//#UC END# *524D713A0311*
}

// первые инициализированные
const Relevancy::Positions& SpanQuery::get_first () const {
	//#UC START# *529CAB2F0142*
	return m_data [m_pos];
	//#UC END# *529CAB2F0142*
}

// ключ
const std::string& SpanQuery::get_key () const {
	//#UC START# *526A8B3502E6*
	return m_key;
	//#UC END# *526A8B3502E6*
}

// поиск
DBComm::DocId SpanQuery::get_next (DBComm::DocId border) {
	//#UC START# *5205177D013D*
	if (m_id < border) {
		m_id = m_searcher->get_next (border);
	} 

	return m_id;
	//#UC END# *5205177D013D*
}

// вычислить значение для прогресс-индикатора
size_t SpanQuery::get_prog_value () {
	//#UC START# *528236090246*
	return m_searcher->get_prog_value ();
	//#UC END# *528236090246*
}

// размер
size_t SpanQuery::get_size () const {
	//#UC START# *523AE8C800F8*
	return (m_deflated)? 1 : m_size;
	//#UC END# *523AE8C800F8*
}

// атрибут для сортировки
size_t SpanQuery::get_sort_attr (DBComm::DocId doc_id) {
	//#UC START# *524C3C8003DB*
	if (m_status == SpanQuery::st_Load) {
		return 0;
	} else if (m_status == SpanQuery::st_PrevLoad) {
		return 1;
	}

	return m_searcher->get_min_size (doc_id, m_pos);
	//#UC END# *524C3C8003DB*
}

// инкремент
void SpanQuery::inc () {
	//#UC START# *5256C9AF022E*
	++m_count;
	//#UC END# *5256C9AF022E*
}

// проверка на загруженность
bool SpanQuery::is_load () const {
	//#UC START# *526564BB001D*
	return m_status == SpanQuery::st_Load;
	//#UC END# *526564BB001D*
}

// загрузка позиций
bool SpanQuery::load (DBComm::DocId doc_id, DBComm::ExtrPair& extr, long offset, bool& has_block) {
	//#UC START# *5256D94F021F*
	if (m_status != SpanQuery::st_Load) {
		m_status = SpanQuery::st_Load;

		if (m_count) {
			if (m_searcher->get_data (m_data, doc_id, m_has_block, m_offset, m_extr) == false) {
				m_status = SpanQuery::st_Bad;
				return false;
			} else if (m_deflated && this->deflate () == false) {
				m_status = SpanQuery::st_Bad;
				return false;
			}
		} else {
			if (m_searcher->get_data (m_data, doc_id, has_block, offset, extr) == false) {
				m_status = SpanQuery::st_Bad;
				return false;
			} else if (m_deflated && this->deflate () == false) {
				m_status = SpanQuery::st_Bad;
				return false;
			}

			return true;
		}
	} 

	if (m_has_block) {
		has_block = true;
	} 

	if (m_size == 1) {
		return true;
	}

	if (m_extr.max > 0) {
		long _min = m_extr.min + m_offset;
		long _max = m_extr.max - m_offset;

		if (extr.max == 0) {
			extr.min = _min - offset;
			extr.max = _max + offset;
		} else {
			if (_min > _max) {
				std::swap (_min, _max);
			}

			if (_min > extr.max) {
				return false;
			}

			if (_max < extr.min) {
				return false;
			}

			if (extr.min < _min - offset) {
				extr.min = _min - offset;
			}

			if (extr.max > _max + offset) {
				extr.max = _max + offset;
			}

			GDS_ASSERT (extr.min <= extr.max);
		}
	}

	return true;
	//#UC END# *5256D94F021F*
}

// оператор
bool SpanQuery::operator == (DBComm::DocId doc_id) const {
	//#UC START# *520BA1500380*
	return (m_id == doc_id);
	//#UC END# *520BA1500380*
}

// оператор
bool SpanQuery::operator == (const std::string& key) const {
	//#UC START# *5239C1750391*
	return (m_key == key);
	//#UC END# *5239C1750391*
}

// предварительная загрузка
bool SpanQuery::prev_load (DBComm::DocId doc_id, DBComm::ExtrPair& extr, long offset, bool& has_block) {
	//#UC START# *525FDD690279*
	GDS_ASSERT (m_count);

	--m_count;

	if (m_status == SpanQuery::st_None) {
		if (m_size == 1) {
			m_status = SpanQuery::st_Load;
		} else {
			m_status = SpanQuery::st_PrevLoad;
		}

		GDS_ASSERT (m_extr.max == 0);

		if (m_count) {
			if (m_searcher->prev_load (m_data, doc_id, m_has_block, m_offset, m_extr) == false) {
				m_status = SpanQuery::st_Bad;
				return false;
			}
		} else {
			if (m_searcher->prev_load (m_data, doc_id, has_block, offset, extr) == false) {
				m_status = SpanQuery::st_Bad;
				return false;
			}

			return true;
		}
	} 

	if (m_has_block) {
		has_block = true;
	}

	if (m_extr.max > 0) {
		long _min = m_extr.min + m_offset;
		long _max = m_extr.max - m_offset;

		if (extr.max == 0) {
			extr.min = _min - offset;
			extr.max = _max + offset;
		} else {
			if (_min > _max) {
				std::swap (_min, _max);
			}

			if (_min > extr.max) {
				return false;
			}

			if (_max < extr.min) {
				return false;
			}

			if (extr.min < _min - offset) {
				extr.min = _min - offset;
			}

			if (extr.max > _max + offset) {
				extr.max = _max + offset;
			}

			GDS_ASSERT (extr.min <= extr.max);
		}
	}

	return true;
	//#UC END# *525FDD690279*
}

// поиск документа
bool SpanQuery::search_doc (DBComm::DocId id) {
	//#UC START# *538C7D2F02FD*
	bool ret = m_searcher->search (id);

	if (ret) {
		m_id = id;
	} else {
		m_id = DBComm::NULL_DOC_ID;
	}

	return ret;
	//#UC END# *538C7D2F02FD*
}

} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

