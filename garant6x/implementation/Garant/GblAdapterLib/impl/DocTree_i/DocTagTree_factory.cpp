////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagTree_factory.cpp"
// C++ Interface Factories implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocTagTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagTree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagTree.h"

namespace GblAdapterLib {

DocTagTree* DocTagTreeServantFactory::make (GTree::Tree* tree, bool optimize_for_everest) {
	DocTagTree_var ret = new DocTagTree (tree, optimize_for_everest);
	
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

