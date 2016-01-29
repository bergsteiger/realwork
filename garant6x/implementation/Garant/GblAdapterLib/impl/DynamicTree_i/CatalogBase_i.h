////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CatalogBase_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CatalogBase_i
// Заголовок реализации класса серванта для интерфеса CatalogBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CATALOGBASE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CATALOGBASE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"

namespace GblAdapterLib {


template <class NodeType_>	
class CatalogBase_i:
	virtual public CatalogBase
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CatalogBase_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~CatalogBase_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	virtual TreeBase* get_cached_adapter_tree () const;

	// Получение рута
	virtual NodeBase* get_cached_root () const;

	virtual GTree::Tree* get_cached_server_tree () const;

	virtual void make_tree (GTree::Tree* server_tree, bool active_changeable);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GCI::IO::String_var m_name;

	mutable NodeBase_var m_root;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual const NodeBase* get_root () const;

	virtual void set_root (NodeBase* root) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CatalogBase
	virtual NodeBase* get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/;

	// implemented method from CatalogBase
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	virtual void set_name (GCI::IO::String* name);
}; // class CatalogBase_i

} // namespace GblAdapterLib

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CatalogBase_i.i.h"

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CATALOGBASE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
