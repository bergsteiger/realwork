////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i.h"

namespace GblAdapterLib {

ComplectInfo_i_factory::ComplectInfo_i_factory () {
}

void ComplectInfo_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ComplectInfoFactoryManager::register_factory (this, priority);
}

const char* ComplectInfo_i_factory::key () const {
	return "ComplectInfo_i";
}

ComplectInfo* ComplectInfo_i_factory::make () {
	ComplectInfo_i_var ret = new ComplectInfo_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

