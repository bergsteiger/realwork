////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::DynamicDocList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/GCI/IO/IO.h"
#include "shared/GCI/I18N/I18N.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include <fstream>
#include "garantServer/src/Business/GblPilot/GblDocListC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterface.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Business/GblLogging/GblLoggingC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"

//forward decl
namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	template <class NodeType_> class ListCatalogBase_i;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class DynListNode_i;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class DynListNodeDelegate;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef std::map < GTree::NodePointer, unsigned long > NodePointerMap;

enum DynListContentImpl {
	DLCI_UNKNOWN
	, DLCI_LEGAL
	, DLCI_MEDIC
};

typedef Tree< DynListNode_i, DynListNodeDelegate > DynListNodeTree;

typedef ListCatalogBase_i< DynListNode_i > ListCatalogBase;

// типы списка для кода реализации
enum DynListTypeImpl {
	T_CORRESPONDENT_IMPL
	, T_CORRESPONDENT_TO_PART_IMPL
	, T_RESPONDENT_IMPL
	, T_RESPONDENT_TO_PART_IMPL
	, T_UNKNOWN_IMPL
	, T_SAME_DOCUMENTS_IMPL
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

