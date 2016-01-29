////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListEntryInfo_i
// Заголовк реализации фабрик интерфеса ListEntryInfo для серванта ListEntryInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTENTRYINFO_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTENTRYINFO_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ListEntryInfo_i
class ListEntryInfo_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ListEntryInfoAbstractFactory {
public:
	ListEntryInfo_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ListEntryInfo* make (const GblPilot::ListEntryInfo& info, const NodeBase* root);

	ListEntryInfo* make (const GblPilot::ListEntryInfo& info);

};

typedef ::Core::Var<ListEntryInfo_i_factory> ListEntryInfo_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTENTRYINFO_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

