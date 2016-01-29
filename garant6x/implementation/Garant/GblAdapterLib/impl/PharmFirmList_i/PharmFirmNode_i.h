////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class PharmFirmNode_i; // self forward Var
typedef ::Core::Var<PharmFirmNode_i> PharmFirmNode_i_var;
typedef ::Core::Var<const PharmFirmNode_i> PharmFirmNode_i_cvar;

class PharmFirmNode_i_factory;
class PharmFirmNode_iServantFactory;

class PharmFirmNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (PharmFirmNode_i)
	friend class PharmFirmNode_i_factory; // self factory
	friend class PharmFirmNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<PharmFirmNode_i>::PoolMemoryManagerSingleton PoolPharmFirmNode_i;
	typedef ::Core::PoolMemoryManager<PharmFirmNode_i> Pool;
	friend class ::Core::PoolMemoryManager<PharmFirmNode_i>;
	void* operator new (size_t cs) {              
		return PoolPharmFirmNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolPharmFirmNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PharmFirmNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	PharmFirmNode_i ();

	virtual ~PharmFirmNode_i ();


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

}; // class PharmFirmNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
