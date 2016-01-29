////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Utils/corba_object_op.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::CoreSrv::Utils::corba_object_op
// Файл реализации утилитного набора corba_object_op
//
// вспомогательные функции работы с объектом (получение его TypeId, ...)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Utils/corba_object_op.h"

//#UC START# *4503D57D00EA_CUSTOM_INCLUDES*
#include "tao/Stub.h"
//#UC END# *4503D57D00EA_CUSTOM_INCLUDES*

namespace CoreSrv {

//#UC START# *4503D57D00EA*
//#UC END# *4503D57D00EA*

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// возвращает type_id для указанного объекта
const char* get_object_type_id (CORBA::Object* obj) {
	//#UC START# *4503D5A00177*
	// TAO depended implementation
	// but if the code is not compiled I think you can find 
	// something like that in a non TAO CORBA.
	TAO_Stub* stub = obj->_stubobj ();
	if (stub) {
		return stub->type_id.in ();
	}
	return 0;
	//#UC END# *4503D5A00177*
}

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

