////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/RefcountTest/RecountSelf.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> TestModel::BasicTests::RefcountTest::RecountSelf
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/RefcountTest/RecountSelf.h"

namespace BasicTests {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RecountSelf::~RecountSelf () {
	//#UC START# *49C8B2090220_DESTR_BODY*
	//#UC END# *49C8B2090220_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
unsigned long RecountSelf::addref () const {
	//#UC START# *49C8B2090220_REFCOUNT_ADDREF*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49C8B2090220_REFCOUNT_ADDREF*
}

unsigned long RecountSelf::release () const {
	//#UC START# *49C8B2090220_REFCOUNT_RELEASE*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49C8B2090220_REFCOUNT_RELEASE*
}

unsigned long RecountSelf::ref_count () const {
	//#UC START# *49C8B2090220_REFCOUNT_REFCOUNT*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49C8B2090220_REFCOUNT_REFCOUNT*
}


} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

