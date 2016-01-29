////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Logger.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::Logger
//
// Логер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_LOGGER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_LOGGER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

namespace ContextSearch {

// Логер
class Logger {
	SET_OBJECT_COUNTER (Logger)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// out
	static void out (const Search::RequestEx& req, Relevancy::IRelevancyInfo* info_collector);

	// out
	static void out (const Search::SplitRequest& req);

private:
	// добавить контекст
	static void add (const Search::StringSet& in, std::string& out);

}; // class Logger

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_LOGGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

