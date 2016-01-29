////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Cache/Cache.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Cache::Cache
//
// Кэш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Cache/Cache.h"

//#UC START# *50AE53480198_CUSTOM_INCLUDES*
#include "shared/GCL/str/str_conv.h"

#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/BaseCache.h"

#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/join.hpp"
#include "boost/bind.hpp"
//#UC END# *50AE53480198_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *50AE53480198*
struct CompareByWords : public std::binary_function<std::string, std::string, bool> {
	bool operator () (const std::string& x, const std::string& y) const {
		size_t x_size = (x.empty ())? 0 : std::count_if (x.begin (), x.end (), boost::is_any_of (" -~")) + 1;
		size_t y_size = (y.empty ())? 0 : std::count_if (y.begin (), y.end (), boost::is_any_of (" -~")) + 1;

		if (x_size == y_size) {
			return (m_is_less)? (x.size () > y.size ()) : (x.size () > y.size ());
		} 

		return (m_is_less)? (x_size < y_size) : (x_size > y_size);
	}

	CompareByWords (bool is_less) : m_is_less (is_less) { }

private:
	bool m_is_less;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef Core::Aptr <char, Core::ArrayDeleteDestructor <char> > Buffer;

template <class Data>
static void read_doc_vector (DBCore::Store* store, Data& out) {
	size_t count = (size_t) store->Length () / sizeof (long);

	Core::Aptr <long, Core::ArrayDeleteDestructor <long> > buf =  new long [count + 1];
	store->Read (buf.inout (), store->Length ());

	out.insert (out.end (), buf.ptr (), buf.ptr () + count);
}

static DBCore::DocVector* get_type_docs (Index* index, const void* key) {
	Core::Aptr <DBCore::DocVector> ret = new DBCore::DocVector ();

	Stream* str = index->keyOpen (key, 0);

	if (str) {
		size_t item_size = sizeof (Ref), size = (size_t) str->Length ();

		Buffer buf = new char [size];
		str->Read (buf.inout (), size);

		ret->resize (size / item_size);

		DBCore::DocVector::iterator it = ret->begin (), it_end = ret->end ();

		for (char* ptr = buf.ptr (); it != it_end; ++it, ptr += item_size) {
			*it = *(long*) ptr;
		}

		index->Close (str);
	}

	return ret._retn ();
}

static void get_docs (SearchBase* base, const GCL::StrVector& types, std::vector <unsigned long>& out) {
	Index* index = base->FindIndex ("Type");

	size_t count = 0;

	for (BTIterator it (index); !it.End (); ++it) {
		HIndexKeyData* key = (HIndexKeyData*) it.Key ();

		std::string key_text = key->text + 4;

		GCL::StrVector::const_iterator _it = std::find (types.begin (), types.end (), key_text);

		if (_it != types.end ()) {
			Core::Aptr <DBCore::DocVector> res = get_type_docs (index, key);

			if (res->empty () == false) {
				size_t mid = out.size ();
				out.insert (out.end (), res->begin (), res->end ());

				if (mid) {
					std::inplace_merge (out.begin (), out.begin () + mid, out.end ());
				}
			}

			if (++count == types.size ()) {
				break;
			}
		}
	}
}

static bool is_digit (const std::string& str) {
	return std::find_if (str.begin (), str.end (), !boost::is_digit ()) == str.end ();
}

static size_t is_number (const char* request, std::string& num) {
	GDS_ASSERT (request);

	bool is_N = false;

	size_t ret = 0;
	std::string copy_req = request;

	num.clear ();

	GCL::to_upper (copy_req);

	GCL::StrVector pattern;
	boost::split (pattern, copy_req, boost::is_space ());

	if (pattern.empty ()) {
		return ret;
	}

	std::string word = pattern [0];

	if (word [0] == 'N' || word [0] == '№') {
		if (word.size () == 1) {
			if (pattern.size () == 1) {
				return 0;
			}
			is_N = true;
			word = pattern [1];
			ret = copy_req.find (word);
		} else {
			word = word.substr (1, word.size ());
			ret = 1;
		}
	}

	if (word.empty () == false && word [word.size () - 1] == '*') {
		return 0;
	}

	bool has_digit = std::find_if (word.begin (), word.end (), boost::is_from_range ('0', '9')) != word.end ();
	bool is_number_ext = (has_digit && !strchr (word.c_str (), '%'));

	if (is_N || is_number_ext) {
		std::string digit, part;

		if (word [0] >= '0' && word [0] <= '9') {
			part = boost::trim_left_copy_if (word, boost::is_from_range ('0', '9'));
			digit = word.substr (0, word.size () - part.size ());

			if (Search::is_digit (digit)) {
				if (part == "-Н") {
					num = digit + "Н";
				} else if (part == "-AP" || part == "AP") {
					num = digit + "-ФЗ";
				} else if (
					part == "-ОЕ"
					|| part == "-Е"
					|| part == "-ОГО"
					|| part == "-ИЙ"
					|| part == "-ЫЙ"
					|| part == "-АЯ"
					|| part == "-ГО"
					|| part == "-ЕГО"
					|| part == "-ИХ"
					|| part == "-ЫХ"
				) {
					num = digit;
				} else if (part == "КЗ" || part == "ФЗ" || part == "ОЗ") {
					num = digit + "-" + part;
				}
			}
		} else {
			digit = boost::trim_left_copy_if (word, !boost::is_from_range ('0', '9'));

			part = word.substr (0, word.size () - digit.size ());

			if (Search::is_digit (digit) && part.size () <= 3) {
				if (*(part.rbegin ()) == '-') {
					part.erase (part.size () - 1);
				}
				if (part == "КЗ" || part == "ОЗ" || part == "ФЗ") {
					num = digit + "-" + part;
				} else if (part == "AP") {
					num = digit + "-" + "ФЗ";
				}
			}
		}

		ret += word.size ();

		word.erase (std::remove (word.begin (), word.end (), '!'), word.end ());

		if (num.empty ()) {
			num += word;
		} 

		while (*(request + ret) == ' ') {
			++ret;
		}
	} else if (pattern.size () > 1) {
		ret = 0;

		if (Search::is_digit (word)) {
			if (pattern [1] == "КЗ" || pattern [1] == "ОЗ" || pattern [1] == "ФЗ") {
				num = word + "-" + pattern [1];
			} else if (pattern [1] == "Н") {
				num = word + "Н";
			} else if (pattern [1] == "AP") {
				num = word + "-" + "ФЗ";
			}
		} else if (Search::is_digit (pattern [1])) {
			if (word == "КЗ" || word == "ОЗ" || word == "ФЗ") {
				num = pattern [1] + "-" + word;
			} else if (word == "ИНВ" || word == "Т") {
				num = word + "-" + pattern [1];
			} else if (word == "AP") {
				num = pattern [1] + "-" + "ФЗ";
			}
		}

		if (num.empty () == false) {
			if (pattern.size () > 2) {
				ret = copy_req.find (pattern [2]);
			} else {
				ret = copy_req.size ();
			}
		}
	}

	if (num.empty () == false) {
		std::string from = "ABCEHKMPTXIOОЗ", to = "АВСЕНКМРТХ1003";

		for (std::string::iterator it = num.begin (); it != num.end (); ++it) {
			size_t pos = from.find (*it);
			*it = (pos != std::string::npos)? to [pos] : *it;
		}
	}

	return ret;
}

static GCL::StrVector* get_numbers (const std::string& str) {
	std::string val;

	GCL::StrVector parts;
	boost::split (parts, str, boost::is_space ());

	for (GCL::StrVector::iterator it = parts.begin (); it != parts.end (); ++it) {
		boost::trim_if (*it, boost::is_punct ());
	}

	const std::string str_copy = boost::join (parts, " ");

	Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

	for (std::string::const_iterator it = str_copy.begin (); it != str_copy.end (); ) {
		size_t pos = Search::is_number (&(*it), val);

		if (pos) {
			ret->push_back (val);
			it += pos;
		} else {
			it = std::find (it, str_copy.end (), ' ');
			if (it != str_copy.end ()) {
				++it;
			}
		}
	}

	return ret._retn ();
}

static bool is_informer (const std::string& str, const std::string& inf) {
	if (str [0] == inf [0]) {
		if (inf.size () == str.size ()) {
			return (inf == str);
		} else if (inf.size () < str.size () && str [inf.size ()] == ' ') {
			return (inf.compare (0, inf.size (), str, 0, inf.size ()) == 0);
		}
	}

	return false;
}

DBCore::RelTuneData* Cache::get_informers (SearchBase* base, const std::string& in) {
	Core::Aptr <DBCore::RelTuneData> ret = new DBCore::RelTuneData ();

	GCL::StrVector parts;
	boost::split (parts, in, boost::is_any_of (" ./-~"));
	{
		size_t count = 0;

		for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
			if (*(it->rbegin ()) == '*') {
				++count;
			}
		}

		if (count == parts.size ()) {
			return ret._retn ();
		}
	}

	this->load_informers (base);

	if (m_informers.empty ()) {
		return ret._retn ();
	}

	using namespace SearchAdapterLib;

	Adapter::IStrings_var res;
	{
		const std::string fix = boost::join (parts, " ");
		Adapter::IHelper_var helper = SearchAdapter::instance ()->get (
			base->abstract_base (), BaseCache::instance ()->get_morpho_cache_ptr ()
		);
		res = helper->transform (fix);
	}

	if (res.is_nil ()) {
		return 0;
	}

	Informers informers;

	std::for_each (res->data ().begin (), res->data ().end ()
		, boost::bind (&Cache::add, this, _1, boost::ref (informers))
	);

	if (informers.empty () == false) {
		DBCore::RelTuneData tmp;
		{
			for (Informers::const_iterator it = informers.begin (); it != informers.end (); ++it) {
				tmp.insert (tmp.end (), it->data.begin (), it->data.end ());
			}
		}

		std::sort (tmp.begin (), tmp.end ());

		ret->reserve (tmp.size ());

		for (DBCore::RelTuneData::const_iterator it = tmp.begin (); it != tmp.end (); ++it) {
			if (ret->empty () == false && ret->back ().id == it->id) {
				if (ret->back ().rel < it->rel) {
					ret->back ().rel = it->rel;
				}
			} else {
				ret->push_back (*it);
			}
		}
	}

	return ret._retn ();
}

void Cache::get_type_data (SearchBase* base, const std::string& in, std::vector <unsigned long>& out) {
	this->load_doc_types (base);

	TypesMap::const_iterator f_it = m_types.end ();

	if (m_types.empty () == false) {
		size_t max_length = 0;
		{
			for (TypesMap::const_iterator it = m_types.begin (); it != m_types.end (); ++it) {
				if (max_length < it->first.size ()) {
					max_length = it->first.size ();
				}
			}
		}

		GCL::StrVector parts;
		boost::split (parts, in, boost::is_punct () || boost::is_space ());

		std::string str;

		for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
			str += *it;
			f_it = m_types.find (str);

			if (f_it != m_types.end () || str.size () >= max_length) {
				break;
			}

			str += " ";
		}
	}

	if (f_it != m_types.end ()) {
		try {
			Search::get_docs (base, f_it->second, out);
		} catch (...) {
			LOG_UEX ((GDS_CURRENT_FUNCTION));
		}
	}
}

void Cache::get_code_data (SearchBase* base, const std::string& in, std::vector <unsigned long>& out) {
	try {
		Core::Aptr <GCL::StrVector> numbers = Search::get_numbers (in);

		if (numbers.is_nil () == false && numbers->empty () == false) {
			Index* index = base->FindIndex ("Number");

			for (GCL::StrVector::const_iterator it = numbers->begin (); it != numbers->end (); ++it) {
				Stream* str = index->OpenN (it->c_str (), 0);

				if (str) {
					size_t mid = out.size ();

					Search::read_doc_vector <std::vector <unsigned long> > (str, out);

					if (mid) {
						std::inplace_merge (out.begin (), out.begin () + mid, out.end ());
					} 

					index->Close (str);
				}
			}
		} 
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
}
//#UC END# *50AE53480198*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Cache::Cache ()
//#UC START# *50AE537803A3_BASE_INIT*
//#UC END# *50AE537803A3_BASE_INIT*
{
	//#UC START# *50AE537803A3_BODY*
	//#UC END# *50AE537803A3_BODY*
}

Cache::~Cache () {
	//#UC START# *50AE53480198_DESTR_BODY*
	this->reset ();
	//#UC END# *50AE53480198_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить информер
void Cache::add (const std::string& in, Informers& data) {
	//#UC START# *53F453F60121*
	InformerNode node;
	Informers::iterator it, it_end = m_informers.end ();

	GCL::StrVector parts;
	boost::split (parts, in, boost::is_punct () || boost::is_space ());

	const std::string fix = boost::join (parts, " ");

	for (const char* req = fix.c_str (); ;) {
		node.key = req;

		it = std::lower_bound (m_informers.begin (), it_end, node);

		for (; it != it_end; ++it) {
			if (is_informer (node.key, it->key)) {
				break;
			}
		}

		if (it != it_end) {
			if (std::find (data.begin (), data.end (), *it) == data.end ()) {
				data.push_back (*it);
			}

			if (node.key.size () == it->key.size ()) {
				break;
			}

			req += it->key.size () + 1;
		} else {
			size_t offset = node.key.find (' ');

			if (offset == std::string::npos) {
				break;
			}

			req += offset + 1;
		}
	}
	//#UC END# *53F453F60121*
}

// "плохие" документы
const Cache::LongVector& Cache::get_bad_docs () {
	//#UC START# *55C8A089028F*
	GUARD (m_mutex);

	if (m_bad_docs.empty ()) {
		m_bad_docs.reserve (1200000);

		const DBCore::RelTuneData& data = SearchAdapter::instance ()->get_tune_data ();

		for (DBCore::RelTuneData::const_iterator it = data.begin (); it != data.end (); ++it) {
			if (it->rel < -25) {
				m_bad_docs.push_back (long (it->id));
			}
		}
	}

	return m_bad_docs;
	//#UC END# *55C8A089028F*
}

// расширения запроса для поиска в заголовках
const GCL::StrVector& Cache::get_ext_request (SearchBase* base) {
	//#UC START# *55B5D03B000F*
	GUARD (m_mutex);

	if (m_ext_request.empty ()) {
		long size = 0;

		Buffer data = this->load_aux (base, AUX_NAME_SEARCH, size);

		for (const char* ptr = data.in (); ptr - data.in () < size; ) {
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
					m_ext_request.push_back (str);
				}
			}
		}

		std::sort (m_ext_request.begin (), m_ext_request.end (), CompareByWords (false));
	}

	return m_ext_request;
	//#UC END# *55B5D03B000F*
}

// чтение из Aux
char* Cache::load_aux (SearchBase* base, const void* key, long& size) {
	//#UC START# *50D9C9F8002C*
	Buffer ret;

	try {
		Index* index = base->FindIndex ("Aux");

		Stream* str = index->Open (key);

		if (str) {
			size = str->Length ();
			ret = new char [size + 4];
			str->Read (ret.inout (), size);
			index->Close (str);
		}
	} catch (...) {
		LOG_UEX (("%s: key %s", GDS_CURRENT_FUNCTION, (char*) key));
	}

	return ret._retn ();
	//#UC END# *50D9C9F8002C*
}

// загрузка типов документа
void Cache::load_doc_types (SearchBase* base) {
	//#UC START# *55C4D30A0161*
	GUARD (m_mutex);

	if (m_types.empty ()) {
		long size = 0;

		Buffer data = this->load_aux (base, AUX_SYN_TYPE, size);

		if (data.is_nil () == false) {
			TypesMap::iterator cur_it;

			for (const char* ptr = data.in (); ptr - data.in () < size; ) {
				std::string key = ptr;

				GCL::to_upper (key);

				ptr += (key.size () + 1);

				cur_it = m_types.insert (TypesMap::value_type (key, GCL::StrVector ((size_t) *ptr))).first;

				++ptr;

				for (; *ptr == 0; ++ptr);

				GCL::StrVector::iterator it = cur_it->second.begin (), it_end = cur_it->second.end ();

				for (; it != it_end; ++it) {
					*it = ptr;
					ptr += (it->size () + 1);
				}
			}
		}
	}
	//#UC END# *55C4D30A0161*
}

// загрузка информеров
void Cache::load_informers (SearchBase* base) {
	//#UC START# *53F0CFE20033*
	GUARD (m_mutex);

	if (m_informers.empty ()) {
		long size = 0;

		Buffer data = this->load_aux (base, AUX_INFORMERS_EX, size);

		if (data.is_nil () == false) {
			const size_t reserve_size = 140000;

			SortAttr attr;

			std::vector <SortAttr> attrs;
			attrs.reserve (reserve_size);

			attr.i = 0;

			InformerNode node;
			Informers informers;
			informers.reserve (reserve_size);

			DBCore::RelPair pair;

			for (const char* ptr = data.in (); ptr - data.in () < size; ) {
				node.key = ptr;

				ptr += strlen (ptr) + 1;
				ptr += strlen (ptr) + 1;

				pair.id = *(long*) ptr;

				ptr += sizeof (Ref);
			
				long rele = *(long*) ptr;
				pair.rel = (short) (rele & 0xFFFF);

				ptr += sizeof (long);

				if (informers.empty () == false && informers.back ().key == node.key) {
					informers.back ().data.push_back (pair);
				} else if (node.key.empty () == false) {
					node.data.clear ();
					node.data.push_back (pair);
					informers.push_back (node);

					attr.ch = node.key.at (0);
					attr.len = node.key.size ();
					attrs.push_back (attr);

					++attr.i;
				}
			}

			GDS_ASSERT (attrs.size () == informers.size ());

			std::sort (attrs.begin (), attrs.end ());

			m_informers.resize (attrs.size ());

			for (size_t i = 0; i < informers.size (); ++i) {
				m_informers [i].key = informers [attrs [i].i].key;
				m_informers [i].data = informers [attrs [i].i].data;
			}
		}
	}
	//#UC END# *53F0CFE20033*
}

// очистить
void Cache::reset () {
	//#UC START# *50AE68980201*
	GUARD (m_mutex);

	m_informers.clear ();
	m_types.clear ();

	LongVector ().swap (m_bad_docs);
	GCL::StrVector ().swap (m_ext_request);
	//#UC END# *50AE68980201*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

