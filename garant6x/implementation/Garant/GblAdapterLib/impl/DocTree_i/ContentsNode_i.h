////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNode_i
// Заголовок реализации класса серванта для интерфеса ContentsNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

//#UC START# *4C778CFA0134_CUSTOM_INCLUDES*
//#UC END# *4C778CFA0134_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ContentsNode_i; // self forward Var
typedef ::Core::Var<ContentsNode_i> ContentsNode_i_var;
typedef ::Core::Var<const ContentsNode_i> ContentsNode_i_cvar;

class ContentsNode_i_factory;
class ContentsNode_iServantFactory;

class ContentsNode_i:
	virtual public ContentsNode
	, virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ContentsNode_i)
	friend class ContentsNode_i_factory; // self factory
	friend class ContentsNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<ContentsNode_i>::PoolMemoryManagerSingleton PoolContentsNode_i;
	typedef ::Core::PoolMemoryManager<ContentsNode_i> Pool;
	friend class ::Core::PoolMemoryManager<ContentsNode_i>;
	void* operator new (size_t cs) {              
		return PoolContentsNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolContentsNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ContentsNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	ContentsNode_i ();

	virtual ~ContentsNode_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeId m_id;

	NodeType m_type;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е.
	// не уникален.
	virtual NodeId get_node_id () const;

	// overloaded method from NodeBase
	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/;


//#UC START# *4C778CFA0134*
//#UC END# *4C778CFA0134*
}; // class ContentsNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
