////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/LayerFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::LayerFilter_i
// Заголовок реализации класса серванта для интерфеса LayerFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_LAYERFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_LAYERFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class LayerFilter_i; // self forward Var
typedef ::Core::Var<LayerFilter_i> LayerFilter_i_var;
typedef ::Core::Var<const LayerFilter_i> LayerFilter_i_cvar;

class LayerFilter_i_factory;

class LayerFilter_i:
	virtual public LayerFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LayerFilter_i)
	friend class LayerFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LayerFilter_i ();

	virtual ~LayerFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	LayerId m_layer;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from LayerFilter
	virtual LayerId get_layer () const;

	virtual void set_layer (LayerId layer);
}; // class LayerFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_LAYERFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
