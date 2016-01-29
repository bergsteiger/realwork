////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseAttribute.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttribute.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRichTypeImpl.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAttribute::RoseAttribute ()
//#UC START# *4A30E7B50092_BASE_INIT*
//#UC END# *4A30E7B50092_BASE_INIT*
{
	//#UC START# *4A30E7B50092_BODY*
	ATL::CComObject<RoseInternal::RoseRichTypeImpl>* obj;
	obj->CreateInstance (&obj);
	obj->QueryInterface (&m_contaiment);	

	GDS_ASSERT_MSG(m_contaiment, ("Can't create user-defined IRoseRichTypePtr"));
	//#UC END# *4A30E7B50092_BODY*
}

RoseAttribute::~RoseAttribute () {
	//#UC START# *4A2F9BCF0105_DESTR_BODY*
	//#UC END# *4A2F9BCF0105_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseRichTypePtr RoseAttribute::get_contaiment () const {
	//#UC START# *4A3F6F2900B5_GET_ACCESSOR*
	return m_contaiment;
	//#UC END# *4A3F6F2900B5_GET_ACCESSOR*
}

void RoseAttribute::set_contaiment (IRoseRichTypePtr contaiment) {
	//#UC START# *4A3F6F2900B5_SET_ACCESSOR*
	m_contaiment = contaiment;
	//#UC END# *4A3F6F2900B5_SET_ACCESSOR*
}

const std::string& RoseAttribute::get_init_value () const {
	//#UC START# *4A30AE8A008D_GET_ACCESSOR*
	return m_init_value;
	//#UC END# *4A30AE8A008D_GET_ACCESSOR*
}

void RoseAttribute::set_init_value (const std::string& init_value) {
	//#UC START# *4A30AE8A008D_SET_ACCESSOR*
	m_init_value = init_value;
	//#UC END# *4A30AE8A008D_SET_ACCESSOR*
}

IRoseClassPtr RoseAttribute::get_parent_class () const {
	//#UC START# *4A30AEFA03D8_GET_ACCESSOR*
	IRoseItemPtr parent = this->get_context ();	
	while (parent && !parent->IsClass (CLASS_TYPE)) {
		parent = parent->GetContext ();
	}
	if (parent && parent->IsClass (CLASS_TYPE)) {
		return parent;
	}

	return 0;
	//#UC END# *4A30AEFA03D8_GET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseItem
IRoseItemPtr RoseAttribute::get_context () const {
	//#UC START# *4A30A6480352_4A2F9BCF0105_GET*
	return RoseTargetItem::get_context ();
	//#UC END# *4A30A6480352_4A2F9BCF0105_GET*
}

void RoseAttribute::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4A2F9BCF0105_SET*
	if (!context->IsClass (CLASS_TYPE) && !context->IsClass (ATTRIBUTE_TYPE)) {
		throw RoseItem::WrongContext ();
	}
	RoseTargetItem::set_context (context);
	//#UC END# *4A30A6480352_4A2F9BCF0105_SET*
}

// overloaded method from RoseObject
HRESULT RoseAttribute::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A2F9BCF0105*
	switch (id) {
		case 412:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // InitValue: Put Property
				if (params->cArgs != 1) {
					return DISP_E_BADPARAMCOUNT;
				}

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&params->rgvarg[0]);
				}
				this->set_init_value (std::string (par__x));
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // InitValue: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetInitValue();
                */
                if (result) {
					DispatchHelper::make_string_result (this->get_init_value (), result);
                } else {
                    this->get_init_value ();
                }
                return S_OK;

            } 
            break;
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
		case 415:
			return this->dispatch_export_control (flags, params, result);
            break;
		case 416:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Containment: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
				} else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}
                /*
                  void PutContainment(const com_ptr<IRoseRichType>& par__x);
                */
				IRoseRichTypePtr contaiment;
				par__x->QueryInterface (&contaiment);

                this->set_contaiment (contaiment);
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Containment: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseRichType> GetContainment();
                */
                if (result) {
                    V_DISPATCH(result) = this->get_contaiment ().Detach ();
                    V_VT(result) = VT_DISPATCH;
                } else {
                    this->get_contaiment ();
                }
                return S_OK;

            } 
            break;
		case 434:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ParentClass: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH) {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
				} else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}
				
				return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // ParentClass: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseClass> GetParentClass();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_parent_class ().Detach (), result);                        
                } else {
                    this->get_parent_class ();
                }
                return S_OK;

            } 
            break;
		case 12875:
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
	//#UC END# *4A2FA53702AA_4A2F9BCF0105*
}

// overloaded method from RoseObject
const std::string RoseAttribute::identify_class () {
	//#UC START# *4A2F96770397_4A2F9BCF0105*
	return ATTRIBUTE_TYPE;
	//#UC END# *4A2F96770397_4A2F9BCF0105*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseAttribute::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A2F9BCF0105*
	return class_name == ATTRIBUTE_TYPE ? VARIANT_TRUE : RoseItem::is_class (class_name);
	//#UC END# *4A2F954B0069_4A2F9BCF0105*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

