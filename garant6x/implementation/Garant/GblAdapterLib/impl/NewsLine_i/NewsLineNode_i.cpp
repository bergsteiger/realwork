////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::NewsLine_i::NewsLineNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NewsLineNode_i::NewsLineNode_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *462DC325033C_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)
	, NodeBase_i (owner_tree, snode)
//#UC END# *462DC325033C_BASE_INIT*
{
	//#UC START# *462DC325033C_BODY*
	//#UC END# *462DC325033C_BODY*
}

NewsLineNode_i::NewsLineNode_i ()
//#UC START# *462DC341034B_BASE_INIT*
//#UC END# *462DC341034B_BASE_INIT*
{
	//#UC START# *462DC341034B_BODY*
	GDS_ASSERT (false);
	//#UC END# *462DC341034B_BODY*
}

NewsLineNode_i::~NewsLineNode_i () {
	//#UC START# *4601093D02EE_DESTR_BODY*
	//#UC END# *4601093D02EE_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* NewsLineNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_4601093D02EE_GET*
	GTree::NodeEntity_var server_entity = this->entity ();
	// try extract Query
	GblPilot::AutoReferatDoc* autoreferat_doc;
	if (*server_entity >>= autoreferat_doc) {
		Document_var document = DocumentFactory::make (autoreferat_doc, FK_AUTOREFERAT_DOCUMENT);
		return Core::IObject::_duplicate (document.in ());
	}

	// try extract AutoReferatDoc
	GblPilot::AutoReferatList* autoreferat_list;
	if (*server_entity >>= autoreferat_list) {
		GblPilot::AutoReferatDoc_var autoreferat = autoreferat_list->get_autoreferat ();
		Document_var document = DocumentFactory::make (autoreferat.in (), FK_AUTOREFERAT_DOCUMENT);
		return Core::IObject::_duplicate (document.in ());
	}
	
	throw NoEntity ();
	//#UC END# *45F65BEA00DA_4601093D02EE_GET*
}

EntityBase* NewsLineNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const NewsLineNode_i*)this)->get_entity ());
}

void NewsLineNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_4601093D02EE_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_4601093D02EE_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

