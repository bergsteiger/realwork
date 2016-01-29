////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/RequestAnalyzer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::RequestAnalyzer
//
// Анализатор контекстного запроса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/impl/Search_i/RequestAnalyzer.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/MorphoBase/Analyzer.h"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

namespace ContextSearch {
namespace Search_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RequestAnalyzer::RequestAnalyzer (
	const Search::RequestEx& request
	, const Search::AlgorithmProperties& prop
	, bool is_ext
)
//#UC START# *54BE3ABC023F_BASE_INIT*
//#UC END# *54BE3ABC023F_BASE_INIT*
{
	//#UC START# *54BE3ABC023F_BODY*
	try {
		this->build (request, prop, is_ext);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *54BE3ABC023F_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// build
void RequestAnalyzer::build (const Search::RequestEx& request, const Search::AlgorithmProperties& prop, bool is_ext) {
	//#UC START# *54BE3EF003B7*
	const Search::PhraseEx& context = request.context;
	const Relevancy::Data& data = request.data;

	Relevancy::AlgorithmProperties r_prop;
	r_prop.info = prop.collector;
	r_prop.max_fragment = prop.max_fragment;

	m_searcher = new Searcher (prop);

	if (data.strongs.empty () && Analyzer::is_identical (context)) {
		Search::PhraseEx req (1, context [0]);
		m_searcher->set (req);

		r_prop.count = context.size ();
		r_prop.rcount = r_prop.count;

		m_algorithm = Relevancy::IAlgorithmFactory::make (data, r_prop, Relevancy::as_Identical); // запрос из одинаковых слов
		return;
	}

	bool is_strong = (data.strongs.size () == context.size () - 1);
		
	if (is_ext && data.strongs.empty () == false) {
		if (is_strong) {
			std::string str;

			for (Search::PhraseEx::const_iterator it = context.begin (); it != context.end (); ++it) {
				if (it->size () != 1) {
					str.clear ();
					break;
				}

				if (str.empty () == false) {
					str += '-';
				}

				str += *(it->begin ());
			}

			if (str.empty () == false && m_searcher->add (str, 0)) {
				m_algorithm = Relevancy::IAlgorithmFactory::make (Relevancy::Data (), r_prop, Relevancy::as_Single);
				return;
			}
		} else if (data.frames.empty ()) {
			std::string str;

			for (size_t i = 0; i < context.size (); ++i) {
				if (context [i].size () != 1) {
					str.clear ();
					break;
				}

				if (str.empty () == false) {
					if (std::binary_search (data.strongs.begin (), data.strongs.end (), i)) {
						str += '-';
					} else {
						str += ' ';
					}
				}

				str += *(context [i].begin ());
			}

			if (str.empty () == false) {
				GCL::StrVector parts;
				boost::split (parts, str, boost::is_space ());

				if (m_searcher->set (parts)) {
					r_prop.count = parts.size ();
					r_prop.rcount = context.size ();
					r_prop.max_fragment = r_prop.count * Relevancy::BASE_FACTOR;

					m_algorithm = Relevancy::IAlgorithmFactory::make (Relevancy::Data (), r_prop, Relevancy::as_Simple);
					return;
				}
			}
		} 
	}

	m_searcher->set (context);

	r_prop.count = context.size ();
	r_prop.rcount = r_prop.count;

	prop.normalizer->init_identical (context, r_prop.identical);

	Relevancy::AlgorithmSelector selector = Relevancy::as_Default;

	if (context.size () == 1) {
		selector = Relevancy::as_Single; // однословный запрос
	} else if (is_strong) {
		selector = Relevancy::as_Strong; // полностью строгий запрос
	} else if (r_prop.identical.empty () && data.strongs.empty () && data.frames.empty ()) {
		selector = Relevancy::as_Simple; // простой запрос без разметки
	} 

	m_algorithm = Relevancy::IAlgorithmFactory::make (data, r_prop, selector);
	//#UC END# *54BE3EF003B7*
}

// algorithm
Relevancy::IAlgorithm* RequestAnalyzer::get_algorithm () {
	//#UC START# *54BE3AFB0356*
	GDS_ASSERT (m_algorithm.is_nil () == false);
	return m_algorithm.in ();
	//#UC END# *54BE3AFB0356*
}

// searcher
Searcher* RequestAnalyzer::get_searcher () {
	//#UC START# *54BE3ADE03CF*
	GDS_ASSERT (m_searcher.is_nil () == false);
	return m_searcher.in ();
	//#UC END# *54BE3ADE03CF*
}

} // namespace Search_i
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

