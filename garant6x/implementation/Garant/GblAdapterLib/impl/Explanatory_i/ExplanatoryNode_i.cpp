////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::ExplanatoryNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExplanatoryNode_i::ExplanatoryNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *462C9D940109_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)
	, NodeBase_i (owner_tree, snode)
//#UC END# *462C9D940109_BASE_INIT*
{
	//#UC START# *462C9D940109_BODY*
	//#UC END# *462C9D940109_BODY*
}

ExplanatoryNode_i::ExplanatoryNode_i ()
//#UC START# *462CA5AE01D4_BASE_INIT*
//#UC END# *462CA5AE01D4_BASE_INIT*
{
	//#UC START# *462CA5AE01D4_BODY*
	GDS_ASSERT (false);
	//#UC END# *462CA5AE01D4_BODY*
}

ExplanatoryNode_i::~ExplanatoryNode_i () {
	//#UC START# *45FFE376004E_DESTR_BODY*
	//#UC END# *45FFE376004E_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* ExplanatoryNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_45FFE376004E_GET*
	try {
		GTree::Tree_var tree = this->owner_tree ()->get_server_tree ();
		GblPilot::DictTree_var dict_tree = GblPilot::DictTree::_narrow (tree);
		// надо переделать на open_entity!!!
		GblPilot::DictDocument_var dict_document = dict_tree->get_explanatory (this->get_server_pointer ());
		Document_var document = DocumentFactory::make (dict_document.in (), FK_DICT_DOCUMENT);
		return Core::IObject::_duplicate (document.in ());
	} catch (GCD::CanNotFindData&) {
	} catch (GTree::InvalidPointer&) {
	}
	throw NoEntity();
	//#UC END# *45F65BEA00DA_45FFE376004E_GET*
}

EntityBase* ExplanatoryNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const ExplanatoryNode_i*)this)->get_entity ());
}

void ExplanatoryNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_45FFE376004E_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_45FFE376004E_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

