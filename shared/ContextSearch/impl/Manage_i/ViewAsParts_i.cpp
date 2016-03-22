////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsParts_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsParts_i
//
// Представление запроса в виде фразальных частей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsParts_i.h"
// by <<uses>> dependencies
#include "boost/lambda/lambda.hpp"
#include "boost/lambda/bind.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/join.hpp"
#include "boost/xpressive/xpressive.hpp"
#include "boost/bind.hpp"
#include "shared/ContextSearch/Common/Comparators.h"
#include "shared/ContextSearch/Common/ContextUtility.h"

namespace ContextSearch {
namespace Manage_i {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// добавить фразу
void ViewAsParts_i::add_phrase (const GCL::StrVector& in, PhraseList& out) {
	//#UC START# *528A2C210021*
	if (out.empty () == false) {
		PhraseList::iterator it = out.begin ();

		if (in.size () == 3 && ContextUtility::is_date (in)) {
			ViewAsParts_i::add_phrase (in, *it);
			return;
		}

		for (; it != out.end (); ++it) {
			for (size_t i = 0; i < it->size (); ++i) {
				GCL::StrSet& cur = it->at (i);
				if (std::find (cur.begin (), cur.end (), in [i]) != cur.end ()) {
					ViewAsParts_i::add_phrase (in, *it);
					return;
				}
			}
		}
	}

	out.push_back (Search::PhraseEx (in.size ()));
	ViewAsParts_i::add_phrase (in, out.back ());
	//#UC END# *528A2C210021*
}

// добавить фразу
void ViewAsParts_i::add_phrase (const GCL::StrVector& in, Search::PhraseEx& out) {
	//#UC START# *528A39530159*
	for (size_t i = 0; i < out.size (); ++i) {
		out [i].insert (in [i]);
	}
	//#UC END# *528A39530159*
}

// строгая фраза
bool ViewAsParts_i::is_strong (const std::string& str) {
	//#UC START# *56AF6495031F*
	if (str != "-") {
		if (std::find (str.begin (), str.end (), '-') != str.end ()) {
			return (std::find (str.begin (), str.end (), ' ') == str.end ());
		}
	}
	return false;
	//#UC END# *56AF6495031F*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ViewAsParts_i::ViewAsParts_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer)
//#UC START# *5273986F01D9_52739AA90277_52739B1C03DF_BASE_INIT*
	: m_communicator (comm)
//#UC END# *5273986F01D9_52739AA90277_52739B1C03DF_BASE_INIT*
{
	//#UC START# *5273986F01D9_52739AA90277_52739B1C03DF_BODY*
	GDS_ASSERT (comm);
	GDS_ASSERT (normalizer);

	m_synonymizer = new Synonymizer (comm, normalizer);
	//#UC END# *5273986F01D9_52739AA90277_52739B1C03DF_BODY*
}

ViewAsParts_i::~ViewAsParts_i () {
	//#UC START# *52739B1C03DF_DESTR_BODY*
	//#UC END# *52739B1C03DF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить
void ViewAsParts_i::add (const Search::StringSet& in) {
	//#UC START# *528A0160039C*
	Search::Phrase phrase;
	phrase.reserve (in.size ());

	for (Search::StringSet::const_iterator it = in.begin (); it != in.end (); ++it) {
		if (it->empty () == false && *it != "-") {
			phrase.push_back (*it);
		}
	}

	if (phrase.empty ()) {
		return;
	}

	m_was_compression |= this->deflate (phrase);

	std::sort (phrase.begin (), phrase.end (), CompareByWords (true));

	m_spans.push_back (phrase);

	//std::copy (phrase.begin (), phrase.end (), std::ostream_iterator <std::string> (std::cout, "; "));
	//std::cout << std::endl;
	//#UC END# *528A0160039C*
}

// сжатие фразы
bool ViewAsParts_i::deflate (GCL::StrVector& out) {
	//#UC START# *5286253E0122*
	if (out.size () == 1) {
		return false;
	}

	size_t prev_size = out.size ();

	typedef std::pair <GCL::StrVector, GCL::StrVector> _Pair;
	typedef std::map <std::string, Defs::Positions> Types;

	using namespace boost::xpressive;

	std::vector <_Pair> pairs;
	Types types;
	_Pair item;

	{
		Defs::Position i = 0;

		for (GCL::StrVector::const_iterator it = out.begin (); it != out.end (); ++it, ++i) {
			sregex re = repeat <1,10> ((set = ' ', '-', '~'));
			sregex_token_iterator end;

			item.first.assign (sregex_token_iterator (it->begin (), it->end (), re), end);
			item.second.assign (sregex_token_iterator (it->begin (), it->end (), re, -1), end);
			pairs.push_back (item);

			std::string key = (item.second.size () == 1)? "1" : boost::join (item.first, "");

			if (item.second.size () > 3) {
				if (std::find_if (key.begin (), key.end (), boost::is_any_of ("-~")) == key.end ()) {
					key = "2";
				}
			}

			Types::iterator _it = types.insert (Types::value_type (key, Defs::Positions ())).first;
			_it->second.push_back (i);
		}
	}

	GCL::StrVector tmp;

	for (Types::const_iterator it = types.begin (); it != types.end (); ++it) {
		size_t f_num = *(it->second.begin ());

		if (it->second.size () == 1) {
			tmp.push_back (out [f_num]);
		} else if (it->first == "1") {
			std::string str;

			for (Defs::Positions::const_iterator _it = it->second.begin (); _it != it->second.end (); ++_it) {
				if (_it != it->second.begin ()) {
					str += ',';
				}
				str += pairs [*_it].second.at (0);
			}

			tmp.push_back (str);
		} else if (it->first == "2") {
			for (Defs::Positions::const_iterator _it = it->second.begin (); _it != it->second.end (); ++_it) {
				tmp.push_back (boost::join ( pairs [*_it].second, " "));
			}
		} else {
			PhraseList list;
			{
				for (Defs::Positions::const_iterator _it = it->second.begin (); _it != it->second.end (); ++_it) {
					ViewAsParts_i::add_phrase (pairs [*_it].second, list);
				}
			} 

			for (PhraseList::const_iterator _it = list.begin (); _it != list.end (); ++_it) {
				std::string str;

				for (size_t i = 0; i < _it->size (); ++i) {
					const GCL::StrSet& cur = _it->at (i);

					for (GCL::StrSet::const_iterator __it = cur.begin (); __it != cur.end (); ++__it) {
						if (__it != cur.begin ()) {
							str += ',';
						}
						str += *__it;
					}

					if (i < it->first.size () && it->first != "1") {
						str += it->first.at (i);
					}
				}

				tmp.push_back (str);
			}
		}
	}

	out = tmp;

	return (out.size () != prev_size);
	//#UC END# *5286253E0122*
}

// создать контейнер спанов
bool ViewAsParts_i::make_spans (const GCL::StrVector& in) {
	//#UC START# *528613E2031C*
	GDS_ASSERT (in.empty () == false);

	Core::Aptr <Search::PhraseEx> res = m_synonymizer->get (in);

	if (res->size () == 1) {
		return false;
	}

	m_was_compression = false;

	std::string str;

	for (Search::PhraseEx::const_iterator it = res->begin (); it != res->end (); ++it) {
		if (it->size () == 1 && ViewAsParts_i::is_strong (*(it->begin ())) == false) {
			if (*(it->begin ()) != "-") {
				if (str.empty () == false) {
					str += " ";
				}

				str += *(it->begin ());
			}
		} else {
			if (str.empty () == false) {
				GCL::StrSet item;
				item.insert (str);
				str.clear ();
				this->add (item);
			}

			this->add (*it);
		}
	}

	if (str.empty () == false) {
		GCL::StrSet item;
		item.insert (str);
		this->add (item);
	}

	if (m_spans.size () > 1) {
		size_t count = 0;

		std::accumulate (m_spans.begin (), m_spans.end (), 0
			, boost::lambda::var (count) += boost::lambda::bind (&Search::Phrase::size, boost::lambda::_2)
		);

		return (count != m_spans.size ());
	}

	return false;
	//#UC END# *528613E2031C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Search::IRequestView
// создать
bool ViewAsParts_i::build (const Search::Phrase& in, const std::string& src) {
	//#UC START# *528CD00602B1_52739B1C03DF*
	try {
		return this->make_spans (in);
	} catch (Search::InvalidSpans&) {
		//LOG_I ((ex.what ()));
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return false;
	//#UC END# *528CD00602B1_52739B1C03DF*
}

// implemented method from Search::IRequestView
// список синонимичных
const Search::SplitRequests& ViewAsParts_i::get_sequence () const {
	//#UC START# *5273997201A4_52739B1C03DF*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *5273997201A4_52739B1C03DF*
}

// implemented method from Search::IRequestView
// спаны
const Search::Phrases& ViewAsParts_i::get_spans () const {
	//#UC START# *5273994602A8_52739B1C03DF*
	return m_spans;
	//#UC END# *5273994602A8_52739B1C03DF*
}

// implemented method from Search::IRequestView
// тип
Search::AlgorithmSelector ViewAsParts_i::get_type () const {
	//#UC START# *5280F02702AB_52739B1C03DF*
	return Search::as_Partial;
	//#UC END# *5280F02702AB_52739B1C03DF*
}
} // namespace Manage_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

