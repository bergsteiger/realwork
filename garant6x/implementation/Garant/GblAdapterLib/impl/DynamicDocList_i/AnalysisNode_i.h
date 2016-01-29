////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::AnalysisNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_ANALYSISNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_ANALYSISNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class AnalysisNode_i; // self forward Var
typedef ::Core::Var<AnalysisNode_i> AnalysisNode_i_var;
typedef ::Core::Var<const AnalysisNode_i> AnalysisNode_i_cvar;

class AnalysisNode_i_factory;
class AnalysisNode_iServantFactory;

class AnalysisNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (AnalysisNode_i)
	friend class AnalysisNode_i_factory; // self factory
	friend class AnalysisNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<AnalysisNode_i>::PoolMemoryManagerSingleton PoolAnalysisNode_i;
	typedef ::Core::PoolMemoryManager<AnalysisNode_i> Pool;
	friend class ::Core::PoolMemoryManager<AnalysisNode_i>;
	void* operator new (size_t cs) {              
		return PoolAnalysisNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolAnalysisNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AnalysisNode_i (TreeBase* owner_tree, const GTree::Node& node);

	virtual ~AnalysisNode_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Если узел пуст, он показывается свернутым с нулем напротив в скобках. Если в нем что-то есть,
	// то разворачивается.
	virtual void expand_if_needed ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// может ли быть построен список
	bool m_has_list;


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

}; // class AnalysisNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_ANALYSISNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
