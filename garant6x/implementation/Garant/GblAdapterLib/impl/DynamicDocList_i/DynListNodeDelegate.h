////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNodeDelegate
// Заголовок реализации класса серванта для интерфеса DynListNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODEDELEGATE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODEDELEGATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

namespace GblAdapterLib {

class DynListNodeDelegate; // self forward Var
typedef ::Core::Var<DynListNodeDelegate> DynListNodeDelegate_var;
typedef ::Core::Var<const DynListNodeDelegate> DynListNodeDelegate_cvar;

class DynListNodeDelegate_factory;
class DynListNodeDelegateServantFactory;

class DynListNodeDelegate:
	virtual public DynListNode
	, virtual public NodeDelegate
{
	SET_OBJECT_COUNTER (DynListNodeDelegate)
	friend class DynListNodeDelegate_factory; // self factory
	friend class DynListNodeDelegateServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<DynListNodeDelegate>::PoolMemoryManagerSingleton PoolDynListNodeDelegate;
	typedef ::Core::PoolMemoryManager<DynListNodeDelegate> Pool;
	friend class ::Core::PoolMemoryManager<DynListNodeDelegate>;
	void* operator new (size_t cs) {              
		return PoolDynListNodeDelegate::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolDynListNodeDelegate::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit DynListNodeDelegate (TreeBase* owner_tree);

	virtual ~DynListNodeDelegate ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DynListNode
	// Получить идентифкатор документа из ноды списка
	virtual ObjectId get_document_id () const;

	// implemented method from DynListNode
	virtual const GCI::IO::String* get_snippet_text () const;
}; // class DynListNodeDelegate

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODEDELEGATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
