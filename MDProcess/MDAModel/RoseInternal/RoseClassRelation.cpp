////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseClassRelation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseClassRelation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassRelation.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseClassRelation::~RoseClassRelation () {
	//#UC START# *4A3B39530278_DESTR_BODY*
	//#UC END# *4A3B39530278_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

IRoseClassPtr RoseClassRelation::get_context_class () const {
	//#UC START# *4A3B3BD8027B*
	return get_context ();
	//#UC END# *4A3B3BD8027B*
}

IRoseClassPtr RoseClassRelation::get_supplier_class () const {
	//#UC START# *4A3B3BC3007B*
	return get_target_class ();
	//#UC END# *4A3B3BC3007B*
}

bool RoseClassRelation::has_client () const {
	//#UC START# *4A3B396700BA*
	return this->get_context () != 0;
	//#UC END# *4A3B396700BA*
}

bool RoseClassRelation::has_supplier () const {
	//#UC START# *4A3B39690275*
	return this->get_target_class () != 0;
	//#UC END# *4A3B39690275*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseItem
IRoseItemPtr RoseClassRelation::get_context () const {
	//#UC START# *4A30A6480352_4A3B39530278_GET*
	return RoseTargetItem::get_context ();
	//#UC END# *4A30A6480352_4A3B39530278_GET*
}

void RoseClassRelation::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4A3B39530278_SET*
	if (!context->IsClass (CLASS_TYPE)) {
		throw RoseItem::WrongContext ();
	}
	RoseTargetItem::set_context (context);
	//#UC END# *4A30A6480352_4A3B39530278_SET*
}

// overloaded method from RoseObject
HRESULT RoseClassRelation::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A3B39530278*
	switch (id) {
		case 412:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // SupplierName: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;
                /*
                  void PutSupplierName(const bstr_t& par__x);
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

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // SupplierName: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;
				/*
                  bstr_t GetSupplierName();
                */
				if (result) {
					DispatchHelper::make_string_result (this->get_target (), result);
                } else {
                    this->get_target ();
                }
                return S_OK;             

            } 
            break;
		case 820:
			return dispatch_export_control (flags, params, result);
            break;
		case 12600:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetContextClass: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;
				 /*
                  com_ptr<IRoseClass> GetContextClass();
                */
				if (result) {
                    DispatchHelper::make_dispatch_result (this->get_context ().Detach (), result);
                } else {
                    this->get_target_class ();
                }
                return S_OK;
            } 
            break;
		case 12601:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetSupplierClass: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

				DispatchHelper::make_dispatch_result (this->get_supplier_class ().Detach (), result);
                return S_OK;

            } 
            break;
		case 12606:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // HasClient: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bool HasClient();
                */
				DispatchHelper::make_bool_result (this->has_client (), result);
                return S_OK;

            } 
            break;
        case 12607:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // HasSupplier: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

				DispatchHelper::make_bool_result (this->has_supplier (), result);
                return S_OK;

            } 
            break;
        case 12608:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetClient: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

				DispatchHelper::make_dispatch_result (this->get_context ().Detach (), result);
                return S_OK;

            } 
            break;
        case 12609:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetSupplier: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

				DispatchHelper::make_dispatch_result (this->get_target_class ().Detach (), result);
                return S_OK;

            } 
            break;
		default:
			return RoseTargetItem::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}

	return S_OK;
	//#UC END# *4A2FA53702AA_4A3B39530278*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

