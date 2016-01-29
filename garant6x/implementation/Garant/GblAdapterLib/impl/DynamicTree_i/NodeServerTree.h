////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeServerTree
//
// ���������� ������, � ����� ��������� (�������� �������������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESERVERTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESERVERTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

//#UC START# *45F7C10C005D_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Business/GblPilot/Home/Adapter.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/TreeNameTranslator.h"
//#UC END# *45F7C10C005D_CUSTOM_INCLUDES*

namespace GblAdapterLib {

// ���������� ������, � ����� ��������� (�������� �������������)
template <class NodeType_>
class NodeServerTree :
	virtual public Listener
	, virtual public Tree<NodeType_, NodeDelegate>
{
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	static TreeBase* make_tree (AttributeTag_const name);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~NodeServerTree ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Listener
	virtual void fire (const Notification* notify) const;

//#UC START# *45F7C10C005D*
protected:
	NodeServerTree (AttributeTag_const name) 
		: TreeBase (false/*��������� ������� ���������� active changable*/)
		, Tree<NodeType_, NodeDelegate> (false/*��������� ������� ���������� active changable*/) {
		//LOG_D (("%s [%d] (%s)", GDS_CURRENT_FUNCTION, (TreeBase*)this, name));
		AttributeTag_const server_tree_name = GblAdapterLib::shell_to_adapter (name);
		GblPilotQueryDef::AttributeTag server_tag = Defines::AttributeTagTranslator::translate (server_tree_name);
		{
			// ����� ������� ��������� ����������� ����� ResetDelta �������� ��� ��������
			// ��� ��� ������ �������� ��������, ����� ������ � ����� ���� �������
			// ��������� �� ������� ������� ������ �� ��������� � �� ������� ������ �� ����� ����������
			// �� �������� ����� �������� ������ ������, ������ � �����
			// � ������ ��������� �������� ������ �� "�������"
			if (!ApplicationHelper::instance ()->get_cached_search_manager ()->attribute_exists (server_tag)) {
				throw CanNotFindData ();
			}
		}
		try {
			GTree::Tree_var tree = ApplicationHelper::instance ()->get_cached_search_manager ()->get_index_tree (server_tag);

			this->apply_server_tree (tree.in ());
			this->set_tree_name (name);

			if (this->get_tree_name () == "AT_NEWS_LINE") {
				NotifyManagerFactory::make ().register_listener_for_notify (NT_MONITORING_UPDATE, this);
				//LOG_D (("Tree::Tree AT_NEWS_LINE 0x%X", (TreeBase*)this));	
			}
		} catch (GCD::CanNotFindData&) {
			throw CanNotFindData ();
		} catch (...) {
			GDS_ASSERT (false);
		}
	}

protected:
	typedef std::map<std::string, GCL::StaticNode_var> TreesMap;
	typedef ACE_Singleton <TreesMap, ACE_SYNCH_RECURSIVE_MUTEX> TreesMapSingl;

private:
	typedef Core::TypeSingleton<ApplicationHelper::BaseId> BaseIdSingleton;
//#UC END# *45F7C10C005D*
}; // class NodeServerTree

} // namespace GblAdapterLib

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.i.h"

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESERVERTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

