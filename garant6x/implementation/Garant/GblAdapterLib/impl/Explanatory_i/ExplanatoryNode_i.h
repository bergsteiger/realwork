////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::ExplanatoryNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_EXPLANATORYNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_EXPLANATORYNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ExplanatoryNode_i; // self forward Var
typedef ::Core::Var<ExplanatoryNode_i> ExplanatoryNode_i_var;
typedef ::Core::Var<const ExplanatoryNode_i> ExplanatoryNode_i_cvar;

class ExplanatoryNode_i_factory;
class ExplanatoryNode_iServantFactory;

class ExplanatoryNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ExplanatoryNode_i)
	friend class ExplanatoryNode_i_factory; // self factory
	friend class ExplanatoryNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<ExplanatoryNode_i>::PoolMemoryManagerSingleton PoolExplanatoryNode_i;
	typedef ::Core::PoolMemoryManager<ExplanatoryNode_i> Pool;
	friend class ::Core::PoolMemoryManager<ExplanatoryNode_i>;
	void* operator new (size_t cs) {              
		return PoolExplanatoryNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolExplanatoryNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExplanatoryNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	ExplanatoryNode_i ();

	virtual ~ExplanatoryNode_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

}; // class ExplanatoryNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_EXPLANATORYNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
