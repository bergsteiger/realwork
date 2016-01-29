////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::NewsLine_i::NewsLineNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NEWSLINE_I_NEWSLINENODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_NEWSLINE_I_NEWSLINENODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class NewsLineNode_i; // self forward Var
typedef ::Core::Var<NewsLineNode_i> NewsLineNode_i_var;
typedef ::Core::Var<const NewsLineNode_i> NewsLineNode_i_cvar;

class NewsLineNode_i_factory;
class NewsLineNode_iServantFactory;

class NewsLineNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (NewsLineNode_i)
	friend class NewsLineNode_i_factory; // self factory
	friend class NewsLineNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<NewsLineNode_i>::PoolMemoryManagerSingleton PoolNewsLineNode_i;
	typedef ::Core::PoolMemoryManager<NewsLineNode_i> Pool;
	friend class ::Core::PoolMemoryManager<NewsLineNode_i>;
	void* operator new (size_t cs) {              
		return PoolNewsLineNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolNewsLineNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NewsLineNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	NewsLineNode_i ();

	virtual ~NewsLineNode_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

}; // class NewsLineNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NEWSLINE_I_NEWSLINENODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
