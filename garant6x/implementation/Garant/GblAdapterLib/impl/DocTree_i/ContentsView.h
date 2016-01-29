////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSVIEW_H__
#define __GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSVIEW_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/View.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"

namespace GblAdapterLib {

class ContentsView;
typedef Core::Var<ContentsView> ContentsView_var;
typedef Core::Var<const ContentsView> ContentsView_cvar;

class ContentsView :
	virtual public View<ContentsNodeDelegate>
{
	SET_OBJECT_COUNTER (ContentsView)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	ContentsView ();

public:
	virtual ~ContentsView ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from TreeBase
	virtual void add_notifier (GCL::StaticNode* root, NodeNotifier* notifier);
protected:

	// overloaded method from TreeBase
	virtual ViewBase* alloc_new_view ();

}; // class ContentsView

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCTREE_I_CONTENTSVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

