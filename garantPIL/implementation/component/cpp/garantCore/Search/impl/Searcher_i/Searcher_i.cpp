////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/Searcher_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::Searcher_i
//
// Реализация поисковой машины
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Searcher_i/Searcher_i.h"
// by <<uses>> dependencies
#include "garantCore/Search/impl/Searcher_i/SearchHelper.h"
#include "garantCore/Search/Utils/Interpreter.h"
#include "garantCore/Search/Cache/AttrCache.h"
#include "garantCore/Search/ContextSearch/ContextSearcher.h"
#include "boost/lambda/lambda.hpp"
#include "garantCore/Search/impl/Searcher_i/Invoker.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"

namespace Search {
namespace Searcher_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Searcher_i::Searcher_i (SearchBase* base)
//#UC START# *509D0F3C0137_BASE_INIT*
	: m_base (base)
//#UC END# *509D0F3C0137_BASE_INIT*
{
	//#UC START# *509D0F3C0137_BODY*
	m_nc_searcher = new NonContextSearcher (base);
	//#UC END# *509D0F3C0137_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// поиск заданного запроса
SearchResult* Searcher_i::_execute (const std::string& query, const SearchProp& prop) {
	//#UC START# *50EFF58502F3*
	if (query.empty ()) { // поиск по пустой карточке
		if (prop.init) {
			return Result::make (SearchHelper::copy_collection (prop.init), 0);
		} else {
			return Result::make (Invoker::instance ()->get (m_base, QueryTag ("AllDocs")), 0);
		}
	}

	Core::Aptr <QueriesTags> tags = Interpreter::execute_ext (query); // интерпретация строки запроса

	if (tags->empty ()) {
		return Result::make (false);
	}

	size_t count = std::count_if (tags->begin (), tags->end ()
		, boost::lambda::_1 == BODY_TYPE || boost::lambda::_1 == TITLE_TYPE
	);

	if (count == 1 && prop.init == 0 && tags->size () == 2) {
		bool is_first = (tags->front () == BODY_TYPE || tags->front () == TITLE_TYPE);

		QueryTag& ctx = (is_first)? tags->front () : tags->back ();
		QueryTag& tag = (is_first)? tags->back () : tags->front ();

		if (tag.op == so_NOT && ctx.op != so_NOT) {
			tag.op = so_OR;
			Core::Aptr <SortedCollection> res = this->execute (QueriesTags (1, tag), prop);
			return Result::make (this->context_search (QueriesTags (1, ctx), res.in (), so_NOT, prop), prop.max_res_size);
		}
	}

	return Result::make (this->execute (*tags, prop), prop.max_res_size);
	//#UC END# *50EFF58502F3*
}

// контекстный поиск в заданном списке
SortedCollection* Searcher_i::context_search (
	const QueriesTags& tags
	, const SortedCollection* in
	, MergeOp op
	, const SearchProp& prop
) {
	//#UC START# *531555AF02E9*
	if (tags.size () == 1) {
		GDS_ASSERT (tags.front ().op != so_NOT);
	}

	BooleanFilter filter;
	filter << Filter (const_cast <SortedCollection*> (in), op) << prop.filter;

	ContextSearcher searcher (m_base, prop.info_collector, prop.ctx_src);

	size_t count = 0;

	for (QueriesTags::const_iterator it = tags.begin (); it != tags.end (); ++it) {
		searcher.add (*it);

		if (it->key == BODY_TYPE) {
			++count;
		}
	}

	Core::Aptr <SortedCollection> ret = searcher.execute (filter.in ());

	if (count == 0 && op == so_AND && in && ret.is_nil () == false) {
		ret = SearchHelper::transform_for_title_search (ret.in (), in);
	}

	return ret._retn ();
	//#UC END# *531555AF02E9*
}

// выполнить
SortedCollection* Searcher_i::execute (const QueriesTags& tags, const SearchProp& prop) {
	//#UC START# *5162C773000B*
	GDS_ASSERT (tags.empty () == false);

	Core::Aptr <SortedCollection> ret;

	QueriesTags ctx_tags;

	AttrCache* cache = AttrCache::instance ();

	Invoker* invoker_ptr = Invoker::instance ();

	for (QueriesTags::const_iterator it = tags.begin (); it != tags.end (); ++it) {
		Core::Aptr <SortedCollection> res;

		if (it->key == BOOL_TYPE) {
			Core::Aptr <QueriesTags> _res = Interpreter::execute_ext (it->val);

			if (std::find_if (_res->begin (), _res->end ()
				, boost::lambda::_1 != BODY_TYPE && boost::lambda::_1 != TITLE_TYPE) == _res->end ()
			) {
				ctx_tags.insert (ctx_tags.end (), _res->begin (), _res->end ());
				continue;
			}

			SearchProp sp;
			sp.doc_id = prop.doc_id;
			sp.filter = prop.filter;

			res = this->execute (*(_res.in ()), sp);
		} else if (it->key == BODY_TYPE || it->key == TITLE_TYPE) {
			ctx_tags.push_back (*it);
			continue;
		} else if (invoker_ptr->is_exist (it->key, false)) {
			res = invoker_ptr->get (*it, prop.doc_id);
		} else if (invoker_ptr->is_exist (it->key, true)) {
			res = invoker_ptr->get (m_base, *it);
		} else if (cache->get_type (it->key) == AttrCache::at_Date) {
			res = m_nc_searcher->find_range (*it, prop.doc_id);
		} else if (cache->get_type (it->key) == AttrCache::at_String && strchr (it->val.c_str (), '*')) {
			res = m_nc_searcher->find_pattern (*it);
		} else {
			res = m_nc_searcher->find (*it, prop.doc_id);
		}

		MergeOp op = it->op;

		if (ret.is_nil ()) {
			if (prop.init) {
				ret = SearchHelper::copy_collection (prop.init);

				if (op != so_NOT) {
					op = so_AND;
				}
			} else if (op == so_NOT) {
				ret = invoker_ptr->get (m_base, QueryTag ("AllDocs"));
				GDS_ASSERT (ret.is_nil () == false);
			}
		}

		if (res.is_nil () || res->ItemCount == 0) {
			if (prop.doc_id) {
				continue;
			}

			if (op == so_NOT) {
				continue;
			} else if (op == so_OR) {
				if (ret.is_nil ()) {
					ret = new DocCollection;
				}
				continue;
			}

			return 0;
		}

		if (ret.is_nil () == false && res->Tag () != ret->Tag () && op != so_NOT) {
			if (SearchHelper::get_data_priority (ret->Tag ()) < SearchHelper::get_data_priority (res->Tag ())) {
				Core::Aptr <SortedCollection> tmp = res._retn ();
				res = ret._retn ();
				ret = tmp._retn ();
			}
		}

		SortedCollection& ref = *(res.in ());

		if (ret.is_nil ()) {
			ret = res._retn ();
		} else if (op == so_OR) {
			GDS_ASSERT (ret->Merge (ref));
		} else if (op == so_AND) {
			ret->m_bCompType = COMP_PLUS;
			GDS_ASSERT (ret->Intersect (ref));
		} else if (op == so_NOT) {
			ret->m_bCompType = COMP_MINUS;
			GDS_ASSERT (ret->Minus (ref));
		} else {
			GDS_ASSERT (0);
		}

		ret->m_bCompType = COMP_STD;

		if (ret.is_nil () || ret->ItemCount == 0) {
			return 0;
		}
	}

	if (ctx_tags.empty () == false) {
		if (ret.is_nil () == false && ret->Inflated ()) {
			ret->Deflate ();
		}
		return this->context_search (ctx_tags, (ret.is_nil ())? prop.init : ret.in (), so_AND, prop);
	}

	return ret._retn ();
	//#UC END# *5162C773000B*
}

// выполнить
SortedCollection* Searcher_i::execute_new (const QueriesTags& tags, const SearchProp& prop) {
	//#UC START# *55C225B10002*
	GDS_ASSERT (tags.empty () == false);

	ContextSearcher searcher (m_base, prop.info_collector, prop.ctx_src);

	BooleanFilter filter;
	filter << Filter (const_cast <SortedCollection*> (prop.init), so_AND) << prop.filter;

	AttrCache* cache = AttrCache::instance ();

	Invoker* invoker_ptr = Invoker::instance ();

	for (QueriesTags::const_iterator it = tags.begin (); it != tags.end (); ++it) {
		Core::Aptr <SortedCollection> res;

		if (it->key == BOOL_TYPE) {
			Core::Aptr <QueriesTags> _res = Interpreter::execute_ext (it->val);

			if (std::find_if (_res->begin (), _res->end ()
				, boost::lambda::_1 != BODY_TYPE && boost::lambda::_1 != TITLE_TYPE) == _res->end ()
			) {
				for (QueriesTags::const_iterator _it = _res->begin (); it != _res->end (); ++it) {
					searcher.add (*it);
				}
				continue;
			}

			SearchProp sp;
			sp.doc_id = prop.doc_id;
			sp.filter = prop.filter;

			res = this->execute (*(_res.in ()), sp);
		} else if (it->key == BODY_TYPE || it->key == TITLE_TYPE) {
			searcher.add (*it);
			continue;
		} else if (invoker_ptr->is_exist (it->key, false)) {
			res = invoker_ptr->get (*it, prop.doc_id);
		} else if (invoker_ptr->is_exist (it->key, true)) {
			res = invoker_ptr->get (m_base, *it);
		} else if (cache->get_type (it->key) == AttrCache::at_Date) {
			res = m_nc_searcher->find_range (*it, prop.doc_id);
		} else if (cache->get_type (it->key) == AttrCache::at_String && strchr (it->val.c_str (), '*')) {
			res = m_nc_searcher->find_pattern (*it);
		} else {
			res = m_nc_searcher->find (*it, prop.doc_id);
		}

		if (res.is_nil () || res->ItemCount == 0) {
			if (prop.doc_id) {
				continue;
			}
			return 0;
		}

		if (res->Inflated ()) {
			res->Deflate ();
		}

		filter << Filter (res._retn (), it->op);
	}

	return searcher.execute (filter.in ());
	//#UC END# *55C225B10002*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ISearcher
// выполнить
SearchResult* Searcher_i::execute (const std::string& query, const SearchProp& prop) {
	//#UC START# *509B887A031F_509D0E9301E1*
	GDS_ASSERT (m_base);

	try {
		return this->_execute (query, prop);
	} catch (SearchAdapterLib::CanceledByUser&) {
		return Result::make (true);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return Result::make (false);
	//#UC END# *509B887A031F_509D0E9301E1*
}

// implemented method from ISearcher
// выполнить
SearchResult* Searcher_i::execute (IQuery* query, const SearchProp& prop) {
	//#UC START# *509B88B1000E_509D0E9301E1*
	GDS_ASSERT (m_base && query);

	const std::string& type = query->get_type ();
	const std::string& data = query->get_data ();

	try {
		if (type == BODY_TYPE || type == TITLE_TYPE) {
			QueriesTags tags (1, QueryTag (type, data, so_AND));
			return Result::make (this->context_search (tags, prop.init, so_AND, prop), prop.max_res_size);
		} else {
			return this->_execute ((type == BOOL_TYPE)? data : type + '(' + data + ')', prop);
		}
	} catch (SearchAdapterLib::CanceledByUser&) {
		return Result::make (true);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return Result::make (false);
	//#UC END# *509B88B1000E_509D0E9301E1*
}
} // namespace Searcher_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

