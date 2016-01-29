////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryPhoneNumberAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryPhoneNumberAttribute_i::QueryPhoneNumberAttribute_i (AttributeTag_const attribute_tag)
//#UC START# *45EEE3810296_45FFE4F3030C_45FFE89F00A5_BASE_INIT*
	: 	QueryAttribute_i (QTT_PHONE_NUMBER, attribute_tag)
//#UC END# *45EEE3810296_45FFE4F3030C_45FFE89F00A5_BASE_INIT*
{
	//#UC START# *45EEE3810296_45FFE4F3030C_45FFE89F00A5_BODY*
	//#UC END# *45EEE3810296_45FFE4F3030C_45FFE89F00A5_BODY*
}

QueryPhoneNumberAttribute_i::~QueryPhoneNumberAttribute_i () {
	//#UC START# *45FFE89F00A5_DESTR_BODY*
	//#UC END# *45FFE89F00A5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryAttribute
void QueryPhoneNumberAttribute_i::clear () {
	//#UC START# *4663F1D20290_45FFE89F00A5*
	m_city_code = 0;
	m_phone_number = 0;
	//#UC END# *4663F1D20290_45FFE89F00A5*
}

// implemented method from QueryPhoneNumberAttribute
const GCI::IO::String& QueryPhoneNumberAttribute_i::get_city_code () const {
	//#UC START# *45EEE6FA01C5_45FFE89F00A5_GET*
	if (m_city_code.is_nil ()) {
		m_city_code = GCI::IO::StringFactory::make ("");
	}
	return *(m_city_code.ptr ());
	//#UC END# *45EEE6FA01C5_45FFE89F00A5_GET*
}

GCI::IO::String& QueryPhoneNumberAttribute_i::get_city_code () {
	return const_cast<GCI::IO::String&>(((const QueryPhoneNumberAttribute_i*)this)->get_city_code ());
}

void QueryPhoneNumberAttribute_i::set_city_code (GCI::IO::String* city_code) {
	//#UC START# *45EEE6FA01C5_45FFE89F00A5_SET*
	m_city_code = IObject::_duplicate (city_code);
	//#UC END# *45EEE6FA01C5_45FFE89F00A5_SET*
}

// implemented method from QueryPhoneNumberAttribute
const GCI::IO::String& QueryPhoneNumberAttribute_i::get_phone_number () const {
	//#UC START# *45EEE6E6032D_45FFE89F00A5_GET*
	if (m_phone_number.is_nil ()) {
		m_phone_number = GCI::IO::StringFactory::make ("");
	}
	return *(m_phone_number.ptr ());
	//#UC END# *45EEE6E6032D_45FFE89F00A5_GET*
}

GCI::IO::String& QueryPhoneNumberAttribute_i::get_phone_number () {
	return const_cast<GCI::IO::String&>(((const QueryPhoneNumberAttribute_i*)this)->get_phone_number ());
}

void QueryPhoneNumberAttribute_i::set_phone_number (GCI::IO::String* phone_number) {
	//#UC START# *45EEE6E6032D_45FFE89F00A5_SET*
	m_phone_number = IObject::_duplicate (phone_number);
	//#UC END# *45EEE6E6032D_45FFE89F00A5_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

