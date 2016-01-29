////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::ArchiEventsListenerImpl
//
// ArchiEventsListenerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/ArchiEventsListenerImpl.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"


namespace ArchiGate {
namespace DocCardRemoteImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ArchiEventsListenerImpl::ArchiEventsListenerImpl ()
//#UC START# *4E896436005E_4E89658F0272_4E8964B2030A_BASE_INIT*
//#UC END# *4E896436005E_4E89658F0272_4E8964B2030A_BASE_INIT*
{
	//#UC START# *4E896436005E_4E89658F0272_4E8964B2030A_BODY*
	//#UC END# *4E896436005E_4E89658F0272_4E8964B2030A_BODY*
}

// remover (logical destructor) function
void ArchiEventsListenerImpl::release () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	this->release_i ();
	//call framework to clean all servant-specific data
	DocCardRemote::ArchiEventsListener_var obj_ = this->_this ();
	DocCardRemote::ArchiEventsListenerFactoryManager::release (obj_);

	//deactivate servant
	PortableServer::ObjectId_var oid;
	try {
		oid = LibHomeFactory::get().get_orb_facet().get_root_poa().servant_to_id (this);
		LibHomeFactory::get().get_orb_facet().get_root_poa().deactivate_object (oid);
	} CATCH_AND_LOG ("ArchiEventsListenerImpl::release - while deactivate servant");
}

void ArchiEventsListenerImpl::release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	//#UC START# *4E8965BA0107_4E8965BA0107_4E8964B2030A*
	//#UC END# *4E8965BA0107_4E8965BA0107_4E8964B2030A*
}

ArchiEventsListenerImpl::~ArchiEventsListenerImpl () {
	//#UC START# *4E8964B2030A_DESTR_BODY*
	//#UC END# *4E8964B2030A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocCardRemote::ArchiEventsListener
// в арчи появился новый документ или обновился старый
void ArchiEventsListenerImpl::on_event (const DocCardRemote::ArchiEvent& event) throw (CORBA::SystemException) {
	//#UC START# *4E8963530060_4E8964B2030A*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4E8963530060_4E8964B2030A*
}
} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

