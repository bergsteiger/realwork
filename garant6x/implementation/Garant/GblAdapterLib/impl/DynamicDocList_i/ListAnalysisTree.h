////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListAnalysisTree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListAnalysisTree
//
// ������ ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTANALYSISTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTANALYSISTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.h"

namespace GblAdapterLib {

// ������ ������� ������
class ListAnalysisTree;
typedef Core::Var<ListAnalysisTree> ListAnalysisTree_var;
typedef Core::Var<const ListAnalysisTree> ListAnalysisTree_cvar;

class ListAnalysisTree :
	virtual public Tree<AnalysisNode_i, NodeDelegate>
{
	SET_OBJECT_COUNTER (ListAnalysisTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit ListAnalysisTree (GTree::Tree* stree);

public:
	~ListAnalysisTree ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������, ���� �� ��������� ���� ������ � ������������ � ��������:
	// 
	// ���� ���� ����, �� ������������ ��������� � ����� �������� � �������. ���� � ��� ���-�� ����,
	// �� ���������������.
	bool m_expanded;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from TreeBase
	void add_notifier (GCL::StaticNode* root, NodeNotifier* notifier);

}; // class ListAnalysisTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTANALYSISTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

