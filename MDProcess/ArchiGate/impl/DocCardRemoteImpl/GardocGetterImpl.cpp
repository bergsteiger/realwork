////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::GardocGetterImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"


namespace ArchiGate {
namespace DocCardRemoteImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GardocGetterImpl::GardocGetterImpl ()
//#UC START# *54999D1F010A_54999DA200ED_54999EC10258_BASE_INIT*
//#UC END# *54999D1F010A_54999DA200ED_54999EC10258_BASE_INIT*
{
	//#UC START# *54999D1F010A_54999DA200ED_54999EC10258_BODY*
	//#UC END# *54999D1F010A_54999DA200ED_54999EC10258_BODY*
}

// remover (logical destructor) function
void GardocGetterImpl::release () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	this->release_i ();
	//call framework to clean all servant-specific data
	DocCardRemote::GardocGetter_var obj_ = this->_this ();
	DocCardRemote::GardocGetterFactoryManager::release (obj_);

	//deactivate servant
	PortableServer::ObjectId_var oid;
	try {
		oid = LibHomeFactory::get().get_orb_facet().get_root_poa().servant_to_id (this);
		LibHomeFactory::get().get_orb_facet().get_root_poa().deactivate_object (oid);
	} CATCH_AND_LOG ("GardocGetterImpl::release - while deactivate servant");
}

void GardocGetterImpl::release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	//#UC START# *54999DB0021B_54999DB0021B_54999EC10258*
	//#UC END# *54999DB0021B_54999DB0021B_54999EC10258*
}

GardocGetterImpl::~GardocGetterImpl () {
	//#UC START# *54999EC10258_DESTR_BODY*
	//#UC END# *54999EC10258_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocCardRemote::GardocGetter
DocCardRemote::GardocList* GardocGetterImpl::gardocs_by_confluenceid_list (
	const DocCardRemote::LongList& confluenceidList
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *54999E0B0002_54999EC10258*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *54999E0B0002_54999EC10258*
}

// implemented method from DocCardRemote::GardocGetter
DocCardRemote::GardocList* GardocGetterImpl::gardocs_by_topic_list (
	const DocCardRemote::LongList& topicList
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *54999DC0004C_54999EC10258*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *54999DC0004C_54999EC10258*
}
} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

