////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsView.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContentsNodeDelegate::ContentsNodeDelegate (TreeBase* owner_tree)
//#UC START# *4C9CA6C40109_BASE_INIT*
: DelegateNodeBase (owner_tree), NodeDelegate (owner_tree), DefaultNodeBase (owner_tree)
//#UC END# *4C9CA6C40109_BASE_INIT*
{
	//#UC START# *4C9CA6C40109_BODY*
	//#UC END# *4C9CA6C40109_BODY*
}

ContentsNodeDelegate::~ContentsNodeDelegate () {
	//#UC START# *4C9CA5D90231_DESTR_BODY*
	//#UC END# *4C9CA5D90231_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from NodeBase
// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не
// уникален.
NodeId ContentsNodeDelegate::get_node_id () const {
	//#UC START# *45EEB95901DE_4C9CA5D90231*
	const ContentsNode* node = dynamic_cast<const ContentsNode*> (this->cached_master_node ());
	GDS_ASSERT (node);
	return node->get_node_id ();
	//#UC END# *45EEB95901DE_4C9CA5D90231*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

