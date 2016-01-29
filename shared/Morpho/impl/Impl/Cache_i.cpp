////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Morpho/impl/Impl/Cache_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Morpho::Impl::Cache_i
//
// Реализация кэша словарей с загрузкой данных из gkdb
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/Morpho/impl/Impl/Cache_i.h"

namespace Morpho {
namespace Impl {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// Контстанты
const size_t Cache_i::RESERVE_SIZE = 1024; // размер для резервирования
const size_t Cache_i::SMALL_RESERVE_SIZE = 128; // размер для резервирования

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// загрузка списка строк
void Cache_i::load (DBCore::IIndex* index, const void* key, GCL::StrVector& out) {
	//#UC START# *4E03654D029C*
	size_t size = 0;

	DBCore::IBuffer_var buf = index->read (key, 0, size);

	if (size) {
		std::string item;

		const char* ptr = buf->get_data ();

		for (size_t i = 0; i < size; i += item.size () + 1) {
			item = ptr + i;
			out.push_back (item);
		}
	}
	//#UC END# *4E03654D029C*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Cache_i::Cache_i ()
//#UC START# *5151CBF301C7_BASE_INIT*
//#UC END# *5151CBF301C7_BASE_INIT*
{
	//#UC START# *5151CBF301C7_BODY*
	//#UC END# *5151CBF301C7_BODY*
}

Cache_i::~Cache_i () {
	//#UC START# *4E0346CB0015_DESTR_BODY*
	//#UC END# *4E0346CB0015_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// загрузка исключаемых из нормалищзации лексем
void Cache_i::load_exclude (DBCore::IIndex* index) {
	//#UC START# *53185D0C0055*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read ("NExc", 0, size);

	if (size) {
		const char* buf = buffer->get_data ();

		for (const char* ptr = buf; (size_t) (ptr - buf) < size; ) {
			std::string key = ptr;
			ptr += (key.size () + 1);
			m_data->exclude [key].push_back (ptr);
			ptr += strlen (ptr) + 1;
		}
	}
	//#UC END# *53185D0C0055*
}

// загрузка морфо-опечаток
void Cache_i::load_pairs (DBCore::IIndex* index, const void* key, Def::FixedPairs& out) {
	//#UC START# *54998FF8004B*
	GCL::StrVector tmp;
	Cache_i::load (index, key, tmp);

	out.resize (tmp.size () / 2);

	size_t i = 0, j = 0, sz = out.size ();

	GDS_ASSERT (sz * 2 == tmp.size ());

	for (; i < sz; ++i, j += 2) {
		out [i].mistake = tmp [j];
		out [i].correct = tmp [j + 1];
	}

	std::sort (out.begin (), out.end ());
	//#UC END# *54998FF8004B*
}

// загрузка постфиксов
void Cache_i::load_postfixes (DBCore::IIndex* index) {
	//#UC START# *4E034F6501A6*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read ("SupW", 0, size);

	if (size) {
		Def::MorphoData& data = m_data->data;

		data.postfixes.reserve (RESERVE_SIZE * 5);

		std::string item;

		const char* buf = buffer->get_data ();

		for (const char* ptr = buf; (size_t) (ptr - buf) < size; ) {
			data.postfixes.push_back ("");

			item = ptr;
			data.postfixes.push_back (item);
			ptr += (item.size () + 1);

			size_t count = (size_t) (*(long*) ptr);

			++ptr;

			for (; *ptr == 0; ++ptr);

			for (size_t i = 0; i < count; ++i) {
				item = ptr;
				data.postfixes.push_back (item);
				ptr += (item.size () + 1);
			}
		}
	}
	//#UC END# *4E034F6501A6*
}

// загрузка данных для псевдоморфологии
void Cache_i::load_pseudo (DBCore::IIndex* index) {
	//#UC START# *4E034EB902DB*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read ("Ends", 0, size);

	if (size) {
		Def::MorphoData& data = m_data->data;

		Def::StrStrMap::iterator it;

		const char* ptr = buffer->get_data ();

		std::string str;

		for (size_t i = 0; i < size; ) {
			it = data.pseudo.insert (Def::StrStrMap::value_type (std::string (ptr + i), str)).first;

			i += it->first.size () + 1;

			it->second = ptr + i;

			i += it->second.size () + 1;
		}
	}
	//#UC END# *4E034EB902DB*
}

// загрузка однословных синонимов
void Cache_i::load_simple_syns (DBCore::IIndex* index) {
	//#UC START# *4E035C1002E0*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read ("SSyn", 0, size);

	if (size) {
		const char* buf = buffer->get_data ();

		Def::Synonyms::iterator cur_it;

		for (const char* ptr = buf; (size_t) (ptr - buf) < size; ) {
			std::string key = ptr;
			ptr += (key.size () + 1);

			cur_it = m_data->syns.insert (Def::Synonyms::value_type (key, GCL::StrVector ((size_t) *ptr))).first;

			++ptr;

			for (; *ptr == 0; ++ptr);

			GCL::StrVector::iterator it = cur_it->second.begin (), it_end = cur_it->second.end ();

			for (; it != it_end; ++it) {
				*it = ptr;
				ptr += (it->size () + 1);
			}
		}
	}
	//#UC END# *4E035C1002E0*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Def::ICache
// очистить кэш
void Cache_i::clear () {
	//#UC START# *4E11F18F00AD_4E0346CB0015*
	GUARD (m_mutex);
	m_data.release ();
	//#UC END# *4E11F18F00AD_4E0346CB0015*
}

// implemented method from Def::ICache
// исключаемые
const Def::Exclude& Cache_i::get_exclude () const {
	//#UC START# *531893830396_4E0346CB0015*
	return m_data->exclude;
	//#UC END# *531893830396_4E0346CB0015*
}

// implemented method from Def::ICache
// вектор опечаток и их исправлений
const Def::FixedPairs& Cache_i::get_fixed_pairs () const {
	//#UC START# *549996DE0286_4E0346CB0015*
	return m_fixed_pairs;
	//#UC END# *549996DE0286_4E0346CB0015*
}

// implemented method from Def::ICache
// данные для морфоанализа
const Def::MorphoData& Cache_i::get_morpho_data () const {
	//#UC START# *4E035CC30254_4E0346CB0015*
	GDS_ASSERT (m_data.is_nil () == false);
	return m_data->data;
	//#UC END# *4E035CC30254_4E0346CB0015*
}

// implemented method from Def::ICache
// ненормализуемые
const GCL::StrVector& Cache_i::get_not_normalized () const {
	//#UC START# *53188CFC0357_4E0346CB0015*
	return m_data->stops;
	//#UC END# *53188CFC0357_4E0346CB0015*
}

// implemented method from Def::ICache
// вектор синонимичных пар
const Def::FixedPairs& Cache_i::get_syn_pairs () const {
	//#UC START# *54F5A6E800E1_4E0346CB0015*
	return m_syn_pairs;
	//#UC END# *54F5A6E800E1_4E0346CB0015*
}

// implemented method from Def::ICache
// синонимы
const Def::Synonyms& Cache_i::get_syns () const {
	//#UC START# *4E01AE6F0073_4E0346CB0015*
	GDS_ASSERT (m_data.is_nil () == false);
	return m_data->syns;
	//#UC END# *4E01AE6F0073_4E0346CB0015*
}

// implemented method from Def::ICache
// синонимы
const GCL::StrVector& Cache_i::get_syns (const std::string& key) {
	//#UC START# *52E138E500BA_4E0346CB0015*
	if (m_data->syns.empty () == false) {
		Def::Synonyms::const_iterator it = m_data->syns.find (key);

		if (it != m_data->syns.end ()) {
			return it->second;
		}
	}

	GUARD (m_mutex);
	static const GCL::StrVector fake_ret;
	return fake_ret;
	//#UC END# *52E138E500BA_4E0346CB0015*
}

// implemented method from Def::ICache
// загрузка
void Cache_i::load (DBCore::IBase* base, bool load_ssyn) {
	//#UC START# *5151CA3C01F0_4E0346CB0015*
	GUARD (m_mutex);

	if (m_data.is_nil ()) {
		m_data = new Def::CacheData ();
	} else {
		return;
	}

#ifdef _DEBUG
	Core::GDS::StopWatch sw ("%s: load morpho cache", GDS_CURRENT_FUNCTION);
#endif

	try {
		if (base) {
			DBCore::IIndex_var index = base->make ("Aux");

			// Загрузка однословных синонимов
			if (load_ssyn) {
				this->load_simple_syns (index.in ());
			}

			// Загрузка морфо-опечаток
			this->load_pairs (index.in (), "MMor", m_fixed_pairs);

			// Загрузка индексируемых морфо-синонимов
			this->load_pairs (index.in (), "MSyn", m_syn_pairs);

			// Загрузка исключаемых лексем
			this->load_exclude (index.in ());

			// Загрузка данных для псевдоморфологии
			this->load_pseudo (index.in ());

			// Загрузка словаря постфиксов
			this->load_postfixes (index.in ());

			// Загрузка словаря префиксов
			m_data->data.prefixes.reserve (RESERVE_SIZE * 16);
			Cache_i::load (index.in (), "MPrf", m_data->data.prefixes);

			// Загрузка словаря стоп-лемм
			m_data->data.stop_lemmas.reserve (SMALL_RESERVE_SIZE);
			Cache_i::load (index.in (), "SLem", m_data->data.stop_lemmas);

			// Загрузка ненормализуемых лексем
			m_data->stops.reserve (SMALL_RESERVE_SIZE);
			Cache_i::load (index.in (), "NotN", m_data->stops);

			std::sort (m_data->stops.begin (), m_data->stops.end ());
		}
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *5151CA3C01F0_4E0346CB0015*
}
} // namespace Impl
} // namespace Morpho

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

