////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/Explanatory_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Explanatory_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
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
	class ExplanatoryNode_i;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class MedExplanatoryNode_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef Tree< ExplanatoryNode_i, NodeDelegate > ExplanatoryTree;

// дерево словаря мед. терминов
typedef Tree< MedExplanatoryNode_i, NodeDelegate > MedExplanatoryTree;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

