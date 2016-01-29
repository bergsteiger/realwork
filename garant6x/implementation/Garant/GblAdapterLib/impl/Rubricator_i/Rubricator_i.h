////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/Rubricator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Rubricator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Global/Core/GTreeC.h"

//forward decl
namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class RubricatorNode_i;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef Tree< RubricatorNode_i, NodeDelegate > RubricatorTree;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

