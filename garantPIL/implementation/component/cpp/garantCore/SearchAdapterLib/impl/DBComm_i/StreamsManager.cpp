////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/StreamsManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::StreamsManager
//
// Менеджер стримов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/StreamsManager.h"
// by <<uses>> dependencies
#include "garantCore/DBExt/Readers/PositionsReader.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/Search/SearchFactories.h"
#include "garantCore/DBExt/Readers/MemoryIndex.h"
#include "boost/algorithm/string/classification.hpp"

namespace SearchAdapterLib {
namespace DBComm_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StreamsManager::StreamsManager (DBCore::IBase* base, const std::string& src, const std::string& form_src)
//#UC START# *4EBA9B4D0067_BASE_INIT*
	: m_use_cache (true)
	, m_form_src (form_src)
//#UC END# *4EBA9B4D0067_BASE_INIT*
{
	//#UC START# *4EBA9B4D0067_BODY*
	m_base = DBCore::IBase::_duplicate (base);
	m_index = m_base->make (src.c_str ());
	//#UC END# *4EBA9B4D0067_BODY*
}

StreamsManager::~StreamsManager () {
	//#UC START# *4EBA9AF30074_DESTR_BODY*
	this->close ();
	//#UC END# *4EBA9AF30074_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// закрыть стримы
void StreamsManager::close (DBCore::Streams& streams_) {
	//#UC START# *4EBAA06C0158*
	if (streams_.first) {
		m_index->close_stream (streams_.first);
		streams_.first = 0;
	}

	if (streams_.second) {
		m_index->close_stream (streams_.second);
		streams_.second = 0;
	}
	//#UC END# *4EBAA06C0158*
}

// закрыть все стримы
void StreamsManager::close () {
	//#UC START# *4EBAB22503A2*
	CachedStreams::iterator it = m_streams.begin (), it_end = m_streams.end ();

	for (; it != it_end; ++it) {
		this->close (it->second);
	}
	//#UC END# *4EBAB22503A2*
}

// вычислить форму
unsigned char StreamsManager::get_form (const std::string& key, std::string& out_key) {
	//#UC START# *4EBBD47600B7*
	unsigned char ret = std::numeric_limits <unsigned char>::max (); // any form is what we want

	DBCore::IIndex_var index = m_base->make (m_form_src.c_str ());

	GDS_ASSERT (index.is_nil () == false);

	if (index->is_valid ()) {
		size_t size = 0;

		DBCore::IBuffer_var buffer;

		if (m_form_src != "Context.str") {
			buffer = index->read (key.c_str (), 0, size);
		} else {
			std::string new_key (1, 0xc0 + key.size ());
			new_key += key;
			buffer = index->read (new_key.c_str (), 0, size);
		}

		if (size) {
			const char* buf = buffer->get ();
			ret = (unsigned char) buf [2];
			out_key = buf + 4;
		}
	}

	return ret;
	//#UC END# *4EBBD47600B7*
}

// фабрика
DBCore::StreamsPair* StreamsManager::make_ (const std::string& key, unsigned long flags) {
	//#UC START# *56AA0C3802FF*
	using namespace ContextSearch;

	if (flags & Search::SP_IGNORE_CACHE) {
		m_use_cache = false;
		this->close ();
		m_streams.clear ();
	}

	std::string word_form;

	if (*(key.rbegin ()) == '!') {
		GDS_ASSERT (key.size () > 1);
		word_form.assign (key.begin (), key.end () - 1);
	} else if (*(key.rbegin ()) == '*') {
		GDS_ASSERT (0);
		return 0;
	}

	DBExt::MemoryIndex* memcache = DBExt::MemoryIndex::instance ();
	DBExt::Def::Type type = (flags & Search::SP_TITLES)? DBExt::Def::dt_Title : DBExt::Def::dt_Text;

	Core::Aptr <DBCore::StreamsPair> ret;

	if (word_form.empty () && memcache->is_load ()) {
		ret = memcache->get (key, type);

		if (ret.is_nil () == false) {
			if (ret->ref_stream.is_nil () == false && ret->data_stream.is_nil () == false) {
				return ret._retn ();
			}
		}
	}

	DBCore::Streams pair;
	unsigned char form = (word_form.empty ())? this->open (key, false, pair) : this->open (word_form, true, pair);

	if (pair.first && pair.second) {
		if (ret.is_nil ()) {
			ret = new DBCore::StreamsPair;
		} 

		DBCore::IIndex* index = (m_use_cache)? 0 : m_index.in ();
		
		if (ret->ref_stream.is_nil ()) {
			ret->ref_stream = new DBExt::StreamReader (pair.first, index);
		} else if (index) {
			index->close_stream (pair.first);
		}

		if (ret->data_stream.is_nil ()) {
			ret->data_stream = new DBExt::PositionsReader (pair.second, form, type, pair.has_form, index);
		} else if (index) {
			index->close_stream (pair.second);
		}

		return ret._retn ();
	}

	return 0;
	//#UC END# *56AA0C3802FF*
}

// открыть стримы
unsigned char StreamsManager::open (const std::string& key, bool is_form, DBCore::Streams& streams_) {
	//#UC START# *4EBAA021012C*
	unsigned char form = std::numeric_limits <unsigned char>::max (); // any form is what we want

	if (is_form) {
		std::string new_key;
		form = this->get_form (key, new_key);

		if (new_key.empty () == false) {
			this->open (new_key, streams_);
		}
	} else {
		this->open (key, streams_);
	}

	return form;
	//#UC END# *4EBAA021012C*
}

// открыть стримы (с добавлением в кэш, если он включен)
void StreamsManager::open (const std::string& key, DBCore::Streams& streams_) {
	//#UC START# *4EBBD66F03BC*
	if (m_use_cache) {
		CachedStreams::iterator it = m_streams.find (key);

		if (it == m_streams.end ()) {
			it = m_streams.insert (CachedStreams::value_type (key, DBCore::Streams ())).first;
			this->open_streams (key, it->second);
		} else if (it->second.first) {
			it->second.first->Seek (0);
			it->second.second->Seek (0);
		} 

		streams_.first = it->second.first;
		streams_.second = it->second.second;
		streams_.has_form = it->second.has_form;
	} else {
		this->open_streams (key, streams_);
	}
	//#UC END# *4EBBD66F03BC*
}

// открыть стримы
void StreamsManager::open_streams (const std::string& key, DBCore::Streams& streams_) {
	//#UC START# *4EBBD5E50198*
	// "Нулевой" стрим, формат: список пар вида {документ (4 байта), смещение (4 байта)}
	streams_.first = m_index->open_stream (key.c_str (), 0);
	// "Второй" стрим, формат: список позиций (2 или 3 байта - позиция, 1 байт - номер формы)
	if (streams_.first) {
		DBCore::Store* store = m_index->open_stream (key.c_str (), 1);
		streams_.has_form = (store->Length () > 32);
		m_index->close_stream (store);

		streams_.second = m_index->open_stream (key.c_str (), 2);
	}
	//#UC END# *4EBBD5E50198*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IStreamsFactory
// проверка на валидность
bool StreamsManager::is_valid () const {
	//#UC START# *55CE1A52012D_4EBA9AF30074*
	return (m_index.is_nil () == false && m_index->is_valid ());
	//#UC END# *55CE1A52012D_4EBA9AF30074*
}

// implemented method from DBCore::IStreamsFactory
// фабрика
DBCore::StreamsPair* StreamsManager::make (const std::string& key, unsigned long flags) {
	//#UC START# *5124FFCF0337_4EBA9AF30074*
	if (*(key.rbegin ()) == '!' || *(key.rbegin ()) == '*') {
		return this->make_ (key, flags);
	} 

	std::string s_key (1, (char) (key.size () + 1));
	s_key += key;

	if (std::find_if (key.begin (), key.end (), boost::is_any_of (" -~")) != key.end ()) {
		if (key.size () > Morpho::Def::MAX_WORD_LEN) {
			s_key.clear ();
			s_key.resize (1, (char) (32));
			s_key += key.substr (0, Morpho::Def::MAX_WORD_LEN);
		} 
		return this->make_ (s_key, flags);
	} else if (std::find_if (key.begin (), key.end (), boost::is_digit ()) == key.end ()) {
		Core::Aptr <DBCore::StreamsPair> ret = this->make_ (s_key, flags);
		if (ret.is_nil () == false) {
			return ret._retn ();
		}
	} 

	s_key [0] |= 0x80; // псевдо
	return this->make_ (s_key, flags);
	//#UC END# *5124FFCF0337_4EBA9AF30074*
}
} // namespace DBComm_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

