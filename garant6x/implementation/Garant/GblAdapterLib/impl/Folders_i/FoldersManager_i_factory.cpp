////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"

namespace GblAdapterLib {

FoldersManager_i_factory* FoldersManager_i_factory::s_instance = 0;

FoldersManager_i_factory::FoldersManager_i_factory () {
}

void FoldersManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FoldersFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* FoldersManager_i_factory::key () const {
	return "FoldersManager_i";
}

Folders* FoldersManager_i_factory::make () {
	FoldersManager_i_var ret = new FoldersManager_i ();
	return ret._retn ();
}

FoldersManager_i& FoldersManager_iServantFactory::make () {
	try {
		return dynamic_cast<FoldersManager_i&> (FoldersFactory::make ());
	} catch (std::bad_cast& ) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Folders_i::FoldersManager_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

