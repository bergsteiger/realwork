////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/Complect_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Complect_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_I_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"

//forward decl
namespace GblAdapterLib {
	class ComplectInfoNode_i;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef Tree< ComplectInfoNode_i, NodeDelegate > ComplectInfoTree;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

