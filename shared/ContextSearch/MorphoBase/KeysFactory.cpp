////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/KeysFactory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::KeysFactory
//
// Фабрика ключей для хранилища
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/KeysFactory.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/classification.hpp"
#include "boost/bind.hpp"
#include "boost/algorithm/string/split.hpp"

//#UC START# *565C3ADC00FD_CUSTOM_INCLUDES*
#include "shared/Morpho/Common/Helper.h"
//#UC END# *565C3ADC00FD_CUSTOM_INCLUDES*

namespace ContextSearch {

//#UC START# *565C3ADC00FD*
//#UC END# *565C3ADC00FD*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// добавить варианты леммы
GCL::StrVector* KeysFactory::correct (const std::string& in) {
	//#UC START# *565C46FD00A5*
	using namespace Morpho;

	Core::Aptr <GCL::StrVector> ret;

	if (in.size () > 2 && (in [0] == '0' || in [0] == '3')) {
		if (std::find_if (in.begin () + 1, in.end (), boost::is_digit ()) == in.end ()) {
			if (in [0] == '3') {
				ret = new GCL::StrVector (1, in);
				Helper::to_cyr (ret->front ());
				ret->front ().at (0) = 'З';
			} else {
				ret = new GCL::StrVector (2, in);
				Helper::to_cyr (ret->front ());
				ret->front ().at (0) = 'О';
				Helper::to_lat (ret->back ());
				ret->back ().at (0) = 'O';
			}

			return ret._retn ();
		}
	}

	if (Helper::has_lat (in) && Helper::has_cyr (in)) {
		if (Helper::is_cyr (in)) {
			ret = new GCL::StrVector (1, in);
			Helper::to_cyr (ret->front ());
		} else if (Helper::is_lat (in)) {
			ret = new GCL::StrVector (1, in);
			Helper::to_lat (ret->front ());
		} else {
			ret = new GCL::StrVector (2, in);
			Helper::to_cyr (ret->front ());
			Helper::to_lat (ret->back ());
		}
	} else if (Helper::is_surrogate_cyr (in)) {
		ret = new GCL::StrVector (1, in);
		Helper::to_cyr (ret->front ());
	} else if (Helper::is_surrogate_lat (in)) {
		ret = new GCL::StrVector (1, in);
		Helper::to_lat (ret->front ());
	} 

	return ret._retn ();
	//#UC END# *565C46FD00A5*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

KeysFactory::KeysFactory (DBComm::IDBCommunicator* comm)
//#UC START# *565C5CFC00D6_BASE_INIT*
	: m_communicator (comm)
//#UC END# *565C5CFC00D6_BASE_INIT*
{
	//#UC START# *565C5CFC00D6_BODY*
	//#UC END# *565C5CFC00D6_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить ключ для заданной леммы
void KeysFactory::add (const std::string& word, GCL::StrSet& out) {
	//#UC START# *565C493501CC*
	if (word.empty () == false) {
		GDS_ASSERT (word.size () <= Morpho::Def::MAX_WORD_LEN);

		out.insert (word);

		char ch = *(word.rbegin ());

		if (ch != '!' && ch != '*') {
			const DBComm::Synonyms& syns = m_communicator->get_ssyns ();

			DBComm::SynPair pair;
			pair.key = word;

			DBComm::Synonyms::const_iterator it = std::lower_bound (syns.begin (), syns.end (), pair, DBComm::SynCompare ());

			if (it != syns.end () && it->key == word) {
				out.insert (it->data.begin (), it->data.end ());
			}
		}
	}
	//#UC END# *565C493501CC*
}

// определение идентичных
void KeysFactory::get_identical (const Search::PhraseEx& request, Relevancy::Positions& out) {
	//#UC START# *5677F2AB036F*
	typedef std::map <std::string, Relevancy::Positions> IdenticalsMap;

	IdenticalsMap data;

	out.clear ();

	for (size_t i = 0; i < request.size (); ++i) {
		Core::Aptr <GCL::StrSet> res = this->make (request [i]);

		for (GCL::StrSet::const_iterator it = res->begin (); it != res->end (); ++it) {
			data [*it].push_back ((unsigned long) i);
		}
	}

	for (IdenticalsMap::const_iterator it = data.begin (); it != data.end (); ++it) {
		if (it->second.size () > 1) {
			out.insert (out.end (), it->second.begin (), it->second.end ());
		}
	}

	if (out.empty () == false) {
		std::sort (out.begin (), out.end ());
		out.erase (std::unique (out.begin (), out.end ()), out.end ());

#ifdef _DEBUG
		std::cout << std::endl;
		std::copy (out.begin (), out.end (), std::ostream_iterator <unsigned long> (std::cout, ", "));
		std::cout << std::endl << std::endl;
#endif
	}
	//#UC END# *5677F2AB036F*
}

// определение идентичных
void KeysFactory::get_identical (const std::string& request, Relevancy::Positions& out) {
	//#UC START# *56D59B5E031A*
	GCL::StrVector parts;
	boost::split (parts, request, boost::is_any_of (" -~"));

	Search::PhraseEx phrase (parts.size ());

	for (size_t i = 0; i < parts.size (); ++i) {
		boost::split (phrase [i], parts [i], boost::is_any_of (","));
	}

	this->get_identical (phrase, out);
	//#UC END# *56D59B5E031A*
}

// создать
GCL::StrSet* KeysFactory::make (const GCL::StrSet& in) {
	//#UC START# *565C3C48031C*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();

	for (GCL::StrSet::const_iterator it = in.begin (); it != in.end (); ++it) {
		Core::Aptr <GCL::StrSet> normas = KeysFactory::make_for_word (*it);
		ret->insert (normas->begin (), normas->end ());
	}

	return ret._retn ();
	//#UC END# *565C3C48031C*
}

// создать
GCL::StrSet* KeysFactory::make_for_word (const std::string& word) {
	//#UC START# *565C3FD80363*
	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();
	KeysFactory::add (word, *ret);

	Core::Aptr <GCL::StrVector> res = KeysFactory::correct (word);

	if (res.is_nil () == false) {
		std::for_each (res->begin (), res->end (), boost::bind (&KeysFactory::add, this, _1, boost::ref (*ret)));
	}

	return ret._retn ();
	//#UC END# *565C3FD80363*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

