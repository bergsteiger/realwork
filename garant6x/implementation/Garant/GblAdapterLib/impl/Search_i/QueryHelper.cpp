////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryHelper.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LogicOperationTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
#include "garantServer/src/Business/GblPilot/Home/Adapter.h"

//#UC START# *4CAC44820175_CUSTOM_INCLUDES*
//#UC END# *4CAC44820175_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4CAC44820175*
void QueryHelper::unpack_context (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes) {
	this->check_saved_query ();
	QueryContextAttribute_var attribute (this->get_context_attribute (tag));
	CORBA::ULong size = server_attributes.length ();
	for (CORBA::ULong i = 0; i < size; ++i) {
		GblPilotQueryDef::QueryContextData* context_data;
		if (server_attributes[i] >>=context_data) {
			attribute->add_value (QLO_AND, GCI::IO::String_var (GCI::IO::StringFactory::make (context_data->context_data ())).in ());
		}
	}
}

void QueryHelper::unpack_node (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes) {
	this->check_saved_query ();
	Search_var search (SearchFactory::make ());
	QueryNodeAttribute_var attribute (this->get_node_attribute (tag));
	CORBA::ULong size = server_attributes.length ();

	for (CORBA::ULong i = 0; i < size; ++i) {
		GblPilotQueryDef::QueryDictData* dict_data;
		if (server_attributes[i] >>= dict_data) {
			NodeBase_var attribute_tree_root (Core::TypeTraits<NodeBase>::Factory::make (tag));
			DefaultNodeBase* default_node_base = dynamic_cast <DefaultNodeBase*> (attribute_tree_root.ptr());
			GDS_ASSERT (default_node_base);
			NodeBase_var node = dynamic_cast <NodeBase*> (default_node_base->find_node_by_path (dict_data->node_path ()));
			attribute->add_value (LogicOperationTranslatorSingleton::instance()->get (dict_data->operation ()), node.in ());
		}
	}
}

void QueryHelper::unpack_date (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes) {	
	this->check_saved_query ();
	QueryDateAttribute_var attribute (this->get_date_attribute (tag));
	CORBA::ULong size = server_attributes.length ();
	for (CORBA::ULong i = 0; i < size; ++i) {
		GblPilotQueryDef::QueryDateData* date_data;
		if (server_attributes [i] >>=date_data) {
			Date from, to;										
			DateTranslator::translate (date_data->from (), from);
			DateTranslator::translate (date_data->to (), to);
			attribute->add_value (QLO_AND, from, to);
		}
	}
}

void QueryHelper::unpack_phone_number (
	AttributeTag tag
	, const GblPilotQueryDef::QueryAttributeValueList& server_attributes
) {
	this->check_saved_query ();
	QueryPhoneNumberAttribute_var attribute (this->get_phone_number_attribute (tag));
	CORBA::ULong size = server_attributes.length ();
	GDS_ASSERT_MSG (size == 1, ("Multiple phone numbers unsupported!"));
	for (CORBA::ULong i = 0; i < size; ++i) {
		GblPilotQueryDef::QueryPhoneNumberData* phone_number_data;
		if (server_attributes [i] >>= phone_number_data) {
			attribute->set_city_code (GCI::IO::String_var (GCI::IO::StringFactory::make (phone_number_data->city_code ())).in ());
			attribute->set_phone_number (GCI::IO::String_var (GCI::IO::StringFactory::make (phone_number_data->phone_number ())).in ());
		}
	}
}

void QueryHelper::pack_context (
	QueryAttribute* adapter_attribute
	, GblPilotQueryDef::QueryAttributeValueList& server_list
) {
	QueryContextAttribute* context = dynamic_cast <QueryContextAttribute*> (adapter_attribute);
	GDS_ASSERT (context);
	const ContextValueList& values = context->get_values ();
	server_list.length (values.size ());
	for (size_t i = 0; i < values.size (); ++i) {
		GblPilotQueryDef::QueryContextData_var qcd = new OBV_GblPilotQueryDef::QueryContextData;
		qcd->context_data (values[i].context->get_data ());
		server_list[i] <<= qcd;
	}		
}

void QueryHelper::pack_phone_number (
	QueryAttribute* adapter_attribute
	, GblPilotQueryDef::QueryAttributeValueList& server_list
) {
	QueryPhoneNumberAttribute* phone_number_attribute = dynamic_cast <QueryPhoneNumberAttribute*> (adapter_attribute);
	GDS_ASSERT (phone_number_attribute);
	server_list.length (1);
	GblPilotQueryDef::QueryPhoneNumberData_var qpnd = new OBV_GblPilotQueryDef::QueryPhoneNumberData ();
	const GCI::IO::String& city_code =	phone_number_attribute->get_city_code ();
	const GCI::IO::String& phone_number = phone_number_attribute->get_phone_number ();
	qpnd->city_code (city_code.get_data ());
	qpnd->phone_number (phone_number.get_data ());
	server_list [0] <<= qpnd;
}

void QueryHelper::pack_date (QueryAttribute* adapter_attribute, GblPilotQueryDef::QueryAttributeValueList& server_list) {
	QueryDateAttribute* date = dynamic_cast <QueryDateAttribute*> (adapter_attribute);
	GDS_ASSERT (date);
	const DateValueList& values = date->get_values ();
	server_list.length (values.size ());
	for (size_t i = 0; i < values.size (); ++i) {
		GblPilotQueryDef::QueryDateData_var qdd = new OBV_GblPilotQueryDef::QueryDateData;
		GblPilotDef::DocDate date;
		DateTranslator::translate (values[i].from, date);
		qdd->from (date);
		DateTranslator::translate (values[i].to, date);
		qdd->to (date);
		server_list[i] <<= qdd;
	}		
}


void QueryHelper::pack_node (QueryAttribute* adapter_attribute, GblPilotQueryDef::QueryAttributeValueList& server_list) {
	QueryNodeAttribute* node = dynamic_cast <QueryNodeAttribute*> (adapter_attribute);
	GDS_ASSERT (node);
	const NodeValueList& values = node->get_values ();
	server_list.length (values.size ());
	for (size_t i = 0; i < values.size (); ++i) {
		GblPilotQueryDef::QueryDictData_var qdd = new OBV_GblPilotQueryDef::QueryDictData;
		const DefaultNodeBase* default_node_base = dynamic_cast <const DefaultNodeBase*> (values[i].node.ptr ());
		GTree::NodePath_var node_path = default_node_base->get_server_path ();
		qdd->operation (LogicOperationTranslatorSingleton::instance ()->get (values[i].operation));
		qdd->node_path (node_path.in ());
		server_list[i] <<= qdd;
	}		
}
//#UC END# *4CAC44820175*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryHelper::QueryHelper (QueryType type)
//#UC START# *45EEE145027B_45FFA1AA01D0_4CAC44820175_BASE_INIT*
: m_type (type)
//#UC END# *45EEE145027B_45FFA1AA01D0_4CAC44820175_BASE_INIT*
{
	//#UC START# *45EEE145027B_45FFA1AA01D0_4CAC44820175_BODY*
	//#UC END# *45EEE145027B_45FFA1AA01D0_4CAC44820175_BODY*
}

QueryHelper::~QueryHelper () {
	//#UC START# *4CAC44820175_DESTR_BODY*
	//#UC END# *4CAC44820175_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает 0, если атрибут не найден
QueryAttribute* QueryHelper::find_attribute (AttributeTag_const tag, QueryTagType type) {
	//#UC START# *4CAC4FA503CB*
	for (size_t i = 0; i < m_attributes.size (); ++i) {
		if (std::string (tag) == m_attributes[i]->get_tag () && type == m_attributes[i]->get_type ()) {
			return m_attributes[i]._sretn ();
		}
	}
	return 0;
	//#UC END# *4CAC4FA503CB*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

QueryType QueryHelper::get_type () const {
	//#UC START# *4CAC55F901B5_GET_ACCESSOR*
	return m_type;
	//#UC END# *4CAC55F901B5_GET_ACCESSOR*
}

void QueryHelper::set_type (QueryType type) const {
	//#UC START# *4CAC55F901B5_SET_ACCESSOR*
	m_type = type;
	//#UC END# *4CAC55F901B5_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Query
QueryAttributeList* QueryHelper::attributes_by_tag (AttributeTag_const tag) {
	//#UC START# *45EEE1450286_4CAC44820175*
	this->check_saved_query ();
	std::string required_tag (tag);
	GDS_ASSERT (required_tag.size ()); 
	
	std::vector<size_t> tags;
	for (size_t i = 0; i < m_attributes.size (); ++i) {
		if (m_attributes[i]->get_tag () == required_tag) {
			tags.push_back (i);
		}
	}

	Core::Aptr<QueryAttributeList> query_attribute_list (new QueryAttributeList);
	for (size_t j = 0; j < tags.size (); ++j) {
		query_attribute_list->push_back (m_attributes[tags[j]]);
	}
	
	return query_attribute_list.forget ();
	//#UC END# *45EEE1450286_4CAC44820175*
}

// implemented method from Query
GblPilotQueryDef::Query* QueryHelper::build_query () {
	//#UC START# *462CA74A0150_4CAC44820175*
	this->check_saved_query ();
	GblPilotQueryDef::Query_var query (new GblPilotQueryDef::Query);
	query->type = QueryTypeTranslatorSingleton::instance ()->get (this->get_type ());
	CORBA::ULong length = m_attributes.size ();
	query->attributes.length (length);
	for (CORBA::ULong i = 0; i < length; ++i) {
		GblPilotQueryDef::QueryAttribute& attribute = query->attributes [i];
		attribute.tag = Defines::AttributeTagTranslator::translate (m_attributes[i]->get_tag ());
		switch (m_attributes[i]->get_type ()) {
			case QTT_CONTEXT:
				this->pack_context (m_attributes[i].ptr (), attribute.value);
			    break;
			case QTT_NODE:    
				this->pack_node (m_attributes[i].ptr (), attribute.value);
			    break;
			case QTT_DATE:    
				this->pack_date (m_attributes[i].ptr (), attribute.value);
			    break;
			case QTT_PHONE_NUMBER:    
				this->pack_phone_number (m_attributes[i].ptr (), attribute.value);
			    break;
			default: 
				GDS_ASSERT (!"Invalid attribute type");
		}
	}
	
	return query._retn ();
	//#UC END# *462CA74A0150_4CAC44820175*
}

// implemented method from Query
void QueryHelper::clear () {
	//#UC START# *45EEE1450285_4CAC44820175*
	m_attributes.clear ();
	//#UC END# *45EEE1450285_4CAC44820175*
}

// implemented method from Query
QueryContextAttribute* QueryHelper::get_context_attribute (AttributeTag_const tag) {
	//#UC START# *45EEE145027F_4CAC44820175*
	return this->get_attribute <QueryContextAttribute, Core::TypeTraits<QueryContextAttribute_i>::Factory> (
		tag
		, QTT_CONTEXT
	);
	//#UC END# *45EEE145027F_4CAC44820175*
}

// implemented method from Query
QueryDateAttribute* QueryHelper::get_date_attribute (AttributeTag_const tag) {
	//#UC START# *45EEE1450283_4CAC44820175*
	return this->get_attribute <QueryDateAttribute, Core::TypeTraits<QueryDateAttribute_i>::Factory> (tag, QTT_DATE);
	//#UC END# *45EEE1450283_4CAC44820175*
}

// implemented method from Query
QueryNodeAttribute* QueryHelper::get_node_attribute (AttributeTag_const tag) {
	//#UC START# *45EEE1450281_4CAC44820175*
	return this->get_attribute <QueryNodeAttribute, Core::TypeTraits<QueryNodeAttribute_i>::Factory> (
		tag
		, QTT_NODE
	);
	//#UC END# *45EEE1450281_4CAC44820175*
}

// implemented method from Query
QueryPhoneNumberAttribute* QueryHelper::get_phone_number_attribute (AttributeTag_const tag) {
	//#UC START# *45EEE145028A_4CAC44820175*
	return this->get_attribute <QueryPhoneNumberAttribute, Core::TypeTraits<QueryPhoneNumberAttribute_i>::Factory> (
		tag
		, QTT_PHONE_NUMBER
	);
	//#UC END# *45EEE145028A_4CAC44820175*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

