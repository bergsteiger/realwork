////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/StorageData.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::StorageData
//
// StorageData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_SEARCHER_I_STORAGEDATA_H__
#define __GARANTCORE_SEARCH_SEARCHER_I_STORAGEDATA_H__

#include "shared/Core/sys/std_inc.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/index.h"

//#UC START# *5107F94B015E_CUSTOM_INCLUDES*
//#UC END# *5107F94B015E_CUSTOM_INCLUDES*

namespace Search {
namespace Searcher_i {

// StorageData
class StorageData {
	SET_OBJECT_COUNTER (StorageData)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// фабрика для коллекции заданного типа
	static SortedCollection* make (long type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit StorageData (SearchBase* base);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// результат
	SortedCollection* _retn ();

	// добавить
	void add (const char* name, const char* from, const char* to);

	// данные
	SortedCollection* get (const char* name, const char* val);

private:
	// добавить
	void add (Index* index, const void* key);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchBase* m_base;

//#UC START# *5107F94B015E*
	Core::Aptr <SortedCollection> m_data;
//#UC END# *5107F94B015E*
}; // class StorageData

} // namespace Searcher_i
} // namespace Search


#endif //__GARANTCORE_SEARCH_SEARCHER_I_STORAGEDATA_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

