////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SortFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::SortFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SortFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SortFilter_i::SortFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6ABE0006D_BASE_INIT*
: m_type (ST_PRIORITY), m_order (SO_DESCENDING)
//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6ABE0006D_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6ABE0006D_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6ABE0006D_BODY*
}

SortFilter_i::~SortFilter_i () {
	//#UC START# *45F6ABE0006D_DESTR_BODY*
	//#UC END# *45F6ABE0006D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from SortFilter
SortOrder SortFilter_i::get_order () const {
	//#UC START# *45EEC54700C4_45F6ABE0006D_GET*
	return m_order;
	//#UC END# *45EEC54700C4_45F6ABE0006D_GET*
}

void SortFilter_i::set_order (SortOrder order) {
	//#UC START# *45EEC54700C4_45F6ABE0006D_SET*
	m_order = order;
	//#UC END# *45EEC54700C4_45F6ABE0006D_SET*
}

// implemented method from SortFilter
const SortFilter* SortFilter_i::get_sub_filter () const {
	//#UC START# *45F6AB9A035B_45F6ABE0006D_GET*
	return m_sub_filter._sretn ();
	//#UC END# *45F6AB9A035B_45F6ABE0006D_GET*
}

SortFilter* SortFilter_i::get_sub_filter () {
	return const_cast<SortFilter*>(((const SortFilter_i*)this)->get_sub_filter ());
}

void SortFilter_i::set_sub_filter (SortFilter* sub_filter) {
	//#UC START# *45F6AB9A035B_45F6ABE0006D_SET*
	m_sub_filter = Core::IObject::_duplicate (sub_filter);
	//#UC END# *45F6AB9A035B_45F6ABE0006D_SET*
}

// implemented method from SortFilter
SortType SortFilter_i::get_type () const {
	//#UC START# *45EEC54700C3_45F6ABE0006D_GET*
	return m_type;
	//#UC END# *45EEC54700C3_45F6ABE0006D_GET*
}

void SortFilter_i::set_type (SortType type) {
	//#UC START# *45EEC54700C3_45F6ABE0006D_SET*
	m_type = type;
	//#UC END# *45EEC54700C3_45F6ABE0006D_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

