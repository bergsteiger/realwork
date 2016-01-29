////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::BoolTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BoolTransformer_i::BoolTransformer_i ()
//#UC START# *45F7C61D0004_45F8012A0233_45F7F08D023A_BASE_INIT*
//#UC END# *45F7C61D0004_45F8012A0233_45F7F08D023A_BASE_INIT*
{
	//#UC START# *45F7C61D0004_45F8012A0233_45F7F08D023A_BODY*
	//#UC END# *45F7C61D0004_45F8012A0233_45F7F08D023A_BODY*
}

BoolTransformer_i::~BoolTransformer_i () {
	//#UC START# *45F7F08D023A_DESTR_BODY*
	//#UC END# *45F7F08D023A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DataTransformer
Variant* BoolTransformer_i::get_variant (const CORBA::Any& data) const {
	//#UC START# *45F7C63403BD_45F7F08D023A*
	ACE_CDR::Boolean val; CORBA::Any::to_boolean to_bool (val);
	data >>= to_bool;
	return VariantFactory::make_bool (val);
	//#UC END# *45F7C63403BD_45F7F08D023A*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

