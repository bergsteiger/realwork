////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CutToLeafCountFilter_i
// �������� ���������� ������ ��������� CutToLeafCountFilter ��� �������� CutToLeafCountFilter_i
//
// ���������� ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CUTTOLEAFCOUNTFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CUTTOLEAFCOUNTFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for CutToLeafCountFilter_i
class CutToLeafCountFilter_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public CutToLeafCountFilterAbstractFactory
{
public:
	CutToLeafCountFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	CutToLeafCountFilter* make (unsigned long leaf_count);

	CutToLeafCountFilter* make ();

};

typedef ::Core::Var<CutToLeafCountFilter_i_factory> CutToLeafCountFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CUTTOLEAFCOUNTFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

