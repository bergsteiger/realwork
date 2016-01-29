////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/SearcherImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::SearcherImpl
// ��������� ���������� ������ �������� ��� ��������� Searcher
//
//
// ��� ����� ����������� ��� ��� "������-������".
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
	// ������ ����� ������������������ ���������� ����� date (����� � �������� ����� 1-�� ������ 1970
	// ����). ������������ ������ ���������, ������� �� ����� ������ ����������.
	virtual DocCardRemote::GardocList* get_notop_created_since (
		CORBA::LongLong date
		, CORBA::Long maxCount
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);

	// implemented method from DocCardRemote::Searcher
	// ������ ����� ������������������ ���������� ����� date (����� � �������� ����� 1-�� ������ 1970
	// ����)
	virtual DocCardRemote::GardocList* get_recently_created_since (
		CORBA::LongLong date
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);

	// implemented method from DocCardRemote::Searcher
	// ������ ����� ������������������ ���������� ����� date (����� � �������� ����� 1-�� ������ 1970
	// ����). ������������ ������ ���������, ������� ����� ������ ����������.
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
