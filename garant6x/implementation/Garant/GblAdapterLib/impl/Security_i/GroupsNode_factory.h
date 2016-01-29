////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::GroupsNode
// Заголовк реализации фабрик интерфеса GroupNode для серванта GroupsNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSNODE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSNODE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode.h"

/// Servant-factory implementation for GroupsNode
namespace GblAdapterLib {
	class GroupsTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class GroupsNodeServantFactory {
	friend class GroupsTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static GroupsNode* make ();

	static GroupsNode* make (TreeBase* owner_tree, const GTree::Node& snode);

	static GroupsNode* servant_make ();
};

/// Interface-factory implementation for GroupsNode
class GroupsNode_factory: virtual public ::Core::RefCountObjectBase, virtual public GroupNodeAbstractFactory {
	friend class GroupsNodeServantFactory;

public:
	GroupsNode_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static GroupsNode_factory* s_instance;

	const char* key () const;

	GroupNode* make ();

};

typedef ::Core::Var<GroupsNode_factory> GroupsNode_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::GroupsNode> {
	typedef GblAdapterLib::GroupsNodeServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_GROUPSNODE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

