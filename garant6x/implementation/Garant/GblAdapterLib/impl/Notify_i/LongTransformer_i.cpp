////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::LongTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LongTransformer_i::LongTransformer_i ()
//#UC START# *45F7C61D0004_45F8012A0233_45F7EB5500DD_BASE_INIT*
//#UC END# *45F7C61D0004_45F8012A0233_45F7EB5500DD_BASE_INIT*
{
	//#UC START# *45F7C61D0004_45F8012A0233_45F7EB5500DD_BODY*
	//#UC END# *45F7C61D0004_45F8012A0233_45F7EB5500DD_BODY*
}

LongTransformer_i::~LongTransformer_i () {
	//#UC START# *45F7EB5500DD_DESTR_BODY*
	//#UC END# *45F7EB5500DD_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DataTransformer
Variant* LongTransformer_i::get_variant (const CORBA::Any& data) const {
	//#UC START# *45F7C63403BD_45F7EB5500DD*
	CORBA::Long val;
	data >>= val;
	return VariantFactory::make_long (val);
	//#UC END# *45F7C63403BD_45F7EB5500DD*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

