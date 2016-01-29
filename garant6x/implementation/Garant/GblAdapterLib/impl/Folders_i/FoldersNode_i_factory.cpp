////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"

namespace GblAdapterLib {

FoldersNode_i_factory* FoldersNode_i_factory::s_instance = 0;

FoldersNode_i_factory::FoldersNode_i_factory () {
}

void FoldersNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FoldersNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* FoldersNode_i_factory::key () const {
	return "FoldersNode_i";
}

FoldersNode* FoldersNode_i_factory::make (Containers::Content* content, Folders* folders) {
	FoldersNode_i_var ret = new FoldersNode_i (content, folders);
	return ret._retn ();
}

FoldersNode_i* FoldersNode_iServantFactory::make (Containers::Content* content, Folders* folders) {
	if (FoldersNode_i_factory::s_instance) {
		return dynamic_cast<FoldersNode_i*>(FoldersNode_i_factory::s_instance->make (content, folders));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Folders_i::FoldersNode_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

