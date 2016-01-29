////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListCatalogBase_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListCatalogBase_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTCATALOGBASE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTCATALOGBASE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblDocListC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CatalogBase_i.h"

namespace GblAdapterLib {


template <class NodeType_>	
class ListCatalogBase_i:
	virtual public CatalogBase_i<NodeType_>
{
	SET_OBJECT_COUNTER (ListCatalogBase_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit ListCatalogBase_i (GblDocList::DocListTree* server_list);

	virtual ~ListCatalogBase_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void make_tree (bool active_changeable);

protected:
	// возвращает экземпляр DocListTree БЕЗ увеличения счетчика ссылок!
	virtual GblDocList::DocListTree* get_cached_server_list () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GblDocList::DocListTree_var m_server_list;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual GblDocList::DocListTree* get_server_list () const;

	virtual void set_server_list (GblDocList::DocListTree* server_list) const;
}; // class ListCatalogBase_i

} // namespace GblAdapterLib

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListCatalogBase_i.i.h"

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTCATALOGBASE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
