////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::NewImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImpl.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImplFactories.h"


namespace BasicTests {
namespace NewImpl {

std::string* NewBinaryFunctor::operator () (const char* first_param_, char* second_param_) const {
	//#UC START# *49AEE45602BA_IMPL*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEE45602BA_IMPL*
}

bool NewBinaryPredicate::operator () (char* first_param_, const char* second_param_) const {
	//#UC START# *49AEE45B006E_IMPL*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEE45B006E_IMPL*
}

bool NewPredicate::operator () (const char* param_) const {
	//#UC START# *49AEE4AF0193_IMPL*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEE4AF0193_IMPL*
}

void NewFunctorBase::operator ()  {
	//#UC START# *49AEE488015C_IMPL*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEE488015C_IMPL*
}

// factory interface wrapper for DerivedLocal
DerivedLocal* DerivedLocalFactory::factory () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	DerivedLocal* ret = dynamic_cast<DerivedLocal*> (NewInterfaces::DerivedInterfaceFactory::factory ());
	if (ret == 0) {
		throw Core::Root::NoActiveFactory ("BasicTests::NewImpl::DerivedLocalFactory");
	}
	return ret;
}



std::string* NewUnaryFunctor::operator () (const char* param_) const {
	//#UC START# *49AEE4D102FA_IMPL*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49AEE4D102FA_IMPL*
}

} //namespace NewImpl
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

