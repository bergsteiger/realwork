////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RealNodeRoot::RealNodeRoot ()
//#UC START# *45EEB95901C5_45F6694A01B5_45F7D8EE031C_BASE_INIT*
//#UC END# *45EEB95901C5_45F6694A01B5_45F7D8EE031C_BASE_INIT*
{
	//#UC START# *45EEB95901C5_45F6694A01B5_45F7D8EE031C_BODY*
	GDS_ASSERT (false);
	//#UC END# *45EEB95901C5_45F6694A01B5_45F7D8EE031C_BODY*
}

RealNodeRoot::RealNodeRoot (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
//#UC START# *45EEB95901C5_45FFF849002E_45F7D8EE031C_BASE_INIT*
	: NodeBase_i (dynamic_cast<TreeBase*> (owner_tree), snode)
	// нужно ли?
	, RealNodeBase (dynamic_cast<TreeBase*> (owner_tree), snode)
	, DefaultNodeBase (dynamic_cast<TreeBase*> (owner_tree))
//#UC END# *45EEB95901C5_45FFF849002E_45F7D8EE031C_BASE_INIT*
{
	//#UC START# *45EEB95901C5_45FFF849002E_45F7D8EE031C_BODY*
	//LOG_D (("%s [%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this));
	m_owner_tree_var = TreeBase::_duplicate(dynamic_cast<TreeBase*> (owner_tree));
	GDS_ASSERT (m_owner_tree_var.ptr());
	//#UC END# *45EEB95901C5_45FFF849002E_45F7D8EE031C_BODY*
}

RealNodeRoot::~RealNodeRoot () {
	//#UC START# *45F7D8EE031C_DESTR_BODY*
	//LOG_D (("%s [%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this));

	// сейчас архитектура такова, что RealNodeRoot "держит" дерево, а должно быть наоборот...
	// в связи с этим возникают проблемы: в одном потоке рут могут "отпустить", в то время как
	// в другом потоке происходит модификация дерева (например, обработка присланой сервером дельты).
	// Модификация дерева требует наличия рут'а, соответсвенно рут не должен умереть до завершения
	// операции модификации дерева.
	m_owner_tree_var->root_is_dead ();
	//#UC END# *45F7D8EE031C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void RealNodeRoot::safety_tree_remove () {
	//#UC START# *4601010D01B5*
	m_owner_tree_var->safety_remove ();
	//#UC END# *4601010D01B5*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const TreeBase* RealNodeRoot::get_owner_tree_var () const {
	//#UC START# *4601017F0109_GET_ACCESSOR*
	return m_owner_tree_var._sretn ();
	//#UC END# *4601017F0109_GET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from DefaultNodeBase
void RealNodeRoot::add_notifier (NodeNotifier* notifier) {
	//#UC START# *45F95547002E_45F7D8EE031C*
	if (m_owner_tree_var->changed_layer (false)) {
		m_owner_tree_var->clear ();
	}
	DefaultNodeBase::add_notifier (notifier);
	//#UC END# *45F95547002E_45F7D8EE031C*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

