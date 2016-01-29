////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BlocksFilter_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::BlocksFilter_i
// �������� ���������� ������ ��������� BlocksFilter ��� �������� BlocksFilter_i
//
// �������� ��� ������� �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BLOCKSFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BLOCKSFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for BlocksFilter_i
class BlocksFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public BlocksFilterAbstractFactory {
public:
	BlocksFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	BlocksFilter* make ();

};

typedef ::Core::Var<BlocksFilter_i_factory> BlocksFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BLOCKSFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

