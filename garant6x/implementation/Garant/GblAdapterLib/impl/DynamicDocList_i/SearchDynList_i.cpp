////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::SearchDynList_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearchDynList_i::SearchDynList_i (GblPilot::SearchDocList* search_doc_list)
//#UC START# *45EEDB91017A_46093B070388_4609330C0356_BASE_INIT*
	: SearchEntity_i (
			GblAdapterLib::SRT_DOCUMENT_LIST
			, search_doc_list->document_count ()
			, search_doc_list->entry_count ()
			, search_doc_list->edition_count ()
		)
	, m_doc_list_tree (search_doc_list->get_doc_list_tree ()) 
//#UC END# *45EEDB91017A_46093B070388_4609330C0356_BASE_INIT*
{
	//#UC START# *45EEDB91017A_46093B070388_4609330C0356_BODY*
	//#UC END# *45EEDB91017A_46093B070388_4609330C0356_BODY*
}

SearchDynList_i::~SearchDynList_i () {
	//#UC START# *4609330C0356_DESTR_BODY*
	//#UC END# *4609330C0356_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from SearchDynList
DynList* SearchDynList_i::get_dyn_list () const {
	//#UC START# *45EEDB91017C_4609330C0356*
	return DynListFactory::make (m_doc_list_tree.in ());
	//#UC END# *45EEDB91017C_4609330C0356*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

