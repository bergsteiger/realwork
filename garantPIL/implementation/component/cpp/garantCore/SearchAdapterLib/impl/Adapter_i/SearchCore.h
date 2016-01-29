////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/SearchCore.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::Adapter_i::SearchCore
//
// Базовая реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHCORE_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHCORE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "shared/Morpho/Def/Def.h"

namespace SearchAdapterLib {
namespace Adapter_i {

// Базовая реализация
class SearchCore {
	SET_OBJECT_COUNTER (SearchCore)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SearchCore (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src);

public:
	virtual ~SearchCore ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// поиск релевантных фрагментов в заданном документе
	ContextSearch::Defs::Fragments* get_fragments (const std::string& in, DBCore::DocId id);

	// поиск позиций всех релевантных фрагментов в заданном документе
	ContextSearch::Defs::Positions* get_positions (const GCL::StrVector& reqs, DBCore::DocId id);

	// поиск релевантных документов
	ContextSearch::Defs::RelevancyDocuments* search (
		const ContextSearch::Defs::Requests& reqs
		, const ContextSearch::Defs::SearchInfo& info
	);

	// поиск релевантных документов
	void search (
		const ContextSearch::Defs::Requests& reqs
		, const ContextSearch::Defs::SearchInfo& info
		, DBCore::IProgress* progress
		, ContextSearch::Defs::IResCollector* collector
	);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ContextSearch::Manage::Env m_env;

	bool m_uwc;
}; // class SearchCore

} // namespace Adapter_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHCORE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

