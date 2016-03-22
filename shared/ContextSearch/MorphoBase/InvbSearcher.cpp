////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/InvbSearcher.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::InvbSearcher
//
// Поиск невидимых блочных вхождений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/InvbSearcher.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/ContextUtility.h"

//#UC START# *56B48AF00107_CUSTOM_INCLUDES*
#include <iterator>

#include "boost/bind.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
//#UC END# *56B48AF00107_CUSTOM_INCLUDES*

namespace ContextSearch {

//#UC START# *56B48AF00107*
struct CompareEntries : public std::binary_function <DBComm::Entry, DBComm::Entry, bool> {
	bool operator () (const DBComm::Entry& x, const DBComm::Entry& y) const {
		return x.pos < y.pos;
	}
};

struct RelCalc {
	size_t operator () (unsigned long first, const DBComm::Entry& second) const {
		return first + second.rel;
	}
};

struct _Entries {
	DBComm::Entries entries;
	std::vector <size_t> positions;
};

////////////////////////////////////////////////////////////////////////////////////////////////

struct Helper {
	static void print (const Relevancy::BlockEntries& data) {
		std::cout << std::endl << std::endl;

		for (Relevancy::BlockEntries::const_iterator it = data.begin (); it != data.end (); ++it) {
			std::cout << "pos:" << it->pos << ", rel: " << it->rel << ", len: " << it->len << ", rest: ";
			std::copy (it->rest.begin (), it->rest.end (), std::ostream_iterator <Defs::Position> (std::cout, ","));
			std::cout << std::endl;
		}
	}

	static void print_entries (const _Entries& val)	{
		const DBComm::Entries& entries = val.entries;
		const std::vector <size_t>& positions = val.positions;

		GDS_ASSERT (entries.size () == positions.size ());

		for (size_t i = 0; i < entries.size (); ++i) {
			std::cout << entries [i].pos << ' ';
		}

		std::cout << "    pos: ";
		std::copy (val.positions.begin (), val.positions.end (), std::ostream_iterator <size_t> (std::cout, ","));
		std::cout << std::endl;
	}

	static void print_markup (const std::vector <Relevancy::Mark>& in) {
		std::cout << std::endl << in.size () << ": ";

		for (std::vector <Relevancy::Mark>::const_iterator it = in.begin (); it != in.end (); ++it) {
			if (*it == Relevancy::mt_None) {
				std::cout << "space ";
			} else if (*it == Relevancy::mt_Strong) {
				std::cout << "strong ";
			} else if (*it == Relevancy::mt_Frame) {
				std::cout << "frame ";
			}
		}

		std::cout << std::endl;
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////

class RequestInflate {
public:
	static GCL::StrVector* execute (const std::string& in) {
		Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

		char delim = -1;

		for (std::string::const_iterator f_it, it = in.begin (); it != in.end ();) {
			it = std::find_if (f_it = it, in.end (), boost::is_any_of (" -~"));

			RequestInflate::add (
				boost::trim_copy_if (std::string (f_it, it), boost::is_any_of ("()")), delim, *ret
			);

			if (it != in.end ()) {
				delim = *it;
				++it;
			}
		}

		return ret._retn ();
	}

	static GCL::StrVector* split (const std::string& in) {
		Core::Aptr <GCL::StrVector> ret = new GCL::StrVector ();

		boost::split (*ret, in, boost::is_any_of (","));

		for (GCL::StrVector::iterator it = ret->begin (); it != ret->end (); ++it) {
			boost::trim_if (*it, boost::is_any_of ("()"));
		}

		return ret._retn ();
	}

private:
	static void add (const std::string& in, char delim, GCL::StrVector& out) {
		GCL::StrVector parts;
		boost::split (parts, in, boost::is_any_of (","));

		if (out.empty ()) {
			out.swap (parts);
		} else {
			GCL::StrVector tmp;

			for (GCL::StrVector::const_iterator it = out.begin (); it != out.end (); ++it) {
				std::string prev = *it + delim;

				for (GCL::StrVector::const_iterator _it = parts.begin (); _it != parts.end (); ++_it) {
					tmp.push_back (prev + *_it);
				}
			}

			out.swap (tmp);
		}
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////

class RequestMarkup {
public:
	RequestMarkup (const std::vector <Relevancy::Mark>& markup) {
		for (size_t i = 0; i < markup.size (); ++i) {
			if (markup [i] == Relevancy::mt_None) {
				m_data.push_back (Template ());
			} 

			m_data.back ().data.push_back (i);
			m_data.back ().markup.push_back (markup [i]);
		}

		//std::for_each (m_data.begin (), m_data.end (), boost::bind (&RequestMarkup::print, this, _1, ','));
	}

public:
	bool check (const _Entries& val) {
		for (std::vector <size_t>::const_iterator it = val.positions.begin (); it != val.positions.end ();) {
			const Template& tmp = this->get (*it);

			if (tmp.data.empty () == false) {
				for (std::vector <size_t>::const_iterator _it = tmp.data.begin (); _it != tmp.data.end (); ++_it, ++it) {
					if (it == val.positions.end () || *it != *_it) {
						return false;
					}
				}

				//print (tmp, ':'); Helper::print_entries (val); std::cout << '\n';

				for (size_t i = 0; i < tmp.markup.size (); ++i) {
					if (tmp.markup [i] != Relevancy::mt_None) {
						GDS_ASSERT (i);
						size_t cur = val.entries [i].pos;
						size_t prev = val.entries [i - 1].pos;

						if (tmp.markup [i] == Relevancy::mt_Strong) {
							if (cur != prev + 1) {
								return false;
							}
						} else if (tmp.markup [i] == Relevancy::mt_Frame) {
							if (cur > prev) {
								if (cur - prev > 2) {
									return false;
								}
							} else {
								if (prev - cur > 2) {
									return false;
								}
							}
						} 
					}
				}
			} else {
				return false;
			}
		}

		return true;
	}

private:
	struct Template {
		std::vector <size_t> data;
		std::vector <Relevancy::Mark> markup;
	};

	typedef std::vector <Template> Templates;

private:
	Templates m_data;

private:
	const Template& get (size_t pos) {
		for (std::vector <Template>::const_iterator it = m_data.begin (); it != m_data.end (); ++it) {
			if (it->data.front () == pos) {
				return *it;
			}
		}

		static Template fake_tmp;
		return fake_tmp;
	}

	void print (const Template& val, char delim) {
		for (size_t j = 0; j < val.data.size (); ++j) {
			if (j) {
				if (val.markup [j] == Relevancy::mt_Strong) {
					std::cout << "-";
				} else if (val.markup [j] == Relevancy::mt_Frame) {
					std::cout << "-";
				} else {
					std::cout << " ";
				}
			}

			std::cout << val.data [j];
		}

		std::cout << delim;
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////

class Evaluator {
public:
	Evaluator (const std::vector <Relevancy::Mark>& markup, size_t context_len) 
		: m_context_len (context_len) 
		, m_markup (markup)
	{
		m_data.reserve (32);
	}

public:
	Relevancy::BlockEntries* get (const DBComm::EntriesVector& data, const std::vector <size_t>& positions) {
		typedef std::vector <DBComm::Entries::const_iterator> Index;

		size_t i = 0, count = data.size (), pos = 0;

		Index index (count);

		for (i = 0; i < count; ++i) {
			index [i] = data [i].begin ();
		}

		unsigned long val, min;

		const unsigned long MAX_VAL = std::numeric_limits <unsigned long>::max ();

		for (; ;) {
			min = MAX_VAL;
			pos = 0;

			for (i = 0; i < count; ++i) {
				if (index [i] != data [i].end ()) {
					val = index [i]->pos; // в pos должны быть абсолютные значения (проверить)

					if (min > val) {
						min = val;
						pos = i;
					} 
				}
			}

			if (min == MAX_VAL) {
				break;
			}

			this->add (index [pos], pos);
			++index [pos];
		}

		return this->get (positions);
	}

private:
	void add (DBComm::Entries::const_iterator f_it, size_t pos) {
		if (m_data.empty () == false) {
			_EntriesVector tmp;

			for (_EntriesVector::const_iterator it = m_data.begin (); it != m_data.end (); ++it) {
				if (std::find (it->positions.begin (), it->positions.end (), pos) == it->positions.end ()) {
					const DBComm::Entry& last = it->entries.back ();

					if (last.pos + last.len > f_it->pos) {
						tmp.push_back (*it);
						tmp.back ().entries.push_back (*f_it);
						tmp.back ().positions.push_back (pos);
					}
				}
			}

			m_data.insert (m_data.end (), tmp.begin (), tmp.end ());
		}

		m_data.push_back (_Entries ());
		m_data.back ().entries.push_back (*f_it);
		m_data.back ().positions.push_back (pos);
	}

	Relevancy::BlockEntries* get (const std::vector <size_t>& positions) {
		//std::cout << std::endl << std::endl;
		//std::for_each (m_data.begin (), m_data.end (), boost::bind (&Helper::print_entries, _1));

		if (m_data.empty ()) {
			return 0;
		}

		Core::Aptr <Relevancy::BlockEntries> ret = new Relevancy::BlockEntries ();
		ret->reserve (m_data.size ());

		RequestMarkup request_markup (m_markup);

		for (size_t i = 0; i < m_data.size (); ++i) {
			const _Entries& cur = m_data [i];

			if (request_markup.check (cur) == false) {
				continue;
			}

			ret->push_back (Relevancy::BlockEntry ());

			Relevancy::BlockEntry& entry = ret->back ();

			// позиция блочного вхождения
			entry.pos = cur.entries.back ().pos;

			// длина блока
			entry.len = cur.entries.back ().len;

			// релевантность вхождения
			entry.rel = std::accumulate (cur.entries.begin (), cur.entries.end (), 0, RelCalc ());

			// остаток в тексте
			std::vector <size_t>::const_iterator it, beg = cur.positions.begin (), end = cur.positions.end ();

			for (size_t pos = 0; pos < m_context_len; ++pos) {
				for (it = beg; it != end; ++it) {
					if (positions [*it] == pos) {
						break;
					}
				}

				if (it == end) {
					entry.rest.push_back (pos);
				}
			}
		}

		//Helper::print (*ret);

		return ret._retn ();
	}

private:
	typedef std::vector <_Entries> _EntriesVector;

	_EntriesVector m_data;

	size_t m_context_len;

	const std::vector <Relevancy::Mark>& m_markup;
};

////////////////////////////////////////////////////////////////////////////////////////////////

class InvbStreamHelper {
public:
	static DBComm::InvisibleDataIndex::const_iterator open (
		const std::string& key, const DBComm::InvisibleDataIndex& index
	) {
		DBComm::InvisibleData item;
		item.key = key;
		return std::lower_bound (index.begin (), index.end (), item);
	}
};

InvbSearcher::Stream::Stream (const std::string& key, const DBComm::InvisibleDataIndex& index) {
	ContextUtility::MarkupCounters counters;
	ContextUtility::get_markup_counters (key, counters);

	if (counters.space || counters.frame) {
		GDS_ASSERT (0);
	} else if (counters.strong) {
		GCL::StrVector parts;
		boost::split (parts, key, boost::is_any_of ("-"));

		m_its.reserve (parts.size ());

		for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); ++it) {
			DBComm::InvisibleDataIndex::const_iterator _it = InvbStreamHelper::open (*it, index);

			if (_it != index.end () && _it->key == *it) {
				m_its.push_back (_it);
			} else {
				break;
			}
		}
		m_is_valid = (m_its.size () == parts.size ());
	} else {
		m_its.resize (1, InvbStreamHelper::open (key, index));
		m_is_valid = (m_its.front () != index.end () && m_its.front ()->key == key);
	}
}

const DBComm::Entries& InvbSearcher::Stream::get (DBComm::DocId id) {
	if (m_is_valid == false) {
		static const DBComm::Entries empty;
		return empty;
	} else if (m_its.size () == 1) {
		return this->get (*(m_its.front ()), id);
	} 

	m_cache.clear ();
	return this->get (id, DBComm::Entries (m_its.size ()), 0);
}

const DBComm::Entries& InvbSearcher::Stream::get (const DBComm::InvisibleData& data, DBComm::DocId id) {
	if (id <= data.ids.back ()) {
		DBCore::DocVector::const_iterator it = std::lower_bound (data.ids.begin (), data.ids.end (), id);

		if (it != data.ids.end () && *it == id) {
			return data.data [std::distance (data.ids.begin (), it)];
		}
	} else {
		m_is_valid = false;
	}

	static const DBComm::Entries empty;
	return empty;
}

const DBComm::Entries& InvbSearcher::Stream::get (DBComm::DocId id, DBComm::Entries chain, size_t pos) {
	if (pos < m_its.size ()) {
		const DBComm::Entries& data = this->get (*(m_its [pos]), id);

		for (DBComm::Entries::const_iterator it = data.begin (); it != data.end (); ++it) {
			if (pos) {
				if (it->pos > chain [pos - 1].pos) {
					if (chain [pos - 1].pos != it->pos - 1) { // строгость
						break;
					}
				} else {
					continue;
				}
			}

			chain [pos] = *it;
			this->get (id, chain, pos + 1);
		}
	} else {
		DBComm::Entry entry;

		entry.pos = chain [0].pos;
		entry.len = chain [0].len;
		entry.rel = std::accumulate (chain.begin (), chain.end (), 0, RelCalc ());

		m_cache.push_back (entry);
	}

	return m_cache;
}
//#UC END# *56B48AF00107*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InvbSearcher::InvbSearcher (const Search::RequestEx& request, DBComm::IDBCommunicator* comm)
//#UC START# *56B48B1E0065_BASE_INIT*
	: m_communicator (comm)
//#UC END# *56B48B1E0065_BASE_INIT*
{
	//#UC START# *56B48B1E0065_BODY*
	const DBComm::InvisibleDataIndex& index = m_communicator->get_invb_index ();

	if (index.empty () == false) {
		std::for_each (request.context.begin (), request.context.end ()
			, boost::bind (&InvbSearcher::add <GCL::StrSet>, this, _1, boost::cref (index))
		);

		m_markup.resize (request.context.size (), Relevancy::mt_None);

		const Relevancy::Data& data = request.data;

		{
			for (Relevancy::Positions::const_iterator it = data.strongs.begin (); it != data.strongs.end (); ++it) {
				m_markup [*it] = Relevancy::mt_Strong;
			}
		}

		{
			for (Relevancy::Frames::const_iterator it = data.frames.begin (); it != data.frames.end (); ++it) {
				for (size_t i = 1; i < it->count; ++i) {
					GDS_ASSERT (m_markup [it->pos + i] == Relevancy::mt_None && it->pos + i < m_markup.size ());
					m_markup [it->pos + i] = Relevancy::mt_Frame;
				}
			}
		}
	}
	//#UC END# *56B48B1E0065_BODY*
}

InvbSearcher::InvbSearcher (const GCL::StrVector& request, DBComm::IDBCommunicator* comm)
//#UC START# *56B48B4A019D_BASE_INIT*
	: m_communicator (comm)
//#UC END# *56B48B4A019D_BASE_INIT*
{
	//#UC START# *56B48B4A019D_BODY*
	const DBComm::InvisibleDataIndex& index = m_communicator->get_invb_index ();

	if (index.empty () == false) {
		m_data.resize (request.size ());

		for (size_t i = 0; i < request.size (); ++i) {
			m_data [i].push_back (Stream (request [i], index));
		}

		// разметки нет, ибо контекст включает либо леммы, либо индексированные нграммы
		m_markup.resize (request.size (), Relevancy::mt_None);
	}
	//#UC END# *56B48B4A019D_BODY*
}

InvbSearcher::InvbSearcher (const std::string& in, bool wo_split, DBComm::IDBCommunicator* comm)
//#UC START# *56D6FA7E02E6_BASE_INIT*
	: m_communicator (comm)
//#UC END# *56D6FA7E02E6_BASE_INIT*
{
	//#UC START# *56D6FA7E02E6_BODY*
	const DBComm::InvisibleDataIndex& index = m_communicator->get_invb_index ();

	if (wo_split) {
		this->add_span (in, index);
	} else {
		GCL::StrVector parts;
		boost::split (parts, in, boost::is_space ());

		std::for_each (parts.begin (), parts.end ()
			, boost::bind (&InvbSearcher::add_span, this, _1, boost::cref (index))
		);
	}
	//#UC END# *56D6FA7E02E6_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// add
void InvbSearcher::add_span (const std::string& in, const DBComm::InvisibleDataIndex& index) {
	//#UC START# *56D6FA9D0166*
	if (index.empty () == false) {
		ContextUtility::MarkupCounters counters;
		ContextUtility::get_markup_counters (in, counters);

		m_markup.push_back (Relevancy::mt_None);

		if (counters.space == 0 && counters.frame == 0) { // одиночная лемма, или н-грамма
			if (std::find (in.begin (), in.end (), ',') == in.end ()) {
				m_data.push_back (WStreams ());
				m_data.back ().push_back (Stream (in, index));
			} else {
				Core::Aptr <GCL::StrVector> ret = RequestInflate::execute (in);
				this->add <GCL::StrVector> (*ret, index);
			}
		} else {
			for (std::string::const_iterator f_it, it = in.begin (); it != in.end (); ) {
				it = std::find_if (f_it = it, in.end (), boost::is_any_of (" -~"));

				Core::Aptr <GCL::StrVector> ret = RequestInflate::split (std::string (f_it, it));
				this->add <GCL::StrVector> (*ret, index);

				if (it != in.end ()) {
					if (*it == '~') {
						m_markup.push_back (Relevancy::mt_Frame);
					} else if (*it == '-') {
						m_markup.push_back (Relevancy::mt_Strong);
					} else {
						m_markup.push_back (Relevancy::mt_None);
					}

					++it;
				}
			}
		}
	}
	//#UC END# *56D6FA9D0166*
}

// вхождения для заданного документа
Relevancy::BlockEntries* InvbSearcher::get (DBComm::DocId id) {
	//#UC START# *56B48B7C002D*
	if (m_data.empty ()) {
		return 0;
	}

	GDS_ASSERT (m_markup.size () == m_data.size ());

	std::vector <size_t> positions;
	positions.reserve (m_data.size ());

	DBComm::EntriesVector data;

	for (Streams::iterator it = m_data.begin (); it != m_data.end (); ++it) {
		DBComm::Entries entries;

		for (WStreams::iterator _it = it->begin (); _it != it->end (); ++_it) { // у слова может быть несколько лемм
			const DBComm::Entries& res = _it->get (id);

			if (res.empty () == false) {
				size_t middle = entries.size ();
				entries.insert (entries.end (), res.begin (), res.end ());

				if (middle) {
					std::inplace_merge (entries.begin (), entries.begin () + middle, entries.end (), CompareEntries ());
				}
			}
		}

		if (entries.empty () == false) {
			data.push_back (entries);
			positions.push_back (std::distance (m_data.begin (), it));
		}
	}

	return (data.empty ())? 0 : Evaluator (m_markup, m_data.size ()).get (data, positions);
	//#UC END# *56B48B7C002D*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

