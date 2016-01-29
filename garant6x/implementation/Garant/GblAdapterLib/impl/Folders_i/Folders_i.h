////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folders_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Folders_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include <queue>
#include "shared/GCI/IO/IO.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
#include <fstream>
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersAdapC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Business/GblXMLSave/GblXMLSaveC.h"


namespace GblAdapterLib {

typedef std::vector < Node_var > NodeVector;

struct Notify {
	NotifyStatus status;
	unsigned long folder_id;
};

typedef std::queue < Notify > NotifyDataList;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

