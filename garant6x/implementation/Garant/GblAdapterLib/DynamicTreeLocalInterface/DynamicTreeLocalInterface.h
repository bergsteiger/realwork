////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterface.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTreeLocalInterface
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREELOCALINTERFACE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREELOCALINTERFACE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"

namespace GblAdapterLib {

class QueryFilter;
typedef ::Core::Var<QueryFilter> QueryFilter_var;
typedef ::Core::Var<const QueryFilter> QueryFilter_cvar;
// ������ ��������
class QueryFilter
	: virtual public FilterForTree
{
public:
	// ������ ����������� ��� ���������� �������
	virtual const GblPilotQueryDef::FilterList& query_list () const = 0;
};

/// factory interface for QueryFilter
class QueryFilterFactory {
public:
	// �������
	static QueryFilter* make (FilterFromQuery* data)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// �������
	static QueryFilter* make (FiltersFromQuery& data)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static QueryFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::QueryFilter> {
	typedef GblAdapterLib::QueryFilterFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREELOCALINTERFACE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
