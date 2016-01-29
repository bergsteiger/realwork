////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfaces/NewInterfaces.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWINTERFACES_H__
#define __TESTMODEL_BASICTESTS_NEWINTERFACES_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>

namespace BasicTests {
namespace NewInterfaces {

class NewFacet;
typedef ::Core::Var<NewFacet> NewFacet_var;
typedef ::Core::Var<const NewFacet> NewFacet_cvar;
class NewFacet
	: virtual public ::Core::IObject
{
};

#pragma pack (push, 1)

struct NewStruct {
	long new_attribute;
};

#pragma pack (pop)

class BaseInterface;
typedef ::Core::Var<BaseInterface> BaseInterface_var;
typedef ::Core::Var<const BaseInterface> BaseInterface_cvar;
class BaseInterface
	: virtual public ::Core::IObject
{
public:
	virtual const long get_lnk_long_p () const = 0;

	virtual void set_lnk_long_p (long lnk_long_p) = 0;

	virtual long get_agr_long_p () const = 0;

	virtual void set_agr_long_p (long agr_long_p) = 0;

	virtual const NewStruct get_lnk_struct_p () const = 0;

	virtual void set_lnk_struct_p (const NewStruct& lnk_struct_p) = 0;

	virtual const NewStruct& get_agr_struct_p () const = 0;

	virtual void set_agr_struct_p (const NewStruct& agr_struct_p) = 0;
};

typedef std::vector < ACE_INT64 > MySyperData;

class DerivedInterface;
typedef ::Core::Var<DerivedInterface> DerivedInterface_var;
typedef ::Core::Var<const DerivedInterface> DerivedInterface_cvar;
class DerivedInterface
	: virtual public BaseInterface
{
public:
	virtual void my_func (const MySyperData& a) const = 0;
};

/// factory interface for DerivedInterface
class DerivedInterfaceFactory {
public:
	static DerivedInterface* factory ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

enum MultiSelector {
	MS_FAST
	, MS_SMALL
};

class AbstractInterface;
typedef ::Core::Var<AbstractInterface> AbstractInterface_var;
typedef ::Core::Var<const AbstractInterface> AbstractInterface_cvar;
class AbstractInterface
	: virtual public ::Core::IObject
{
};

class BaseInterface1;
typedef ::Core::Var<BaseInterface1> BaseInterface1_var;
typedef ::Core::Var<const BaseInterface1> BaseInterface1_cvar;
class BaseInterface1
	: virtual public AbstractInterface
{
};

/// factory interface for BaseInterface1
class BaseInterface1Factory {
public:
	static BaseInterface1* make (MultiSelector key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DerivedInterface1;
typedef ::Core::Var<DerivedInterface1> DerivedInterface1_var;
typedef ::Core::Var<const DerivedInterface1> DerivedInterface1_cvar;
class DerivedInterface1
	: virtual public BaseInterface1
{
};

/// factory interface for DerivedInterface1
class DerivedInterface1Factory {
public:
	static DerivedInterface1* make_derived (MultiSelector key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static DerivedInterface1* make (MultiSelector key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace NewInterfaces
} // namespace BasicTests

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <BasicTests::NewInterfaces::DerivedInterface> {
	typedef BasicTests::NewInterfaces::DerivedInterfaceFactory Factory;
};
template <>
struct TypeTraits <BasicTests::NewInterfaces::BaseInterface1> {
	typedef BasicTests::NewInterfaces::BaseInterface1Factory Factory;
};
template <>
struct TypeTraits <BasicTests::NewInterfaces::DerivedInterface1> {
	typedef BasicTests::NewInterfaces::DerivedInterface1Factory Factory;
};
} // namespace Core


#endif //__TESTMODEL_BASICTESTS_NEWINTERFACES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
