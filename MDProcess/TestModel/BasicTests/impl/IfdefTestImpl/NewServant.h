////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/NewServant.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::IfdefTestImpl::NewServant
// Заголовок реализации класса серванта для интерфеса TestLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_NEWSERVANT_H__
#define __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_NEWSERVANT_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImpl.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefTestImpl {

class NewServant; // self forward Var
typedef ::Core::Var<NewServant> NewServant_var;
typedef ::Core::Var<const NewServant> NewServant_cvar;

class NewServant_factory;

class NewServant:
	virtual public TestLocal
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (NewServant)
	friend class NewServant_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NewServant ();

	virtual ~NewServant ();
}; // class NewServant

} // namespace IfdefTestImpl
} // namespace BasicTests


#endif //WIN32
#endif //__TESTMODEL_BASICTESTS_IFDEFTESTIMPL_NEWSERVANT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
