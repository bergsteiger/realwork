////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocNodeFilter_i
// �������� ���������� ������ ��������� DocNodeFilter ��� �������� DocNodeFilter_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DocNodeFilter_i
class DocNodeFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DocNodeFilterAbstractFactory {
public:
	DocNodeFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DocNodeFilter* make ();

};

typedef ::Core::Var<DocNodeFilter_i_factory> DocNodeFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_DOCNODEFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

