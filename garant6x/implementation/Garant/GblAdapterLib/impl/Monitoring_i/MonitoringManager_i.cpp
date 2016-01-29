////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i_factory.h"

//#UC START# *45FFE7AF00CB_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
//#UC END# *45FFE7AF00CB_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45FFE7AF00CB*
//#UC END# *45FFE7AF00CB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MonitoringManager_i::MonitoringManager_i ()
//#UC START# *45EEC103021E_45EEC16B01A1_45FFE7AF00CB_BASE_INIT*
	: m_is_anno_present (this->check_anno_present ())
//#UC END# *45EEC103021E_45EEC16B01A1_45FFE7AF00CB_BASE_INIT*
{
	//#UC START# *45EEC103021E_45EEC16B01A1_45FFE7AF00CB_BODY*
	NotifyManagerFactory::make ().register_listener_for_notify (NT_BASE_UPDATE_END, this);
	//#UC END# *45EEC103021E_45EEC16B01A1_45FFE7AF00CB_BODY*
}

MonitoringManager_i::~MonitoringManager_i () {
	//#UC START# *45FFE7AF00CB_DESTR_BODY*
	//#UC END# *45FFE7AF00CB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

bool MonitoringManager_i::check_anno_present () const {
	//#UC START# *45FFEA910138*
	return ApplicationHelper::instance ()->get_cached_function_manager ()->is_anno_present () == true;
	//#UC END# *45FFEA910138*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Listener
void MonitoringManager_i::fire (const Notification* notify) const {
	//#UC START# *45EEDE9D01C5_45FFE7AF00CB*
	m_is_anno_present = this->check_anno_present ();
	//#UC END# *45EEDE9D01C5_45FFE7AF00CB*
}

// implemented method from Monitoring
bool MonitoringManager_i::is_exist () const {
	//#UC START# *45EEC1030220_45FFE7AF00CB*
	return m_is_anno_present;
	//#UC END# *45EEC1030220_45FFE7AF00CB*
}

// implemented method from Monitoring
bool MonitoringManager_i::is_news_line_defined () const {
	//#UC START# *45EEC103021F_45FFE7AF00CB*
	CORBA::ULong query_count = ApplicationHelper::instance ()->get_cached_prime ()->get_query_count ();
	LOG_D (("%s: query_count = %d", GDS_CURRENT_FUNCTION, query_count));
	return query_count != 0;
	//#UC END# *45EEC103021F_45FFE7AF00CB*
}

// implemented method from Monitoring
const NodeBase* MonitoringManager_i::get_news_line_root () const {
	//#UC START# *46023FE30057_45FFE7AF00CB_GET*
	return NodeBaseFactory::make ("AT_NEWS_LINE");
	//#UC END# *46023FE30057_45FFE7AF00CB_GET*
}

NodeBase* MonitoringManager_i::get_news_line_root () {
	return const_cast<NodeBase*>(((const MonitoringManager_i*)this)->get_news_line_root ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

