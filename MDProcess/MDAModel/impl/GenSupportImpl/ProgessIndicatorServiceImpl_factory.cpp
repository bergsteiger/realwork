////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ProgessIndicatorServiceImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl_factory.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl.h"

namespace GenSupportImpl {

ProgessIndicatorServiceImpl_factory::ProgessIndicatorServiceImpl_factory () {
}

void ProgessIndicatorServiceImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GenSupport::ProgessIndicatorServiceFactoryManager::register_factory (this, priority);
}

const char* ProgessIndicatorServiceImpl_factory::key () const {
	return "ProgessIndicatorServiceImpl";
}

GenSupport::ProgessIndicatorService* ProgessIndicatorServiceImpl_factory::get () {
	ProgessIndicatorServiceImpl_var ret = new ProgessIndicatorServiceImpl ();
	return ret._retn ();
}

} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

