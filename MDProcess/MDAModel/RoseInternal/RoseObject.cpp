////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseObject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseObject.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

//#UC START# *4A2F952100C7_CUSTOM_INCLUDES*
//#UC END# *4A2F952100C7_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A2F952100C7*
//#UC END# *4A2F952100C7*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseObject::~RoseObject () {
	//#UC START# *4A2F952100C7_DESTR_BODY*
	//#UC END# *4A2F952100C7_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

HRESULT RoseObject::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA*
	switch (id) {
		case 12668:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // IdentifyClass: Method
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}

                /*
                  bstr_t IdentifyClass();
                */
                if (result) {
					DispatchHelper::make_string_result (this->identify_class (), result);					
                } else {
                    this->identify_class ();
                }
				
                return S_OK;

            } 
            break;
		case 12669:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // IsClass: Method
				if (params->cArgs != 1) {
					return DISP_E_BADPARAMCOUNT;
				}

                _bstr_t par_theClassName;
				VARIANT tmp;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
					if (VariantChangeType(&tmp, &params->rgvarg[0], 0, VT_BSTR) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par_theClassName = V_BSTR(&tmp);
                } else {
					par_theClassName = V_BSTR(&params->rgvarg[0]);
				}
                /*
                  bool IsClass(const bstr_t& par_theClassName);
                */
                if (result) {
					V_BOOL(result) = this->is_class (static_cast<const char*> (par_theClassName));
                    V_VT(result) = VT_BOOL;
                } else {
                    this->is_class (static_cast<const char*> (par_theClassName));
                }
                return S_OK;

            } 
            break;
		default:
			return DISP_E_MEMBERNOTFOUND;
	}

	return S_OK;
	//#UC END# *4A2FA53702AA*
}

const std::string RoseObject::identify_class () {
	//#UC START# *4A2F96770397*
	return ROSE_OBJECT_TYPE;
	//#UC END# *4A2F96770397*
}

// приведение
VARIANT_BOOL RoseObject::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069*
	return class_name == ROSE_OBJECT_TYPE ? VARIANT_TRUE : VARIANT_FALSE;
	//#UC END# *4A2F954B0069*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

