////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DelegateNodeRoot::DelegateNodeRoot (TreeBase* owner_tree)
//#UC START# *45FE9032035B_BASE_INIT*
: DefaultNodeBase (owner_tree), NodeDelegate (owner_tree), DelegateNodeBase (owner_tree)
//#UC END# *45FE9032035B_BASE_INIT*
{
	//#UC START# *45FE9032035B_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (NodeDelegate*)this));
	m_owner_view = dynamic_cast <ViewBase*> (owner_tree); // take ownership
	GDS_ASSERT (m_owner_view.ptr ());
	//#UC END# *45FE9032035B_BODY*
}

DelegateNodeRoot::~DelegateNodeRoot () {
	//#UC START# *45FE8E720000_DESTR_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (NodeDelegate*)this));
	// отсюда может полететь InvalidOwnerTree в случае обновления базы:
	// 1. приходит нотификация об обновлении базы.
	// 2. по этой нотификации оболочка дёргает на Common get_new_main_menu,
	// которое зануляет все деревья
	// 3. Оболочка отпускает рут вью, для которого дёргается этот деструктор,
	// а в root_is_dead пытаемя обратиться к дереву.
	try {
		m_owner_view->root_is_dead ();
	} catch (TreeBase::InvalidOwnerTree&) {
	}
	//#UC END# *45FE8E720000_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from DefaultNodeBase
bool DelegateNodeRoot::apply_change_delta (GTree::ChangeDelta& delta) {
	//#UC START# *45F95B9A0000_45FE8E720000*
	// для вью с дельтой об изменении ноды ничего делать не надо,
	// всё обработается на дереве
	// (сейчас приходит для структуры документа после контекстной фильтрации,
	// когда меняют комментарий, подходящий под фильтр)

	return false;
	//#UC END# *45F95B9A0000_45FE8E720000*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

