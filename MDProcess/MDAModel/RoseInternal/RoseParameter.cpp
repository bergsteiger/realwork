////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseParameter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseParameter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseParameter.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseParameter::~RoseParameter () {
	//#UC START# *4A35E19B02F8_DESTR_BODY*
	//#UC END# *4A35E19B02F8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& RoseParameter::get_initial_value () const {
	//#UC START# *4A35E1B30033_GET_ACCESSOR*
	return m_initial_value;
	//#UC END# *4A35E1B30033_GET_ACCESSOR*
}

void RoseParameter::set_initial_value (const std::string& initial_value) {
	//#UC START# *4A35E1B30033_SET_ACCESSOR*
	m_initial_value = initial_value;
	//#UC END# *4A35E1B30033_SET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseItem
IRoseItemPtr RoseParameter::get_context () const {
	//#UC START# *4A30A6480352_4A35E19B02F8_GET*
	return RoseTargetItem::get_context ();
	//#UC END# *4A30A6480352_4A35E19B02F8_GET*
}

void RoseParameter::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4A35E19B02F8_SET*
	if (!context->IsClass (CLASS_TYPE) && !context->IsClass (OPERATION_TYPE)) {
		throw RoseItem::WrongContext ();
	}
	RoseTargetItem::set_context (context);
	//#UC END# *4A30A6480352_4A35E19B02F8_SET*
}

// overloaded method from RoseItem
const std::string& RoseParameter::get_stereotype () const {
	//#UC START# *4A2FB5E600F1_4A35E19B02F8_GET*
	return RoseTargetItem::get_stereotype ();
	//#UC END# *4A2FB5E600F1_4A35E19B02F8_GET*
}

void RoseParameter::set_stereotype (const std::string& stereotype) {
	//#UC START# *4A2FB5E600F1_4A35E19B02F8_SET*
	RoseTargetItem::set_stereotype (stereotype);
	//#UC END# *4A2FB5E600F1_4A35E19B02F8_SET*
}

// overloaded method from RoseObject
HRESULT RoseParameter::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A35E19B02F8*
	switch (id) {
		case 413:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Type: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&params->rgvarg[0]);
				}
                /*
                  void PutType(const bstr_t& par__x);
                */
				this->set_target (std::string (par__x));
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Type: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetType();
                */
                if (result) {
					DispatchHelper::make_string_result (this->get_target (), result);
                } else {
                    this->get_target ();
                }
                
				return S_OK;

            } 
            break;
		case 414:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // InitValue: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&params->rgvarg[0]);
				}

                /*
                  void PutInitValue(const bstr_t& par__x);
                */
				this->set_initial_value (std::string (par__x));
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // InitValue: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetInitValue();
                */
                if (result) {
                   DispatchHelper::make_string_result (this->get_initial_value (), result);
                } else {
                    this->get_initial_value ();
                }
                return S_OK;

            } 
            break;
		case 12877:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetTypeClass: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseClass> GetTypeClass();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_target_class ().Detach (), result);
                } else {
                   this->get_target_class ();
                }
                return S_OK;

            } 
            break;
		default:
			return RoseTargetItem::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}

	return S_OK;
	//#UC END# *4A2FA53702AA_4A35E19B02F8*
}

// overloaded method from RoseObject
const std::string RoseParameter::identify_class () {
	//#UC START# *4A2F96770397_4A35E19B02F8*
	return PARAMETER_TYPE;
	//#UC END# *4A2F96770397_4A35E19B02F8*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseParameter::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A35E19B02F8*
	return class_name == PARAMETER_TYPE ? VARIANT_TRUE : RoseTargetItem::is_class (class_name);
	//#UC END# *4A2F954B0069_4A35E19B02F8*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

