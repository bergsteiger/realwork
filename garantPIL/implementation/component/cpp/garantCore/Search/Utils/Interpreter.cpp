////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Utils/Interpreter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Utils::Interpreter
//
// Интерпретатор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/Utils/Interpreter.h"
// by <<uses>> dependencies
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/lambda/lambda.hpp"
#include "boost/bind.hpp"

//#UC START# *50A510FD01FE_CUSTOM_INCLUDES*
//#UC END# *50A510FD01FE_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *50A510FD01FE*
struct IsClassOrMkb {
	bool operator () (const Search::QueryTag& val) {
		return (val.key == "Class") || (val.key == "Mkb");
	}
};

struct IsOrOperation {
	bool operator () (const Search::QueryTag& val) {
		return val.op == Search::so_OR;
	}
};

struct IsAndOperation {
	bool operator () (const Search::QueryTag& val) {
		return val.op == Search::so_AND;
	}
};
//#UC END# *50A510FD01FE*

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// выполнить
QueriesTags* Interpreter::execute (const std::string& str, bool need_optimize) {
	//#UC START# *50A516130204*
	if (str.empty ()) {
		GDS_ASSERT (false && "empty query");
		return new QueriesTags ();
	}

	std::vector <std::string> values, keys;
	{
		size_t count = 0, pos = 0, i = 0;

		std::string::const_iterator it = str.begin (), it_end = str.end ();

		for (; it != it_end; ++it, ++i) {
			if (*it == '(') {
				if (count == 0) {
					keys.push_back (str.substr (pos, i - pos));
					pos = i + 1;
				}

				++count;
			} else if (*it == ')') {
				--count;

				if (count == 0) {
					values.push_back (str.substr (pos, i - pos));
					pos = i + 1;
				}
			}
		}
	}

	if (keys.size () != values.size ()) {
		GDS_ASSERT (false && "invalid query");
		return new QueriesTags ();
	}

	Core::Aptr <QueriesTags> ret = new QueriesTags ();
	ret->reserve (keys.size ());

	for (size_t i = 0; i < keys.size (); ++i) {
		QueryTag item;

		std::string::iterator it = std::find_if (keys [i].begin (), keys [i].end ()
			, boost::lambda::_1 == so_OR || boost::lambda::_1 == so_AND || boost::lambda::_1 == so_NOT
		);

		if (it != keys [i].end ()) {
			item.op = *it;
			item.key.assign (it + 1, keys [i].end ());
		} else {
			item.op = so_OR;
			item.key = keys [i];
		}

		item.val = values [i];

		boost::trim (item.key);
		boost::trim (item.val);

		if (need_optimize) {
			Interpreter::optimize (item);

			Core::Aptr <QueriesTags> res = Interpreter::optimize_brackets (item);

			if (res.is_nil () == false) {
				ret->insert (ret->end (), res->begin (), res->end ());
				continue;
			}
		} 

		ret->push_back (item);
	}

	return ret._retn ();
	//#UC END# *50A516130204*
}

// выполнить с валидацией и сортировкой
QueriesTags* Interpreter::execute_ext (const std::string& str) {
	//#UC START# *55BB733D014D*
	Core::Aptr <QueriesTags> ret = Interpreter::execute (str, true);

	QueriesTags::iterator or_end = std::partition (ret->begin (), ret->end (), IsOrOperation ());
	QueriesTags::iterator and_end = std::partition (or_end, ret->end (), IsAndOperation ());

	std::partition (ret->begin (), or_end, IsClassOrMkb ());
	std::partition (or_end, and_end, IsClassOrMkb ());
	std::partition (and_end, ret->end (), IsClassOrMkb ());

	return ret._retn ();
	//#UC END# *55BB733D014D*
}

// оптимизация
void Interpreter::optimize (QueryTag& tag) {
	//#UC START# *55BA5E4A0021*
	if (tag.key != BOOL_TYPE) {
		return;
	}

	Core::Aptr <QueriesTags> tags = Interpreter::execute (tag.val);

	if (tags->size () == 1) {
		QueryTag& first = tags->at (0);

		if (first.op == so_NOT && tag.op != so_OR) {
			tag.key = first.key;
			tag.val = first.val;

			if (tag.op == so_NOT) {
				tag.op = so_AND; // A ~ (~ B) == A & B
			} else if (tag.op == so_AND) {
				tag.op = so_NOT; // A & (~ B) == A ~ B
			} 
		} else if (first.op != so_NOT && tag.op != so_NOT) {
			tag.key = first.key; // A & (& B) == A & (| B) == A & B
			tag.val = first.val; // A | (| B) == A | (& B) == A | B
		} 
	} else if (tag.op != so_OR) { 
		if (std::find_if (tags->begin (), tags->end (), boost::bind (&QueryTag::op, _1) != so_NOT) == tags->end ()) {
			// & (~ A ~ B ~ ...) == & (~ (A | B | ...)) == ~ (A | B | ...)
			// ~ (~ A ~ B ~ ...) == ~ (~ (A | B | ...)) == & (A | B | ...)

			tag.val.clear ();

			if (tag.op == so_AND) {
				tag.op = so_NOT;
			} else if (tag.op == so_NOT) {
				tag.op = so_AND;
			}

			for (QueriesTags::const_iterator it = tags->begin (); it != tags->end (); ++it) {
				tag.val += "| " + it->key + '(' + it->val + ") ";
			}

			boost::trim_right (tag.val);
		}
	}
	//#UC END# *55BA5E4A0021*
}

// оптимизация скобок
QueriesTags* Interpreter::optimize_brackets (QueryTag& tag) {
	//#UC START# *55E704EA01BD*
	if (tag.key == BOOL_TYPE && tag.op != so_NOT) {
		Core::Aptr <QueriesTags> res = Interpreter::execute (tag.val);

		if (res->size () > 1) {
			if (std::find_if (res->begin (), res->end (), boost::bind (&QueryTag::op, _1) != tag.op) == res->end ()) {
				return res._retn ();
			}
		}
	}

	return 0;
	//#UC END# *55E704EA01BD*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

