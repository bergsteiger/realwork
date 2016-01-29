////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseCategory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseCategory
//
// папка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseCategory.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.h"
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseCategory::RoseCategory ()
//#UC START# *4A9386B40286_BASE_INIT*
: m_categories (__uuidof(RoseCategoryCollection))
, m_class_diagrams (__uuidof(RoseClassDiagramCollection))
, m_classes (__uuidof(RoseClassCollection))
, m_dependecies (__uuidof(RoseCategoryDependencyCollection))
, m_scenario_diagrams (__uuidof(RoseScenarioDiagramCollection))
, m_state_machine_owner (0)
, m_global (false)
//#UC END# *4A9386B40286_BASE_INIT*
{
	//#UC START# *4A9386B40286_BODY*
	//#UC END# *4A9386B40286_BODY*
}

RoseCategory::~RoseCategory () {
	//#UC START# *4A9384F203AF_DESTR_BODY*
	//#UC END# *4A9384F203AF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

bool RoseCategory::is_controlled () const {
	//#UC START# *4A93884F0095*
	return true;
	//#UC END# *4A93884F0095*
}

bool RoseCategory::is_modiable () const {
	//#UC START# *4A93880D0342*
	return true;
	//#UC END# *4A93880D0342*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseCategoryCollectionPtr RoseCategory::get_categories () const {
	//#UC START# *4A938A0D02A9_GET_ACCESSOR*
	return m_categories;
	//#UC END# *4A938A0D02A9_GET_ACCESSOR*
}

IRoseClassDiagramCollectionPtr RoseCategory::get_class_diagrams () const {
	//#UC START# *4A93879002B1_GET_ACCESSOR*
	return m_class_diagrams;
	//#UC END# *4A93879002B1_GET_ACCESSOR*
}

IRoseClassCollectionPtr RoseCategory::get_classes () const {
	//#UC START# *4A93865F01AE_GET_ACCESSOR*
	return m_classes;
	//#UC END# *4A93865F01AE_GET_ACCESSOR*
}

IRoseCategoryDependencyCollectionPtr RoseCategory::get_dependecies () const {
	//#UC START# *4A9386D903CB_GET_ACCESSOR*
	return m_dependecies;
	//#UC END# *4A9386D903CB_GET_ACCESSOR*
}

bool RoseCategory::get_global () const {
	//#UC START# *4A9386A802F8_GET_ACCESSOR*
	return m_global;
	//#UC END# *4A9386A802F8_GET_ACCESSOR*
}

void RoseCategory::set_global (bool global) {
	//#UC START# *4A9386A802F8_SET_ACCESSOR*
	m_global = global;
	//#UC END# *4A9386A802F8_SET_ACCESSOR*
}

IRoseCategoryPtr RoseCategory::get_parent_category () const {
	//#UC START# *4A93873B02E9_GET_ACCESSOR*
	IRoseItemPtr parent = this->get_context ();	
	while (parent && !parent->IsClass (CATEGORY_TYPE)) {
		parent = parent->GetContext ();
	}
	if (parent && parent->IsClass (CATEGORY_TYPE)) {
		return parent;
	}

	return 0;
	//#UC END# *4A93873B02E9_GET_ACCESSOR*
}

IRoseScenarioDiagramCollectionPtr RoseCategory::get_scenario_diagrams () const {
	//#UC START# *4A9387BD0343_GET_ACCESSOR*
	return m_scenario_diagrams;
	//#UC END# *4A9387BD0343_GET_ACCESSOR*
}

IRoseStateMachineOwnerPtr RoseCategory::get_state_machine_owner () const {
	//#UC START# *4A9386C20366_GET_ACCESSOR*
	return m_state_machine_owner;
	//#UC END# *4A9386C20366_GET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseItem
IRoseItemPtr RoseCategory::get_context () const {
	//#UC START# *4A30A6480352_4A9384F203AF_GET*
	return RoseItem::get_context ();
	//#UC END# *4A30A6480352_4A9384F203AF_GET*
}

void RoseCategory::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4A9384F203AF_SET*
	if (!context->IsClass (CATEGORY_TYPE)) {
		throw RoseItem::WrongContext ();
	}
	RoseItem::set_context (context);
	//#UC END# *4A30A6480352_4A9384F203AF_SET*
}

// overloaded method from RoseObject
HRESULT RoseCategory::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A9384F203AF*
	switch (id) {
		case 412:
            if ((flags & DISPATCH_PROPERTYPUT) != 0) {
                // Global: Put Property
				if (params->cArgs != 1) {
					return DISP_E_BADPARAMCOUNT;
				}

                VARIANT_BOOL par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BOOL) {
					if (VariantChangeType(&x, &params->rgvarg[0], 0, VT_BOOL) != S_OK) {
                            return DISP_E_BADVARTYPE;
					}
                    par__x = V_BOOL(&x);
				} else {
					par__x = V_BOOL(&params->rgvarg[0]);
				}
				this->set_global (par__x ? true : false);
                return S_OK;

            } else if ((flags & DISPATCH_PROPERTYGET) != 0) {
                // Global: Get Property
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}

                if (result) {
                    V_BOOL(result) = this->get_global () ? VARIANT_TRUE : VARIANT_FALSE;
                    V_VT(result) = VT_BOOL;
                } else {
					this->get_global ();
                }
                return S_OK;

            } 
            break;
        case 413:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Classes: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;

                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH) {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
                else par__x = V_DISPATCH(&params->rgvarg[0]);
                return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Classes: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					DispatchHelper::make_dispatch_result (this->get_classes ().Detach (), result);
                } else {
                   this->get_classes ();
                }
                return S_OK;

            } 
            break;
        case 414:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Categories: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                   if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
                else par__x = V_DISPATCH(&params->rgvarg[0]);
                return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Categories: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

               if (result) {
					DispatchHelper::make_dispatch_result (this->get_categories ().Detach (), result);
                } else {
                   this->get_categories ();
                }
                return S_OK;

            } 
            break;
        case 415:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ParentCategory: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
                else par__x = V_DISPATCH(&params->rgvarg[0]);
                return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // ParentCategory: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					DispatchHelper::make_dispatch_result (this->get_parent_category ().Detach (), result);
                } else {
                    this->get_parent_category ();
                }
                return S_OK;

            } 
            break;
        case 416:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ClassDiagrams: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
                else par__x = V_DISPATCH(&params->rgvarg[0]);
                
				return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // ClassDiagrams: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					 DispatchHelper::make_dispatch_result (this->get_class_diagrams ().Detach (), result);
                } else {
                    this->get_class_diagrams ();
                }
                return S_OK;

            } 
            break;
		case 418:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ScenarioDiagrams: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                   if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
                else par__x = V_DISPATCH(&params->rgvarg[0]);

                return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // ScenarioDiagrams: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

				if (result) {
					DispatchHelper::make_dispatch_result (this->get_scenario_diagrams ().Detach (), result);
                } else {
                    this->get_scenario_diagrams ();
                }
                return S_OK;

            } 
            break;
        case 12433:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // IsControlled: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					V_BOOL(result) = this->is_controlled () ? VARIANT_TRUE : VARIANT_FALSE;
                    V_VT(result) = VT_BOOL;
                } else {
					this->is_controlled ();
                }
                return S_OK;

            } 
            break;
        case 12434:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // Control: Method
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                BSTR par_Path;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_Path = V_BSTR(&x);
                }
                else par_Path = V_BSTR(&params->rgvarg[0]);
               
				if (result) {
					V_BOOL(result) = this->is_controlled () ? VARIANT_TRUE : VARIANT_FALSE;
                    V_VT(result) = VT_BOOL;
                } else {
					this->is_controlled ();
                }
                return S_OK;

            } 
            break;
		case 12438:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // IsModifiable: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					V_BOOL(result) = this->is_modiable () ? VARIANT_TRUE : VARIANT_FALSE;
                    V_VT(result) = VT_BOOL;
                } else {
					this->is_modiable ();
                }
                return S_OK;

            } 
            break;
		case 12660:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetCategoryDependencies: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					DispatchHelper::make_dispatch_result (this->get_dependecies ().Detach (), result);
                } else {
                    this->get_scenario_diagrams ();
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

                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH) {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
                else par__x = V_DISPATCH(&params->rgvarg[0]);
               return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // StateMachineOwner: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                if (result) {
					DispatchHelper::make_dispatch_result (this->get_state_machine_owner ().Detach (), result);
                } else {
                    this->get_state_machine_owner ();
                }
                return S_OK;

            } 
            break;
		default:
			return RoseItem::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}
	return S_OK;
	//#UC END# *4A2FA53702AA_4A9384F203AF*
}

// overloaded method from RoseObject
const std::string RoseCategory::identify_class () {
	//#UC START# *4A2F96770397_4A9384F203AF*
	return CATEGORY_TYPE;
	//#UC END# *4A2F96770397_4A9384F203AF*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseCategory::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A9384F203AF*
	return (class_name == std::string (CATEGORY_TYPE) || class_name == std::string (CONTROLLABLE_UNIT_TYPE))
		? VARIANT_TRUE 
		: RoseItem::is_class (class_name);
	//#UC END# *4A2F954B0069_4A9384F203AF*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

