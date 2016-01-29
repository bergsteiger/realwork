////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewServant.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NewServant
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/BasicTests/impl/NewImpl/NewServant.h"
#include "TestModel/BasicTests/impl/NewImpl/Environment.h"

namespace BasicTests {
namespace NewImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NewServant::NewServant ()
//#UC START# *49B93A110156_49B93A3403B0_49B945C203C2_BASE_INIT*
//#UC END# *49B93A110156_49B93A3403B0_49B945C203C2_BASE_INIT*
{
	//#UC START# *49B93A110156_49B93A3403B0_49B945C203C2_BODY*
	//#UC END# *49B93A110156_49B93A3403B0_49B945C203C2_BODY*
}

NewServant::~NewServant () {
	//#UC START# *49B945C203C2_DESTR_BODY*
	//#UC END# *49B945C203C2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NewInterfaces::BaseInterface
long NewServant::get_agr_long_p () const {
	//#UC START# *49B8D4690386_49B945C203C2_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D4690386_49B945C203C2_GET*
}

void NewServant::set_agr_long_p (long agr_long_p) {
	//#UC START# *49B8D4690386_49B945C203C2_SET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D4690386_49B945C203C2_SET*
}

// implemented method from NewInterfaces::BaseInterface
const NewInterfaces::NewStruct& NewServant::get_agr_struct_p () const {
	//#UC START# *49B8D6E20087_49B945C203C2_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D6E20087_49B945C203C2_GET*
}

void NewServant::set_agr_struct_p (const NewInterfaces::NewStruct& agr_struct_p) {
	//#UC START# *49B8D6E20087_49B945C203C2_SET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D6E20087_49B945C203C2_SET*
}

// implemented method from NewInterfaces::BaseInterface
const long NewServant::get_lnk_long_p () const {
	//#UC START# *49B8D4150393_49B945C203C2_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D4150393_49B945C203C2_GET*
}

void NewServant::set_lnk_long_p (long lnk_long_p) {
	//#UC START# *49B8D4150393_49B945C203C2_SET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D4150393_49B945C203C2_SET*
}

// implemented method from NewInterfaces::BaseInterface
const NewInterfaces::NewStruct NewServant::get_lnk_struct_p () const {
	//#UC START# *49B8D6CC0146_49B945C203C2_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D6CC0146_49B945C203C2_GET*
}

void NewServant::set_lnk_struct_p (const NewInterfaces::NewStruct& lnk_struct_p) {
	//#UC START# *49B8D6CC0146_49B945C203C2_SET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B8D6CC0146_49B945C203C2_SET*
}

// implemented method from NewInterfaces::DerivedInterface
void NewServant::my_func (const NewInterfaces::MySyperData& a) const {
	//#UC START# *49BA60BC0263_49B945C203C2*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49BA60BC0263_49B945C203C2*
}
} // namespace NewImpl
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

