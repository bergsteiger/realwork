////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseOperation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOperation.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseOperation::RoseOperation ()
//#UC START# *4A35E1420114_BASE_INIT*
: m_parameters (0)
, m_state_machine_owner (0)
//#UC END# *4A35E1420114_BASE_INIT*
{
	//#UC START# *4A35E1420114_BODY*
	typedef RoseInternal::RoseCollectionImpl<IRoseParameterCollection, IRoseParameter> RoseParameterCollectionImpl;
	ATL::CComObject<RoseParameterCollectionImpl>* col;
	col->CreateInstance (&col);
	col->QueryInterface (&m_parameters);
	//#UC END# *4A35E1420114_BODY*
}

RoseOperation::~RoseOperation () {
	//#UC START# *4A35E07A02AF_DESTR_BODY*
	//#UC END# *4A35E07A02AF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет параметр в коллекцию
void RoseOperation::add_parameter (IRoseParameterPtr param) {
	//#UC START# *4A38C77E000D*
	if (param) {
		m_parameters->Add (param);
	}
	//#UC END# *4A38C77E000D*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseParameterCollectionPtr RoseOperation::get_parameters () const {
	//#UC START# *4A35E0CF00BD_GET_ACCESSOR*
	return m_parameters;
	//#UC END# *4A35E0CF00BD_GET_ACCESSOR*
}

void RoseOperation::set_parameters (IRoseParameterCollectionPtr parameters) {
	//#UC START# *4A35E0CF00BD_SET_ACCESSOR*
	m_parameters = parameters;
	//#UC END# *4A35E0CF00BD_SET_ACCESSOR*
}

IRoseClassPtr RoseOperation::get_parent_class () const {
	//#UC START# *4A363044015C_GET_ACCESSOR*
	IRoseItemPtr parent = this->get_context ();	
	while (parent && !parent->IsClass (CLASS_TYPE)) {
		parent = parent->GetContext ();
	}
	if (parent && parent->IsClass (CLASS_TYPE)) {
		return parent;
	}

	return 0;
	//#UC END# *4A363044015C_GET_ACCESSOR*
}

IRoseStateMachineOwnerPtr RoseOperation::get_state_machine_owner () const {
	//#UC START# *4A35E13D01EA_GET_ACCESSOR*
	return m_state_machine_owner;
	//#UC END# *4A35E13D01EA_GET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseItem
IRoseItemPtr RoseOperation::get_context () const {
	//#UC START# *4A30A6480352_4A35E07A02AF_GET*
	return RoseTargetItem::get_context ();
	//#UC END# *4A30A6480352_4A35E07A02AF_GET*
}

void RoseOperation::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4A35E07A02AF_SET*
	if (!context->IsClass (CLASS_TYPE)) {
		throw RoseItem::WrongContext ();
	}
	RoseTargetItem::set_context (context);
	//#UC END# *4A30A6480352_4A35E07A02AF_SET*
}

// overloaded method from RoseObject
HRESULT RoseOperation::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A35E07A02AF*
	switch (id) {
		case 412:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ReturnType: Put Property                
                /*
                  void PutReturnType(const bstr_t& par__x);
                */
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
                // ReturnType: Get Property
				/*
                  bstr_t GetReturnType();
                */
				if (result) {
					DispatchHelper::make_string_result (this->get_target (), result);
                } else {
                    this->get_target ();
                }
                return S_OK;
            } 
            break;
		case 413:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Parameters: Put Property
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
                  void PutParameters(const com_ptr<IRoseParameterCollection>& par__x);
                */
				return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Parameters: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseParameterCollection> GetParameters();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_parameters ().Detach (), result);
                } else {
					this->get_parameters ();
                }
                return S_OK;

            } 
            break;
        case 414:
			return this->dispatch_export_control (flags, params, result);
            break;
		case 444:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ParentClass: Put Property
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
                  void PutParentClass(const com_ptr<IRoseClass>& par__x);
                */
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
		case 12790:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // StateMachineOwner: Put Property
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
                  void PutStateMachineOwner(const com_ptr<IRoseStateMachineOwner>& par__x);
                */
				return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // StateMachineOwner: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseStateMachineOwner> GetStateMachineOwner();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_state_machine_owner ().Detach (), result);                    
                } else {
                    this->get_state_machine_owner ();
                }
                return S_OK;

            } 
            break;
		case 12876:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetResultClass: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseClass> GetResultClass();
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
	//#UC END# *4A2FA53702AA_4A35E07A02AF*
}

// overloaded method from RoseObject
const std::string RoseOperation::identify_class () {
	//#UC START# *4A2F96770397_4A35E07A02AF*
	return OPERATION_TYPE;
	//#UC END# *4A2F96770397_4A35E07A02AF*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseOperation::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A35E07A02AF*
	return class_name == OPERATION_TYPE ? VARIANT_TRUE : RoseTargetItem::is_class (class_name);
	//#UC END# *4A2F954B0069_4A35E07A02AF*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

