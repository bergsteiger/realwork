////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/InpharmFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::InpharmFilter_i
// Заголовок реализации класса серванта для интерфеса InpharmFilter
//
// реализация фильтра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_INPHARMFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_INPHARMFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class InpharmFilter_i; // self forward Var
typedef ::Core::Var<InpharmFilter_i> InpharmFilter_i_var;
typedef ::Core::Var<const InpharmFilter_i> InpharmFilter_i_cvar;

class InpharmFilter_i_factory;

// реализация фильтра
class InpharmFilter_i:
	virtual public InpharmFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (InpharmFilter_i)
	friend class InpharmFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InpharmFilter_i ();

	virtual ~InpharmFilter_i ();
}; // class InpharmFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_INPHARMFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
