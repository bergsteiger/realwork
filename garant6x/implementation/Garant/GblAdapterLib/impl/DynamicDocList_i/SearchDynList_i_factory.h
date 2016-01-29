////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::SearchDynList_i
// Заголовк реализации фабрик интерфеса SearchDynList для серванта SearchDynList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_SEARCHDYNLIST_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_SEARCHDYNLIST_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for SearchDynList_i
class SearchDynList_i_factory: virtual public ::Core::RefCountObjectBase, virtual public SearchDynListAbstractFactory {
public:
	SearchDynList_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	SearchDynList* make (GblPilot::SearchDocList* search_doc_list);

};

typedef ::Core::Var<SearchDynList_i_factory> SearchDynList_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_SEARCHDYNLIST_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

