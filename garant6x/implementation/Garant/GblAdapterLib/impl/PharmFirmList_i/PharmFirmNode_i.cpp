////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PharmFirmNode_i::PharmFirmNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *47E8EBB70168_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)
	, NodeBase_i (owner_tree, snode)
//#UC END# *47E8EBB70168_BASE_INIT*
{
	//#UC START# *47E8EBB70168_BODY*
	//#UC END# *47E8EBB70168_BODY*
}

PharmFirmNode_i::PharmFirmNode_i ()
//#UC START# *47E8EBCF01ED_BASE_INIT*
//#UC END# *47E8EBCF01ED_BASE_INIT*
{
	//#UC START# *47E8EBCF01ED_BODY*
	GDS_ASSERT (false);
	//#UC END# *47E8EBCF01ED_BODY*
}

PharmFirmNode_i::~PharmFirmNode_i () {
	//#UC START# *47E8EB4B0169_DESTR_BODY*
	//#UC END# *47E8EB4B0169_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* PharmFirmNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_47E8EB4B0169_GET*
	try {
		GTree::NodeEntity_var server_entity = this->entity ();

		GCD::ObjectID id;
		if ((*server_entity >>= id)) {
			return PharmFirmListEntryFactory::make (id);
		}
	} catch (GTree::InvalidPointer&) {
	}
	
	GDS_ASSERT (false);
	throw NoEntity (); 
	//#UC END# *45F65BEA00DA_47E8EB4B0169_GET*
}

EntityBase* PharmFirmNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const PharmFirmNode_i*)this)->get_entity ());
}

void PharmFirmNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_47E8EB4B0169_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_47E8EB4B0169_SET*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType PharmFirmNode_i::get_type () const {
	//#UC START# *45EEB9590224_47E8EB4B0169_GET*
	return LNT_FIRM;
	//#UC END# *45EEB9590224_47E8EB4B0169_GET*
}

void PharmFirmNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_47E8EB4B0169_SET*
	throw ConstantModify ();
	//#UC END# *45EEB9590224_47E8EB4B0169_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

