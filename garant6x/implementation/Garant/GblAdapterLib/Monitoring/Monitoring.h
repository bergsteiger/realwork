////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblPilot/GblDocListC.h"

namespace GblAdapterLib {

class MonitoringList;
typedef ::Core::Var<MonitoringList> MonitoringList_var;
typedef ::Core::Var<const MonitoringList> MonitoringList_cvar;
// Интерфейс-врапер, для того что бы отдать Документ с мониторингом ввиде Списка из опроеации
// поиска. Сразу после получения MonitoringList необхождимо преобразовать его к документу, через
// метод summary
class MonitoringList
	: virtual public SearchEntity
	, virtual public DynList
{
public:
	virtual const Document* get_summary () const = 0;
	virtual Document* get_summary () = 0;
};

/// factory interface for MonitoringList
class MonitoringListFactory {
public:
	static MonitoringList* make (GblDocList::DocListTree* server_list, unsigned long document_count)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Monitoring;
typedef ::Core::Var<Monitoring> Monitoring_var;
typedef ::Core::Var<const Monitoring> Monitoring_cvar;
class Monitoring
	: virtual public ::Core::IObject
{
public:
	virtual const NodeBase* get_news_line_root () const = 0;
	virtual NodeBase* get_news_line_root () = 0;

	virtual bool is_news_line_defined () const = 0;

	virtual bool is_exist () const = 0;
};

/// factory interface for Monitoring
class MonitoringFactory {
public:
	static Monitoring* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::MonitoringList> {
	typedef GblAdapterLib::MonitoringListFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Monitoring> {
	typedef GblAdapterLib::MonitoringFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
