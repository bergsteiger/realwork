////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::BuildListener_i
// Заголовк реализации фабрик интерфеса BuildListner для серванта BuildListener_i
//
// ждет события окончания сборки, по приходу события копирует файлв сборки в локальное место,
// запускает тестовый сценарий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_BUILDLISTENER_I_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_BUILDLISTENER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Comm/CommFactories.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

/// Interface-factory implementation for BuildListener_i
class BuildListener_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public ServerGate::Comm::BuildListnerAbstractFactory
{
public:
	BuildListener_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ServerGate::Comm::BuildListner* get ();

};

typedef ::Core::Var<BuildListener_i_factory> BuildListener_i_factory_var;

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_BUILDLISTENER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

