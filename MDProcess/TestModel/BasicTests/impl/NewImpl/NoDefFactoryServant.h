////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NoDefFactoryServant.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NoDefFactoryServant
// Заголовок реализации класса серванта для интерфеса DerivedLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL_NODEFFACTORYSERVANT_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL_NODEFFACTORYSERVANT_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImpl.h"

namespace BasicTests {
namespace NewImpl {

class NoDefFactoryServant; // self forward Var
typedef ::Core::Var<NoDefFactoryServant> NoDefFactoryServant_var;
typedef ::Core::Var<const NoDefFactoryServant> NoDefFactoryServant_cvar;

class NoDefFactoryServant_factory;

class NoDefFactoryServant:
	virtual public DerivedLocal
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (NoDefFactoryServant)
	friend class NoDefFactoryServant_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~NoDefFactoryServant ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NewInterfaces::BaseInterface
	virtual long get_agr_long_p () const;

	virtual void set_agr_long_p (long agr_long_p);

	// implemented method from NewInterfaces::BaseInterface
	virtual const NewInterfaces::NewStruct& get_agr_struct_p () const;

	virtual void set_agr_struct_p (const NewInterfaces::NewStruct& agr_struct_p);

	// implemented method from NewInterfaces::BaseInterface
	virtual const long get_lnk_long_p () const;

	virtual void set_lnk_long_p (long lnk_long_p);

	// implemented method from NewInterfaces::BaseInterface
	virtual const NewInterfaces::NewStruct get_lnk_struct_p () const;

	virtual void set_lnk_struct_p (const NewInterfaces::NewStruct& lnk_struct_p);

	// implemented method from NewInterfaces::DerivedInterface
	virtual void my_func (const NewInterfaces::MySyperData& a) const;
}; // class NoDefFactoryServant

} // namespace NewImpl
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL_NODEFFACTORYSERVANT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
