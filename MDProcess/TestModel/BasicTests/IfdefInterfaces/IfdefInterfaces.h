////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/IfdefInterfaces/IfdefInterfaces.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::IfdefInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_IFDEFINTERFACES_H__
#define __TESTMODEL_BASICTESTS_IFDEFINTERFACES_H__

#include "shared/Core/sys/std_inc.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefInterfaces {

#if defined(ACE_HAS_WINNT4) && defined(WIN32)
class TestInterface;
typedef ::Core::Var<TestInterface> TestInterface_var;
typedef ::Core::Var<const TestInterface> TestInterface_cvar;
class TestInterface
	: virtual public ::Core::IObject
{
};
#endif //ACE_HAS_WINNT4 && WIN32

/// factory interface for TestInterface
#if defined(ACE_HAS_WINNT4) && defined(WIN32)
class TestInterfaceFactory {
public:
	static TestInterface* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};
#endif //ACE_HAS_WINNT4 && WIN32

} // namespace IfdefInterfaces
} // namespace BasicTests

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <BasicTests::IfdefInterfaces::TestInterface> {
	typedef BasicTests::IfdefInterfaces::TestInterfaceFactory Factory;
};
} // namespace Core


#endif //WIN32
#endif //__TESTMODEL_BASICTESTS_IFDEFINTERFACES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
