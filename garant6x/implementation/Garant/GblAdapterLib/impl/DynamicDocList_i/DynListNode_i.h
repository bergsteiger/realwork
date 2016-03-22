////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNode_i
// Заголовок реализации класса серванта для интерфеса DynListNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garantServer/src/Business/GblPilot/GblDocListC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class DynListNode_i; // self forward Var
typedef ::Core::Var<DynListNode_i> DynListNode_i_var;
typedef ::Core::Var<const DynListNode_i> DynListNode_i_cvar;

class DynListNode_i_factory;
class DynListNode_iServantFactory;

class DynListNode_i:
	virtual public DynListNode
	, virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (DynListNode_i)
	friend class DynListNode_i_factory; // self factory
	friend class DynListNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<DynListNode_i>::PoolMemoryManagerSingleton PoolDynListNode_i;
	typedef ::Core::PoolMemoryManager<DynListNode_i> Pool;
	friend class ::Core::PoolMemoryManager<DynListNode_i>;
	void* operator new (size_t cs) {              
		return PoolDynListNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolDynListNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DynListNode_i ();

	DynListNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	virtual ~DynListNode_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual unsigned long get_block_position () const;

private:
	virtual ObjectId get_parent_document_id () const;

	virtual bool is_document_node (GblDocList::ListNodeType type) const;

	virtual bool is_sub_or_para_node () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable ObjectId m_document_id;

	char m_list_node_type;

	GCI::IO::String_var m_snippet_text;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DynListNode
	// Получить идентифкатор документа из ноды списка
	virtual ObjectId get_document_id () const;

	// implemented method from DynListNode
	virtual const GCI::IO::String* get_snippet_text () const;
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

}; // class DynListNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
