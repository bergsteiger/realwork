////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::GroupsNode
// Заголовок реализации класса серванта для интерфеса GroupNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSNODE_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSNODE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

//#UC START# *49DF28BE03B4_CUSTOM_INCLUDES*
//#UC END# *49DF28BE03B4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class GroupsNode; // self forward Var
typedef ::Core::Var<GroupsNode> GroupsNode_var;
typedef ::Core::Var<const GroupsNode> GroupsNode_cvar;

class GroupsNode_factory;
class GroupsNodeServantFactory;

class GroupsNode:
	virtual public GroupNode
	, virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (GroupsNode)
	friend class GroupsNode_factory; // self factory
	friend class GroupsNodeServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<GroupsNode>::PoolMemoryManagerSingleton PoolGroupsNode;
	typedef ::Core::PoolMemoryManager<GroupsNode> Pool;
	friend class ::Core::PoolMemoryManager<GroupsNode>;
	void* operator new (size_t cs) {              
		return PoolGroupsNode::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolGroupsNode::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GroupsNode (TreeBase* owner_tree, const GTree::Node& snode);

	GroupsNode ();

	virtual ~GroupsNode ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GroupNode
	// есть ли в группе пользователи
	virtual bool has_users () const /*throw (AccessDenied, CanNotFindData)*/;

	// implemented method from ProfileNode
	virtual Uid get_uid () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/;


//#UC START# *49DF28BE03B4*
//#UC END# *49DF28BE03B4*
}; // class GroupsNode

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSNODE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
