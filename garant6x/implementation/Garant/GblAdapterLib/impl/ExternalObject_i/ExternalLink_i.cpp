////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalLink_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExternalLink_i::ExternalLink_i (const char* url)
//#UC START# *45ED93720286_45EE711B02D4_45EE7E3F0394_BASE_INIT*
	: m_url (GCI::IO::StringFactory::make (url))
//#UC END# *45ED93720286_45EE711B02D4_45EE7E3F0394_BASE_INIT*
{
	//#UC START# *45ED93720286_45EE711B02D4_45EE7E3F0394_BODY*
	//#UC END# *45ED93720286_45EE711B02D4_45EE7E3F0394_BODY*
}

ExternalLink_i::~ExternalLink_i () {
	//#UC START# *45EE7E3F0394_DESTR_BODY*
	//#UC END# *45EE7E3F0394_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ExternalLink
// Ссылка на внешние ресурсы в стандарте URL.
const GCI::IO::String* ExternalLink_i::get_url () const {
	//#UC START# *45ED93720288_45EE7E3F0394_GET*
	return m_url._sretn ();
	//#UC END# *45ED93720288_45EE7E3F0394_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

