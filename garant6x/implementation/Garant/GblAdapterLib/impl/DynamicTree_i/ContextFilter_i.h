////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ContextFilter_i
// Заголовок реализации класса серванта для интерфеса ContextFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CONTEXTFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CONTEXTFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class ContextFilter_i; // self forward Var
typedef ::Core::Var<ContextFilter_i> ContextFilter_i_var;
typedef ::Core::Var<const ContextFilter_i> ContextFilter_i_cvar;

class ContextFilter_i_factory;

class ContextFilter_i:
	virtual public ContextFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ContextFilter_i)
	friend class ContextFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ContextFilter_i ();

	virtual ~ContextFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchArea m_area;

	GCI::IO::String_var m_context;

	FindOrder m_order;

	ContextPlace m_place;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContextFilter
	virtual SearchArea get_area () const;

	virtual void set_area (SearchArea area);

	// implemented method from ContextFilter
	virtual ContextFilter* clone () const;

	// implemented method from ContextFilter
	virtual const GCI::IO::String& get_context () const;
	virtual GCI::IO::String& get_context ();

	virtual void set_context (GCI::IO::String* context);

	// implemented method from ContextFilter
	virtual Filtered* filtrate (const ListForFiltering* list) const;

	// implemented method from ContextFilter
	virtual FindOrder get_order () const;

	virtual void set_order (FindOrder order);

	// implemented method from ContextFilter
	virtual ContextPlace get_place () const;

	virtual void set_place (ContextPlace place);
}; // class ContextFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CONTEXTFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
