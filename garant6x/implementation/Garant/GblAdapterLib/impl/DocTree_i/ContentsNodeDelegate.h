////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNodeDelegate
// Заголовок реализации класса серванта для интерфеса ContentsNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODEDELEGATE_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODEDELEGATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

namespace GblAdapterLib {

class ContentsNodeDelegate; // self forward Var
typedef ::Core::Var<ContentsNodeDelegate> ContentsNodeDelegate_var;
typedef ::Core::Var<const ContentsNodeDelegate> ContentsNodeDelegate_cvar;

class ContentsNodeDelegate_factory;
class ContentsNodeDelegateServantFactory;

class ContentsNodeDelegate:
	virtual public ContentsNode
	, virtual public NodeDelegate
{
	SET_OBJECT_COUNTER (ContentsNodeDelegate)
	friend class ContentsNodeDelegate_factory; // self factory
	friend class ContentsNodeDelegateServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<ContentsNodeDelegate>::PoolMemoryManagerSingleton PoolContentsNodeDelegate;
	typedef ::Core::PoolMemoryManager<ContentsNodeDelegate> Pool;
	friend class ::Core::PoolMemoryManager<ContentsNodeDelegate>;
	void* operator new (size_t cs) {              
		return PoolContentsNodeDelegate::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolContentsNodeDelegate::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit ContentsNodeDelegate (TreeBase* owner_tree);

	virtual ~ContentsNodeDelegate ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е.
	// не уникален.
	virtual NodeId get_node_id () const;

}; // class ContentsNodeDelegate

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODEDELEGATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
