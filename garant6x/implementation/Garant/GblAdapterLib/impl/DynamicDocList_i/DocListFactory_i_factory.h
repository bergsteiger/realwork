////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DocListFactory_i
// �������� ���������� ������ ��������� DocListFactory ��� �������� DocListFactory_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DOCLISTFACTORY_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DOCLISTFACTORY_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DocListFactory_i
class DocListFactory_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DocListFactoryAbstractFactory
{
public:
	DocListFactory_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocListFactory* make ();

};

typedef ::Core::Var<DocListFactory_i_factory> DocListFactory_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DOCLISTFACTORY_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

