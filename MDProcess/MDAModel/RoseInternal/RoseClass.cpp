////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseClass.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseClass
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClass.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRichTypeImpl.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseClass::RoseClass ()
//#UC START# *4A30E7C00233_BASE_INIT*
: m_is_abstract (false)
, m_accociate_roles (__uuidof(RoseRoleCollection))
, m_associations (__uuidof(RoseAssociationCollection))
, m_attributes (__uuidof(RoseAttributeCollection))
, m_dependecies (__uuidof(RoseClassDependencyCollection))
, m_inherite_relations (0)
, m_nested_classes (__uuidof(RoseClassCollection))
, m_operations (__uuidof(RoseOperationCollection))
, m_parameters (__uuidof(RoseParameterCollection))
, m_realize_relations (0)
, m_state_machine_owner (0)
//#UC END# *4A30E7C00233_BASE_INIT*
{
	//#UC START# *4A30E7C00233_BODY*
	_bstr_t tool_name (TOOL_NAME);
	_bstr_t prop_implement_select_type (PROP_IMPLEMENT_SELECT_TYPE);
	_bstr_t prop_overload_select_type (PROP_OVERLOAD_SELECT_TYPE);

	this->override_property (std::string (tool_name), std::string (prop_implement_select_type), "all");
	this->override_property (std::string (tool_name), std::string (prop_overload_select_type), "include");

	typedef RoseInternal::RoseCollectionImpl<IRoseInheritRelationCollection, IRoseInheritRelation> RoseInheritRelationCollectionImpl;
	ATL::CComObject<RoseInheritRelationCollectionImpl>* inh;
	inh->CreateInstance (&inh);
	inh->QueryInterface (&m_inherite_relations);

	typedef RoseInternal::RoseCollectionImpl<IRoseRealizeRelationCollection, IRoseRealizeRelation> RoseRealizeRelationCollectionImpl;
	ATL::CComObject<RoseRealizeRelationCollectionImpl>* realize;
	realize->CreateInstance (&realize);
	realize->QueryInterface (&m_realize_relations);

	ATL::CComObject<RoseInternal::RoseRichTypeImpl>* cls_kind;
	ATL::CComObject<RoseInternal::RoseRichTypeImpl>::CreateInstance (&cls_kind);

	m_class_kind = cls_kind;
	m_class_kind->PutName ("NormalClass");
	//#UC END# *4A30E7C00233_BODY*
}

RoseClass::~RoseClass () {
	//#UC START# *4A30DA730027_DESTR_BODY*
	//#UC END# *4A30DA730027_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void RoseClass::add_inherit_relation (IRoseInheritRelationPtr rel) {
	//#UC START# *4A3B3D460124*
	GDS_ASSERT(rel);
	m_inherite_relations->Add (rel);
	//#UC END# *4A3B3D460124*
}

void RoseClass::add_realize_relation (IRoseRealizeRelationPtr rel) {
	//#UC START# *4A3B3D69038F*
	GDS_ASSERT(rel);
	m_realize_relations->Add (rel);
	//#UC END# *4A3B3D69038F*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseRoleCollectionPtr RoseClass::get_accociate_roles () const {
	//#UC START# *4A30E15F01EB_GET_ACCESSOR*
	return m_accociate_roles;
	//#UC END# *4A30E15F01EB_GET_ACCESSOR*
}

IRoseAssociationCollectionPtr RoseClass::get_associations () const {
	//#UC START# *4A30DFC20351_GET_ACCESSOR*
	return m_associations;
	//#UC END# *4A30DFC20351_GET_ACCESSOR*
}

IRoseAttributeCollectionPtr RoseClass::get_attributes () const {
	//#UC START# *4A30DD14000E_GET_ACCESSOR*
	return m_attributes;
	//#UC END# *4A30DD14000E_GET_ACCESSOR*
}

IRoseRichTypePtr RoseClass::get_class_kind () const {
	//#UC START# *4A30DC96012C_GET_ACCESSOR*
	return m_class_kind;
	//#UC END# *4A30DC96012C_GET_ACCESSOR*
}

void RoseClass::set_class_kind (IRoseRichTypePtr class_kind) {
	//#UC START# *4A30DC96012C_SET_ACCESSOR*
	m_class_kind = class_kind;
	//#UC END# *4A30DC96012C_SET_ACCESSOR*
}

IRoseClassDependencyCollectionPtr RoseClass::get_dependecies () const {
	//#UC START# *4A30DFB80216_GET_ACCESSOR*
	return m_dependecies;
	//#UC END# *4A30DFB80216_GET_ACCESSOR*
}

IRoseInheritRelationCollectionPtr RoseClass::get_inherite_relations () const {
	//#UC START# *4A30DF2103A1_GET_ACCESSOR*
	return m_inherite_relations;
	//#UC END# *4A30DF2103A1_GET_ACCESSOR*
}

bool RoseClass::get_is_abstract () const {
	//#UC START# *4A30DC710194_GET_ACCESSOR*
	return m_is_abstract;
	//#UC END# *4A30DC710194_GET_ACCESSOR*
}

void RoseClass::set_is_abstract (bool is_abstract) {
	//#UC START# *4A30DC710194_SET_ACCESSOR*
	m_is_abstract = is_abstract;
	//#UC END# *4A30DC710194_SET_ACCESSOR*
}

IRoseClassCollectionPtr RoseClass::get_nested_classes () const {
	//#UC START# *4A30E09B01D1_GET_ACCESSOR*
	return m_nested_classes;
	//#UC END# *4A30E09B01D1_GET_ACCESSOR*
}

IRoseOperationCollectionPtr RoseClass::get_operations () const {
	//#UC START# *4A30DD4100E9_GET_ACCESSOR*
	return m_operations;
	//#UC END# *4A30DD4100E9_GET_ACCESSOR*
}

IRoseParameterCollectionPtr RoseClass::get_parameters () const {
	//#UC START# *4A30DDAA01EE_GET_ACCESSOR*
	return m_parameters;
	//#UC END# *4A30DDAA01EE_GET_ACCESSOR*
}

void RoseClass::set_parameters (IRoseParameterCollectionPtr parameters) {
	//#UC START# *4A30DDAA01EE_SET_ACCESSOR*
	m_parameters = parameters;
	//#UC END# *4A30DDAA01EE_SET_ACCESSOR*
}

IRoseCategoryPtr RoseClass::get_parent_category () const {
	//#UC START# *4A30DDE603B0_GET_ACCESSOR*
	IRoseItemPtr parent = this->get_context ();	
	while (parent && !parent->IsClass (CATEGORY_TYPE)) {
		parent = parent->GetContext ();
	}
	if (parent && parent->IsClass (CATEGORY_TYPE)) {
		return parent;
	}

	return 0;
	//#UC END# *4A30DDE603B0_GET_ACCESSOR*
}

IRoseRealizeRelationCollectionPtr RoseClass::get_realize_relations () const {
	//#UC START# *4A30DF40017B_GET_ACCESSOR*
	return m_realize_relations;
	//#UC END# *4A30DF40017B_GET_ACCESSOR*
}

IRoseStateMachineOwnerPtr RoseClass::get_state_machine_owner () const {
	//#UC START# *4A30E1E5016E_GET_ACCESSOR*
	return m_state_machine_owner;
	//#UC END# *4A30E1E5016E_GET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseObject
HRESULT RoseClass::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A30DA730027*
	switch (id) {
		case 412:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Abstract: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                VARIANT_BOOL par__x;
				VARIANT x;
				if (V_VT(&params->rgvarg[0]) != VT_BOOL) {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BOOL) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BOOL(&x);
                }
				else {
					par__x = V_BOOL(&params->rgvarg[0]);
				}
				this->set_is_abstract (par__x ? true : false);
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Abstract: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bool GetAbstract();
                */
                if (result) {
                    V_BOOL(result) = this->get_is_abstract () ? VARIANT_TRUE : VARIANT_FALSE;
                    V_VT(result) = VT_BOOL;
                } else {
					this->get_is_abstract ();
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
                } else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}
                
				return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // ParentCategory: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseCategory> GetParentCategory();
                */
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
                // Attributes: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH) {
					if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                }
				else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}

                return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Attributes: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseAttributeCollection> GetAttributes();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_attributes ().Detach (), result);
                } else {
                   this->get_attributes ();
                }
                return S_OK;

            } 
            break;
        case 417:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Operations: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType( &x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
                } else  {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}
                
				return DISP_E_MEMBERNOTFOUND;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Operations: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseOperationCollection> GetOperations();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_operations ().Detach (), result);
                } else {
                    this->get_operations ();
                }
                return S_OK;

            } 
            break;
        case 418:
			return this->dispatch_export_control (flags, params, result);
            break;
		case 419:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // ClassKind: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType( &x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_DISPATCH(&x);
				} else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}
				IRoseRichTypePtr rich (par__x);
				HRESULT hr = par__x->QueryInterface (&rich);
				if (FAILED(hr)) {
					throw _com_error (hr);
				}
				this->set_class_kind (rich);
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // ClassKind: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseRichType> GetClassKind();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_class_kind ().Detach (), result);
                } else {
                    this->get_class_kind ();
                }
                return S_OK;

            } 
            break;
		case 422:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetHasRelations: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseHasRelationshipCollection> GetHasRelations();
                */
                return DISP_E_MEMBERNOTFOUND;
            } 
            break;
		case 423:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetInheritRelations: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseInheritRelationCollection> GetInheritRelations();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_inherite_relations ().Detach (), result);
                } else {
                    this->get_inherite_relations ();
                }
                return S_OK;
            } 
            break;
		case 424:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetSuperclasses: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                    /*
                      com_ptr<IRoseClassCollection> GetSuperclasses();
                    */                    
                return DISP_E_MEMBERNOTFOUND;

            } 
            break;
		case 425:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetAssociations: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseAssociationCollection> GetAssociations();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_associations ().Detach (), result);
                } else {
                    this->get_associations ();
                }
                return S_OK;

            } 
            break;
		case 438:
			if ( (flags & DISPATCH_METHOD) != 0) {
                // DeleteInheritRel: Method
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_theInheritRel;
				VARIANT x;
				if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if (VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theInheritRel = V_DISPATCH(&x);
				} else {
					par_theInheritRel = V_DISPATCH(&params->rgvarg[0]);
				}                

				IRoseInheritRelationPtr rel;
				par_theInheritRel->QueryInterface (&rel);
				                
				GDS_ASSERT (rel);

				VARIANT_BOOL is_deleted = VARIANT_FALSE;
				if (this->m_inherite_relations->Exists (rel)) {
					this->m_inherite_relations->Remove (rel);
					is_deleted = VARIANT_TRUE;
				}

				DispatchHelper::make_bool_result (is_deleted, result);
                return S_OK;

            } 
            break;
		case 445:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetAssociateRoles: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                    /*
                      com_ptr<IRoseRoleCollection> GetAssociateRoles();
                    */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_accociate_roles ().Detach (), result);
                } else {
                    this->get_accociate_roles ();
                }
                return S_OK;

            } 
            break;
		case 446:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetNestedClasses: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseClassCollection> GetNestedClasses();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_nested_classes ().Detach (), result);
                } else {
					this->get_nested_classes ();
                }
                return S_OK;

            } 
            break;
		case 12611:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // DeleteRealizeRel: Method
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par_theRealizeRel;
				VARIANT x;
				if (V_VT(&params->rgvarg[0]) != VT_DISPATCH)
                {
                    if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theRealizeRel = V_DISPATCH(&x);
				} else {
					par_theRealizeRel = V_DISPATCH(&params->rgvarg[0]);
				}                

				IRoseRealizeRelationPtr rel;
				par_theRealizeRel->QueryInterface (&rel);


                /*
                  bool DeleteRealizeRel(const com_ptr<IRoseRealizeRelation>& par_theRealizeRel);
                */
				GDS_ASSERT (rel);

				VARIANT_BOOL is_deleted = VARIANT_FALSE;
				if (this->m_realize_relations->Exists (rel)) {
					this->m_realize_relations->Remove (rel);
					is_deleted = VARIANT_TRUE;
				}

				DispatchHelper::make_bool_result (is_deleted, result);

                return S_OK;

            } 
            break;
		case 12612:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetRealizeRelations: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseRealizeRelationCollection> GetRealizeRelations();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_realize_relations ().Detach (), result);
                } else {
                    this->get_realize_relations ();
                }
                return S_OK;

            } 
            break;
		case 12662:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetClassDependencies: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseClassDependencyCollection> GetClassDependencies();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_dependecies ().Detach (), result);
                } else {
                    this->get_dependecies ();
                }
                return S_OK;

            } 
            break;
		case 12666:
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
		default:
			return RoseItem::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}
	return S_OK;
	//#UC END# *4A2FA53702AA_4A30DA730027*
}

// overloaded method from RoseObject
const std::string RoseClass::identify_class () {
	//#UC START# *4A2F96770397_4A30DA730027*
	return CLASS_TYPE;
	//#UC END# *4A2F96770397_4A30DA730027*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseClass::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A30DA730027*
	return class_name == std::string (CLASS_TYPE) ? VARIANT_TRUE : RoseItem::is_class (class_name);
	//#UC END# *4A2F954B0069_4A30DA730027*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

