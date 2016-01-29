////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for FoldersNode
FoldersNode* FoldersNodeFactory::make (
	Containers::Content* content
	, Folders* folders
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FoldersNodeFactoryManager::Singleton::instance ()->make (content, folders);
}

// factory interface wrapper for Folders
Folders& FoldersFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FoldersFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for Folder
Folder* FolderFactory::make (
	GblFolders::Folder* folder_content
	, FoldersNode* folders_node
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return FolderFactoryManager::Singleton::instance ()->make (folder_content, folders_node);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

