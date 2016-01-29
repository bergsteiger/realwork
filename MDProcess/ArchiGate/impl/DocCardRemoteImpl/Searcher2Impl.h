////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::Searcher2Impl
// Заголовок реализации класса серванта для интерфеса Searcher2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHER2IMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHER2IMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class Searcher2Impl; // self forward Var
typedef ::Core::Var<Searcher2Impl> Searcher2Impl_var;
typedef ::Core::Var<const Searcher2Impl> Searcher2Impl_cvar;

class Searcher2Impl_factory;

class Searcher2Impl:
	virtual public POA_ArchiGate::DocCardRemote::Searcher2
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (Searcher2Impl)
	friend class Searcher2Impl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Searcher2Impl ();

	virtual void release () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~Searcher2Impl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::Searcher2
	virtual DocCardRemote::GardocList* get_notop_created_since (
		CORBA::LongLong date
		, CORBA::Long maxCount
		, const char* partnerId
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);

	// implemented method from DocCardRemote::Searcher2
	virtual DocCardRemote::GardocList* get_top_created_since (
		CORBA::LongLong date
		, CORBA::Long maxCount
		, const char* partnerId
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);
}; // class Searcher2Impl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHER2IMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
