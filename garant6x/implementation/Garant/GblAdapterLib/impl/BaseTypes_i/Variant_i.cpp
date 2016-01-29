////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::Variant_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i.h"

//#UC START# *456EEB6E00EA_CUSTOM_INCLUDES*
//#UC END# *456EEB6E00EA_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *456EEB6E00EA*
//#UC END# *456EEB6E00EA*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Variant_i::Variant_i ()
//#UC START# *456ED2D701D4_4602A882007D_456EEB6E00EA_BASE_INIT*
//#UC END# *456ED2D701D4_4602A882007D_456EEB6E00EA_BASE_INIT*
{
	//#UC START# *456ED2D701D4_4602A882007D_456EEB6E00EA_BODY*
	//#UC END# *456ED2D701D4_4602A882007D_456EEB6E00EA_BODY*
}

Variant_i::Variant_i (long value)
//#UC START# *456ED2D701D4_456EE9DF038A_456EEB6E00EA_BASE_INIT*
: m_type (VT_LONG), m_long (value)
//#UC END# *456ED2D701D4_456EE9DF038A_456EEB6E00EA_BASE_INIT*
{
	//#UC START# *456ED2D701D4_456EE9DF038A_456EEB6E00EA_BODY*
	//#UC END# *456ED2D701D4_456EE9DF038A_456EEB6E00EA_BODY*
}

Variant_i::Variant_i (bool value)
//#UC START# *456ED2D701D4_456EEA5F005D_456EEB6E00EA_BASE_INIT*
: m_type (VT_BOOL), m_bool (value)
//#UC END# *456ED2D701D4_456EEA5F005D_456EEB6E00EA_BASE_INIT*
{
	//#UC START# *456ED2D701D4_456EEA5F005D_456EEB6E00EA_BODY*
	//#UC END# *456ED2D701D4_456EEA5F005D_456EEB6E00EA_BODY*
}

Variant_i::Variant_i (GCI::IO::String* value)
//#UC START# *456ED2D701D4_456EEA7E0261_456EEB6E00EA_BASE_INIT*
: m_type(VT_STRING)
//#UC END# *456ED2D701D4_456EEA7E0261_456EEB6E00EA_BASE_INIT*
{
	//#UC START# *456ED2D701D4_456EEA7E0261_456EEB6E00EA_BODY*
	m_string = GCI::IO::String::_duplicate (value);
	//#UC END# *456ED2D701D4_456EEA7E0261_456EEB6E00EA_BODY*
}

Variant_i::Variant_i (Core::IObject* value)
//#UC START# *456ED2D701D4_456EEA9C01E4_456EEB6E00EA_BASE_INIT*
: m_type(VT_OBJECT)
//#UC END# *456ED2D701D4_456EEA9C01E4_456EEB6E00EA_BASE_INIT*
{
	//#UC START# *456ED2D701D4_456EEA9C01E4_456EEB6E00EA_BODY*
	m_object = Core::IObject::_duplicate (value);
	//#UC END# *456ED2D701D4_456EEA9C01E4_456EEB6E00EA_BODY*
}

Variant_i::~Variant_i () {
	//#UC START# *456EEB6E00EA_DESTR_BODY*
	//#UC END# *456EEB6E00EA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Variant
// вернуть булево значение
bool Variant_i::get_bool () const /*throw (InvalidType)*/ {
	//#UC START# *456ED2D701D6_456EEB6E00EA*
	if (m_type != VT_BOOL) {
		throw InvalidType ();
	}
	return m_bool;
	//#UC END# *456ED2D701D6_456EEB6E00EA*
}

// implemented method from Variant
// вернуть целое
long Variant_i::get_long () const /*throw (InvalidType)*/ {
	//#UC START# *456ED2D701D5_456EEB6E00EA*
	if (m_type != VT_LONG) {
		throw InvalidType ();
	}
	return m_long;
	//#UC END# *456ED2D701D5_456EEB6E00EA*
}

// implemented method from Variant
// вернуть объект
Core::IObject* Variant_i::get_object () /*throw (InvalidType)*/ {
	//#UC START# *456ED2D701D8_456EEB6E00EA*
	if (m_type != VT_OBJECT) {
		throw InvalidType ();
	}
	return m_object._sretn ();
	//#UC END# *456ED2D701D8_456EEB6E00EA*
}

// implemented method from Variant
// вернуть строку
GCI::IO::String* Variant_i::get_string () /*throw (InvalidType)*/ {
	//#UC START# *456ED2D701D7_456EEB6E00EA*
	if (m_type != VT_STRING) {
		throw InvalidType ();
	}
	return m_string._sretn ();
	//#UC END# *456ED2D701D7_456EEB6E00EA*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

