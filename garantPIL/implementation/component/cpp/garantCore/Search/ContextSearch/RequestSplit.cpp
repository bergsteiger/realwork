////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/RequestSplit.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::RequestSplit
//
// Разделение запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/ContextSearch/RequestSplit.h"
// by <<uses>> dependencies
#include "garantCore/Search/Cache/Cache.h"
#include "boost/algorithm/string/classification.hpp"
#include "boost/bind.hpp"
#include "shared/GCL/str/str_conv.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/Morpho/Facade/Cache.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/DBComm.h"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// validate
void RequestSplit::validate (const std::string& str, std::string& out) {
	//#UC START# *55B77C99000D*
	size_t counter = 0;

	for (std::string::const_iterator it = str.begin (), first_it = it; ; ) {
		if (it == str.end () || *it == ' ') {
			if (out.empty () == false && *(out.rbegin ()) != '-') {
				out += ' ';
			}

			out.append (first_it, it);
			++counter;

			for (; it != str.end (); ++it) {
				if (*it != ' ') {
					break;
				}
			}

			if (it == str.end () || counter >= DBCore::MAX_WORDS_OF_REQUEST) {
				break;
			}

			first_it = it;
		} else {
			++it;
		}
	}

	GCL::to_upper (out);
	//#UC END# *55B77C99000D*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RequestSplit::RequestSplit (Base* base)
//#UC START# *55B5E95701CF_BASE_INIT*
	: m_data (Cache::instance ()->get_ext_request (base))
//#UC END# *55B5E95701CF_BASE_INIT*
{
	//#UC START# *55B5E95701CF_BODY*
	DBCore::IBase_var _base = DBCore::DBFactory::make (base);
	m_normalizer = Morpho::Factory::make (Morpho::get_cache (_base.in ()));
	//#UC END# *55B5E95701CF_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// execute
bool RequestSplit::execute (const std::string& req, std::string& name_part, std::string& text_part) {
	//#UC START# *55B5EB6603E7*
	if (std::count (req.begin (), req.end (), '\"') == 2) {
		return false;
	}

	if (req.rfind ("--") != std::string::npos || m_data.empty ()) {
		return false;
	}

	std::string rest, fixed;

	this->validate (req, fixed);

	for (std::string::iterator _it = fixed.begin (); _it != fixed.end (); ) {
		if (*_it == ' ') {
			++_it;
			continue;
		}

		GCL::StrVector::const_iterator it;

		size_t count = std::count_if (_it, fixed.end (), boost::is_any_of (" -"));

		for (it = m_data.begin (); it != m_data.end (); ++it) {
			size_t _count = std::count_if (it->begin (), it->end (), boost::is_any_of (" -"));

			if (_count <= count) {
				break;
			}
		}

		if (it != m_data.end ()) {
			it = std::find_if (it, m_data.end (), boost::bind (
				&RequestSplit::is_equal, this, std::string (_it, fixed.end ()), _1, boost::ref (rest))
			);

			if (it != m_data.end ()) {
				if (name_part.empty () == false) {
					name_part += ' ';
				}

				name_part += rest;
				_it += rest.size ();
				continue;
			} 
		}

		if (text_part.empty () == false) {
			text_part += ' ';
		}

		std::string::iterator f_it = std::find (_it, fixed.end (), ' ');
		text_part.append (_it, f_it);
		_it = f_it;
	}

	return (name_part.empty () == false && text_part.empty () == false);
	//#UC END# *55B5EB6603E7*
}

// is_equal
bool RequestSplit::is_equal (const std::string& str, const std::string& syn, std::string& out) {
	//#UC START# *55B5F125009F*
	std::string::const_iterator str_it_, str_it = str.begin ();
	std::string::const_iterator syn_it_, syn_it = syn.begin ();

	for (; ; ++str_it, ++syn_it) {
		if (*syn_it != '<' && *syn_it != *str_it) {
			return false;
		}

		str_it = std::find_if (str_it_ = str_it, str.end (), boost::is_any_of (" -"));
		syn_it = std::find_if (syn_it_ = syn_it, syn.end (), boost::is_any_of (" -"));

		if (syn_it != syn.end ()) {
			if (str_it == str.end ()) {
				return false;
			} else if (*str_it != *syn_it) {
				return false;
			}
		} else if (str_it != str.end ()) {
			if (*str_it == '-' || *str_it == '~') {
				return false;
			}
		}

		if (std::count (syn_it_, syn_it, '<')) {
			if (*(syn_it_ + 1) == 'X') {
				if (std::find_if (str_it_, str_it, !boost::is_digit ()) != str_it) {
					return false;
				}
			} else {
				GDS_ASSERT (0);
			}
		} else {
			Core::Aptr <GCL::StrSet> res = m_normalizer->execute (std::string (str_it_, str_it), false);

			const std::string& first = *(res->begin ());

			if (first.size () != std::distance (syn_it_, syn_it)) {
				return false;
			}

			if (std::equal (first.begin (), first.end (), syn_it_) == false) {
				return false;
			} 
		}

		if (syn_it == syn.end ()) {
			break;
		}
	}

	out.assign (str.begin (), str_it);
	return true;
	//#UC END# *55B5F125009F*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

