////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelPropertiesHelperImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl_factory.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl.h"

namespace RoseModelImpl {

ModelPropertiesHelperImpl_factory::ModelPropertiesHelperImpl_factory () {
}

void ModelPropertiesHelperImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ModelPropertiesHelperFactoryManager::register_factory (this, priority);
}

const char* ModelPropertiesHelperImpl_factory::key () const {
	return "ModelPropertiesHelperImpl";
}

ModelPropertiesHelper* ModelPropertiesHelperImpl_factory::get () {
	ModelPropertiesHelperImpl_var ret = new ModelPropertiesHelperImpl ();
	return ret._retn ();
}

} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

