////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::IsVirtualImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/IsVirtualImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseObject.h"
#include "MDProcess/MDAModel/RoseInternal/BaseRoseImpl.h"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IsVirtualImpl::IsVirtualImpl ()
//#UC START# *4AA60846020A_4AA6086C0389_4AA608AF01E7_BASE_INIT*
//#UC END# *4AA60846020A_4AA6086C0389_4AA608AF01E7_BASE_INIT*
{
	//#UC START# *4AA60846020A_4AA6086C0389_4AA608AF01E7_BODY*
	//#UC END# *4AA60846020A_4AA6086C0389_4AA608AF01E7_BODY*
}

IsVirtualImpl::~IsVirtualImpl () {
	//#UC START# *4AA608AF01E7_DESTR_BODY*
	//#UC END# *4AA608AF01E7_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IsVirtual
// возвращает true, если элемент виртуальный
bool IsVirtualImpl::execute (IRoseElementPtr elem) const {
	//#UC START# *4AA60875024B_4AA608AF01E7*
	RoseInternal::IVirtualPtr obj;
	if (elem.QueryInterface (__uuidof (RoseInternal::IVirtual), &obj) == S_OK && obj != 0) {
		RoseInternal::RoseObject* real_obj = dynamic_cast<RoseInternal::RoseObject*> (obj.GetInterfacePtr ());

		return real_obj != 0;
	}

	return false;
	//#UC END# *4AA60875024B_4AA608AF01E7*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

