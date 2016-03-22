////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Searcher.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Searcher
//
// Searcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/Searcher.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "shared/ContextSearch/Common/Constants.h"
#include "boost/lambda/lambda.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "shared/ContextSearch/MorphoBase/KeysFactory.h"

//#UC START# *4F313B660191_CUSTOM_INCLUDES*
//#UC END# *4F313B660191_CUSTOM_INCLUDES*

namespace ContextSearch {

//#UC START# *4F313B660191*
static const size_t INFINITE_SIZE = std::numeric_limits <size_t>::max ();

struct StreamProgress {
	size_t operator () (size_t first_param, const SearchStream* second_param) const {
		if (m_flag) {
			return first_param + second_param->stream_length ();
		} else {
			return first_param + second_param->progress_tell ();
		}
	}

	StreamProgress (bool val) : m_flag (val) { }

private:
	bool m_flag;
};
//#UC END# *4F313B660191*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Константы
const size_t Searcher::GREAT_RESERVE_SIZE = 1024 * 8; // размер для резервирования

void Searcher::StreamDestroy::operator () (CacheNode& param_) const {
	//#UC START# *4551D425003E_IMPL*
	if (param_.stream) {
		delete param_.stream;
		param_.stream = 0;
	}
	//#UC END# *4551D425003E_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// сравнение масок
bool Searcher::compare_mask_equal (unsigned long x, unsigned long y) {
	//#UC START# *512CBE540186*
	return (x & POS_TEXT) == (y & POS_TEXT);
	//#UC END# *512CBE540186*
}

// получить пару (min и max) следующих после start_id и удовлетворяющий запросу документов, для
// открытых по каждому ключу стримов
void Searcher::get_next_pair (Search::DocIdPair& pair, StreamPointers& sp, DBComm::DocId start_id) {
	//#UC START# *5406F9EF00C2*
	DBComm::DocId doc_id, result = DBComm::INFINITE_DOC_ID;

	bool is_remove_if = false;

	StreamPointers::iterator it = sp.begin (), it_end = sp.end ();

	for (; it != it_end; ++it) { // each stream pointer
		doc_id = (*it)->get_next (start_id);

		if (doc_id == DBComm::NULL_DOC_ID) {
			is_remove_if = true;
			*it = 0;
		} else if (doc_id < result) {
			result = doc_id;
		}
	}

	if (is_remove_if) {
		sp.erase (std::remove_if (sp.begin (), it_end, boost::lambda::_1 == (SearchStream*) 0), sp.end ());
	}

	if (result == DBComm::INFINITE_DOC_ID) {
		result =  DBComm::NULL_DOC_ID;
	}

	if (result > pair.max_id) {
		pair.max_id = result;
	}

	if (result < pair.min_id) {
		pair.min_id = result;
	}
	//#UC END# *5406F9EF00C2*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Searcher::Searcher (const Search::AlgorithmProperties& properties)
//#UC START# *548EE9220107_BASE_INIT*
	: m_properties (properties)
	, m_offset (properties.max_fragment + Relevancy::EXT_LEN)
	, m_pos (0)
//#UC END# *548EE9220107_BASE_INIT*
{
	//#UC START# *548EE9220107_BODY*
	//#UC END# *548EE9220107_BODY*
}

Searcher::~Searcher () {
	//#UC START# *4F313B660191_DESTR_BODY*
	this->reset ();
	//#UC END# *4F313B660191_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить
bool Searcher::add (const std::string& str, size_t i) {
	//#UC START# *5405B9CF01ED*
	if (m_streams.empty ()) {
		m_streams.resize (1);
	} 

	GDS_ASSERT (i < m_streams.size ());

	if (std::find_if (str.begin (), str.end (), boost::is_any_of (" -~")) != str.end ()) {
		return this->add_stream (str, m_streams [i]);
	}

	Core::Aptr <GCL::StrSet> res;

	if (*(str.rbegin ()) == '*' && m_properties.wild_mng) {
		res = m_properties.wild_mng->get (str);
	} else {
		res = KeysFactory (m_properties.comm).make_for_word (str);
	}

	m_streams [i].reserve (res->size ());

	std::for_each (res->begin (), res->end ()
		, boost::bind (&Searcher::add_stream, this, _1, boost::ref (m_streams [i]))
	);

	return true;
	//#UC END# *5405B9CF01ED*
}

// добавить стрим
bool Searcher::add_stream (const std::string& key, StreamPointers& streams) {
	//#UC START# *4F3531760019*
	StreamsCache::const_iterator it = std::find_if (
		m_cache.begin (), m_cache.end (), boost::bind (&StreamsCache::value_type::key, _1) == key
	);

	if (it != m_cache.end ()) {
		it->stream->add_ref ();
		streams.push_back (it->stream);
	} else {
		Core::Aptr <SearchStream> stream = new SearchStream (key, m_properties.factory, m_properties.flags);

		if (stream->is_valid ()) {
			m_cache.push_back (CacheNode ());
			m_cache.back ().key = key;
			m_cache.back ().stream = stream._retn ();

			streams.push_back (m_cache.back ().stream);
		} else {
			return false;
		}
	}

	return true;
	//#UC END# *4F3531760019*
}

// получить позиции для лексемы
bool Searcher::get_data (
	Relevancy::Positions& out
	, StreamPointers& streams
	, DBComm::DocId doc_id
	, bool& has_block
	, const DBCore::ExtrPair& extr
) {
	//#UC START# *505729C600E0*
	out.clear ();
	out.reserve (GREAT_RESERVE_SIZE);

	if (streams.size () == 1) {
		streams.front ()->fill_positions (out, doc_id, has_block, extr);
	} else {
		std::for_each (streams.begin (), streams.end ()
			, boost::bind (&SearchStream::fill_positions, _1
			, boost::ref (out), doc_id
			, boost::ref (has_block), extr)
		);

		out.erase (std::unique (out.begin (), out.end (), Searcher::compare_mask_equal), out.end ());
	}

	return (out.empty () == false);
	//#UC END# *505729C600E0*
}

// позиции слов фразы для заданного документа
bool Searcher::get_data (Relevancy::DataVector& result, DBComm::DocId doc_id, bool& has_block) {
	//#UC START# *5405BC2E000D*
	size_t total = m_streams.size ();

	if (result.empty ()) {
		result.resize (total);
	}

	DBCore::ExtrPair extr;

	if (total == 1) {
		return this->get_data (result [0], m_streams [0], doc_id, has_block, extr);
	}

	size_t pos = 0;
	this->get_min_size (doc_id, pos);

	Relevancy::Positions& data = result [pos];

	if (!this->get_data (data, m_streams [pos], doc_id, has_block, extr)) {
		return false;
	}

	if (has_block == false) {
		extr.min = (data.front () & POS_TEXT) - m_offset;
		extr.max = (data.back  () & POS_TEXT) + m_offset;
	}

	return this->get_data (result, doc_id, has_block, m_offset, extr);
	//#UC END# *5405BC2E000D*
}

// позиции слов фразы для заданного документа
bool Searcher::get_data (
	Relevancy::DataVector& result
	, DBComm::DocId doc_id
	, bool& has_block
	, size_t offset
	, DBCore::ExtrPair& extr
) {
	//#UC START# *5405BC7F038D*
	size_t i = 0, total = m_streams.size ();

	GDS_ASSERT (total > 1);

	for (; i < total; ++i) {
		if (i != m_pos) {
			Relevancy::Positions& res = result [i];

			if (!this->get_data (res, m_streams [i], doc_id, has_block, extr)) {
				return false;
			}

			if (has_block) {
				extr.min = 0;
				extr.max = 0;
			} else {
				long _min = (res.front () & POS_TEXT) - offset;
				long _max = (res.back  () & POS_TEXT) + offset;

				if (extr.min < _min) {
					extr.min = _min;
				}

				if (extr.max > _max) {
					extr.max = _max;
				}
			}
		}
	}

	return true;
	//#UC END# *5405BC7F038D*
}

// количество минимальных вхождений
size_t Searcher::get_min_size (DBComm::DocId doc_id, size_t& pos) {
	//#UC START# *5405BB4E01AD*
	size_t i, count, min_len = INFINITE_SIZE, total = m_streams.size ();

	m_pos = 0;

	for (i = 0; i < total; ++i) {
		count = 0;

		StreamPointers::const_iterator it = m_streams [i].begin (), it_end = m_streams [i].end ();

		for (; it != it_end; ++it) {
			count += (*it)->get_data_len (doc_id);
		}

		if (count < min_len) {
			min_len = count;
			m_pos = i;
		}
	}

	pos = m_pos;

	return min_len;
	//#UC END# *5405BB4E01AD*
}

// искать следующий документ
DBComm::DocId Searcher::get_next (DBComm::DocId border) {
	//#UC START# *5405BD3D0270*
	m_pair.max_id = DBComm::NULL_DOC_ID;
	m_pair.min_id = DBComm::INFINITE_DOC_ID;

	for (DBComm::DocId id = border; m_pair.min_id != m_pair.max_id; id = m_pair.max_id) {
		m_pair.min_id = DBComm::INFINITE_DOC_ID;

		Streams::iterator it = m_streams.begin (), it_end = m_streams.end ();

		for (; it != it_end; ++it) {
			Searcher::get_next_pair (m_pair, *it, id);

			if (m_pair.min_id == DBComm::NULL_DOC_ID) {
				return m_pair.min_id;
			}
		}
	}

	return m_pair.min_id;
	//#UC END# *5405BD3D0270*
}

// значение для прогресс-индикатора
size_t Searcher::get_prog_value () {
	//#UC START# *5405BAA00114*
	size_t sum = 0, lim = 0;

	for (Streams::iterator it = m_streams.begin (); it != m_streams.end (); ++it) {
		sum = std::accumulate (it->begin (), it->end (), sum, StreamProgress (false));
		lim = std::accumulate (it->begin (), it->end (), lim, StreamProgress (true));
	}

	sum = sum ? sum : 1;
	lim = lim ? lim : 1;

	return size_t (100 * double (sum) / double (lim));
	//#UC END# *5405BAA00114*
}

// предварительная загрузка
bool Searcher::prev_load (
	Relevancy::DataVector& result
	, DBComm::DocId doc_id
	, bool& has_block
	, size_t offset
	, DBCore::ExtrPair& extr
) {
	//#UC START# *5405BDAF0245*
	Relevancy::Positions& data = result [m_pos];

	if (!this->get_data (data, m_streams [m_pos], doc_id, has_block, extr)) {
		return false;
	}

	if (has_block == false) {
		long _min = (data.front () & POS_TEXT) - offset;
		long _max = (data.back  () & POS_TEXT) + offset;

		if (extr.max == 0) {
			extr.min = _min;
			extr.max = _max;
		} else {
			if (extr.min < _min) {
				extr.min = _min;
			}

			if (extr.max > _max) {
				extr.max = _max;
			}
		}
	}

	return true;
	//#UC END# *5405BDAF0245*
}

// сброс кэшей
void Searcher::reset () {
	//#UC START# *54C10E2401FC*
	if (m_cache.empty () == false) {
		std::for_each (m_cache.begin (), m_cache.end (), Searcher::StreamDestroy ());
		m_cache.clear ();
	}
	m_streams.clear ();
	//#UC END# *54C10E2401FC*
}

// поиск заданного документа
bool Searcher::search (DBComm::DocId id) {
	//#UC START# *5405BE4F02AE*
	if (m_streams.empty ()) {
		return false;
	}

	Streams::iterator it = m_streams.begin (), it_end = m_streams.end ();

	for (; it != it_end; ++it) {
		bool is_exist = false;

		for (StreamPointers::iterator _it = it->begin (); _it != it->end (); ++_it) {
			is_exist |= (*_it)->search (id);
		}

		if (is_exist == false) {
			return false;
		}
	}

	return true;
	//#UC END# *5405BE4F02AE*
}

// инициализация
void Searcher::set (const Search::PhraseEx& in) {
	//#UC START# *539065F20114*
	this->reset ();

	m_streams.resize (in.size ());

	for (size_t i = 0; i < in.size (); ++i) {
		const std::string& val = *(in [i].begin ());

		Core::Aptr <GCL::StrSet> res;

		if (in [i].size () == 1 && *(val.rbegin ()) == '*' && m_properties.wild_mng) {
			res = m_properties.wild_mng->get (val);
		} else {
			res = KeysFactory (m_properties.comm).make (in [i]);
		}

		m_streams [i].reserve (res->size ());

		std::for_each (res->begin (), res->end ()
			, boost::bind (&Searcher::add_stream, this, _1, boost::ref (m_streams [i]))
		);
	}
	//#UC END# *539065F20114*
}

// инициализация
bool Searcher::set (const Search::Phrase& in) {
	//#UC START# *54B93DC901FC*
	this->reset ();

	m_streams.resize (in.size ());

	for (size_t i = 0; i < in.size (); ++i) {
		if (this->add (in [i], i) == false) {
			return false;
		}
	}

	return true;
	//#UC END# *54B93DC901FC*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

