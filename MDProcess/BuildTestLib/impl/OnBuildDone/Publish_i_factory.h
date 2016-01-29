////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::Publish_i
// Заголовк реализации фабрик интерфеса Publish для серванта Publish_i
//
// текущая реализация публикует результаты тестов в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_PUBLISH_I_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_PUBLISH_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublishFactories.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

/// Interface-factory implementation for Publish_i
class Publish_i_factory: virtual public ::Core::RefCountObjectBase, virtual public TestPublish::PublishAbstractFactory {
public:
	Publish_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	TestPublish::Publish* make ();

};

typedef ::Core::Var<Publish_i_factory> Publish_i_factory_var;

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_PUBLISH_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

