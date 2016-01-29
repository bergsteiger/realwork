////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::ServerAdapterConverters
// Файл реализации утилитного набора ServerAdapterConverters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LanguagesTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

//#UC START# *460B956502AF_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"
//#UC END# *460B956502AF_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace ServerAdapterConverters {

//#UC START# *460B956502AF*
//#UC END# *460B956502AF*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

GCD::PID adapter_to_server (const PId& adap) {
	//#UC START# *460B95A600CB*
	GCD::PID serv;
	serv.m_class_id = adap.class_id;
	serv.m_object_id = adap.object_id;
	return serv;
	//#UC END# *460B95A600CB*
}

void adapter_to_server (const PositionList& adap, GblPilotDef::SubParaList& serv) /*throw (Unsupported)*/ {
	//#UC START# *460BAE0903B9*
	CORBA::ULong length = adap.size ();
	serv.length (length);

	for (CORBA::ULong i = 0; i < length; ++i) {
		GblPilotDef::SubPara& sub_para = serv [i];
		adapter_to_server (adap[i], sub_para);
	}
	//#UC END# *460BAE0903B9*
}

void adapter_to_server (const Position& adap, GblPilotDef::SubPara& serv) /*throw (Unsupported)*/ {
	//#UC START# *460CCAA201E4*
	switch (adap.type) {
	case PT_PARA:
		serv.m_sub = 0;
		serv.m_para = adap.point;
		break;
	case PT_SUB:
		serv.m_sub = adap.point;
		serv.m_para = 0;
		break;
	case PT_BOOKMARK: {
		FoldersNode_var folders_node (FoldersFactory::make ().find_folder_node (adap.point));
		Core::IObject_var base_entity (static_cast<Node*> (folders_node.ptr ())->open ());
		Bookmark* bookmark = dynamic_cast <Bookmark*> (base_entity.ptr ());
		serv.m_sub = 0;
		serv.m_para = bookmark->get_paragraph ();
		break;
	}
	default:
		throw Unsupported ();
	}
	//#UC END# *460CCAA201E4*
}

GTree::NodeIndexPath* adapter_to_server (const NodeIndexPath& adapter_index_path) {
	//#UC START# *47B6D48902FA*
	const long len = adapter_index_path.size ();
	GTree::NodeIndexPath_var ip = new GTree::NodeIndexPath;
	ip->length (len);
	for (long i = 0; i < len; ++i) {
		ip [i] = adapter_index_path[i];
	}
	return ip._retn ();
	//#UC END# *47B6D48902FA*
}

GblConsultingDef::ClientConsultationStatus adapter_to_server (ConsultationStatus adapter_status) {
	//#UC START# *486B36420166*
	GblConsultingDef::ClientConsultationStatus server_status = GblConsultingDef::CCS_NOT_DEFINED;
	if (adapter_status & CS_SENT) {
		server_status |= GblConsultingDef::CCS_SENT;
	}
	if (adapter_status & CS_PAYMENT_REQUEST) {
		server_status |= GblConsultingDef::CCS_PAYMENT_REQUEST;
	}
	if (adapter_status & CS_ANSWER_RECEIVED) {
		server_status |= GblConsultingDef::CCS_ANSWER_RECEIVED;
	}
	if (adapter_status & CS_ANSWER_NOT_CONFIRM) {
		server_status |= GblConsultingDef::CCS_ANSWER_NOT_CONFIRM;
	}
	if (adapter_status & CS_READ) {
		server_status |= GblConsultingDef::CCS_READ;
	}
	if (adapter_status & CS_READ_NOT_CONFIRM) {
		server_status |= GblConsultingDef::CCS_READ_NOT_CONFIRM;
	}
	if (adapter_status & CS_ESTIMATION_SENT) {
		server_status |= GblConsultingDef::CCS_ESTIMATION_SENT;
	}
	if (adapter_status & CS_DRAFTS) {
		server_status |= GblConsultingDef::CCS_CREATED;
	}
	if (adapter_status & CS_PAYMENT_REFUSAL) {
		server_status |= GblConsultingDef::CCS_PAYMENT_REFUSAL;
	}
	if (adapter_status & CS_PAYMENT_CONFIRM) {
		server_status |= GblConsultingDef::CCS_PAYMENT_CONFIRM;
	}
	if (adapter_status & CS_VALIDATION_FAILED) {
		server_status |= GblConsultingDef::CCS_VALIDATION_FAILED;
	}
	return server_status;
	//#UC END# *486B36420166*
}

GTree::FindOrder adapter_to_server (FindOrder adapter_order) {
	//#UC START# *4D3EABF5008B*
	switch (adapter_order) {
		case FO_SEQUENCE: return GTree::FO_SEQUENCE;
		case FO_ANY:      return GTree::FO_ANY;
		default: GDS_ASSERT (false);
	}
	return GTree::FO_ANY;
	//#UC END# *4D3EABF5008B*
}

GTree::SearchArea adapter_to_server (SearchArea adapter_area) {
	//#UC START# *4D3EACE502A5*
	switch (adapter_area) {
		case SA_ONE_LEVEL:        return GTree::SA_ONE_LEVEL;
		case SA_ALL_LEVEL:        return GTree::SA_ALL_LEVEL;
		case SA_IN_ALL_TEXT:      return GTree::SA_IN_ALL_TEXT;
		case SA_IN_ONE_SENTENCES: return GTree::SA_IN_ONE_SENTENCES;
		default: GDS_ASSERT (false);
	}
	return GTree::SA_ALL_LEVEL;
	//#UC END# *4D3EACE502A5*
}

GTree::ContextPlace adapter_to_server (ContextPlace adapter_place) {
	//#UC START# *4D3EAD0C00A5*
	switch (adapter_place) {
		case CP_ANY:             return GTree::CP_ANY;
		case CP_BEGIN_OF_PHRASE: return GTree::CP_BEGIN_OF_PHRASE;
		case CP_BEGIN_OF_WORD:   return GTree::CP_BEGIN_OF_WORD;
		case CP_WHOLE_WORD:      return GTree::CP_WHOLE_WORD;
		default: GDS_ASSERT (false);
	}
	return GTree::CP_ANY;
	//#UC END# *4D3EAD0C00A5*
}

void category_to_query (const NodeBase* category, GblPilotQueryDef::Query& query) {
	//#UC START# *460BB2E5036B*
	query.type = GblPilotQueryDef::QT_DETAIL;
	if (category != 0) {
		Query_var adapter_query = QueryFactory::make (QT_DETAIL); 
		QueryNodeAttribute_var attribute =
			adapter_query->get_node_attribute (
				const_cast<AttributeTag> (dynamic_cast<const NodeBase_i*> (category)->get_tree_name ())
			);
		attribute->add_value (QLO_OR, const_cast <NodeBase*> (category));
		GblPilotQueryDef::Query_var server_query (adapter_query->build_query ());
		query = *server_query.ptr ();
	}
	//#UC END# *460BB2E5036B*
}

unsigned long consultation_status_to_folders_flag (GblConsultingDef::ClientConsultationStatus server_status) {
	//#UC START# *486B4C8900FE*
	unsigned long flag = 0;
	if (server_status & GblConsultingDef::CCS_SENT) {
		flag |= NF_CONSULTATION_SENT;
	}
	if (server_status & GblConsultingDef::CCS_PAYMENT_REQUEST) {
		flag |= NF_PAYMENT_REQUEST;
	}
	if (server_status & GblConsultingDef::CCS_ANSWER_RECEIVED) {
		flag |= NF_ANSWER_RECEIVED;
	}
	if (server_status & GblConsultingDef::CCS_ANSWER_NOT_CONFIRM) {
		flag |= NF_ANSWER_RECEIVED;
	}
	if (server_status & GblConsultingDef::CCS_READ_NOT_CONFIRM) {
		flag |= NF_ANSWER_READ;
	}
	if (server_status & GblConsultingDef::CCS_READ) {
		flag |= NF_ANSWER_READ;
	}
	if (server_status & GblConsultingDef::CCS_ESTIMATION_SENT) {
		flag |= NF_ESTIMATION_SENT;
	}
	if (server_status & GblConsultingDef::CCS_PAYMENT_REFUSAL) {
		flag |= NF_PAYMENT_REFUSAL;
	}
	if (server_status & GblConsultingDef::CCS_PAYMENT_CONFIRM) {
		flag |= NF_PAYMENT_CONFIRM;
	}
	if (server_status & GblConsultingDef::CCS_CREATED) {
		flag |= NF_DRAFTS;
	}
	if (server_status & GblConsultingDef::CCS_VALIDATION_FAILED) {
		flag |= NF_VALIDATION_FAILED;
	}
	return flag;
	//#UC END# *486B4C8900FE*
}

void convert (const NodePosition& adapter_from, GTree::NodePosition& srv_from) {
	//#UC START# *46151F7E0399*
	srv_from.pos = adapter_from.pos;

	const NodeBase_i* from_child = dynamic_cast<const NodeBase_i*> (adapter_from.node.ptr ());
	if (from_child) {
		srv_from.node.child_pointer = from_child->get_server_pointer ();
	} else {
		srv_from.node.child_pointer = GTree::ROOT_POINT;
	}
	
	NodeBase_i_cvar from_parent = 0;
	if (from_child) {
		from_parent = dynamic_cast<const NodeBase_i*> (from_child->get_parent ());
	}
	if (from_parent.ptr ()) {
		srv_from.node.parent_pointer = from_parent->get_server_pointer ();
	} else {
		srv_from.node.parent_pointer = GTree::ROOT_POINT;
	}
	//#UC END# *46151F7E0399*
}

void server_to_adapter (const GblPilotDef::SubPara& serv, Position& adap) /*throw (Unsupported)*/ {
	//#UC START# *460BAC17029F*
	if (!serv.m_sub) {
		adap.type = PT_PARA;
		adap.point = serv.m_para;
	} else if (!serv.m_para) {
		adap.type = PT_SUB;
		adap.point = serv.m_sub;
	} else {
		throw Unsupported();
	}
	//#UC END# *460BAC17029F*
}

void server_to_adapter (const GblPilotDef::SubParaList& serv, PositionList*& adap) /*throw (Unsupported)*/ {
	//#UC START# *460BADAA00EA*

	unsigned long length = serv.length();
	adap = new PositionList (length);

	for (unsigned long i = 0; i < length; ++i) {
		server_to_adapter (serv [i], adap->operator [] (i));		
	}
	//#UC END# *460BADAA00EA*
}

void server_to_adapter (const GblPilotDef::DictLanguageList& serv, LanguagesList& adap) {
	//#UC START# *460BB2AF01C5*
	CORBA::ULong length = serv.length ();
	for (CORBA::ULong i = 0; i < length; ++i) {
		adap.push_back (LanguagesTranslatorSingleton::instance()->get (serv[i]));
	}
	//#UC END# *460BB2AF01C5*
}

void server_to_adapter (GTree::NodeIndexPath* index_path, NodeIndexPath& adap_path) {
	//#UC START# *47B6D5B502D3*
	adap_path.clear ();
	const CORBA::ULong len = index_path->length ();
	adap_path.reserve (len);
	for (CORBA::ULong i = 0; i < len; ++i) {
		adap_path.push_back (index_path->operator [] (i));
	}
	//#UC END# *47B6D5B502D3*
}

ConsultationStatus server_to_adapter (GblConsultingDef::ClientConsultationStatus server_status) {
	//#UC START# *486B3685024C*
	ConsultationStatus adapter_status = 0;
	if (server_status & GblConsultingDef::CCS_SENT) {
		adapter_status |= CS_SENT;
	}
	if (server_status & GblConsultingDef::CCS_PAYMENT_REQUEST) {
		adapter_status |= CS_PAYMENT_REQUEST;
	}
	if (server_status & GblConsultingDef::CCS_ANSWER_RECEIVED) {
		adapter_status |= CS_ANSWER_RECEIVED;
	}
	if (server_status & GblConsultingDef::CCS_ANSWER_NOT_CONFIRM) {
		adapter_status |= CS_ANSWER_NOT_CONFIRM;
	}
	if (server_status & GblConsultingDef::CCS_READ) {
		adapter_status |= CS_READ;
	}
	if (server_status & GblConsultingDef::CCS_READ_NOT_CONFIRM) {
		adapter_status |= CS_READ_NOT_CONFIRM;
	}
	if (server_status & GblConsultingDef::CCS_ESTIMATION_SENT) {
		adapter_status |= CS_ESTIMATION_SENT;
	}
	if (server_status & GblConsultingDef::CCS_CREATED) {
		adapter_status |= CS_DRAFTS;
	}
	if (server_status & GblConsultingDef::CCS_PAYMENT_REFUSAL) {
		adapter_status |= CS_PAYMENT_REFUSAL;
	}
	if (server_status & GblConsultingDef::CCS_PAYMENT_CONFIRM) {
		adapter_status |= CS_PAYMENT_CONFIRM;
	}
	if (server_status & GblConsultingDef::CCS_VALIDATION_FAILED) {
		adapter_status |= CS_VALIDATION_FAILED;
	}
	return adapter_status;
	//#UC END# *486B3685024C*
}

// Преобразование серверного списка вида Документ, Саб в адаптерный
void server_to_adapter (const GblPilotDef::DocPointContainer& serv, DocPointList& adap) {
	//#UC START# *4DCCD8970014*
	const CORBA::ULong len = serv.length ();
	adap.reserve (len);
	for (CORBA::ULong i = 0; i < len; ++i) {
		DocPoint doc_point;
		doc_point.doc_id = serv [i].doc;
		doc_point.sub_id = serv [i].sub;
		adap.push_back (doc_point);
	}
	//#UC END# *4DCCD8970014*
}

} // namespace ServerAdapterConverters
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

