////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::SearcherImpl
// Заголовок реализации класса серванта для интерфеса Searcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHERIMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class SearcherImpl; // self forward Var
typedef ::Core::Var<SearcherImpl> SearcherImpl_var;
typedef ::Core::Var<const SearcherImpl> SearcherImpl_cvar;

class SearcherImpl_factory;

class SearcherImpl:
	virtual public POA_ArchiGate::DocCardRemote::Searcher
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (SearcherImpl)
	friend class SearcherImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SearcherImpl ();

	virtual void release () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~SearcherImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::Searcher
	// Список новых зарегистрированных документов после date (время в секундах после 1-го января 1970
	// года). Возвращаются только документы, которые НЕ нужно срочно обработать.
	virtual DocCardRemote::GardocList* get_notop_created_since (
		CORBA::LongLong date
		, CORBA::Long maxCount
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);

	// implemented method from DocCardRemote::Searcher
	// список новых зарегистрированных документов после date (время в секундах после 1-го января 1970
	// года)
	virtual DocCardRemote::GardocList* get_recently_created_since (
		CORBA::LongLong date
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);

	// implemented method from DocCardRemote::Searcher
	// список новых зарегистрированных документов после date (время в секундах после 1-го января 1970
	// года). Возвращаются только документы, которые нужно срочно обработать.
	virtual DocCardRemote::GardocList* get_top_created_since (
		CORBA::LongLong date
		, CORBA::Long maxCount
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);
}; // class SearcherImpl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
