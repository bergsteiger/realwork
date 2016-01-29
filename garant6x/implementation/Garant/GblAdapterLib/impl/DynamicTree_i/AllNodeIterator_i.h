////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::AllNodeIterator_i
// Заголовок реализации класса серванта для интерфеса NodeIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ALLNODEITERATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ALLNODEITERATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

//#UC START# *473D8B540129_CUSTOM_INCLUDES*
//#UC END# *473D8B540129_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class AllNodeIterator_i; // self forward Var
typedef ::Core::Var<AllNodeIterator_i> AllNodeIterator_i_var;
typedef ::Core::Var<const AllNodeIterator_i> AllNodeIterator_i_cvar;

class AllNodeIterator_i_factory;
class AllNodeIterator_iServantFactory;

class AllNodeIterator_i:
	virtual public NodeIterator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AllNodeIterator_i)
	friend class AllNodeIterator_i_factory; // self factory
	friend class AllNodeIterator_iServantFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AllNodeIterator_i (DefaultNodeBase* from_node, FlagMask with_flag);

	virtual ~AllNodeIterator_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable FlagNodeBase_var m_cur_node;

	FlagMask m_with_flags;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NodeIterator
	virtual const NodeBase* get_next () const;
	virtual NodeBase* get_next ();

//#UC START# *473D8B540129*
//#UC END# *473D8B540129*
}; // class AllNodeIterator_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ALLNODEITERATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
