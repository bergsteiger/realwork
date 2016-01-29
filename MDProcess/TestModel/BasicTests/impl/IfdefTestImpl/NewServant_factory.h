////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/NewServant_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::IfdefTestImpl::NewServant
// Заголовк реализации фабрик интерфеса TestLocal для серванта NewServant
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_NEWSERVANT_FCTR_H__
#define __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_NEWSERVANT_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImplFactories.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImpl.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefTestImpl {

/// Interface-factory implementation for NewServant
class NewServant_factory: virtual public ::Core::RefCountObjectBase, virtual public TestLocalAbstractFactory {
public:
	NewServant_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	TestLocal* create ();

};

typedef ::Core::Var<NewServant_factory> NewServant_factory_var;

} // namespace IfdefTestImpl
} // namespace BasicTests


#endif //WIN32
#endif //__TESTMODEL_BASICTESTS_IFDEFTESTIMPL_NEWSERVANT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

