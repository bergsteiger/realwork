////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Monitoring_i::MonitoringList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MonitoringList_i::MonitoringList_i (GblDocList::DocListTree* server_list, unsigned long document_count)
//#UC START# *45EEC0FD01B1_460117B20232_4601086000BB_BASE_INIT*
	: DynList_i (server_list)
	, ListCatalogBase (server_list)
	, SearchEntity_i (SRT_AUTOREFERAT, document_count, 0, 0) 
//#UC END# *45EEC0FD01B1_460117B20232_4601086000BB_BASE_INIT*
{
	//#UC START# *45EEC0FD01B1_460117B20232_4601086000BB_BODY*
	//#UC END# *45EEC0FD01B1_460117B20232_4601086000BB_BODY*
}

MonitoringList_i::~MonitoringList_i () {
	//#UC START# *4601086000BB_DESTR_BODY*
	//???? Не нужно ли здесь уменьшать счетчик ссылок на server_list, есть ощущение что он живет до самого логаута
	//#UC END# *4601086000BB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MonitoringList
const Document* MonitoringList_i::get_summary () const {
	//#UC START# *45EEC0FD01B4_4601086000BB_GET*
	GblPilot::AutoReferatList_var list = GblPilot::AutoReferatList::_narrow (this->get_cached_server_tree ());
	GDS_ASSERT (list.in ());
	GblPilot::AutoReferatDoc_var autoreferat = list->get_autoreferat ();
	Document_var summary = DocumentFactory::make (autoreferat.in(), FK_AUTOREFERAT_DOCUMENT);	
	return summary._retn ();
	//#UC END# *45EEC0FD01B4_4601086000BB_GET*
}

Document* MonitoringList_i::get_summary () {
	return const_cast<Document*>(((const MonitoringList_i*)this)->get_summary ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

