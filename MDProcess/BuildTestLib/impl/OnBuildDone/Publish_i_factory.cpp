////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::Publish_i
//
// текущая реализация публикует результаты тестов в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i.h"
#include "MDProcess/BuildTestLib/LibHome.h"

namespace BuildTestLib {
namespace OnBuildDone {

Publish_i_factory::Publish_i_factory () {
}

void Publish_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TestPublish::PublishFactoryManager::register_factory (this, priority);
}

const char* Publish_i_factory::key () const {
	return "Publish_i";
}

TestPublish::Publish* Publish_i_factory::make () {
	Publish_i_var ret = new Publish_i ();
	return ret->_this ();
}

} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

