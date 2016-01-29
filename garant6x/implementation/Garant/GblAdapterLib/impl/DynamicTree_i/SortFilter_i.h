////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SortFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::SortFilter_i
// Заголовок реализации класса серванта для интерфеса SortFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_SORTFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_SORTFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class SortFilter_i; // self forward Var
typedef ::Core::Var<SortFilter_i> SortFilter_i_var;
typedef ::Core::Var<const SortFilter_i> SortFilter_i_cvar;

class SortFilter_i_factory;

class SortFilter_i:
	virtual public SortFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SortFilter_i)
	friend class SortFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SortFilter_i ();

	virtual ~SortFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SortOrder m_order;

	SortFilter_var m_sub_filter;

	SortType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from SortFilter
	virtual SortOrder get_order () const;

	virtual void set_order (SortOrder order);

	// implemented method from SortFilter
	virtual const SortFilter* get_sub_filter () const;
	virtual SortFilter* get_sub_filter ();

	virtual void set_sub_filter (SortFilter* sub_filter);

	// implemented method from SortFilter
	virtual SortType get_type () const;

	virtual void set_type (SortType type);
}; // class SortFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_SORTFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
