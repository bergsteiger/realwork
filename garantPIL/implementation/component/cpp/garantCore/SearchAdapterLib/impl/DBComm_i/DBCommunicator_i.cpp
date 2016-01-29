////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ћодуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::DBCommunicator_i
//
// –еализаци€ интерфейса коммуникации с хранилищем
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"
// by <<uses>> dependencies
#include "boost/bind.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/lexical_cast.hpp"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/gardefs.h"
#include "garantPIL/implementation/component/cpp/libs/zlib/src/pack.h"
#include "shared/GCL/str/str_conv.h"
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "boost/algorithm/string/trim.hpp"
#include "boost/lambda/lambda.hpp"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/Dumper.h"

namespace SearchAdapterLib {
namespace DBComm_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool DBCommunicator_i::PatternCompare::operator () (const SynKey& first_param_, const SynKey& second_param_) const {
	//#UC START# *5379EBC40210_IMPL*
	using namespace ContextSearch;

	size_t x = ContextUtility::get_words_count (first_param_.key); 
	size_t y = ContextUtility::get_words_count (second_param_.key);

	if (x == y) {
		return first_param_.key.size () > second_param_.key.size ();
	}

	return (x > y);
	//#UC END# *5379EBC40210_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// инициализаци€ вектора строк
void DBCommunicator_i::init_str_vector (const char* buf, size_t size, GCL::StrVector& out) {
	//#UC START# *546B76F003A8*
	for (const char* ptr = buf; (size_t) (ptr - buf) < size; ) {
		std::string str = ptr;
		ptr += str.size () + 1;

		if (str.empty () == false) {
			if (str [str.size () - 1] == ' ') {
				boost::trim_right (str);
			}
			if (str [0] == ' ') {
				boost::trim_left (str);
			}

			if (str.empty () == false) {
				GCL::to_upper (str);
				out.push_back (str);
			}
		}
	}
	//#UC END# *546B76F003A8*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DBCommunicator_i::DBCommunicator_i (DBCore::IBase* base)
//#UC START# *51EE77A20342_BASE_INIT*
//#UC END# *51EE77A20342_BASE_INIT*
{
	//#UC START# *51EE77A20342_BODY*
	try {
		DBCore::IIndex_var index = base->make ("Aux");

		if (index->is_valid ()) {
			// «агрузка синонимов
			this->load_syns (index.in ());
			// «агрузка стоп-слов и стоп-фраз
			this->load_exclude_data (index.in ());
			// «агрузка устойчивых словосочетаний
			this->load_hard_phrases (index.in ());
			// «агрузка длин блоков, приписанных к позици€м из невидимого текста
			this->load_blocks_lengths (index.in ());
			// «агрузка значений релевантности дл€ обычного невидимого текста
			this->load_invisible_rel (index.in ());
			// «агрузка шаблонов частей речи
			this->load_PSD_templates (index.in ());
			// «агрузка данных дл€ алгоритма модификации значений релевантности
			this->load_tune_data (index.in ());
			// «агрузка словар€ фразальных замен
			this->load_phrasal_replacement (index.in ());

			this->dump ();
		}
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *51EE77A20342_BODY*
}

DBCommunicator_i::~DBCommunicator_i () {
	//#UC START# *4EBBDD2C01CE_DESTR_BODY*
	//#UC END# *4EBBDD2C01CE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// дамп
void DBCommunicator_i::dump () {
	//#UC START# *4EBC01F20048*
#ifdef _DEBUG
	//Dumper ("C:\\Logs\\invisible_blocks").out (m_invisible_blocks);
	//Dumper ("C:\\Logs\\invisible_rel").out (m_invisible_rel);
	//Dumper ("C:\\Logs\\parts_of_speech").out (m_templates);
	//Dumper ("C:\\Logs\\tune_data").out (m_tune_data);
	//Dumper ("C:\\Logs\\hard").out (m_hard_phrases);
	//Dumper ("C:\\Logs\\syns").out (m_syns);
	//Dumper ("C:\\Logs\\pattern").out (m_templates_syns);
	//Dumper ("C:\\Logs\\phrasal_replacement").out (m_phrasal_pair);
	//Dumper ("C:\\Logs\\exclude.txt").out (m_excluded);
#endif
	//#UC END# *4EBC01F20048*
}

// загрузка синонимов
void DBCommunicator_i::init_syns (const char* buf, size_t size, SynKeys& keys, SynValues& data) {
	//#UC START# *53763D3401D5*
	const size_t MAX_COUNT = 170000;

	SynKey empty_key;
	GCL::StrVector empty_list;

	keys.reserve (MAX_COUNT);
	data.reserve (MAX_COUNT);

	size_t counter = 0;

	GCL::StrVector::iterator it;

	for (const char* ptr = buf; (size_t) (ptr - buf) < size; ++counter) {
		keys.push_back (empty_key);
		keys.back ().key = ptr;
		keys.back ().i = counter;

		ptr += keys.back ().key.size () + 1;

		data.push_back (empty_list);

		GCL::StrVector& values = data.back ();
		values.resize (*(long*) ptr);

		ptr += sizeof (long);

		for (it = values.begin (); it != values.end (); ++it) {
			*it = ptr;
			ptr += it->size () + 1;
		}
	}
	//#UC END# *53763D3401D5*
}

// загрузка шаблонов частей речи
void DBCommunicator_i::load_PSD_templates (DBCore::IIndex* index) {
	//#UC START# *4EBC0190030B*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_PartsSpeechAnalyzer, 0, size);

	GCL::StrVector tmp, data;

	if (buffer.is_nil () == false) {
		const char* ptr = buffer->get_data ();

		std::string str;

		for (size_t pos = 0, length = 0; pos < size; pos += length, ptr += length) {
			GDS_ASSERT (ptr);

			str = ptr;
			tmp.push_back (str);
			length = str.size () + 1;
		}
	}

	DBCore::Bytes item;

	for (GCL::StrVector::const_iterator it = tmp.begin (); it != tmp.end (); ++it) {
		boost::split (data, *it, boost::is_any_of ("-"));

		item.resize (data.size ());

		for (size_t i = 0; i < data.size (); ++i) {
			if (data [i].empty ()) {
				item.clear ();
				break;
			}

			item [i] = (char) boost::lexical_cast <short> (data [i]);
		}

		if (item.empty ()) {
			LOG_E (("%s: invalid template: %s", GDS_CURRENT_FUNCTION, it->c_str ()));
		} else {
			m_templates.push_back (item);
		}
	}
	//#UC END# *4EBC0190030B*
}

// загрузка длин блоков, приписанных к позици€м из невидимого текста
void DBCommunicator_i::load_blocks_lengths (DBCore::IIndex* index) {
	//#UC START# *4EBC01520176*
#ifdef _DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_INVISIBLE_LENS, 0, size);

	if (buffer.is_nil () == false) {
		const char* buf = buffer->get_data ();

		size_t item_size = sizeof (long);

		using namespace ContextSearch;

		Defs::InvisibleData def;
		Defs::InvisibleBlocks::iterator it;

		//format: [doc_id] [count (N)] [{pos_0, len_0, rel_0}, ... , {pos_N, len_N, rel_N}]

		for (const char* ptr = buf; (size_t) (ptr - buf) < size; ) {
			it = m_invisible_blocks.insert (Defs::InvisibleBlocks::value_type (*(long*) ptr, def)).first;

			ptr += item_size;

			long count = *(long*) ptr; // количество троек вида {позици€, длина, балл релевантности}

			ptr += item_size;

			for (long i = 0; i < count; ++i, ptr += item_size) {
				Defs::InvisibleBlockPosition& cur = (it->second) [*(long*) ptr];
				ptr += item_size;
				cur.length = *(long*) ptr;
				ptr += item_size;
				cur.relevancy = (unsigned long)(*(long*) ptr);
			}
		}
	}
	//#UC END# *4EBC01520176*
}

// загрузка стоп-слов и стоп-фраз
void DBCommunicator_i::load_exclude_data (DBCore::IIndex* index) {
	//#UC START# *4EBC011E026E*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_EXCLUDE_WORDS, 0, size);

	if (buffer.is_nil () == false) {
		DBCommunicator_i::init_str_vector (buffer->get_data (), size, m_excluded);

		std::sort (m_excluded.begin (), m_excluded.end () 
			, boost::bind (std::greater <size_t> ()
			, boost::bind (&std::string::size, _1)
			, boost::bind (&std::string::size, _2))
		);
	}
	//#UC END# *4EBC011E026E*
}

// загрузка строгих фраз
void DBCommunicator_i::load_hard_phrases (DBCore::IIndex* index) {
	//#UC START# *4FFFFDF10063*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_HARD, 0, size);

	if (buffer.is_nil () == false) {
		m_hard_phrases.reserve (4096);

		DBCommunicator_i::init_str_vector (buffer->get_data (), size, m_hard_phrases);
	}
	//#UC END# *4FFFFDF10063*
}

// загрузка значений релевантности дл€ обычного невидимого текста
void DBCommunicator_i::load_invisible_rel (DBCore::IIndex* index) {
	//#UC START# *4EBC016302BB*
#ifdef _DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_INVISIBLE_RELES, 0, size);

	if (buffer.is_nil () == false) {
		const char* buf = buffer->get_data ();

		size_t item_size = sizeof (long);

		using namespace ContextSearch;

		Defs::RelPos item;
		Defs::PositionsRel def;
		Defs::InvisibleRel::iterator it;

		//format: [doc_id] [count (N)] [{pos_0, rel_0}, ... , {pos_N, rel_N}]

		for (const char* ptr = buf; (size_t) (ptr - buf) < size; ) {
			it = m_invisible_rel.insert (Defs::InvisibleRel::value_type (*(long*) ptr, def)).first;

			ptr += item_size;

			long count = *(long*) ptr; // количество пар вида {позици€, балл релевантности}

			ptr += item_size;

			for (long i = 0; i < count; ++i, ptr += (item_size << 1)) {
				item.pos = *(long*) ptr;
				item.rel = (unsigned char)(*(long*) (ptr + item_size));
				it->second.push_back (item);
			}
		}
	}
	//#UC END# *4EBC016302BB*
}

// загрузка словар€ фразальных замен
void DBCommunicator_i::load_phrasal_replacement (DBCore::IIndex* index) {
	//#UC START# *4EBD0A690337*
	size_t size = 0;

	DBCore::IBuffer_var buffer = index->read (AUX_PHRASAL_NORMALIZER, 0, size);

	if (buffer.is_nil () == false) {
		const char* buf = buffer->get_data ();

		ContextSearch::DBComm::StrPair pair;

		for (const char* ptr = buf; (size_t) (ptr - buf) < size; ptr += strlen (ptr) + 1) {
			const char* loc = strchr (ptr, ';');

			if (loc) {
				pair.first.assign (ptr, loc - ptr);
				pair.second = loc + 1;

				m_phrasal_pair.push_back (pair);
			} else {
				LOG_E (("%s: invalid value: %s", GDS_CURRENT_FUNCTION, ptr));
			}
		}

		std::sort (m_phrasal_pair.begin (), m_phrasal_pair.end ());
	}
	//#UC END# *4EBD0A690337*
}

// загрузка синонимов
void DBCommunicator_i::load_syns (DBCore::IIndex* index) {
	//#UC START# *4EBC013F014A*
#ifdef _DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	{
		size_t size = 0;

		DBCore::IBuffer_var buffer = index->read (AUX_SYN_MORPHO, 0, size);

		if (buffer.is_nil () == false && size) {
			SynKeys keys;
			std::vector <GCL::StrVector> values;
			this->init_syns (buffer->get_data (), size, keys, values);

			std::sort (keys.begin (), keys.end ());

			size_t sz = keys.size ();

			m_syns.resize (sz);

			for (size_t i = 0; i < sz; ++i) {
				m_syns [i].key = keys [i].key;
				m_syns [i].data.swap (values [keys [i].i]);
			}
		}
	} 
	
	{
		size_t size = 0;

		DBCore::IBuffer_var buffer = index->read (AUX_SYN_MORPHO_PATTERN, 0, size);

		if (buffer.is_nil () == false && size) {
			SynKeys keys;
			std::vector <GCL::StrVector> values;
			this->init_syns (buffer->get_data (), size, keys, values);

			std::sort (keys.begin (), keys.end (), PatternCompare ());

			size_t sz = keys.size ();

			m_templates_syns.resize (sz);

			for (size_t i = 0; i < sz; ++i) {
				m_templates_syns [i].key = keys [i].key;
				m_templates_syns [i].data.swap (values [keys [i].i]);
				GCL::to_upper (m_templates_syns [i].key);
			}
		}
	}
	//#UC END# *4EBC013F014A*
}

// загрузка данных дл€ алгоритма модификации значений релевантности
void DBCommunicator_i::load_tune_data (DBCore::IIndex* index) {
	//#UC START# *4EBC01BE002D*
#ifdef _DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	DBCore::Store* str = index->open_stream (AUX_RELEVANCY_CALCULATED_CHANGES, 0);

	if (str) {
		DBCore::RelTuneData tune_data;
		tune_data.reserve (3000000);

		int rel_value;
		long count, docs_count, packed_size;

		str->Read (&count, sizeof (count));

		for (int i = 0; i < count; ++i) {
			str->Read (&rel_value, sizeof (rel_value));
			str->Read (&docs_count, sizeof (docs_count));
			str->Read (&packed_size, sizeof (packed_size));

			Core::Aptr <long, Core::ArrayDeleteDestructor <long> > docs = new long [docs_count + 1];

			if (packed_size) {
				Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buf = new char [packed_size];
				str->Read (buf.inout (), packed_size);
				G_UNZIP (buf.inout (), packed_size, (char*) (docs.inout ()), docs_count * sizeof (long));
			} else {
				str->Read (docs.inout (), docs_count * sizeof (long));
			}

			DBCore::RelPair pair;
			pair.rel = (short) (rel_value & 0xFFFF);

			if (tune_data.empty ()) {
				tune_data.resize (docs_count, pair);

				for (long j = 0; j < docs_count; ++j) {
					tune_data [j].id = (docs.in ()) [j];
				} 
			} else {
				DBCore::RelTuneData tmp;
				tmp.reserve (docs_count);

				DBCore::RelTuneData::iterator it = tune_data.begin (), it_end = tune_data.end ();

				long* cur = docs.in (); 
				long* end = docs.in () + docs_count;

				for (; cur != end; ++cur) {
					it = std::find_if (it, it_end, boost::lambda::_1 >= *cur);

					if (it == it_end) {
						break;
					} else if (*cur == (long) it->id) {
						it->rel += (short) (rel_value & 0xFFFF);
					} else {
						pair.id = (DBCore::DocId) *cur;
						tmp.push_back (pair);
					}
				}

				if (cur != end) {
					if (tmp.empty () == false) {
						size_t middle = tune_data.size ();
						tune_data.insert (tune_data.end (), tmp.begin (), tmp.end ());
						std::inplace_merge (tune_data.begin (), tune_data.begin () + middle, tune_data.end ());
					}

					{
						DBCore::RelTuneData _tmp (std::distance (cur, end), pair);
						tmp.swap (_tmp);
					}

					for (it = tmp.begin (); cur != end; ++cur, ++it) {
						it->id = (DBCore::DocId) *cur;
					}
				}

				size_t middle = tune_data.size ();
				tune_data.insert (tune_data.end (), tmp.begin (), tmp.end ());
				std::inplace_merge (tune_data.begin (), tune_data.begin () + middle, tune_data.end ());
			}
		}

		index->close_stream (str);

		m_tune_data = tune_data;
	}
	//#UC END# *4EBC01BE002D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextSearch::DBComm::IDBCommunicator
// стоп-слова и стоп-фразы
const GCL::StrVector& DBCommunicator_i::get_exclude_data () const {
	//#UC START# *4B67DCC30276_4EBBDD2C01CE*
	return m_excluded;
	//#UC END# *4B67DCC30276_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// устойчивые словосочетани€
const GCL::StrVector& DBCommunicator_i::get_hard_phrases () const {
	//#UC START# *500018D200C0_4EBBDD2C01CE*
	return m_hard_phrases;
	//#UC END# *500018D200C0_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// длины блоков приписанных к позици€м из невидимого текста
const ContextSearch::Defs::InvisibleBlocks& DBCommunicator_i::get_invisible_blocks () const {
	//#UC START# *4CCAB28003E5_4EBBDD2C01CE*
	return m_invisible_blocks;
	//#UC END# *4CCAB28003E5_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// "баллы релевантности" дл€ позиций из простого невидимого текста документа
const ContextSearch::Defs::InvisibleRel& DBCommunicator_i::get_invisible_rel () const {
	//#UC START# *4CDA94F802E8_4EBBDD2C01CE*
	return m_invisible_rel;
	//#UC END# *4CDA94F802E8_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// фразальные замены
const ContextSearch::DBComm::StrPairVector& DBCommunicator_i::get_phrasal_replacement () const {
	//#UC START# *53EB7B910025_4EBBDD2C01CE*
	return m_phrasal_pair;
	//#UC END# *53EB7B910025_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// синонимы
const ContextSearch::DBComm::Synonyms& DBCommunicator_i::get_syns () const {
	//#UC START# *4BC867480074_4EBBDD2C01CE*
	return m_syns;
	//#UC END# *4BC867480074_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// шаблоны частиречных св€зей
const DBCore::PSDTemplates& DBCommunicator_i::get_templates () const {
	//#UC START# *4D2ECD830237_4EBBDD2C01CE*
	return m_templates;
	//#UC END# *4D2ECD830237_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// шаблонные синонимы
const ContextSearch::DBComm::Synonyms& DBCommunicator_i::get_templates_syns () const {
	//#UC START# *535691C20306_4EBBDD2C01CE*
	return m_templates_syns;
	//#UC END# *535691C20306_4EBBDD2C01CE*
}

// implemented method from ContextSearch::DBComm::IDBCommunicator
// данные дл€ алгоритма модификации значений релевантности
const DBCore::RelTuneData& DBCommunicator_i::get_tune_data () const {
	//#UC START# *53834CDE025C_4EBBDD2C01CE*
	return m_tune_data;
	//#UC END# *53834CDE025C_4EBBDD2C01CE*
}
} // namespace DBComm_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

