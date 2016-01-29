////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::Package_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/LibHome.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i.h"
// by <<uses>> dependencies
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Package_i::Package_i (RosePackageLockingServer::PackageGUID_const guid)
//#UC START# *45DB06280283_45E2B3A5034F_45E2C8100235_BASE_INIT*
: m_guid (guid)
//#UC END# *45DB06280283_45E2B3A5034F_45E2C8100235_BASE_INIT*
{
	//#UC START# *45DB06280283_45E2B3A5034F_45E2C8100235_BODY*
	//#UC END# *45DB06280283_45E2B3A5034F_45E2C8100235_BODY*
}

Package_i::~Package_i () {
	//#UC START# *45E2C8100235_DESTR_BODY*
	//#UC END# *45E2C8100235_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from RosePackageLockingServer::Package
// прокоммитеть изменения
void Package_i::commit () throw (CORBA::SystemException, RosePackageLockingServer::LockFailed) {
	//#UC START# *45DB0865014B_45E2C8100235*
	PackageManagerExFactory::instance ().unlock (m_guid, false);
	//#UC END# *45DB0865014B_45E2C8100235*
}

// implemented method from RosePackageLockingServer::Package
// информация о пакете
RosePackageLockingServer::PackageInfo* Package_i::get_info ()
	throw (CORBA::SystemException)
{
	//#UC START# *45DD89DA0274_45E2C8100235_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45DD89DA0274_45E2C8100235_GET*
}

// implemented method from RosePackageLockingServer::Package
// начать модификацию пакета
void Package_i::modify () throw (CORBA::SystemException, RosePackageLockingServer::LockFailed) {
	//#UC START# *45DB08170061_45E2C8100235*
	PackageManagerExFactory::instance ().lock (m_guid);
	//#UC END# *45DB08170061_45E2C8100235*
}

// implemented method from RosePackageLockingServer::Package
// откатить изменения в пакете
void Package_i::rollback () throw (CORBA::SystemException) {
	//#UC START# *4628BB03038F_45E2C8100235*
	PackageManagerExFactory::instance ().unlock (m_guid, true);
	//#UC END# *4628BB03038F_45E2C8100235*
}
} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

