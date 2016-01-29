////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::Folder_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.h"

namespace GblAdapterLib {

Folder_i_factory* Folder_i_factory::s_instance = 0;

Folder_i_factory::Folder_i_factory () {
}

void Folder_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FolderFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* Folder_i_factory::key () const {
	return "Folder_i";
}

Folder* Folder_i_factory::make (GblFolders::Folder* folder_content, FoldersNode* folders_node) {
	Folder_i_var ret = new Folder_i (folder_content, folders_node);
	return ret._retn ();
}

Folder_i* Folder_iServantFactory::make (GblFolders::Folder* folder_content, FoldersNode* folders_node) {
	if (Folder_i_factory::s_instance) {
		return dynamic_cast<Folder_i*>(Folder_i_factory::s_instance->make (folder_content, folders_node));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Folders_i::Folder_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

