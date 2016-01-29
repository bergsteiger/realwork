////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::Searcher2Impl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"


namespace ArchiGate {
namespace DocCardRemoteImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Searcher2Impl::Searcher2Impl ()
//#UC START# *541ABEBE0377_541ABEE501EF_541ABF3401D6_BASE_INIT*
//#UC END# *541ABEBE0377_541ABEE501EF_541ABF3401D6_BASE_INIT*
{
	//#UC START# *541ABEBE0377_541ABEE501EF_541ABF3401D6_BODY*
	//#UC END# *541ABEBE0377_541ABEE501EF_541ABF3401D6_BODY*
}

// remover (logical destructor) function
void Searcher2Impl::release () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	this->release_i ();
	//call framework to clean all servant-specific data
	DocCardRemote::Searcher2_var obj_ = this->_this ();
	DocCardRemote::Searcher2FactoryManager::release (obj_);

	//deactivate servant
	PortableServer::ObjectId_var oid;
	try {
		oid = LibHomeFactory::get().get_orb_facet().get_root_poa().servant_to_id (this);
		LibHomeFactory::get().get_orb_facet().get_root_poa().deactivate_object (oid);
	} CATCH_AND_LOG ("Searcher2Impl::release - while deactivate servant");
}

void Searcher2Impl::release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	//#UC START# *541ABEF30046_541ABEF30046_541ABF3401D6*
	//#UC END# *541ABEF30046_541ABEF30046_541ABF3401D6*
}

Searcher2Impl::~Searcher2Impl () {
	//#UC START# *541ABF3401D6_DESTR_BODY*
	//#UC END# *541ABF3401D6_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocCardRemote::Searcher2
DocCardRemote::GardocList* Searcher2Impl::get_notop_created_since (
	CORBA::LongLong date
	, CORBA::Long maxCount
	, const char* partnerId
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *541ABF020119_541ABF3401D6*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *541ABF020119_541ABF3401D6*
}

// implemented method from DocCardRemote::Searcher2
DocCardRemote::GardocList* Searcher2Impl::get_top_created_since (
	CORBA::LongLong date
	, CORBA::Long maxCount
	, const char* partnerId
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *541ABEF90122_541ABF3401D6*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *541ABEF90122_541ABF3401D6*
}
} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

