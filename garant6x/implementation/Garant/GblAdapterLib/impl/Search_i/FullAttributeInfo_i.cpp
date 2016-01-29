////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FullAttributeInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LogicOperationTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FullAttributeInfo_i::FullAttributeInfo_i (const GblPilotQueryDef::FullAttributeInfo& full_info)
//#UC START# *4CCAA696021D_4CCA78470101_4CCA78B800ED_BASE_INIT*
//#UC END# *4CCAA696021D_4CCA78470101_4CCA78B800ED_BASE_INIT*
{
	//#UC START# *4CCAA696021D_4CCA78470101_4CCA78B800ED_BODY*
	m_tag = full_info.tag.in ();

	for (CORBA::ULong i = 0; i < full_info.available_operations.length (); ++i) {
		m_available_operations.push_back (
			LogicOperationTranslatorSingleton::instance ()->get (full_info.available_operations [i])
		);
	}

	GblPilotQueryDef::NullDefaultValue* null_default;
	const char* context_value;
	GTree::NodePath* node_path;
	if (full_info.default_value >>= null_default) {
		// оставляем m_default_value пустым
	} else if (full_info.default_value >>= context_value) {
		QueryContextAttribute* query_context_attribute = QueryContextAttributeFactory::make (m_tag.c_str ());
		query_context_attribute->add_value (
			QLO_OR
			, GCI::IO::String_var (GCI::IO::StringFactory::make (context_value)).in ()
		);
		m_default_value = query_context_attribute;
	} else {
		if (full_info.default_value >>= node_path) {
			QueryNodeAttribute* query_node_attribute = QueryNodeAttributeFactory::make (m_tag.c_str ());
			Search_cvar search = SearchFactory::make ();
			NodeBase_var attribute_tree_root = Core::TypeTraits<NodeBase>::Factory::make (m_tag.c_str ());
			DefaultNodeBase* node_base = dynamic_cast <DefaultNodeBase*> (attribute_tree_root.ptr ());
			GDS_ASSERT (node_base);
			NodeBase_var node = dynamic_cast <NodeBase*> (node_base->find_node_by_path (*node_path));
			query_node_attribute->add_value (QLO_OR, node.in ());
			m_default_value = query_node_attribute;
		}
	}
	//#UC END# *4CCAA696021D_4CCA78470101_4CCA78B800ED_BODY*
}

FullAttributeInfo_i::~FullAttributeInfo_i () {
	//#UC START# *4CCA78B800ED_DESTR_BODY*
	//#UC END# *4CCA78B800ED_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AttributeInfo
const OperationList& FullAttributeInfo_i::get_available_operations () const {
	//#UC START# *45F115F702DB_4CCA78B800ED_GET*
	return m_available_operations;
	//#UC END# *45F115F702DB_4CCA78B800ED_GET*
}

// implemented method from AttributeInfo
// Получить дефолтное значение атрибута
QueryAttribute* FullAttributeInfo_i::get_default_value () const {
	//#UC START# *45F115DD01E2_4CCA78B800ED*
	return m_default_value._sretn ();
	//#UC END# *45F115DD01E2_4CCA78B800ED*
}

// implemented method from AttributeInfo
bool FullAttributeInfo_i::get_is_exist () const {
	//#UC START# *45F115DD01E3_4CCA78B800ED_GET*
	return true;
	//#UC END# *45F115DD01E3_4CCA78B800ED_GET*
}

// implemented method from FullAttributeInfo
const GCI::IO::String* FullAttributeInfo_i::get_tag () const {
	//#UC START# *4CCAA6D101AA_4CCA78B800ED_GET*
	return GCI::IO::StringFactory::make (m_tag.c_str ());
	//#UC END# *4CCAA6D101AA_4CCA78B800ED_GET*
}

GCI::IO::String* FullAttributeInfo_i::get_tag () {
	return const_cast<GCI::IO::String*>(((const FullAttributeInfo_i*)this)->get_tag ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

