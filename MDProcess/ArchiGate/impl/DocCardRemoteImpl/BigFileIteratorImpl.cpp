////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::BigFileIteratorImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"


namespace ArchiGate {
namespace DocCardRemoteImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BigFileIteratorImpl::BigFileIteratorImpl ()
//#UC START# *54E3357F0376_54E338B70161_54E3386A0275_BASE_INIT*
//#UC END# *54E3357F0376_54E338B70161_54E3386A0275_BASE_INIT*
{
	//#UC START# *54E3357F0376_54E338B70161_54E3386A0275_BODY*
	//#UC END# *54E3357F0376_54E338B70161_54E3386A0275_BODY*
}

// remover (logical destructor) function
void BigFileIteratorImpl::destroy () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	this->destroy_i ();
	//call framework to clean all servant-specific data
	DocCardRemote::BigFileIterator_var obj_ = this->_this ();
	DocCardRemote::BigFileIteratorFactoryManager::destroy (obj_);

	//deactivate servant
	PortableServer::ObjectId_var oid;
	try {
		oid = LibHomeFactory::get().get_orb_facet().get_root_poa().servant_to_id (this);
		LibHomeFactory::get().get_orb_facet().get_root_poa().deactivate_object (oid);
	} CATCH_AND_LOG ("BigFileIteratorImpl::destroy - while deactivate servant");
}

void BigFileIteratorImpl::destroy_i () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	//#UC START# *54E337D50035_54E337D50035_54E3386A0275*
	//#UC END# *54E337D50035_54E337D50035_54E3386A0275*
}

BigFileIteratorImpl::~BigFileIteratorImpl () {
	//#UC START# *54E3386A0275_DESTR_BODY*
	//#UC END# *54E3386A0275_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocCardRemote::BigFileIterator
DocCardRemote::ByteBuffer* BigFileIteratorImpl::next (
	CORBA::LongLong chunkSizeInBytes
) throw (
	CORBA::SystemException
) {
	//#UC START# *54E337C000AF_54E3386A0275*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *54E337C000AF_54E3386A0275*
}
} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

