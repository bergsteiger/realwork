////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfoNode_i
// Заголовок реализации класса серванта для интерфеса ComplectInfoNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFONODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFONODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ComplectInfoNode_i; // self forward Var
typedef ::Core::Var<ComplectInfoNode_i> ComplectInfoNode_i_var;
typedef ::Core::Var<const ComplectInfoNode_i> ComplectInfoNode_i_cvar;

class ComplectInfoNode_i_factory;
class ComplectInfoNode_iServantFactory;

class ComplectInfoNode_i:
	virtual public ComplectInfoNode
	, virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ComplectInfoNode_i)
	friend class ComplectInfoNode_i_factory; // self factory
	friend class ComplectInfoNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<ComplectInfoNode_i>::PoolMemoryManagerSingleton PoolComplectInfoNode_i;
	typedef ::Core::PoolMemoryManager<ComplectInfoNode_i> Pool;
	friend class ::Core::PoolMemoryManager<ComplectInfoNode_i>;
	void* operator new (size_t cs) {              
		return PoolComplectInfoNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolComplectInfoNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ComplectInfoNode_i ();

	ComplectInfoNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	virtual ~ComplectInfoNode_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Данные ноды
	mutable GCI::IO::String_var m_info;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ComplectInfoNode
	virtual const GCI::IO::String* get_info () const;
	virtual GCI::IO::String* get_info ();
}; // class ComplectInfoNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFONODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
