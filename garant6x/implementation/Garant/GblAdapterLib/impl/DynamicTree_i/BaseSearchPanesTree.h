////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BaseSearchPanesTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::BaseSearchPanesTree
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BASESEARCHPANESTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BASESEARCHPANESTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class BaseSearchPanesTree; // self forward Var
typedef ::Core::Var<BaseSearchPanesTree> BaseSearchPanesTree_var;
typedef ::Core::Var<const BaseSearchPanesTree> BaseSearchPanesTree_cvar;

class BaseSearchPanesTree_factory;

class BaseSearchPanesTree:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (BaseSearchPanesTree)
	friend class BaseSearchPanesTree_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~BaseSearchPanesTree ();
}; // class BaseSearchPanesTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BASESEARCHPANESTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
