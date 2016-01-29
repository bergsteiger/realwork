////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::MedExplanatoryNode_i
// Заголовок реализации класса серванта для интерфеса 
//
// Узел для словарной статьи мед. термина
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_MEDEXPLANATORYNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_MEDEXPLANATORYNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class MedExplanatoryNode_i; // self forward Var
typedef ::Core::Var<MedExplanatoryNode_i> MedExplanatoryNode_i_var;
typedef ::Core::Var<const MedExplanatoryNode_i> MedExplanatoryNode_i_cvar;

class MedExplanatoryNode_i_factory;
class MedExplanatoryNode_iServantFactory;

// Узел для словарной статьи мед. термина
class MedExplanatoryNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (MedExplanatoryNode_i)
	friend class MedExplanatoryNode_i_factory; // self factory
	friend class MedExplanatoryNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<MedExplanatoryNode_i>::PoolMemoryManagerSingleton PoolMedExplanatoryNode_i;
	typedef ::Core::PoolMemoryManager<MedExplanatoryNode_i> Pool;
	friend class ::Core::PoolMemoryManager<MedExplanatoryNode_i>;
	void* operator new (size_t cs) {              
		return PoolMedExplanatoryNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolMedExplanatoryNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MedExplanatoryNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	MedExplanatoryNode_i ();

	virtual ~MedExplanatoryNode_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

}; // class MedExplanatoryNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_MEDEXPLANATORYNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
