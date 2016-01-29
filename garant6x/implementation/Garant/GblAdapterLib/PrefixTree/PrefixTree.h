////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PrefixTree
//
// ������ ��� ��� �������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PREFIXTREE_H__
#define __GARANT6X_GBLADAPTERLIB_PREFIXTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"
#include "garantServer/src/Global/Core/GTreeC.h"

namespace GblAdapterLib {

class PrefixNode;
typedef ::Core::Var<PrefixNode> PrefixNode_var;
typedef ::Core::Var<const PrefixNode> PrefixNode_cvar;
// ���� �������� ��� �������� ����������
class PrefixNode
	: virtual public NodeBase
{
};

/// factory interface for PrefixNode
class PrefixNodeFactory {
public:
	static PrefixNode* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/;

	static PrefixNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::PrefixNode> {
	typedef GblAdapterLib::PrefixNodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PREFIXTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
