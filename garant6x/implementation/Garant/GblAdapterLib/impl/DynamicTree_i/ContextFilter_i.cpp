////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ContextFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContextFilter_i::ContextFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6A24B01B5_BASE_INIT*
	: m_order (FO_ANY), m_area (SA_ONE_LEVEL), m_place (CP_BEGIN_OF_WORD), m_context (GCI::IO::StringFactory::make (""))
//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6A24B01B5_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6A24B01B5_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6A24B01B5_BODY*
}

ContextFilter_i::~ContextFilter_i () {
	//#UC START# *45F6A24B01B5_DESTR_BODY*
	//#UC END# *45F6A24B01B5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContextFilter
SearchArea ContextFilter_i::get_area () const {
	//#UC START# *45F6A12200FA_45F6A24B01B5_GET*
	return m_area;
	//#UC END# *45F6A12200FA_45F6A24B01B5_GET*
}

void ContextFilter_i::set_area (SearchArea area) {
	//#UC START# *45F6A12200FA_45F6A24B01B5_SET*
	m_area = area;
	//#UC END# *45F6A12200FA_45F6A24B01B5_SET*
}

// implemented method from ContextFilter
ContextFilter* ContextFilter_i::clone () const {
	//#UC START# *46E662C8033B_45F6A24B01B5*
	Core::Var<ContextFilter_i> clone = new ContextFilter_i ();	
	clone->m_order = m_order;
	clone->m_area = m_area;
	clone->m_place = m_place;
	clone->m_context = m_context;
	return clone._retn ();
	//#UC END# *46E662C8033B_45F6A24B01B5*
}

// implemented method from ContextFilter
const GCI::IO::String& ContextFilter_i::get_context () const {
	//#UC START# *45F6A1BE034B_45F6A24B01B5_GET*
	return *m_context.in ();
	//#UC END# *45F6A1BE034B_45F6A24B01B5_GET*
}

GCI::IO::String& ContextFilter_i::get_context () {
	return const_cast<GCI::IO::String&>(((const ContextFilter_i*)this)->get_context ());
}

void ContextFilter_i::set_context (GCI::IO::String* context) {
	//#UC START# *45F6A1BE034B_45F6A24B01B5_SET*
	m_context = GCI::IO::String::_duplicate (context);
	//#UC END# *45F6A1BE034B_45F6A24B01B5_SET*
}

// implemented method from ContextFilter
Filtered* ContextFilter_i::filtrate (const ListForFiltering* list) const {
	//#UC START# *4D3E9E7E01ED_45F6A24B01B5*
	GDS_ASSERT (m_context->get_length());

	GTree::NameFilter_var name_filter = new OBV_GTree::NameFilter ();
	name_filter->name_context (m_context->get_data ());
	name_filter->area (ServerAdapterConverters::adapter_to_server (m_area));
	name_filter->order (ServerAdapterConverters::adapter_to_server (m_order));
	name_filter->place (ServerAdapterConverters::adapter_to_server (m_place));

	GCD::StringList server_list;
	server_list.length (list->get_count ());

	for (size_t i = 0, count = list->get_count (); i < count; ++i) {
		GCI::IO::String_var item = list->item (i);
		server_list [i] = item->get_data ();
	}

	GCD::LongList_var server_result (
		ApplicationHelper::instance ()->get_cached_context_filter ()->filtrate (server_list, name_filter.in ())
	);
	
	return new Filtered (server_result->get_buffer (), server_result->get_buffer () + server_result->length ());
	//#UC END# *4D3E9E7E01ED_45F6A24B01B5*
}

// implemented method from ContextFilter
FindOrder ContextFilter_i::get_order () const {
	//#UC START# *45F6A0FB00EA_45F6A24B01B5_GET*
	return m_order;
	//#UC END# *45F6A0FB00EA_45F6A24B01B5_GET*
}

void ContextFilter_i::set_order (FindOrder order) {
	//#UC START# *45F6A0FB00EA_45F6A24B01B5_SET*
	m_order = order;
	//#UC END# *45F6A0FB00EA_45F6A24B01B5_SET*
}

// implemented method from ContextFilter
ContextPlace ContextFilter_i::get_place () const {
	//#UC START# *45F6A08A0000_45F6A24B01B5_GET*
	return m_place;
	//#UC END# *45F6A08A0000_45F6A24B01B5_GET*
}

void ContextFilter_i::set_place (ContextPlace place) {
	//#UC START# *45F6A08A0000_45F6A24B01B5_SET*
	m_place = place;
	//#UC END# *45F6A08A0000_45F6A24B01B5_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

