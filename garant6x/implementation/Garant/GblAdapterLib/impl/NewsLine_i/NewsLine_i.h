////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLine_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::NewsLine_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NEWSLINE_I_H__
#define __GARANT6X_GBLADAPTERLIB_NEWSLINE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"

//forward decl
namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NewsLineNode_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef Tree< NewsLineNode_i, NodeDelegate > NewsLineTree;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NEWSLINE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

