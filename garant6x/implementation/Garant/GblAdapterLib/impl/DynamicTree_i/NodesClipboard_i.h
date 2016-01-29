////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodesClipboard_i
// Заголовок реализации класса серванта для интерфеса NodesClipboard
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESCLIPBOARD_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESCLIPBOARD_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Global/Core/GTreeC.h"

//#UC START# *4600E3C501E4_CUSTOM_INCLUDES*
//#UC END# *4600E3C501E4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class NodesClipboard_i; // self forward Var
typedef ::Core::Var<NodesClipboard_i> NodesClipboard_i_var;
typedef ::Core::Var<const NodesClipboard_i> NodesClipboard_i_cvar;

class NodesClipboard_i_factory;

class NodesClipboard_i:
	virtual public NodesClipboard
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (NodesClipboard_i)
	friend class NodesClipboard_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NodesClipboard_i ();

	NodesClipboard_i (GTree::NodeHolder* node_holder);

	virtual ~NodesClipboard_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual GTree::NodeHolder* node_holder ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GTree::NodeHolder_var m_server_node_holder;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NodesClipboard
	virtual GCI::IO::Stream* as_evd (EVDGeneratorStyle style) const;

	// implemented method from NodesClipboard
	virtual unsigned long get_count () const;

//#UC START# *4600E3C501E4*
//#UC END# *4600E3C501E4*
}; // class NodesClipboard_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESCLIPBOARD_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
