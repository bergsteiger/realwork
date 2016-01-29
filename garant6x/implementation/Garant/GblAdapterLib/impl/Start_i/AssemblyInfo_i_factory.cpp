////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::AssemblyInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i.h"

namespace GblAdapterLib {

AssemblyInfo_i_factory::AssemblyInfo_i_factory () {
}

void AssemblyInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	AssemblyInfoFactoryManager::register_factory (this, priority);
}

const char* AssemblyInfo_i_factory::key () const {
	return "AssemblyInfo_i";
}

AssemblyInfo* AssemblyInfo_i_factory::make () {
	AssemblyInfo_i_var ret = new AssemblyInfo_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

