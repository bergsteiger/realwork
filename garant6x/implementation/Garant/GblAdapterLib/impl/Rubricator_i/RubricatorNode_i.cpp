////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Rubricator_i::RubricatorNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/NodeTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RubricatorNode_i::RubricatorNode_i ()
//#UC START# *462F2CB303A9_BASE_INIT*
//#UC END# *462F2CB303A9_BASE_INIT*
{
	//#UC START# *462F2CB303A9_BODY*
	GDS_ASSERT (false);
	//#UC END# *462F2CB303A9_BODY*
}

RubricatorNode_i::RubricatorNode_i (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
//#UC START# *462F2CCB034B_BASE_INIT*
	: RealNodeBase (dynamic_cast <TreeBase*> (owner_tree), snode)
	, DefaultNodeBase (dynamic_cast <TreeBase*> (owner_tree))	
	, NodeBase_i (dynamic_cast <TreeBase*> (owner_tree), snode)
//#UC END# *462F2CCB034B_BASE_INIT*
{
	//#UC START# *462F2CCB034B_BODY*
	GblPilotDef::RubricatorValue* rv = GblPilotDef::RubricatorValue::_downcast(snode.value.in ());
	m_node_type = NodeTypeTranslatorSingleton::instance ()->get (rv->type ());
	//#UC END# *462F2CCB034B_BODY*
}

RubricatorNode_i::~RubricatorNode_i () {
	//#UC START# *45F5869600A0_DESTR_BODY*
	//#UC END# *45F5869600A0_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* RubricatorNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_45F5869600A0_GET*
	try {
		GTree::NodeEntity_var server_entity = this->entity ();

		GblDocList::DocListTree* server_list;
		if ((*server_entity >>= server_list)) {
			return Core::TypeTraits<DynList>::Factory::make (server_list);
		}
	} catch (GCD::CanNotFindData&) {
	} catch (GTree::InvalidPointer&) {
	}
	throw NoEntity ();
	//#UC END# *45F65BEA00DA_45F5869600A0_GET*
}

EntityBase* RubricatorNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const RubricatorNode_i*)this)->get_entity ());
}

void RubricatorNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_45F5869600A0_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_45F5869600A0_SET*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType RubricatorNode_i::get_type () const {
	//#UC START# *45EEB9590224_45F5869600A0_GET*
	return m_node_type; 
	//#UC END# *45EEB9590224_45F5869600A0_GET*
}

void RubricatorNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_45F5869600A0_SET*
	throw ConstantModify ();
	//#UC END# *45EEB9590224_45F5869600A0_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

