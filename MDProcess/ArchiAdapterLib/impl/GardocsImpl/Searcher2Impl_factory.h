////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/Searcher2Impl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::Searcher2Impl
// �������� ���������� ������ ��������� Searcher2 ��� �������� Searcher2Impl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHER2IMPL_FCTR_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHER2IMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

/// Interface-factory implementation for Searcher2Impl
class Searcher2Impl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Gardocs::Searcher2AbstractFactory
{
public:
	Searcher2Impl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Gardocs::Searcher2* get ();

};

typedef ::Core::Var<Searcher2Impl_factory> Searcher2Impl_factory_var;

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_SEARCHER2IMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

