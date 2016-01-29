////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/RequestBuilder.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::RequestBuilder
//
// Конструктор запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_REQUESTBUILDER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_REQUESTBUILDER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

namespace ContextSearch {

// Конструктор запросов
class RequestBuilder {
	SET_OBJECT_COUNTER (RequestBuilder)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Функтор для поиска специальных символов в строке
	struct HasSpecial : public std::unary_function<std::string, bool> {
		bool operator () (const std::string& param_) const;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// make
	static void make (const std::string& in, Relevancy::Data& data);

	// make
	static void make (const std::string& in, Search::SplitRequest& out);

	// make_deflate
	static Search::RequestsEx* make_deflate (const Search::SplitRequests& in);

	// спаны в виде списка запросов
	static Search::Phrases* make_sequence (const Search::Phrases& spans);

private:
	// convert
	static void convert (const Search::SplitRequest& in, Search::RequestEx& out);

	// проверка на наличие общих слов
	static bool has_intersection (const Search::Phrase& x, const Search::Phrase& y, Relevancy::Positions& out);

}; // class RequestBuilder

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_REQUESTBUILDER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

