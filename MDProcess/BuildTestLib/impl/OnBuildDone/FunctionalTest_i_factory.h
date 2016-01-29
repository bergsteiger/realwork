////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::FunctionalTest_i
// Заголовк реализации фабрик интерфеса FunctionalTest для серванта FunctionalTest_i
//
// FunctionalTest_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FUNCTIONALTEST_I_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FUNCTIONALTEST_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestResults/TestResultsFactories.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

/// Interface-factory implementation for FunctionalTest_i
class FunctionalTest_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TestResults::FunctionalTestAbstractFactory
{
public:
	FunctionalTest_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	TestResults::FunctionalTest* make ();

};

typedef ::Core::Var<FunctionalTest_i_factory> FunctionalTest_i_factory_var;

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FUNCTIONALTEST_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

