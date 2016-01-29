////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeIterator_i
// Заголовок реализации класса серванта для интерфеса NodeIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEITERATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEITERATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

//#UC START# *45F7BD35005D_CUSTOM_INCLUDES*
//#UC END# *45F7BD35005D_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class NodeIterator_i; // self forward Var
typedef ::Core::Var<NodeIterator_i> NodeIterator_i_var;
typedef ::Core::Var<const NodeIterator_i> NodeIterator_i_cvar;

class NodeIterator_i_factory;
class NodeIterator_iServantFactory;

class NodeIterator_i:
	virtual public NodeIterator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (NodeIterator_i)
	friend class NodeIterator_i_factory; // self factory
	friend class NodeIterator_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	class CompactSelectorHelper {
		SET_OBJECT_COUNTER (CompactSelectorHelper)
	//////////////////////////////////////////////////////////////////////////////////////////
	// static member methods and data
	public:
		static void close_selector (GTree::CompactSelector& selector, CompactSelectorList& selector_list);

		static long get_stub_count (GCL::StaticNode* child);

		static void open_selector (GTree::CompactSelector& selector, IndexInParent index);

		static void try_close_selector (GTree::CompactSelector& selector, CompactSelectorList& selector_list);

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	public:
		virtual ~CompactSelectorHelper ();

	}; // class CompactSelectorHelper

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NodeIterator_i (DefaultNodeBase* from_node, FlagMask with_flag);

	virtual ~NodeIterator_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual GCL::StaticNode* get_base_next () const;

	virtual GTree::CompactSelectorList* make_compact_selectors () const;

	virtual GTree::SelectorList* make_selectors () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable FlagNodeBase_var m_cur_node;

	FlagNodeBase* m_root;

	FlagMask m_with_flags;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NodeIterator
	virtual const NodeBase* get_next () const;
	virtual NodeBase* get_next ();

//#UC START# *45F7BD35005D*
typedef CompactSelectorHelper CSH;
//#UC END# *45F7BD35005D*
}; // class NodeIterator_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEITERATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
