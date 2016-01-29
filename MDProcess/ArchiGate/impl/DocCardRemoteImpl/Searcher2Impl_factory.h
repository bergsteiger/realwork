////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/Searcher2Impl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::Searcher2Impl
// �������� ���������� ������ ��������� Searcher2 ��� �������� Searcher2Impl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHER2IMPL_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHER2IMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

/// Interface-factory implementation for Searcher2Impl
class Searcher2Impl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocCardRemote::Searcher2AbstractFactory
{
public:
	Searcher2Impl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocCardRemote::Searcher2* make ();

};

typedef ::Core::Var<Searcher2Impl_factory> Searcher2Impl_factory_var;

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_SEARCHER2IMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

