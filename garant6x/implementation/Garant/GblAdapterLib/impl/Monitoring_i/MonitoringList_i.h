////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringList_i
// Заголовок реализации класса серванта для интерфеса MonitoringList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGLIST_I_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGLIST_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"

namespace GblAdapterLib {

class MonitoringList_i; // self forward Var
typedef ::Core::Var<MonitoringList_i> MonitoringList_i_var;
typedef ::Core::Var<const MonitoringList_i> MonitoringList_i_cvar;

class MonitoringList_i_factory;

class MonitoringList_i:
	virtual public MonitoringList
	, virtual public SearchEntity_i
	, virtual public DynList_i
{
	SET_OBJECT_COUNTER (MonitoringList_i)
	friend class MonitoringList_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MonitoringList_i (GblDocList::DocListTree* server_list, unsigned long document_count);

	virtual ~MonitoringList_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MonitoringList
	virtual const Document* get_summary () const;
	virtual Document* get_summary ();
}; // class MonitoringList_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
