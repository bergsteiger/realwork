////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::SearchEntity_i
// Заголовк реализации фабрик интерфеса SearchEntity для серванта SearchEntity_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_SEARCHENTITY_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_SEARCHENTITY_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for SearchEntity_i
class SearchEntity_i_factory: virtual public ::Core::RefCountObjectBase, virtual public SearchEntityAbstractFactory {
public:
	SearchEntity_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	SearchEntity* make (SearchResultType result_type, size_t document_count, size_t entry_count, size_t edition_count);

	SearchEntity* make (GblPilotQueryDef::SearchEntity* search_entity);

};

typedef ::Core::Var<SearchEntity_i_factory> SearchEntity_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_SEARCHENTITY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

