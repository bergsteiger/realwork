////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/StringDataTransformer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::StringDataTransformer_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/StringDataTransformer_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StringDataTransformer_i::StringDataTransformer_i ()
//#UC START# *45F7C61D0004_45F8012A0233_45F7F2380022_BASE_INIT*
//#UC END# *45F7C61D0004_45F8012A0233_45F7F2380022_BASE_INIT*
{
	//#UC START# *45F7C61D0004_45F8012A0233_45F7F2380022_BODY*
	//#UC END# *45F7C61D0004_45F8012A0233_45F7F2380022_BODY*
}

StringDataTransformer_i::~StringDataTransformer_i () {
	//#UC START# *45F7F2380022_DESTR_BODY*
	//#UC END# *45F7F2380022_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DataTransformer
Variant* StringDataTransformer_i::get_variant (const CORBA::Any& data) const {
	//#UC START# *45F7C63403BD_45F7F2380022*
	const char* val;
	data >>= val;
	return VariantFactory::make_string (GCI::IO::String_var (GCI::IO::StringFactory::make (val)).in ());	
	//#UC END# *45F7C63403BD_45F7F2380022*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

