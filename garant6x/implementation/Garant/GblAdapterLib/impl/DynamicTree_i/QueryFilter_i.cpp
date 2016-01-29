////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::QueryFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryFilter_i::QueryFilter_i (FilterFromQuery* data)
//#UC START# *4600F3AE0222_4600F67F0196_4600FB070167_BASE_INIT*
//#UC END# *4600F3AE0222_4600F67F0196_4600FB070167_BASE_INIT*
{
	//#UC START# *4600F3AE0222_4600F67F0196_4600FB070167_BODY*
	m_list.length (1);
	this->insert_data (0, data);
	//#UC END# *4600F3AE0222_4600F67F0196_4600FB070167_BODY*
}

QueryFilter_i::QueryFilter_i (FiltersFromQuery& data)
//#UC START# *4600F3AE0222_4600F69D03D8_4600FB070167_BASE_INIT*
//#UC END# *4600F3AE0222_4600F69D03D8_4600FB070167_BASE_INIT*
{
	//#UC START# *4600F3AE0222_4600F69D03D8_4600FB070167_BODY*
	m_list.length (data.size ());
	for (size_t i = 0; i < data.size (); ++i) {
		this->insert_data (i, data[i].in ());
	}
	//#UC END# *4600F3AE0222_4600F69D03D8_4600FB070167_BODY*
}

QueryFilter_i::QueryFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_4600FB070167_BASE_INIT*
//#UC END# *45EEBB9B01F4_45F6A01A007D_4600FB070167_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_4600FB070167_BODY*
	GDS_ASSERT (false);
	//#UC END# *45EEBB9B01F4_45F6A01A007D_4600FB070167_BODY*
}

QueryFilter_i::~QueryFilter_i () {
	//#UC START# *4600FB070167_DESTR_BODY*
	//#UC END# *4600FB070167_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void QueryFilter_i::insert_data (size_t index, FilterFromQuery* data) {
	//#UC START# *4600FB3E0177*
	GDS_ASSERT (index < m_list.length ());
	
	GCI::IO::String_var name (data->get_name ());
	m_list[index].name = name->get_data ();
	m_list[index].filter = data->get_server_query ();
	//#UC END# *4600FB3E0177*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryFilter
// список подзапросов для построения запроса
const GblPilotQueryDef::FilterList& QueryFilter_i::query_list () const {
	//#UC START# *4600F6FA0399_4600FB070167*
	return m_list;
	//#UC END# *4600F6FA0399_4600FB070167*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

