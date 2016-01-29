////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewServant_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NewServant
// Заголовк реализации фабрик интерфеса DerivedLocal для серванта NewServant
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL_NEWSERVANT_FCTR_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL_NEWSERVANT_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImplFactories.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImpl.h"

namespace BasicTests {
namespace NewImpl {

/// Interface-factory implementation for NewServant
class NewServant_factory: virtual public ::Core::RefCountObjectBase, virtual public DerivedLocalAbstractFactory {
public:
	NewServant_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	NewInterfaces::DerivedInterface* factory ();

};

typedef ::Core::Var<NewServant_factory> NewServant_factory_var;

} // namespace NewImpl
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL_NEWSERVANT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

