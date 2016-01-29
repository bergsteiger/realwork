////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserNodeDelegate::UserNodeDelegate (TreeBase* owner_tree)
//#UC START# *49E58127026C_BASE_INIT*
: DefaultNodeBase (owner_tree), DelegateNodeBase (owner_tree), NodeDelegate (owner_tree)
//#UC END# *49E58127026C_BASE_INIT*
{
	//#UC START# *49E58127026C_BODY*
	//#UC END# *49E58127026C_BODY*
}

UserNodeDelegate::~UserNodeDelegate () {
	//#UC START# *49E57FD50219_DESTR_BODY*
	//#UC END# *49E57FD50219_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ProfileNode
Uid UserNodeDelegate::get_uid () const {
	//#UC START# *465EC3DA036B_49E57FD50219*
	const ProfileNode* master_node = dynamic_cast<const ProfileNode*> (this->cached_master_node ());
	GDS_ASSERT (master_node);
	return master_node->get_uid ();
	//#UC END# *465EC3DA036B_49E57FD50219*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// возвращает ноду по видемому индексу относительно текущей
NodeBase* UserNodeDelegate::get_by_visible_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D8_49E57FD50219*
	// проблема в том, что приходит reset_delta, которая удаляет из вью эту ноду,
	// отсылаем на оболочку нотификацию. Оболочка кладёт нотификацию в очередь и дёргает 
	// get_by_visible_index на удалённой ноде. Про таймстемпы оболочка понятия не имеет, а 
	// с точки зрения адаптера всё зашибись - дельта уже применилась.  А отец у ноды уже 
	// невидим в дереве, что приводит к проезду по памяти во время выполнения функции.
	// (см. NodeDelegate::get_by_visible_index - там есть заточка с таймстемпом, которая не спасает) .
	if (!dynamic_cast<const FlagNodeBase*>(m_parent)) {
		LOG_W (("call %s at changеd tree", GDS_CURRENT_FUNCTION));
		return 0;
	}

	// К278839378 - очередные гонки в момент перерисовки дерева и обработки нотификаций
	if ((ind < 0) && !dynamic_cast<const FlagNodeBase*>(m_prev)) {
		LOG_W (("call %s at changеd tree", GDS_CURRENT_FUNCTION));
		return 0;
	}

	return NodeDelegate::get_by_visible_index (ind);
	//#UC END# *45EEB95901D8_49E57FD50219*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

