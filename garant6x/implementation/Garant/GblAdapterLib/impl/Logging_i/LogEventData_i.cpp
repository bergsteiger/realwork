////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Logging_i::LogEventData_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i_factory.h"
#include "garantServer/src/Business/GblLogging/GblLoggingC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LogEventTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocWithPid.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LogEventData_i::LogEventData_i ()
//#UC START# *45ED59730069_45ED5A8C03B1_45ED5B1F0044_BASE_INIT*
//#UC END# *45ED59730069_45ED5A8C03B1_45ED5B1F0044_BASE_INIT*
{
	//#UC START# *45ED59730069_45ED5A8C03B1_45ED5B1F0044_BODY*
	//#UC END# *45ED59730069_45ED5A8C03B1_45ED5B1F0044_BODY*
}

LogEventData_i::~LogEventData_i () {
	//#UC START# *45ED5B1F0044_DESTR_BODY*
	//#UC END# *45ED5B1F0044_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from LogEventData
void LogEventData_i::add_date (const Date& data) {
	//#UC START# *4746DDAB022F_45ED5B1F0044*
	CORBA::Any any_data;
	GCD::DateEx server_date;
	DateTranslator::translate_date (data, server_date);
	any_data <<= server_date;
	m_data.push_back (any_data);
	//#UC END# *4746DDAB022F_45ED5B1F0044*
}

// implemented method from LogEventData
void LogEventData_i::add_object (const Core::IObject* data) {
	//#UC START# *45ED5973006A_45ED5B1F0044*
	CORBA::Any any_data;
	Document_cvar document = Core::IObject::_duplicate (dynamic_cast <const Document*> (data));	
	if (document.ptr ()) {
		any_data <<= 
			static_cast <CORBA::ULong>(document->get_redaction_pid ().m_object_id);
	} else {
		DynList_cvar dyn_list = Core::IObject::_duplicate (dynamic_cast <const DynList*> (data));	
		if (dyn_list.ptr ()) {
			GblDocList::DocListTree_ptr doc_list = 
				dynamic_cast <const DynList_i*> (dyn_list.in ())->get_cached_server_doc_list ();
			any_data <<= doc_list;
		} else {
			Query_var query = Core::IObject::_duplicate (const_cast <Query*> (dynamic_cast <const Query*> (data)));	
			if (query.ptr ()) {
				GblPilotQueryDef::Query* server_query = query->build_query ();
				any_data <<= server_query;
			} else {
				GDS_ASSERT_MSG (false, ("Unknown event type"));
				return;
			}
		}
	}
	m_data.push_back (any_data);
	//#UC END# *45ED5973006A_45ED5B1F0044*
}

// implemented method from LogEventData
void LogEventData_i::add_string (const char* data) {
	//#UC START# *45ED5973006C_45ED5B1F0044*
	CORBA::Any any_data;
	any_data <<= data;
	m_data.push_back (any_data);
	//#UC END# *45ED5973006C_45ED5B1F0044*
}

// implemented method from LogEventData
void LogEventData_i::add_ulong (unsigned long data) {
	//#UC START# *4746DD60023E_45ED5B1F0044*
	CORBA::Any any_data;
	any_data <<= static_cast <CORBA::ULong> (data);
	m_data.push_back (any_data);
	//#UC END# *4746DD60023E_45ED5B1F0044*
}

// implemented method from LogEventData
// Записать в лог
void LogEventData_i::write_to_log (LogEvent log_event) const {
	//#UC START# *474C1E8F01B0_45ED5B1F0044*
	::GblLogging::EventData_var data_for_server = new ::GblLogging::EventData ();
	data_for_server->length (m_data.size ());
	for (unsigned i = 0; i < m_data.size (); i++) {
		(*data_for_server) [i] = m_data [i];
	}
	ApplicationHelper::instance ()->get_cached_logging_manager ()->
		add_event (LogEventTranslatorSingleton::instance ()->get (log_event), data_for_server.in ());
	//#UC END# *474C1E8F01B0_45ED5B1F0044*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

