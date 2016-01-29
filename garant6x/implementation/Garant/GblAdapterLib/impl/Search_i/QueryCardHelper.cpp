////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryCardHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryCardHelper::QueryCardHelper ()
//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC969FF0186_BASE_INIT*
//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC969FF0186_BASE_INIT*
{
	//#UC START# *4CC7D7240069_4CC7E1EC001C_4CC969FF0186_BODY*
	//#UC END# *4CC7D7240069_4CC7E1EC001C_4CC969FF0186_BODY*
}

QueryCardHelper::~QueryCardHelper () {
	//#UC START# *4CC969FF0186_DESTR_BODY*
	//#UC END# *4CC969FF0186_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GCI::IO::Stream* QueryCardHelper::get_evd_card (GblPilotQueryDef::QueryType type) const {
	//#UC START# *4CC96BB400E3*
	try {
		GCD::SeqOctet_var card (
			ApplicationHelper::instance ()->get_cached_search_manager ()->get_evd_query_form (type)
		);
		return MemoryStreamFactory::make (card.in (), true);
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}

	GDS_ASSERT (false);
	return 0;
	//#UC END# *4CC96BB400E3*
}

AttributeList* QueryCardHelper::get_exist_attrs (GblPilotQueryDef::QueryType type) const {
	//#UC START# *4CCA6530017A*
	GblPilotQueryDef::FullAttributeInfoList_var result 
		(ApplicationHelper::instance ()->get_cached_search_manager ()->get_attributes_info (type));

	std::auto_ptr<AttributeList> out (new AttributeList ());
	if (result.ptr () && result->length ()) {
		out->reserve (result->length ());
		for (size_t i = 0; i < result->length (); ++i) {
			out->push_back (FullAttributeInfoFactory::make (result[i]));
		}
	}

	return out.release ();
	//#UC END# *4CCA6530017A*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

