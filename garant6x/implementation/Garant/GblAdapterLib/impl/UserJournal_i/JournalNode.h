////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::JournalNode
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALNODE_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALNODE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class JournalNode; // self forward Var
typedef ::Core::Var<JournalNode> JournalNode_var;
typedef ::Core::Var<const JournalNode> JournalNode_cvar;

class JournalNode_factory;

class JournalNode:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (JournalNode)
	friend class JournalNode_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<JournalNode>::PoolMemoryManagerSingleton PoolJournalNode;
	typedef ::Core::PoolMemoryManager<JournalNode> Pool;
	friend class ::Core::PoolMemoryManager<JournalNode>;
	void* operator new (size_t cs) {              
		return PoolJournalNode::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolJournalNode::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	JournalNode ();

	JournalNode (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	virtual ~JournalNode ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeType m_type;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

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

}; // class JournalNode

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_I_JOURNALNODE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
