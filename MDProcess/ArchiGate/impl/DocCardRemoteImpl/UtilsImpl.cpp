////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::UtilsImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"


namespace ArchiGate {
namespace DocCardRemoteImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UtilsImpl::UtilsImpl ()
//#UC START# *549999D000FB_54999A570130_54999EB50367_BASE_INIT*
//#UC END# *549999D000FB_54999A570130_54999EB50367_BASE_INIT*
{
	//#UC START# *549999D000FB_54999A570130_54999EB50367_BODY*
	//#UC END# *549999D000FB_54999A570130_54999EB50367_BODY*
}

// remover (logical destructor) function
void UtilsImpl::release () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	this->release_i ();
	//call framework to clean all servant-specific data
	DocCardRemote::Utils_var obj_ = this->_this ();
	DocCardRemote::UtilsFactoryManager::release (obj_);

	//deactivate servant
	PortableServer::ObjectId_var oid;
	try {
		oid = LibHomeFactory::get().get_orb_facet().get_root_poa().servant_to_id (this);
		LibHomeFactory::get().get_orb_facet().get_root_poa().deactivate_object (oid);
	} CATCH_AND_LOG ("UtilsImpl::release - while deactivate servant");
}

void UtilsImpl::release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	//#UC START# *54999A610258_54999A610258_54999EB50367*
	//#UC END# *54999A610258_54999A610258_54999EB50367*
}

UtilsImpl::~UtilsImpl () {
	//#UC START# *54999EB50367_DESTR_BODY*
	//#UC END# *54999EB50367_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocCardRemote::Utils
// ����������� ������ ������� ����������� � ��� ��� �� ������� �������� ��� ��������� � ���������
// ���� � ���������� Searcher2::get_xxxx, � ����� ���������� ������ (�������� ��������� ��
// ��������). ���� �����, ������� ������ ������ ������� ������, �� ��������� ����� ��������
// ��������� �������� �����. ������� ������� ������������ � ������, ���� ��� �� Searcher2::get_xxxx
// �� �������� �� ���� ��������, ������� update_old_last_created_time � ��������� ��������� � ����.
// ������ ����� �������� �� �������� ������� 30-�� ����� � ��������� ���������� �������. ����
// ������������ ����� ������ �������� ���������, �� ������ �������� time.
const CORBA::LongLong UtilsImpl::update_old_last_created_time (
	CORBA::LongLong date
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *54999A72023E_54999EB50367*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *54999A72023E_54999EB50367*
}
} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

