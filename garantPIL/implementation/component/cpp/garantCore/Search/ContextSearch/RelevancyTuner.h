////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/RelevancyTuner.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::RelevancyTuner
//
// Класс для изменения значения релевантности в списке найденных
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CONTEXTSEARCH_RELEVANCYTUNER_H__
#define __GARANTCORE_SEARCH_CONTEXTSEARCH_RELEVANCYTUNER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/refcol.h"

namespace Search {

// Класс для изменения значения релевантности в списке найденных
class RelevancyTuner {
	SET_OBJECT_COUNTER (RelevancyTuner)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// вектор документов
	typedef std::vector < unsigned long > DocVector;

	// Константы
	static const short CODE_FACTOR; // за CODE
	static const short TYPE_FACTOR; // за TYPE

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// добавка для типа
	static short get_value (SearchAdapterLib::Adapter::TuneDocType type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit RelevancyTuner (SearchAdapterLib::Adapter::IRelevancyInfo* collector);

public:
	virtual ~RelevancyTuner ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// выполнить
	virtual void execute (
		RefwReleCollection* result
		, const SearchAdapterLib::Adapter::RelTuneData& data
		, SearchAdapterLib::Adapter::TuneDocType type
	) const;

	// выполнить
	void execute (RefwReleCollection* result, const DocVector& data, SearchAdapterLib::Adapter::TuneDocType type) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchAdapterLib::Adapter::IRelevancyInfo* m_info_collector;
}; // class RelevancyTuner

} // namespace Search


#endif //__GARANTCORE_SEARCH_CONTEXTSEARCH_RELEVANCYTUNER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

