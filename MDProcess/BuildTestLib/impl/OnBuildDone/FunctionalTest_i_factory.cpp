////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::FunctionalTest_i
//
// FunctionalTest_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i.h"
#include "MDProcess/BuildTestLib/LibHome.h"

namespace BuildTestLib {
namespace OnBuildDone {

FunctionalTest_i_factory::FunctionalTest_i_factory () {
}

void FunctionalTest_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TestResults::FunctionalTestFactoryManager::register_factory (this, priority);
}

const char* FunctionalTest_i_factory::key () const {
	return "FunctionalTest_i";
}

TestResults::FunctionalTest* FunctionalTest_i_factory::make () {
	FunctionalTest_i_var ret = new FunctionalTest_i ();
	return ret->_this ();
}

} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

