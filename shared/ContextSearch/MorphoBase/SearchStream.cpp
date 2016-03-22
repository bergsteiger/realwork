////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/SearchStream.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::SearchStream
//
// Класс для поиска данных в открытом стриме
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/SearchStream.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// сравнение позиций
bool SearchStream::compare_mask_less (unsigned long x, unsigned long y) {
	//#UC START# *4F156F58021F*
	return (x & POS_TEXT) < (y & POS_TEXT);
	//#UC END# *4F156F58021F*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearchStream::SearchStream (const std::string& key, DBComm::IStreamsFactory* factory, unsigned long flags)
//#UC START# *45213E0E0213_BASE_INIT*
	: m_count (0)
	, m_is_bad (false)
//#UC END# *45213E0E0213_BASE_INIT*
{
	//#UC START# *45213E0E0213_BODY*
	m_cache.doc_id = DBComm::NULL_DOC_ID;
	m_cache.length = 0;
	m_cache.pos = 0;

	GDS_ASSERT (factory);

	if (factory) {
		m_pair = factory->make (key, flags);
	}
	//#UC END# *45213E0E0213_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// счетчик ссылок
void SearchStream::add_ref () {
	//#UC START# *540737AF01BB*
	++m_count;
	//#UC END# *540737AF01BB*
}

// добавить данные в вектор позиций
void SearchStream::fill_positions (
	Relevancy::Positions& data
	, DBComm::DocId doc_id
	, bool& has_block
	, const DBCore::ExtrPair& extr
) {
	//#UC START# *452139BA034B*
	if (m_cache.doc_id == doc_id) {
		size_t middle = data.size ();

		if (m_count) {
			if (m_data.id != doc_id) {
				m_data.id = doc_id;
				m_data.data.clear ();
				m_pair->data_stream->get (m_data.data, m_cache, extr);
				m_data.has_block = m_pair->data_stream->has_block ();
			} 

			if (m_data.data.empty ()) {
				return;
			} 

			Relevancy::Positions::const_iterator it = m_data.data.begin (), it_end = m_data.data.end ();

			Defs::Position min_val = (extr.min < 0)? 1 : (Defs::Position) extr.min;
			Defs::Position max_val = (Defs::Position) extr.max;

			if (min_val && max_val && m_data.has_block == false) {
				if (min_val > (m_data.data.front () & POS_TEXT)) {
					it = std::lower_bound (it, it_end, min_val, compare_mask_less);

					if (it == it_end) {
						return;
					}
				}

				if (max_val < (m_data.data.back () & POS_TEXT)) {
					it_end = std::upper_bound (it, it_end, max_val, compare_mask_less);
				}
			}

			data.insert (data.end (), it, it_end);

			if (has_block == false) {
				has_block = m_data.has_block;
			}
		} else {
			m_pair->data_stream->get (data, m_cache, extr);

			if (has_block == false) {
				has_block = m_pair->data_stream->has_block ();
			}
		}

		if (middle) {
			std::inplace_merge (data.begin (), data.begin () + middle, data.end (), compare_mask_less);
		}
	}
	//#UC END# *452139BA034B*
}

// длина порции данных с позициями
size_t SearchStream::get_data_len (DBComm::DocId doc_id) const {
	//#UC START# *50572240036A*
	return (m_cache.doc_id == doc_id)? m_cache.length : 0;
	//#UC END# *50572240036A*
}

// поиск документа
DBComm::DocId SearchStream::get_next (DBComm::DocId start_id) {
	//#UC START# *452139B70203*
	if (m_cache.doc_id >= start_id) {
		return m_cache.doc_id; // found in cache
	}

	if (m_is_bad) {
		return DBComm::NULL_DOC_ID;
	}

	DBCore::IRefStream* reader_ptr = m_pair->ref_stream.in (); // for economy of time

	do {
		if (reader_ptr->get_next (m_cache, start_id) == false) {
			m_is_bad = true;
			m_cache.doc_id = DBComm::NULL_DOC_ID;
			break;
		}
	} while (m_cache.doc_id < start_id);

	return m_cache.doc_id;
	//#UC END# *452139B70203*
}

// проверка на валидность открытия стрима
const bool SearchStream::is_valid () const {
	//#UC START# *45E6EDAD034B*
	return m_pair.is_nil () == false;
	//#UC END# *45E6EDAD034B*
}

// оператор
bool SearchStream::operator == (DBComm::DocId doc_id) const {
	//#UC START# *4DC1366801E1*
	return (m_cache.doc_id == doc_id);
	//#UC END# *4DC1366801E1*
}

// получить позицию прогресс-индикатора
unsigned long SearchStream::progress_tell () const {
	//#UC START# *45213C05003E*
	return m_pair.is_nil ()? 0 : m_pair->ref_stream->get_tell ();
	//#UC END# *45213C05003E*
}

// поиск документа
bool SearchStream::search (DBComm::DocId doc_id) {
	//#UC START# *4F26C268002D*
	m_cache.doc_id = doc_id;

	if (m_pair->ref_stream->search (m_cache)) {
		return true;
	} 

	m_cache.doc_id = DBComm::NULL_DOC_ID;
	return false;
	//#UC END# *4F26C268002D*
}

// получить длину стрима
const unsigned long SearchStream::stream_length () const {
	//#UC START# *45213B50035B*
	return m_pair.is_nil () ? 0 : m_pair->ref_stream->get_length ();
	//#UC END# *45213B50035B*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

