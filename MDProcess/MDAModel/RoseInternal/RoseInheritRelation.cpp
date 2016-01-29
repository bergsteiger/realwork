////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseInheritRelation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseInheritRelation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseInheritRelation.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseInheritRelation::~RoseInheritRelation () {
	//#UC START# *4A3B398F018A_DESTR_BODY*
	//#UC END# *4A3B398F018A_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseObject
HRESULT RoseInheritRelation::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A3B398F018A*
	switch (id) {
		case 819:
			return dispatch_export_control (flags, params, result);
            break;
		default:
			return RoseClassRelation::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}

	return S_OK;
	//#UC END# *4A2FA53702AA_4A3B398F018A*
}

// overloaded method from RoseObject
const std::string RoseInheritRelation::identify_class () {
	//#UC START# *4A2F96770397_4A3B398F018A*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A2F96770397_4A3B398F018A*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseInheritRelation::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A3B398F018A*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A2F954B0069_4A3B398F018A*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

