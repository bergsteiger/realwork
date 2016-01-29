////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributeInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Business/GblPilot/Home/Adapter.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LogicOperationTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AttributeInfo_i::AttributeInfo_i (AttributeTag_const tag)
//#UC START# *46013D9303AF_BASE_INIT*
//#UC END# *46013D9303AF_BASE_INIT*
{
	//#UC START# *46013D9303AF_BODY*
	this->fill_attribute_info (tag);
	
	// TODO: !!! Now not suppoted next attributes:
	//AT_NAME
	//AT_LEGAL_FORCE
	//AT_REVISION_DATE
	//AT_PUBLISHING_DATE
	//AT_LAST_EDITION_DATE
	//AT_FILE_POSITION
	//AT_REG_DATE
	//AT_INCLUDE_DATE
	//AT_EDITED_DATE
	//AT_NO_ACTIVE_DATE
	//AT_SORT_DATE
	//AT_ANONCE_DATE
	//AT_NO_CONTROL_DATE
	//AT_WARNING
	//AT_CLASS
	//AT_SIZE
	//AT_TEXT
	//AT_INTERNAL_HANDLE
	//AT_CLIENT_NAME
	//AT_CLIENT_REG_NUM
	//AT_DEALER_NAME
	//AT_COMPLECT_NAME
	//AT_COMPLECT_VER
	//AT_THEMES_NAME
	//AT_EMAIL
	//AT_ANNO_DATE
	//AT_INCLUDE_DATE_SHORT

	//#UC END# *46013D9303AF_BODY*
}

AttributeInfo_i::~AttributeInfo_i () {
	//#UC START# *4601290C02F8_DESTR_BODY*
	//#UC END# *4601290C02F8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void AttributeInfo_i::fill_attribute_info (AttributeTag_const tag) const {
	//#UC START# *46013D5A0333*
	if (m_exist.is_nil ()) {
		GblPilotQueryDef::AttributeInfo_var server_attribute_info =  
			ApplicationHelper::instance ()->get_cached_search_manager ()->get_attribute_info (
				Defines::AttributeTagTranslator::translate (tag)
			);
		
		m_exist = new bool (server_attribute_info->is_exist);

		CORBA::ULong size = server_attribute_info->available_operations.length ();
		
		for (CORBA::ULong i = 0; i < size; ++i) {
			m_available_operations.push_back (
				LogicOperationTranslatorSingleton::instance ()->get (server_attribute_info->available_operations [i])
			);
		}

		m_default_value = 0;
		// Зачитываем дефолтное значение для атрибута
		GblPilotQueryDef::DefaultValueList_var default_value_list;
		try {
			default_value_list = ApplicationHelper::instance ()->get_cached_search_manager ()->get_default_value (
				Defines::AttributeTagTranslator::translate (tag)
			);
		} catch (...) {
		}
		if (default_value_list.ptr () && default_value_list->length ()) {
			const char* context_value;
			if ((*default_value_list) [0] >>= context_value) {
				QueryContextAttribute* query_context_attribute = QueryContextAttributeFactory::make (tag);
				for (unsigned i = 0; i < default_value_list->length (); i++) {
					if ((*default_value_list) [i] >>= context_value) {
						query_context_attribute->add_value (
							QLO_OR
							, GCI::IO::String_var (GCI::IO::StringFactory::make (context_value)).in ()
						);
					}
				}
				m_default_value = query_context_attribute;
			} else {
				GTree::NodePath* node_path;
				if ((*default_value_list) [0] >>= node_path) {
					QueryNodeAttribute* query_node_attribute = QueryNodeAttributeFactory::make (tag);
					Search_cvar search = SearchFactory::make ();
					NodeBase_var attribute_tree_root = Core::TypeTraits<NodeBase>::Factory::make (tag);
					DefaultNodeBase* node_base = dynamic_cast <DefaultNodeBase*> (attribute_tree_root.ptr ());
					GDS_ASSERT (node_base);
					for (unsigned i = 0; i < default_value_list->length (); i++) {
						if ((*default_value_list) [i] >>= node_path) {
							NodeBase_var node = dynamic_cast <NodeBase*> (node_base->find_node_by_path (*node_path));
							query_node_attribute->add_value (QLO_OR, node.in ());
						}
					}
					m_default_value = query_node_attribute;
				}
			}
		}
	}
	//#UC END# *46013D5A0333*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AttributeInfo
const OperationList& AttributeInfo_i::get_available_operations () const {
	//#UC START# *45F115F702DB_4601290C02F8_GET*
	return m_available_operations;
	//#UC END# *45F115F702DB_4601290C02F8_GET*
}

// implemented method from AttributeInfo
// Получить дефолтное значение атрибута
QueryAttribute* AttributeInfo_i::get_default_value () const {
	//#UC START# *45F115DD01E2_4601290C02F8*
	return m_default_value.ptr () ? m_default_value._sretn () : throw NoDefaultValue ();
	//#UC END# *45F115DD01E2_4601290C02F8*
}

// implemented method from AttributeInfo
bool AttributeInfo_i::get_is_exist () const {
	//#UC START# *45F115DD01E3_4601290C02F8_GET*
	return *m_exist;
	//#UC END# *45F115DD01E3_4601290C02F8_GET*
}

// implemented method from BaseUpdateChecker_i
void AttributeInfo_i::clear_cache () {
	//#UC START# *45702DA9037A_4601290C02F8*
	m_exist.reset ();
	m_available_operations.clear ();
	m_default_value = 0;
	//#UC END# *45702DA9037A_4601290C02F8*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

