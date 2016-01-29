////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::SearcherImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/LibHome.h"
#include "MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"


namespace ArchiGate {
namespace DocCardRemoteImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearcherImpl::SearcherImpl ()
//#UC START# *4E1444FF01E5_4E14455401DB_4E14463002AC_BASE_INIT*
//#UC END# *4E1444FF01E5_4E14455401DB_4E14463002AC_BASE_INIT*
{
	//#UC START# *4E1444FF01E5_4E14455401DB_4E14463002AC_BODY*
	//#UC END# *4E1444FF01E5_4E14455401DB_4E14463002AC_BODY*
}

// remover (logical destructor) function
void SearcherImpl::release () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	this->release_i ();
	//call framework to clean all servant-specific data
	DocCardRemote::Searcher_var obj_ = this->_this ();
	DocCardRemote::SearcherFactoryManager::release (obj_);

	//deactivate servant
	PortableServer::ObjectId_var oid;
	try {
		oid = LibHomeFactory::get().get_orb_facet().get_root_poa().servant_to_id (this);
		LibHomeFactory::get().get_orb_facet().get_root_poa().deactivate_object (oid);
	} CATCH_AND_LOG ("SearcherImpl::release - while deactivate servant");
}

void SearcherImpl::release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject) {
	//#UC START# *4E15C91203C2_4E15C91203C2_4E14463002AC*
	//#UC END# *4E15C91203C2_4E15C91203C2_4E14463002AC*
}

SearcherImpl::~SearcherImpl () {
	//#UC START# *4E14463002AC_DESTR_BODY*
	//#UC END# *4E14463002AC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocCardRemote::Searcher
// Список новых зарегистрированных документов после date (время в секундах после 1-го января 1970
// года). Возвращаются только документы, которые НЕ нужно срочно обработать.
DocCardRemote::GardocList* SearcherImpl::get_notop_created_since (
	CORBA::LongLong date
	, CORBA::Long maxCount
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *521C80F90222_4E14463002AC*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *521C80F90222_4E14463002AC*
}

// implemented method from DocCardRemote::Searcher
// список новых зарегистрированных документов после date (время в секундах после 1-го января 1970
// года)
DocCardRemote::GardocList* SearcherImpl::get_recently_created_since (
	CORBA::LongLong date
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *4E14457802FF_4E14463002AC*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4E14457802FF_4E14463002AC*
}

// implemented method from DocCardRemote::Searcher
// список новых зарегистрированных документов после date (время в секундах после 1-го января 1970
// года). Возвращаются только документы, которые нужно срочно обработать.
DocCardRemote::GardocList* SearcherImpl::get_top_created_since (
	CORBA::LongLong date
	, CORBA::Long maxCount
) throw (
	CORBA::SystemException
	, DocCardRemote::IllegalStateExceptionRemote
) {
	//#UC START# *521C80DA02BC_4E14463002AC*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *521C80DA02BC_4E14463002AC*
}
} // namespace DocCardRemoteImpl
} // namespace ArchiGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

