////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_SortParamsWrapper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynList_i::SortParamsWrapper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ListSortTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/SortOrderTranslator.h"

namespace GblAdapterLib {
class DynList_i;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DynList_i::SortParamsWrapper::SortParamsWrapper (DynList_i* owner)
//#UC START# *4602A0FD032E_BASE_INIT*
	: m_owner (owner)
//#UC END# *4602A0FD032E_BASE_INIT*
{
	//#UC START# *4602A0FD032E_BODY*
	//#UC END# *4602A0FD032E_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

SortParams& DynList_i::SortParamsWrapper::get () {
	//#UC START# *4602A1660187*
	if (m_sort_params.is_nil ()) {
		GblDocList::DocListTree_ptr server_tree = m_owner->get_cached_server_doc_list ();
		GblPilotDef::SortParams params = server_tree->current_sort_type ();
		m_sort_params = new SortParams;
		m_sort_params->sort_type = ListSortTypeTranslatorSingleton::instance ()->get (params.m_type);
		m_sort_params->sort_order = SortOrderTranslatorSingleton::instance ()->get (params.m_order);
	}
	return *m_sort_params;
	//#UC END# *4602A1660187*
}

void DynList_i::SortParamsWrapper::reset () {
	//#UC START# *46CE9683006A*
	m_sort_params.release ();
	//#UC END# *46CE9683006A*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

