////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/FiltersFactory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Filters_i::FiltersFactory
//
// Фабрика
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Filters_i/FiltersFactory.h"
// by <<uses>> dependencies
#include "garantCore/Search/impl/Filters_i/InitList_i.h"
#include "garantCore/Search/impl/Filters_i/LoadList_i.h"
#include "garantCore/Search/impl/Filters_i/BooleanFilter_i.h"
#include "garantCore/Search/impl/Filters_i/AsVector_i.h"

namespace Search {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// фабрика
SearchAdapterLib::Adapter::IFilter* FiltersFactory::make (SortedCollection* in, MergeOp op) {
	//#UC START# *52FA5051008D*
	ContextSearch::Defs::IFilter_var ret;

	if (in && in->ItemCount) {
		switch (in->Tag ()) {
			case OT_DOCCOLLECTION:
			case OT_REFCOLLECTION:
			case OT_PARASCOLLECTION:
			case OT_RELECOLLECTION: 
			case OT_RELESUBCOLLECTION:
			case OT_CORRREFS_COLLECTION:
			case OT_REFWEIGHTCOLLECTION:
				ret = new InitList_i (in, op);
				break;
			default:
				GDS_ASSERT (0);
		}
	}

	return ret._retn ();
	//#UC END# *52FA5051008D*
}

// фабрика
SearchAdapterLib::Adapter::IFilter* FiltersFactory::make (Index* index, const char* key, MergeOp op) {
	//#UC START# *52FA5D9602A6*
	return new LoadList_i (index, key, op);
	//#UC END# *52FA5D9602A6*
}

// фабрика
SearchAdapterLib::Adapter::IFilter* FiltersFactory::make (Base* base, const char* name, const char* key, MergeOp op) {
	//#UC START# *5302044D03D4*
	return new LoadList_i (base->FindIndex (name), key, op);
	//#UC END# *5302044D03D4*
}

// фабрика
IBooleanFilter* FiltersFactory::make (MergeOp op) {
	//#UC START# *530B57530236*
	return new BooleanFilter_i (op);
	//#UC END# *530B57530236*
}

// фабрика
SearchAdapterLib::Adapter::IFilter* FiltersFactory::make (const SearchAdapterLib::Adapter::LongVector& in, MergeOp op) {
	//#UC START# *53D7BBAA0281*
	return new AsVector_i (in, op);
	//#UC END# *53D7BBAA0281*
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

