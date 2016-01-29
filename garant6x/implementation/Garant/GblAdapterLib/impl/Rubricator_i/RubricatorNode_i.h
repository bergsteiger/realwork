////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Rubricator_i::RubricatorNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_RUBRICATORNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_RUBRICATORNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class RubricatorNode_i; // self forward Var
typedef ::Core::Var<RubricatorNode_i> RubricatorNode_i_var;
typedef ::Core::Var<const RubricatorNode_i> RubricatorNode_i_cvar;

class RubricatorNode_i_factory;
class RubricatorNode_iServantFactory;

class RubricatorNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (RubricatorNode_i)
	friend class RubricatorNode_i_factory; // self factory
	friend class RubricatorNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<RubricatorNode_i>::PoolMemoryManagerSingleton PoolRubricatorNode_i;
	typedef ::Core::PoolMemoryManager<RubricatorNode_i> Pool;
	friend class ::Core::PoolMemoryManager<RubricatorNode_i>;
	void* operator new (size_t cs) {              
		return PoolRubricatorNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolRubricatorNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RubricatorNode_i ();

	RubricatorNode_i (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	virtual ~RubricatorNode_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeType m_node_type;


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

}; // class RubricatorNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_RUBRICATORNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
