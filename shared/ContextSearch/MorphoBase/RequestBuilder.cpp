////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/RequestBuilder.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::RequestBuilder
//
// Конструктор запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/RequestBuilder.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "boost/algorithm/string/join.hpp"
#include "boost/algorithm/string/classification.hpp"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool RequestBuilder::HasSpecial::operator () (const std::string& param_) const {
	//#UC START# *4FA5219D0268_IMPL*
	return (*(param_.rbegin ()) == '!');
	//#UC END# *4FA5219D0268_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// convert
void RequestBuilder::convert (const Search::SplitRequest& in, Search::RequestEx& out) {
	//#UC START# *537E20EC0206*
	out.data = in.data;
	out.context.resize (in.context.size ());

	for (size_t i = 0; i < in.context.size (); ++i) {
		out.context [i].insert (in.context [i]);
	}
	//#UC END# *537E20EC0206*
}

// проверка на наличие общих слов
bool RequestBuilder::has_intersection (const Search::Phrase& x, const Search::Phrase& y, Relevancy::Positions& out) {
	//#UC START# *52A72B430034*
	GDS_ASSERT (x.size () == y.size ());

	size_t i;

	for (i = 0; i < x.size (); ++i) {
		if (i + 2 >= x.size ()) {
			break;
		}

		if (ContextUtility::is_date (x [i], x [i + 1], x [i + 2]) 
			&& ContextUtility::is_date (y [i], y [i + 1], y [i + 2])
		) {
			Search::Phrase date_1 (x.begin () + i, x.begin () + i + 3);
			Search::Phrase date_2 (y.begin () + i, y.begin () + i + 3);

			if (ContextUtility::is_equal_date (date_1, date_2)) {
				return true;
			}
		}
	}

	Relevancy::Positions tmp;
	tmp.reserve (x.size ());

	for (i = 0; i < x.size (); ++i) {
		if (x [i] == y [i]) {
			tmp.push_back (i);
		}
	}

	if (out.empty ()) {
		out = tmp;
	} else {
		Relevancy::Positions res;
		std::set_intersection  (out.begin (), out.end (), tmp.begin (), tmp.end (), std::back_inserter (res));
		out = res;
	}

	return  (out.empty () == false);
	//#UC END# *52A72B430034*
}

// make
void RequestBuilder::make (const std::string& in, Relevancy::Data& data) {
	//#UC START# *52A5F00E0367*
	unsigned short pos = 0;

	Relevancy::Frame frame;
	frame.count = 0;

	for (std::string::const_iterator it = in.begin (); it != in.end (); ) {
		it = std::find_if (it, in.end (), boost::is_any_of (" -~"));

		if (it != in.end ()) {
			++pos;

			if (*it == '~') {
				if (frame.count == 0) {
					frame.count = 2;
					frame.pos = pos - 1;
					data.frames.push_back (frame);
				} else {
					++data.frames.back ().count;
				}
			} else {
				frame.count = 0;

				if (*it == '-') {
					data.strongs.push_back (pos);
				} 
			}

			++it;
		}
	}
	//#UC END# *52A5F00E0367*
}

// make
void RequestBuilder::make (const std::string& in, Search::SplitRequest& out) {
	//#UC START# *52A71CD302F6*
	if (in.empty () == false) {
		GCL::StrVector tmp;

		ContextUtility::split (out.context, in, false);
		ContextUtility::split (tmp, in, true);

		RequestBuilder::make (boost::join (tmp, " "), out.data);
	}
	//#UC END# *52A71CD302F6*
}

// make_deflate
Search::RequestsEx* RequestBuilder::make_deflate (const Search::SplitRequests& in) {
	//#UC START# *52A7273A022C*
	if (in.size () == 1) {
		Core::Aptr <Search::RequestsEx> ret = new Search::RequestsEx (1);
		RequestBuilder::convert (in [0], ret->at (0));
		return ret._retn ();
	}

	Core::Aptr <Search::RequestsEx> ret = new Search::RequestsEx ();
	ret->reserve (in.size ());

	Relevancy::Positions common;

	std::vector <bool> busy (in.size (), false);

	size_t i = 0, j, start;

	for (; i < in.size (); i = start + 1) {
		start = i;

		if (busy [i] == false) {
			Search::RequestEx req;
			RequestBuilder::convert (in [i], req);

			if (std::find_if (in [i].context.begin (), in [i].context.end (), HasSpecial ()) == in [i].context.end ()) {
				for (i = i + 1; i < in.size (); ++i) {
					if (busy [i]) {
						continue;
					}

					const Search::Phrase& cur = in [i].context;

					if (std::find_if (cur.begin (), cur.end (), HasSpecial ()) == cur.end ()) {
						if (in [start] == in [i] && has_intersection (in [start].context, cur, common)) {
							for (j = 0; j < cur.size (); ++j) {
								req.context [j].insert (cur [j]); // мерджим со следующим запросом
							}

							busy [i] = true; // TODO: отказались от проверки идентичности из-за дат типа 13.06.06
						}
					}
				}
			}

			ret->push_back (req);
			common.clear ();
		}
	}

	return ret._retn ();
	//#UC END# *52A7273A022C*
}

// спаны в виде списка запросов
Search::Phrases* RequestBuilder::make_sequence (const Search::Phrases& spans) {
	//#UC START# *535E92D3001F*
	Core::Aptr <Search::Phrases> ret = new Search::Phrases ();

	GCL::StrVector::const_iterator _it;

	for (Search::Phrases::const_iterator it = spans.begin (); it != spans.end (); ++it) {
		if (ret->empty ()) {
			for (_it = it->begin (); _it != it->end (); ++_it) {
				ret->push_back (GCL::StrVector (1, *_it));
			}
		} else {
			Search::Phrases tmp;

			for (size_t i = 0; i < ret->size (); ++i) {
				for (_it = it->begin (); _it != it->end (); ++_it) {
					tmp.push_back (ret->at (i));
					tmp.back ().push_back (*_it);
				}
			}

			ret->swap (tmp);
		}
	}

	return ret._retn ();
	//#UC END# *535E92D3001F*
}

} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

