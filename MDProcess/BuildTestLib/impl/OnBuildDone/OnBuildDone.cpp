////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::BuildTestLib::OnBuildDone
//
// имлементация того что надо сделать по событию окончания сборки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDoneFactories.h"
#include "MDProcess/BuildTestLib/LibHome.h"


namespace BuildTestLib {
namespace OnBuildDone {

// factory interface wrapper for LocalPageLogin
LocalPageLogin* LocalPageLoginFactory::make (
	const std::string& login
	, const std::string& passwd
	, ServerGate::Contents::PageId page_id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return LocalPageLoginFactoryManager::Singleton::instance ()->make (login, passwd, page_id);
}



} //namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

