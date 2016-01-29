////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmList_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::PharmFirmList_i
//
// Пакет реализации списка-фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"

//forward decl
namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class PharmFirmNode_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef Tree< PharmFirmNode_i, NodeDelegate > PharmFirmTree;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

