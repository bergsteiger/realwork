////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Estimation_i
//
// реализация интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i.h"

namespace GblAdapterLib {

Estimation_i_factory::Estimation_i_factory () {
}

void Estimation_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	EstimationFactoryManager::register_factory (this, priority);
}

const char* Estimation_i_factory::key () const {
	return "Estimation_i";
}

Estimation* Estimation_i_factory::make () {
	Estimation_i_var ret = new Estimation_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

