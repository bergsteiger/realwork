////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListCatalogBase_i.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListCatalogBase_i
// Файл inline реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class NodeType_>
ListCatalogBase_i<NodeType_>::ListCatalogBase_i (GblDocList::DocListTree* server_list)
//#UC START# *4603C88200D9_BASE_INIT*
	: m_server_list (GblDocList::DocListTree::_duplicate (server_list))
//#UC END# *4603C88200D9_BASE_INIT**cpp*
{
	//#UC START# *4603C88200D9_BODY*
	//#UC END# *4603C88200D9_BODY**cpp*
}

template <class NodeType_>
ListCatalogBase_i<NodeType_>::~ListCatalogBase_i () {
	//#UC START# *4603A1A5003A_DESTR_BODY*
	try {
		if (!CORBA::is_nil (m_server_list)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_server_list.in ());
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *4603A1A5003A_DESTR_BODY**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает экземпляр DocListTree БЕЗ увеличения счетчика ссылок!
template <class NodeType_>
GblDocList::DocListTree* ListCatalogBase_i<NodeType_>::get_cached_server_list () const {
	//#UC START# *494B7D4F02FC*
	return m_server_list.ptr ();
	//#UC END# *494B7D4F02FC**cpp*
}

template <class NodeType_>
void ListCatalogBase_i<NodeType_>::make_tree (bool active_changeable) {
	//#UC START# *462E2A5F0119*
	TreeBase_var tree = new ListTree<NodeType_> (active_changeable);
	ApplicationHelper::instance ()->get_cached_life_cycle_manager()->duplicate_object (m_server_list.in ());
	tree->apply_server_tree (m_server_list.in ());

	this->set_root (dynamic_cast<NodeBase*> (tree->root ()));
	//#UC END# *462E2A5F0119**cpp*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

template <class NodeType_>
GblDocList::DocListTree* ListCatalogBase_i<NodeType_>::get_server_list () const {
	//#UC START# *4603C8B6031A_GET_ACCESSOR*
	return GblDocList::DocListTree::_duplicate (m_server_list.in ());
	//#UC END# *4603C8B6031A_GET_ACCESSOR*
}

template <class NodeType_>
void ListCatalogBase_i<NodeType_>::set_server_list (GblDocList::DocListTree* server_list) const {
	//#UC START# *4603C8B6031A_SET_ACCESSOR*
	m_server_list = server_list;
	//#UC END# *4603C8B6031A_SET_ACCESSOR*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

