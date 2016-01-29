////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::NewImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfaces.h"


namespace BasicTests {
namespace NewImpl {

struct NewBinaryFunctor : public std::binary_function<char, char, std::string*> {
	std::string* operator () (const char* first_param_, char* second_param_) const;
};

struct NewBinaryPredicate : public std::binary_function<char, char, bool> {
	bool operator () (char* first_param_, const char* second_param_) const;
};

struct NewPredicate : public std::unary_function<char, bool> {
	bool operator () (const char* param_) const;
};

struct NewFunctorBase {
	void operator () ;
};

class BaseLocal;
typedef ::Core::Var<BaseLocal> BaseLocal_var;
typedef ::Core::Var<const BaseLocal> BaseLocal_cvar;
class BaseLocal
	: virtual public ::Core::IObject
{
};

struct Deallocator {
	static void destroy (NewPredicate* content) {
		//#UC START# *49B9457402B6*
		throw Core::Root::MDAGenNotImplemented (GDS_CURRENT_FUNCTION);
		//#UC END# *49B9457402B6*
	}

};

class DerivedLocal;
typedef ::Core::Var<DerivedLocal> DerivedLocal_var;
typedef ::Core::Var<const DerivedLocal> DerivedLocal_cvar;
class DerivedLocal
	: virtual public BaseLocal
	, virtual public NewInterfaces::DerivedInterface
{
};

/// factory interface for DerivedLocal
class DerivedLocalFactory {
public:
	static DerivedLocal* factory ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

struct NewUnaryFunctor : public std::unary_function<char, std::string*> {
	std::string* operator () (const char* param_) const;
};

typedef ::Core::Box<NewPredicate, Deallocator> NewBox;


} //namespace NewImpl
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

