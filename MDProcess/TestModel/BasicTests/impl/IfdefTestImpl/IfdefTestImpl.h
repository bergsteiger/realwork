////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::IfdefTestImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_H__
#define __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/IfdefInterfaces/IfdefInterfaces.h"


#if defined(WIN32)
namespace BasicTests {
namespace IfdefTestImpl {

class TestLocal;
typedef ::Core::Var<TestLocal> TestLocal_var;
typedef ::Core::Var<const TestLocal> TestLocal_cvar;
class TestLocal
	: virtual public ::Core::IObject
{
};

/// factory interface for TestLocal
class TestLocalFactory {
public:
	static TestLocal* create ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} //namespace IfdefTestImpl
} // namespace BasicTests


#endif //WIN32
#endif //__TESTMODEL_BASICTESTS_IFDEFTESTIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

