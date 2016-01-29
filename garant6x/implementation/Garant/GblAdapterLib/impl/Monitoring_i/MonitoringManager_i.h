////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringManager_i
// Заголовок реализации класса серванта для интерфеса Monitoring
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring.h"

//#UC START# *45FFE7AF00CB_CUSTOM_INCLUDES*
//#UC END# *45FFE7AF00CB_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class MonitoringManager_i; // self forward Var
typedef ::Core::Var<MonitoringManager_i> MonitoringManager_i_var;
typedef ::Core::Var<const MonitoringManager_i> MonitoringManager_i_cvar;

class MonitoringManager_i_factory;

class MonitoringManager_i:
	virtual public Monitoring
	, virtual public Listener
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MonitoringManager_i)
	friend class MonitoringManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MonitoringManager_i ();

	virtual ~MonitoringManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual bool check_anno_present () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable bool m_is_anno_present;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Listener
	virtual void fire (const Notification* notify) const;

	// implemented method from Monitoring
	virtual bool is_exist () const;

	// implemented method from Monitoring
	virtual bool is_news_line_defined () const;

	// implemented method from Monitoring
	virtual const NodeBase* get_news_line_root () const;
	virtual NodeBase* get_news_line_root ();

//#UC START# *45FFE7AF00CB*
//#UC END# *45FFE7AF00CB*
}; // class MonitoringManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MONITORING_I_MONITORINGMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
