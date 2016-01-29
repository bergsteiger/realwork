////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/EntityStorage_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::EntityStorage_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/EntityStorage_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EntityStorage_i::~EntityStorage_i () {
	//#UC START# *46163833035E_DESTR_BODY*
	//#UC END# *46163833035E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityStorage
// получить содежимое
Containers::Content* EntityStorage_i::get_cached_content () const {
	//#UC START# *4616371B010F_46163833035E*
	return 0;
	//#UC END# *4616371B010F_46163833035E*
}

// implemented method from EntityStorage
// получить тип содержимого
Containers::ContentType EntityStorage_i::get_content_type () const {
	//#UC START# *461636870045_46163833035E*
	return 0;
	//#UC END# *461636870045_46163833035E*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

