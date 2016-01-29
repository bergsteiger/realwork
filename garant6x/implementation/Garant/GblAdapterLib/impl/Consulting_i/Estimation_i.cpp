////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Estimation_i
//
// реализация интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Estimation_i::Estimation_i ()
//#UC START# *4570081E002E_45700DC8004E_45700D700000_BASE_INIT*
//#UC END# *4570081E002E_45700DC8004E_45700D700000_BASE_INIT*
{
	//#UC START# *4570081E002E_45700DC8004E_45700D700000_BODY*
	//#UC END# *4570081E002E_45700DC8004E_45700D700000_BODY*
}

Estimation_i::~Estimation_i () {
	//#UC START# *45700D700000_DESTR_BODY*
	//#UC END# *45700D700000_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Estimation
// комментарий к оценке
const GCI::IO::String& Estimation_i::get_text () const {
	//#UC START# *4570081E0030_45700D700000_GET*
	return *m_text.ptr ();
	//#UC END# *4570081E0030_45700D700000_GET*
}

GCI::IO::String& Estimation_i::get_text () {
	return const_cast<GCI::IO::String&>(((const Estimation_i*)this)->get_text ());
}

void Estimation_i::set_text (GCI::IO::String* text) {
	//#UC START# *4570081E0030_45700D700000_SET*
	m_text = GCI::IO::String::_duplicate (text);
	//#UC END# *4570081E0030_45700D700000_SET*
}

// implemented method from Estimation
// оценка
EstimationValue Estimation_i::get_value () const {
	//#UC START# *4570081E002F_45700D700000_GET*
	return m_value;
	//#UC END# *4570081E002F_45700D700000_GET*
}

void Estimation_i::set_value (EstimationValue value) {
	//#UC START# *4570081E002F_45700D700000_SET*
	m_value = value;
	//#UC END# *4570081E002F_45700D700000_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

