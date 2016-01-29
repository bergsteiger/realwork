////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::AnalysisNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AnalysisNode_i::AnalysisNode_i (TreeBase* owner_tree, const GTree::Node& node)
//#UC START# *4A9F8A1501E0_BASE_INIT*
	: RealNodeBase (owner_tree, node)
	, DefaultNodeBase (owner_tree)
	, NodeBase_i (owner_tree, node)
//#UC END# *4A9F8A1501E0_BASE_INIT*
{
	//#UC START# *4A9F8A1501E0_BODY*
	m_has_list = ACE_OS::strstr (node.name.data.in (), "(0)") ? false : true;
	//#UC END# *4A9F8A1501E0_BODY*
}

AnalysisNode_i::~AnalysisNode_i () {
	//#UC START# *4A9E6EDC03D7_DESTR_BODY*
	//#UC END# *4A9E6EDC03D7_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Если узел пуст, он показывается свернутым с нулем напротив в скобках. Если в нем что-то есть, то
// разворачивается.
void AnalysisNode_i::expand_if_needed () {
	//#UC START# *4DAE85470152*
	if (m_has_list && this->has_children ()) {
		this->set_flag (FM_OPEN, true);
	}
	//#UC END# *4DAE85470152*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
const EntityBase* AnalysisNode_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_4A9E6EDC03D7_GET*
	try {
		GTree::NodeEntity_var server_entity = this->entity ();

		GblDocList::DocListTree* server_list;
		if ((*server_entity >>= server_list)) {
			return Core::TypeTraits<DynList>::Factory::make (server_list);
		}
	} catch (GTree::InvalidPointer&) {
		throw NoEntity ();
	}

	throw NoEntity ();
	//#UC END# *45F65BEA00DA_4A9E6EDC03D7_GET*
}

EntityBase* AnalysisNode_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const AnalysisNode_i*)this)->get_entity ());
}

void AnalysisNode_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_4A9E6EDC03D7_SET*
	GDS_ASSERT (false);
	//#UC END# *45F65BEA00DA_4A9E6EDC03D7_SET*
}

// overloaded method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType AnalysisNode_i::get_type () const {
	//#UC START# *45EEB9590224_4A9E6EDC03D7_GET*
	if (m_has_list) {
		return DLF_ANALYSIS_NODE_HAS_DATA;
	}

	return DLF_ANALYSIS_NODE_EMPTY;
	//#UC END# *45EEB9590224_4A9E6EDC03D7_GET*
}

void AnalysisNode_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_4A9E6EDC03D7_SET*
	GDS_ASSERT (false);
	throw ConstantModify ();
	//#UC END# *45EEB9590224_4A9E6EDC03D7_SET*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

