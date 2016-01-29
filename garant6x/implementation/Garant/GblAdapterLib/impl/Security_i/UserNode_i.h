////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNode_i
// Заголовок реализации класса серванта для интерфеса ProfileNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

//#UC START# *49E46F4802D4_CUSTOM_INCLUDES*
//#UC END# *49E46F4802D4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class UserNode_i; // self forward Var
typedef ::Core::Var<UserNode_i> UserNode_i_var;
typedef ::Core::Var<const UserNode_i> UserNode_i_cvar;

class UserNode_i_factory;
class UserNode_iServantFactory;

class UserNode_i:
	virtual public ProfileNode
	, virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (UserNode_i)
	friend class UserNode_i_factory; // self factory
	friend class UserNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<UserNode_i>::PoolMemoryManagerSingleton PoolUserNode_i;
	typedef ::Core::PoolMemoryManager<UserNode_i> Pool;
	friend class ::Core::PoolMemoryManager<UserNode_i>;
	void* operator new (size_t cs) {              
		return PoolUserNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolUserNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UserNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	UserNode_i ();

	virtual ~UserNode_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ProfileNode
	virtual Uid get_uid () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RealNodeBase
	virtual void change_node_value (const GTree::NodeValueData& value);
protected:

	// overloaded method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

	// overloaded method from NodeBase
	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/;


//#UC START# *49E46F4802D4*
private:
	static NodeType UserNode_i::create_type_by_flags (GslUserManager::UserFlag flags);
//#UC END# *49E46F4802D4*
}; // class UserNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
