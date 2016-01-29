////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewServant.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NewServant
// ��������� ���������� ������ �������� ��� ��������� DerivedLocal
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL_NEWSERVANT_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL_NEWSERVANT_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImpl.h"

namespace BasicTests {
namespace NewImpl {

class NewServant; // self forward Var
typedef ::Core::Var<NewServant> NewServant_var;
typedef ::Core::Var<const NewServant> NewServant_cvar;

class NewServant_factory;

class NewServant:
	virtual public DerivedLocal
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (NewServant)
	friend class NewServant_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NewServant ();

	virtual ~NewServant ();

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
}; // class NewServant

} // namespace NewImpl
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL_NEWSERVANT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
