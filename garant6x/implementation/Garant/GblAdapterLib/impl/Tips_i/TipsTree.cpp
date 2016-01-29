////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTree.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Tips_i::TipsTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTree.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TipsTree::TipsTree (GTree::Tree* tree)
//#UC START# *4ABB4D2800C9_BASE_INIT*
: TreeBase (true), Tree<TipsTreeNode_i, NodeDelegate> (true)
//#UC END# *4ABB4D2800C9_BASE_INIT*
{
	//#UC START# *4ABB4D2800C9_BODY*
	this->apply_server_tree (tree);
	this->set_tree_name ("Советы Дня");
	//#UC END# *4ABB4D2800C9_BODY*
}

TipsTree::~TipsTree () {
	//#UC START# *47B71BF6005C_DESTR_BODY*
	//#UC END# *47B71BF6005C_DESTR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

