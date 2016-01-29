////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::ServerAdapterConverters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_SERVERADAPTERCONVERTERS_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_SERVERADAPTERCONVERTERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"

//#UC START# *460B956502AF_USER_INCLUDES*
//#UC END# *460B956502AF_USER_INCLUDES*

namespace GblAdapterLib {
namespace ServerAdapterConverters {

GCD::PID adapter_to_server (const PId& adap);

void server_to_adapter (const GblPilotDef::SubPara& serv, Position& adap) /*throw (Unsupported)*/;

void adapter_to_server (const Position& adap, GblPilotDef::SubPara& serv) /*throw (Unsupported)*/;

void server_to_adapter (const GblPilotDef::SubParaList& serv, PositionList*& adap) /*throw (Unsupported)*/;

void adapter_to_server (const PositionList& adap, GblPilotDef::SubParaList& serv) /*throw (Unsupported)*/;

void server_to_adapter (const GblPilotDef::DictLanguageList& serv, LanguagesList& adap);

void category_to_query (const NodeBase* category, GblPilotQueryDef::Query& query);

void convert (const NodePosition& adapter_from, GTree::NodePosition& srv_from);

GTree::NodeIndexPath* adapter_to_server (const NodeIndexPath& adapter_index_path);

void server_to_adapter (GTree::NodeIndexPath* index_path, NodeIndexPath& adap_path);

GblConsultingDef::ClientConsultationStatus adapter_to_server (ConsultationStatus adapter_status);

ConsultationStatus server_to_adapter (GblConsultingDef::ClientConsultationStatus server_status);

unsigned long consultation_status_to_folders_flag (GblConsultingDef::ClientConsultationStatus server_status);

GTree::FindOrder adapter_to_server (FindOrder adapter_order);

GTree::SearchArea adapter_to_server (SearchArea adapter_area);

GTree::ContextPlace adapter_to_server (ContextPlace adapter_place);

// Преобразование серверного списка вида Документ, Саб в адаптерный
void server_to_adapter (const GblPilotDef::DocPointContainer& serv, DocPointList& adap);

//#UC START# *460B956502AF_USER_DEFINITION*
template <class SourceList, class TagetList> 
void copy_intervals (SourceList* source, TagetList& target) {
	CORBA::ULong length = source->length ();
	for (CORBA::ULong i = 0; i < length; ++i) {
		DateInterval date_interval;
		DateTranslator::translate ((*source)[i].m_from, date_interval.start);
		DateTranslator::translate ((*source)[i].m_to, date_interval.finish);
		target.push_back (date_interval);
	}
}
//#UC END# *460B956502AF_USER_DEFINITION*

} // namespace ServerAdapterConverters
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_SERVERADAPTERCONVERTERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
