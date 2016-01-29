////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryCreator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryCreator_i::QueryCreator_i ()
//#UC START# *4CAC12FC021C_4CAC13A502F0_4CAC13BB0261_BASE_INIT*
//#UC END# *4CAC12FC021C_4CAC13A502F0_4CAC13BB0261_BASE_INIT*
{
	//#UC START# *4CAC12FC021C_4CAC13A502F0_4CAC13BB0261_BODY*
	//#UC END# *4CAC12FC021C_4CAC13A502F0_4CAC13BB0261_BODY*
}

QueryCreator_i::~QueryCreator_i () {
	//#UC START# *4CAC13BB0261_DESTR_BODY*
	//#UC END# *4CAC13BB0261_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryCreator
Query* QueryCreator_i::make_query (const GblPilotQueryDef::Query& query) const {
	//#UC START# *45FFD0F30387_4CAC13BB0261*
	return FoldersQueryFactoriesFactory::make_query (query);
	//#UC END# *45FFD0F30387_4CAC13BB0261*
}

// implemented method from QueryCreator
Query* QueryCreator_i::make_query (
	GblFolders::SavedQuery* saved_query
	, bool load_on_demand
	, FoldersNode* folders_node
) const {
	//#UC START# *45FFD15202EB_4CAC13BB0261*
	return FoldersQueryFactoriesFactory::make_query (saved_query, load_on_demand, folders_node);
	//#UC END# *45FFD15202EB_4CAC13BB0261*
}

// implemented method from QueryCreator
Query* QueryCreator_i::make_query (GblUserJournal::JournalQuery* journal_query) const {
	//#UC START# *4A8D922C0217_4CAC13BB0261*
	return FoldersQueryFactoriesFactory::make_query (journal_query);
	//#UC END# *4A8D922C0217_4CAC13BB0261*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

