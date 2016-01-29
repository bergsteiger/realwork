////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPrefix_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPrefix
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPrefix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPrefix.h"

namespace StrFunctionImpl {

CutPrefix_factory::CutPrefix_factory () {
}

void CutPrefix_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CutPrefix_factory::key () const {
	return "_cut_prefix";
}

TemplateFunctions::InternalFunction* CutPrefix_factory::make () {
	CutPrefix_var ret = new CutPrefix ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

