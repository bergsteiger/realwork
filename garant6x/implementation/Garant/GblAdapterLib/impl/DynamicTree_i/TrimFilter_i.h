////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TrimFilter_i
// Заголовок реализации класса серванта для интерфеса TrimFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TRIMFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TRIMFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class TrimFilter_i; // self forward Var
typedef ::Core::Var<TrimFilter_i> TrimFilter_i_var;
typedef ::Core::Var<const TrimFilter_i> TrimFilter_i_cvar;

class TrimFilter_i_factory;

class TrimFilter_i:
	virtual public TrimFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TrimFilter_i)
	friend class TrimFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TrimFilter_i ();

	virtual ~TrimFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_is_trimmed;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TrimFilter
	virtual bool get_is_trimmed () const;

	virtual void set_is_trimmed (bool is_trimmed);
}; // class TrimFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TRIMFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
