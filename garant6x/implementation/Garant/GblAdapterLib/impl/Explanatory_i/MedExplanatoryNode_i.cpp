////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::MedExplanatoryNode_i
//
// Узел для словарной статьи мед. термина
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MedExplanatoryNode_i::MedExplanatoryNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *47CBC39401D1_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)
	, NodeBase_i (owner_tree, snode)
//#UC END# *47CBC39401D1_BASE_INIT*
{
	//#UC START# *47CBC39401D1_BODY*
	//#UC END# *47CBC39401D1_BODY*
}

MedExplanatoryNode_i::MedExplanatoryNode_i ()
//#UC START# *47CBC39F020E_BASE_INIT*
//#UC END# *47CBC39F020E_BASE_INIT*
{
	//#UC START# *47CBC39F020E_BODY*
	GDS_ASSERT (false);
	//#UC END# *47CBC39F020E_BODY*
}

MedExplanatoryNode_i::~MedExplanatoryNode_i () {
	//#UC START# *47CBBE6301C2_DESTR_BODY*
	//#UC END# *47CBBE6301C2_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* MedExplanatoryNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_47CBBE6301C2_GET*
	try {
		GTree::NodeEntity_var server_entity = this->entity ();

		GblPilot::PharmDictDocument* doc;
		if (*server_entity >>= doc) {
			return DocumentFactory::make (doc, FK_PHARM_DICT_DOCUMENT);
		}
	} catch (GCD::CanNotFindData&) {
	} catch (GTree::InvalidPointer&) {
	} 
	throw NoEntity (); 
	//#UC END# *45F65BEA00DA_47CBBE6301C2_GET*
}

EntityBase* MedExplanatoryNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const MedExplanatoryNode_i*)this)->get_entity ());
}

void MedExplanatoryNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_47CBBE6301C2_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_47CBBE6301C2_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

