////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTreeView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListTreeView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREEVIEW_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREEVIEW_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/View.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"

namespace GblAdapterLib {

class ListTreeView;
typedef Core::Var<ListTreeView> ListTreeView_var;
typedef Core::Var<const ListTreeView> ListTreeView_cvar;

class ListTreeView :
	virtual public View<DynListNodeDelegate>
{
	SET_OBJECT_COUNTER (ListTreeView)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	ListTreeView ();

public:
	virtual ~ListTreeView ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from TreeBase
	virtual ViewBase* alloc_new_view ();

}; // class ListTreeView

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

