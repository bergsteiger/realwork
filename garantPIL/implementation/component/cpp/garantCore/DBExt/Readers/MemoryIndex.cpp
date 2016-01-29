////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Readers/MemoryIndex.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::DBExt::Readers::MemoryIndex
//
// MemoryIndex
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Readers/MemoryIndex.h"
// by <<uses>> dependencies
#include "garantCore/DBExt/Readers/MemRefStream_i.h"
#include "garantCore/DBExt/Readers/MemDataStream_i.h"

//#UC START# *51532B59030D_CUSTOM_INCLUDES*
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/gardefs.h"
//#UC END# *51532B59030D_CUSTOM_INCLUDES*

namespace DBExt {

//#UC START# *51532B59030D*
static const char* CONTEXT_INDEX_NAME = "NWCntxt";

class _Streams {
public:
	_Streams (DBCore::IIndex* index) 
		: m_index (index)
		, m_store_0 (0)
		, m_store_1 (0)
		, m_store_2 (0)	{
	}

	virtual ~_Streams () {
		if (m_store_0) {
			m_index->close_stream (m_store_0);
		}
		if (m_store_1) {
			m_index->close_stream (m_store_1);
		}
		if (m_store_2) {
			m_index->close_stream (m_store_2);
		}
	}

public:
	bool open (const char* key, DBCore::LoadType type) {
		if (type == DBCore::lt_All) {
			m_store_0 = m_index->open_stream (key, 0);
			m_store_1 = m_index->open_stream (key, 1);
			m_store_2 = m_index->open_stream (key, 2);
			return (m_store_0 && m_store_1 && m_store_2);
		} else if (type == DBCore::lt_Refs) {
			m_store_0 = m_index->open_stream (key, 0);
			m_store_1 = m_index->open_stream (key, 1);
			return (m_store_0 && m_store_1);
		} else if (type == DBCore::lt_Data) {
			m_store_1 = m_index->open_stream (key, 1);
			m_store_2 = m_index->open_stream (key, 2);
			return (m_store_1 && m_store_2);
		}

		GDS_ASSERT (0);
		return false;
	}

	bool has_form () {
		return (m_store_1->Length () > 32);
	}

	int read_0 (Data& item) {
		GDS_ASSERT (item.ref_len == 0);
		item.ref_len = m_store_0->Length ();
		item.ref_buf = new char [item.ref_len + 1];
		return (m_store_0->Read (item.ref_buf, item.ref_len) == item.ref_len);
	}

	int read_2 (Data& item) {
		GDS_ASSERT (item.data_len == 0);
		item.data_len = m_store_2->Length ();
		item.data_buf = new char [item.data_len + 1];
		return (m_store_2->Read (item.data_buf, item.data_len) == item.data_len);
	}

private:
	DBCore::IIndex* m_index;

	DBCore::Store* m_store_0; // refs
	DBCore::Store* m_store_1; // forms
	DBCore::Store* m_store_2; // data
};

////////////////////////////////////////////////////////////////////////////////////////////

class ThreadManager {
public:
	ThreadManager () { }

public:
	void execute (ACE_THR_FUNC thr_func, void* arg, DBCore::IBasePool* pool, DBCore::LoadType type);

	DBCore::IBase* get ();
	DBCore::LoadType get_type () const;

	size_t get_pos ();

public:
	typedef ACE_Singleton <ThreadManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ThreadManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	Core::Mutex m_mutex;

	DBCore::LoadType m_type;
	DBCore::IBasePool_var m_pool;

	size_t m_pos;
};

void ThreadManager::execute (ACE_THR_FUNC thr_func, void* arg, DBCore::IBasePool* pool, DBCore::LoadType type) {
	m_pos = 0;
	m_type = type;
	m_pool = DBCore::IBasePool::_duplicate (pool);

	size_t thr_count = pool->get_size ();

	ACE_Thread_Manager* manager = ACE_Thread_Manager::instance ();

	std::vector <ACE_thread_t> thr_ids (thr_count);

	for (size_t i = 0; i < thr_count; ++i) {
		if (manager->spawn (thr_func, arg, THR_NEW_LWP | THR_JOINABLE, &thr_ids [i]) < 0) {
			throw std::exception ();
		}
	}

	for (size_t i = 0; i < thr_count; ++i) {
		manager->join (thr_ids [i]);
	}

	LOG_I (("%s, loaded: %d", GDS_CURRENT_FUNCTION, m_pos - thr_count));
}

DBCore::IBase* ThreadManager::get () {
	GUARD (m_mutex);
	static size_t pool_index = 0;
	return m_pool->get (pool_index++);
}

DBCore::LoadType ThreadManager::get_type () const {
	return m_type;
}

size_t ThreadManager::get_pos () {
	GUARD (m_mutex);
	size_t ret = m_pos;
	++m_pos;
	return ret;
}

int thr_func (void* arg) {
	typedef std::vector <Data> _Index;

	_Index* data = static_cast <_Index*> (arg);

	ThreadManager* manager = ThreadManager::Singleton::instance ();

	GDS_ASSERT (manager && data);

	DBCore::IBase* base = manager->get ();
	DBCore::IIndex_var index = base->make (CONTEXT_INDEX_NAME);

	DBCore::LoadType type = manager->get_type ();

	for (size_t pos = manager->get_pos (); pos < data->size (); pos = manager->get_pos ()) {
		Data& item = data->at (pos);

		_Streams streams (index.in ());

		streams.open (item.key.c_str (), type);
		item.has_form = streams.has_form ();

		bool has_data = false;

		if (type == DBCore::lt_All) {
			streams.read_0 (item);
			has_data = streams.read_2 (item);
		} else if (type == DBCore::lt_Refs) {
			streams.read_0 (item);
		} else if (type == DBCore::lt_Data) {
			has_data = streams.read_2 (item);
		}

		if (has_data && item.has_form) {
			MemoryIndex::filtrate (item);
			item.has_form = false;
		}
	}

	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////

void MemoryIndex::filtrate (Data& data) {
	//#UC START# *515C534D00B9*
	Core::GDS::StopWatchEx sw (GDS_CURRENT_FUNCTION);

	const char* ptr = data.data_buf;
	int length = data.data_len;

	char* ref_ptr = data.ref_buf;

	long cur, count = 0;

	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > tmp = new char [length + 1];

	do {
		cur = *(long*) ptr;

		if (cur & Def::IS_3_BYTES) {
			memcpy (tmp.inout () + count, ptr, 3);
			count += 3;

			ptr += 3;
			length -= 3;
		} else {
			memcpy (tmp.inout () + count, ptr, 2);
			count += 2;

			ptr += 2;
			length -= 2;
		}

		++ptr;
		--length;

		if (cur & Def::END_PORTION) {
			ref_ptr += 4;
			memcpy (ref_ptr, &count, sizeof (long));
			ref_ptr += 4;
		}
	} while (length);

	GDS_ASSERT (ref_ptr - data.ref_buf == data.ref_len);

	// Перезаписываем позиции
	delete [] data.data_buf;
	data.data_len = count;
	data.data_buf = new char [count + 1];
	memcpy (data.data_buf, tmp.in (), count); // TODO: memmove?
	//#UC END# *515C534D00B9*
}
//#UC END# *51532B59030D*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// проверка на то то, что лексема удовлетворяет заданному шаблону
bool MemoryIndex::is_skip (const char* key) {
	//#UC START# *515C49B1010A*
	std::string str = key;
	size_t key_len = str.size ();

	if (key_len == 1) {
		if (str [0] < '0' || str [0] > '9') {
			return true;
		} 
	} else if (key_len > 16) {
		return true;
	} else if (ContextSearch::ContextUtility::is_digit (str)) {
		if (key_len > 4) {
			return true;
		}
	} else if (ContextSearch::ContextUtility::has_digit (str)) {
		return true;
	}

	return false;
	//#UC END# *515C49B1010A*
}

// вернуть длину стрима
long MemoryIndex::get_stream_len (DBCore::IIndex* index, const char* key, unsigned short stream_no) {
	//#UC START# *52CFBAC3019A*
	long ret = 0;

	DBCore::Store* store = index->open_stream (key, stream_no);

	if (store) {
		ret = store->Length ();
		index->close_stream (store);
	}

	return ret;
	//#UC END# *52CFBAC3019A*
}

// список лексем
GCL::StrVector* MemoryIndex::get_lexemes (DBCore::IBase* base) {
	//#UC START# *52DD3CA501E5*
	Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

	DBCore::IIndex_var index = base->make ("Aux");

	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_TOP_LEMMS, 0, size);

	if (buffer.is_nil () == false) {
		const char* ptr = buffer->get_data ();

		std::string str;

		for (size_t pos = 0, length = 0; pos < size; pos += length, ptr += length) {
			size_t str_len = strlen (ptr);

			GDS_ASSERT (str_len);

			if (*ptr == '#') {
				char first = (char) (str_len);
				str = ptr;
				str [0] = first | 0x80;
			} else {
				char first = (char) (str_len + 1);
				str = first;
				str += ptr;
			}

			ret->push_back (str);
			length = str_len + 1;
		}
	}

	return ret._retn ();
	//#UC END# *52DD3CA501E5*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MemoryIndex::MemoryIndex ()
//#UC START# *51532C190105_BASE_INIT*
	: m_total (0)
//#UC END# *51532C190105_BASE_INIT*
{
	//#UC START# *51532C190105_BODY*
	//#UC END# *51532C190105_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить ключ
bool MemoryIndex::add (DBCore::IIndex* index, const char* key, bool is_load, DBCore::LoadType type) {
	//#UC START# *52BC16A501FE*
	_Streams streams (index);

	bool ret = streams.open (key, type);

	if (ret && is_load) {
		m_data.push_back (Data ());

		Data& item = m_data.back ();

		item.key = key;
		item.has_form = streams.has_form ();

		Core::GDS::StopWatchEx sw ("Read");

		if (type == DBCore::lt_All) {
			ret = (streams.read_0 (item) && streams.read_2 (item));
		} else if (type == DBCore::lt_Refs) {
			ret = streams.read_0 (item);
		} else if (type == DBCore::lt_Data) {
			ret = streams.read_2 (item);
		}
	}

	return ret;
	//#UC END# *52BC16A501FE*
}

// добавить ключ
bool MemoryIndex::add_ (DBCore::IIndex* index, const char* key, bool is_load, bool filtering) {
	//#UC START# *52CFD10E0140*
	DBCore::Store* store_0 = index->key_open (key, 0); // refs
	DBCore::Store* store_1 = index->key_open (key, 1); // forms
	DBCore::Store* store_2 = index->key_open (key, 2); // data

	if (store_0 && store_1 && store_2) {
		if (is_load) {
			m_data.push_back (Data ());

			Data& item = m_data.back ();

			item.key = key;
			item.ref_len = store_0->Length ();
			item.data_len = store_2->Length ();
			item.has_form = (store_1->Length () > 32);

			GDS_ASSERT (item.ref_len > 0 && item.data_len > 0);

			item.ref_buf = new char [item.ref_len + 1];

			if (store_0->Read (item.ref_buf, item.ref_len) != item.ref_len) {
				return false;
			}

			item.data_buf = new char [item.data_len + 1];

			if (store_2->Read (item.data_buf, item.data_len) != item.data_len) {
				return false;
			}

			if (item.has_form && filtering) {
				MemoryIndex::filtrate (item);
				item.has_form = false;
			}
		} 

		index->close_stream (store_0);
		index->close_stream (store_1);
		index->close_stream (store_2);

		return true;
	} 

	return false;
	//#UC END# *52CFD10E0140*
}

// очистить
void MemoryIndex::clear () {
	//#UC START# *515C49050162*
	GUARD (m_mutex);
	_Index tmp;
	m_data.swap (tmp);
	//#UC END# *515C49050162*
}

// вернуть стримы для заданного ключа
DBCore::StreamsPair* MemoryIndex::get (const std::string& key, Def::Type type) {
	//#UC START# *51532C250345*
	Core::Aptr <DBCore::StreamsPair> ret;

	Data item;
	item.key = key;

	_Index::const_iterator it = std::lower_bound (m_data.begin (), m_data.end (), item);

	if (it != m_data.end () && it->key == key) {
		ret = new DBCore::StreamsPair;

		if (it->ref_len) {
			ret->ref_stream = new MemRefStream_i (it->ref_buf, it->ref_len);
		}

		if (it->data_len) {
			ret->data_stream = new MemDataStream_i (it->data_buf, it->data_len, type, it->has_form);
		}
	} 

	return ret._retn ();
	//#UC END# *51532C250345*
}

// проверка на то, что кэш инициализирован
bool MemoryIndex::is_load () const {
	//#UC START# *517939D40342*
	return (m_data.empty () == false);
	//#UC END# *517939D40342*
}

// загрузить
void MemoryIndex::load (DBCore::IBase* base) {
	//#UC START# *515330B602C5*
	DBCore::IIndex_var index = base->make (CONTEXT_INDEX_NAME);

	GDS_ASSERT (index->is_valid ());

	m_data.clear ();
	m_data.reserve (index->key_count ());

	DBCore::IBTreeIterator_var it = index->make_iterator ();

	for (; !it->End (); it->next ()) {
		const char* key = (const char*) it->Key ();

		if (this->add_ (index.in (), key, !MemoryIndex::is_skip (key + 1), false) == false) {
			GDS_ASSERT (0);
			break;
		}
	}
	//#UC END# *515330B602C5*
}

// построить memcache поискового индекса
void MemoryIndex::load (const DBCore::MemCacheSettings& settings) {
	//#UC START# *52BAF3270162*
	GUARD (m_mutex);

	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	if (this->is_load ()) {
		return;
	}

	DBCore::IBasePool* pool = const_cast <DBCore::IBasePool*> (settings.pool.in ());

	GDS_ASSERT (pool && pool->get_size ());

	if (settings.for_list) {
		MemoryIndex::prev_load (settings);
		ThreadManager::Singleton::instance ()->execute ((ACE_THR_FUNC) thr_func, &m_data, pool, settings.type);
	} else {
		this->load (pool->get (0));
	}
	//#UC END# *52BAF3270162*
}

// предварительная загрузка
void MemoryIndex::prev_load (const DBCore::MemCacheSettings& settings) {
	//#UC START# *52BD8B9F03A5*
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

	DBCore::IBasePool* pool = const_cast <DBCore::IBasePool*> (settings.pool.in ());

	GDS_ASSERT (pool && pool->get_size ());

	DBCore::IBase* base = pool->get (0);

	Core::Aptr <GCL::StrVector> lexemes = MemoryIndex::get_lexemes (base);

	GDS_ASSERT (lexemes->empty () == false);

	m_total = 0;
	m_data.clear ();

	unsigned long long max_size_in_bytes = settings.max_size * 1000 * 1000 * 1000;

	size_t item_size = sizeof (Data);

	Data item;

	DBCore::IIndex_var index = base->make (CONTEXT_INDEX_NAME);

	GCL::StrVector::const_iterator it;

	for (it = lexemes->begin (); it != lexemes->end (); ++it) {
		if (index->is_valid_key (it->c_str ())) {
			m_total += item_size;
			m_total += it->size ();

			if (settings.type == DBCore::lt_All) {
				m_total += MemoryIndex::get_stream_len (index.in (), it->c_str (), 0);
				m_total += MemoryIndex::get_stream_len (index.in (), it->c_str (), 2);
			} else if (settings.type == DBCore::lt_Refs) {
				m_total += MemoryIndex::get_stream_len (index.in (), it->c_str (), 0);
			} else if (settings.type == DBCore::lt_Data) {
				m_total += MemoryIndex::get_stream_len (index.in (), it->c_str (), 2);
			}

			if (m_total >= max_size_in_bytes) {
				break;
			}

			item.key = *it;
			m_data.push_back (item);
		} 
	}

	std::sort (m_data.begin (), m_data.end ());
	LOG_I (("%s, lexemes: %d", GDS_CURRENT_FUNCTION, m_data.size ()));
	//#UC END# *52BD8B9F03A5*
}

} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

