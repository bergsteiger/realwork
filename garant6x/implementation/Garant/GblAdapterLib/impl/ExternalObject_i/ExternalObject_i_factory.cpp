////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalObject_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i.h"

namespace GblAdapterLib {

ExternalObject_i_factory::ExternalObject_i_factory () {
}

void ExternalObject_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ExternalObjectFactoryManager::register_factory (this, priority);
}

const char* ExternalObject_i_factory::key () const {
	return "ExternalObject_i";
}

ExternalObject* ExternalObject_i_factory::make () {
	ExternalObject_i_var ret = new ExternalObject_i ();
	return ret._retn ();
}

ExternalObject* ExternalObject_i_factory::make (GblPilot::InternalObj* obj) {
	ExternalObject_i_var ret = new ExternalObject_i (obj);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

