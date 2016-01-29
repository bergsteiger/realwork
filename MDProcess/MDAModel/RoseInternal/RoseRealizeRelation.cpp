////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseRealizeRelation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseRealizeRelation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRealizeRelation.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseRealizeRelation::~RoseRealizeRelation () {
	//#UC START# *4A3B3921012E_DESTR_BODY*
	//#UC END# *4A3B3921012E_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseObject
HRESULT RoseRealizeRelation::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A3B3921012E*
	switch (id) {
		case 12602:
			 // GetContextClass: Method
			return RoseClassRelation::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
            break;
		case 12604:
			// GetSupplierClass: Method
            return RoseClassRelation::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err); 
            break;
		default:
			return RoseClassRelation::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}

	return S_OK;
	//#UC END# *4A2FA53702AA_4A3B3921012E*
}

// overloaded method from RoseObject
const std::string RoseRealizeRelation::identify_class () {
	//#UC START# *4A2F96770397_4A3B3921012E*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A2F96770397_4A3B3921012E*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseRealizeRelation::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A3B3921012E*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A2F954B0069_4A3B3921012E*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

