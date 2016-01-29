////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BlocksFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::BlocksFilter_i
// Заголовок реализации класса серванта для интерфеса BlocksFilter
//
// заглушка для фильтра по блокам
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BLOCKSFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BLOCKSFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class BlocksFilter_i; // self forward Var
typedef ::Core::Var<BlocksFilter_i> BlocksFilter_i_var;
typedef ::Core::Var<const BlocksFilter_i> BlocksFilter_i_cvar;

class BlocksFilter_i_factory;

// заглушка для фильтра по блокам
class BlocksFilter_i:
	virtual public BlocksFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BlocksFilter_i)
	friend class BlocksFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BlocksFilter_i ();

	virtual ~BlocksFilter_i ();
}; // class BlocksFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_BLOCKSFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
