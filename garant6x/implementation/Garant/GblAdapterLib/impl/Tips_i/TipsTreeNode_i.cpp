////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsTreeNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TipsTreeNode_i::TipsTreeNode_i ()
//#UC START# *45EEB95901C5_45F6694A01B5_47B71AFC018F_BASE_INIT*
//#UC END# *45EEB95901C5_45F6694A01B5_47B71AFC018F_BASE_INIT*
{
	//#UC START# *45EEB95901C5_45F6694A01B5_47B71AFC018F_BODY*
	//#UC END# *45EEB95901C5_45F6694A01B5_47B71AFC018F_BODY*
}

TipsTreeNode_i::TipsTreeNode_i (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
//#UC START# *45EEB95901C5_45FFF849002E_47B71AFC018F_BASE_INIT*
	: RealNodeBase (dynamic_cast <TreeBase*> (owner_tree), snode)
	, DefaultNodeBase (dynamic_cast <TreeBase*> (owner_tree))	
	, NodeBase_i (dynamic_cast <TreeBase*> (owner_tree), snode)
//#UC END# *45EEB95901C5_45FFF849002E_47B71AFC018F_BASE_INIT*
{
	//#UC START# *45EEB95901C5_45FFF849002E_47B71AFC018F_BODY*
	//#UC END# *45EEB95901C5_45FFF849002E_47B71AFC018F_BODY*
}

TipsTreeNode_i::~TipsTreeNode_i () {
	//#UC START# *47B71AFC018F_DESTR_BODY*
	//#UC END# *47B71AFC018F_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* TipsTreeNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_47B71AFC018F_GET*
	try {
		GTree::Tree_var tree = this->owner_tree ()->get_server_tree ();
		GblPilot::TipsTree_var tips_tree = GblPilot::TipsTree::_narrow (tree.in ());
		GblPilot::TipDocument_var tip_document = tips_tree->get_tip_document (this->get_server_pointer ());
		Document_var document = DocumentFactory::make (tip_document.in (), FK_TIP_DOCUMENT);
		return Core::IObject::_duplicate (document.in ());
	} catch (GCD::CanNotFindData&) {
	} catch (GTree::InvalidPointer&) {
	}
	throw NoEntity();
	//#UC END# *45F65BEA00DA_47B71AFC018F_GET*
}

EntityBase* TipsTreeNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const TipsTreeNode_i*)this)->get_entity ());
}

void TipsTreeNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_47B71AFC018F_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_47B71AFC018F_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

