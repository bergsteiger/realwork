////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/LocalPageLogin_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::LocalPageLogin_i
// Заголовк реализации фабрик интерфеса LocalPageLogin для серванта LocalPageLogin_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LOCALPAGELOGIN_I_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LOCALPAGELOGIN_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDoneFactories.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

/// Interface-factory implementation for LocalPageLogin_i
class LocalPageLogin_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public LocalPageLoginAbstractFactory
{
public:
	LocalPageLogin_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	LocalPageLogin* make (const std::string& login, const std::string& passwd, ServerGate::Contents::PageId page_id);

};

typedef ::Core::Var<LocalPageLogin_i_factory> LocalPageLogin_i_factory_var;

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_LOCALPAGELOGIN_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

