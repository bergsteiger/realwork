////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::MissingInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i.h"

namespace GblAdapterLib {

MissingInfo_i_factory::MissingInfo_i_factory () {
}

void MissingInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MissingInfoFactoryManager::register_factory (this, priority);
}

const char* MissingInfo_i_factory::key () const {
	return "MissingInfo_i";
}

MissingInfo* MissingInfo_i_factory::make (const GCD::PID& pid) {
	MissingInfo_i_var ret = new MissingInfo_i (pid);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

