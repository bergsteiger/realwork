////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::BuildListener_i
//
// ждет события окончания сборки, по приходу события копирует файлв сборки в локальное место,
// запускает тестовый сценарий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i.h"
#include "MDProcess/BuildTestLib/LibHome.h"

namespace BuildTestLib {
namespace OnBuildDone {

BuildListener_i_factory::BuildListener_i_factory () {
}

void BuildListener_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ServerGate::Comm::BuildListnerFactoryManager::register_factory (this, priority);
}

const char* BuildListener_i_factory::key () const {
	return "BuildListener_i";
}

ServerGate::Comm::BuildListner* BuildListener_i_factory::get () {
	BuildListener_i_var ret = new BuildListener_i ();
	return ret->_this ();
}

} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

