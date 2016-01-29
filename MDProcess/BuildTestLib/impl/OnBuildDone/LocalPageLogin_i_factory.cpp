////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::LocalPageLogin_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i_factory.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i.h"

namespace BuildTestLib {
namespace OnBuildDone {

LocalPageLogin_i_factory::LocalPageLogin_i_factory () {
}

void LocalPageLogin_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	LocalPageLoginFactoryManager::register_factory (this, priority);
}

const char* LocalPageLogin_i_factory::key () const {
	return "LocalPageLogin_i";
}

LocalPageLogin* LocalPageLogin_i_factory::make (
	const std::string& login
	, const std::string& passwd
	, ServerGate::Contents::PageId page_id
) {
	LocalPageLogin_i_var ret = new LocalPageLogin_i (login, passwd, page_id);
	return ret._retn ();
}

} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

