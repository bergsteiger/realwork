////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Logger.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::Logger
//
// Логер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/Logger.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/join.hpp"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить контекст
void Logger::add (const Search::StringSet& in, std::string& out) {
	//#UC START# *51432B4500BE*
	if (in.size () > 1) {
		out += "(" + boost::join (in, ",") + ")";
	} else {
		out += *(in.begin ());
	}
	//#UC END# *51432B4500BE*
}

// out
void Logger::out (const Search::RequestEx& req, Relevancy::IRelevancyInfo* info_collector) {
	//#UC START# *51432B150107*
#ifdef _DEBUG
	bool is_debug = true;
#else
	bool is_debug = false;
#endif

	const Relevancy::Positions& strongs = req.data.strongs;

	if (info_collector || is_debug) {
		std::string str;

		Relevancy::Frames::const_iterator it = req.data.frames.begin ();

		for (size_t i = 0; i < req.context.size (); ++i) {
			if (std::binary_search (strongs.begin (), strongs.end (), i)) {
				str += "-";
			} else if (i) {
				str += " ";
			}

			add (req.context [i], str);

			if (it != req.data.frames.end () && i == it->pos) {
				for (size_t j = 1; j < it->count; ++j) {
					str += "~";
					add (req.context [++i], str);
				}
				++it;
			}
		}

		if (info_collector) {
			info_collector->add (str);
		}

		str += '\n';

		if (is_debug) {
			std::cout << std::endl << str << std::endl << "{ ";
			std::copy (strongs.begin (), strongs.end (), std::ostream_iterator <size_t> (std::cout, " "));
			std::cout << "}" << std::endl << std::endl;
		}
	}
	//#UC END# *51432B150107*
}

// out
void Logger::out (const Search::SplitRequest& req) {
	//#UC START# *51432BC4016F*
	const Relevancy::Positions& strongs = req.data.strongs;

	std::string str;

	Relevancy::Frames::const_iterator it = req.data.frames.begin ();

	for (size_t i = 0; i < req.context.size (); ++i) {
		if (std::binary_search (strongs.begin (), strongs.end (), i)) {
			str += "-";
		} else if (i) {
			str += " ";
		}

		str += req.context [i];

		if (it != req.data.frames.end () && i == it->pos) {
			for (size_t j = 1; j < it->count; ++j) {
				str += "~";
				str += req.context [++i];
			}
			++it;
		}
	}

	std::cout << std::endl << str;
	//#UC END# *51432BC4016F*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

