////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimLeafFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TrimLeafFilter_i
// Заголовок реализации класса серванта для интерфеса TrimLeafFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TRIMLEAFFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TRIMLEAFFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class TrimLeafFilter_i; // self forward Var
typedef ::Core::Var<TrimLeafFilter_i> TrimLeafFilter_i_var;
typedef ::Core::Var<const TrimLeafFilter_i> TrimLeafFilter_i_cvar;

class TrimLeafFilter_i_factory;

class TrimLeafFilter_i:
	virtual public TrimLeafFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TrimLeafFilter_i)
	friend class TrimLeafFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TrimLeafFilter_i ();

	virtual ~TrimLeafFilter_i ();
}; // class TrimLeafFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TRIMLEAFFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
