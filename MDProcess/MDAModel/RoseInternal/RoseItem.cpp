////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseItem.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRichTypeImpl.h"
#include "boost/token_iterator.hpp"
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include "MDProcess/MDAModel/Base/Base.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

const char* RoseItem::WrongContext::uid () const /*throw ()*/ {
	return "44032940-97CA-4E96-8E41-F6C0D15ECCC5";
}

const char* RoseItem::WrongContext::what () const throw () {
	//#UC START# *4A954BBF03E4_WHAT_IMPL*
	return "WrongContext (исключение о том, что неверно указан родитель элемента)";
	//#UC END# *4A954BBF03E4_WHAT_IMPL*
}



//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseItem::RoseItem ()
//#UC START# *4A35E6680164_BASE_INIT*
: m_context_ptr (0), m_documentation ("undefined")
//#UC END# *4A35E6680164_BASE_INIT*
{
	//#UC START# *4A35E6680164_BODY*
	ATL::CComObject<RoseInternal::RoseRichTypeImpl>* obj;
	ATL::CComObject<RoseInternal::RoseRichTypeImpl>::CreateInstance (&obj);

	m_export_control = obj;
	m_export_control->PutName ("PublicAccess");
	obj->set_delegate (this);
	//#UC END# *4A35E6680164_BODY*
}

RoseItem::~RoseItem () {
	//#UC START# *4A2F96B6030A_DESTR_BODY*
	//#UC END# *4A2F96B6030A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

HRESULT RoseItem::dispatch_export_control (WORD flags, DISPPARAMS* params, VARIANT* result) {
	//#UC START# *4A362EA10131*
	 if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
        // ExportControl: Put Property
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
		this->set_export_control (rich);
        return S_OK;

    } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
        // ExportControl: Get Property
        if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

        /*
          com_ptr<IRoseRichType> GetExportControl();
        */
        if (result) {
			DispatchHelper::make_dispatch_result (this->get_export_control ().Detach (), result);
        } else {
			this->get_export_control ();
        }
        return S_OK;

    } 
    return S_OK;
	//#UC END# *4A362EA10131*
}

// возврашаеьт реального родителя элемента
IRoseElementPtr RoseItem::get_real_context () const {
	//#UC START# *4AA746D10248*
	IRoseElementPtr parent = m_context_ptr;
	IRoseElementPtr real_context = 0;

	while (parent && !real_context) {
		if (
			(parent.GetInterfacePtr ()) 
			&& !(dynamic_cast<RoseInternal::RoseElement*> (parent.GetInterfacePtr ()))
		) {
			real_context = parent;
		}

		parent = RoseHelper::get_context (parent);
	}

	return real_context;
	//#UC END# *4AA746D10248*
}

// формирует имя свойства для записи в родительский элемент - просто приклеивает UID к имени
// свойства
const std::string RoseItem::make_property_name (const std::string& prop_name) const {
	//#UC START# *4A4833710313*
	return prop_name + this->get_unique_id ();
	//#UC END# *4A4833710313*
}

// возвращает true, сли свойство должно быть просто записано в родителя без изменения значения
bool RoseItem::need_write_to_parent (const std::string& prop_name) const {
	//#UC START# *4A4833ED0105*
	if (
		prop_name.find (PROP_OS_GUID) != std::string::npos
		|| prop_name.find (Base::ELEMENT_CREATION_ORDER) != std::string::npos
	) {
		return true;
	}
	//проверяем, может это юзер-секция (формат: "<текст>:*UC_ID*")
	return RoseHelper::is_user_code_property(prop_name);
	//#UC END# *4A4833ED0105*
}

// изменилось имя
void RoseItem::rich_type_name_changed (IRoseRichType* obj, const std::string& old_value) {
	//#UC START# *4C1B537000E9*
	//#UC END# *4C1B537000E9*
}

// изменилось значение свойства
void RoseItem::rich_type_value_changed (IRoseRichType* obj, short old_value) {
	//#UC START# *4C1B53B102FC*
	//#UC END# *4C1B53B102FC*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseItemPtr RoseItem::get_context () const {
	//#UC START# *4A30A6480352_GET_ACCESSOR*
	return m_context_ptr;
	//#UC END# *4A30A6480352_GET_ACCESSOR*
}

void RoseItem::set_context (IRoseItemPtr context) /*throw WrongContext*/ {
	//#UC START# *4A30A6480352_SET_ACCESSOR*
	m_context_ptr = context;
	//#UC END# *4A30A6480352_SET_ACCESSOR*
}

const std::string& RoseItem::get_documentation () const {
	//#UC START# *4A2FB5CF0316_GET_ACCESSOR*
	return m_documentation;
	//#UC END# *4A2FB5CF0316_GET_ACCESSOR*
}

void RoseItem::set_documentation (const std::string& documentation) {
	//#UC START# *4A2FB5CF0316_SET_ACCESSOR*
	m_documentation = documentation;
	//#UC END# *4A2FB5CF0316_SET_ACCESSOR*
}

IRoseRichTypePtr RoseItem::get_export_control () const {
	//#UC START# *4A35E3B60097_GET_ACCESSOR*
	return m_export_control;
	//#UC END# *4A35E3B60097_GET_ACCESSOR*
}

void RoseItem::set_export_control (IRoseRichTypePtr export_control) {
	//#UC START# *4A35E3B60097_SET_ACCESSOR*
	m_export_control = export_control;
	//#UC END# *4A35E3B60097_SET_ACCESSOR*
}

const std::string& RoseItem::get_stereotype () const {
	//#UC START# *4A2FB5E600F1_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *4A2FB5E600F1_GET_ACCESSOR*
}

void RoseItem::set_stereotype (const std::string& stereotype) {
	//#UC START# *4A2FB5E600F1_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *4A2FB5E600F1_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from RoseElement
// при необходимости обновляет информацию о свойствах у родителя - например необходимо записать в
// родителя список артефактов, сгенерённых с элемента
void RoseItem::update_parent_properties (
	const std::string& tool_name
	, const std::string& prop_name
	, const std::string& value
) {
	//#UC START# *4A41B92000F2_4A2F96B6030A*
	if (this->need_write_to_parent (prop_name)) {
		if (m_context_ptr) {
			std::string new_prop_name = this->make_property_name (prop_name);
			if (prop_name.find ("A4A33D1ACBA4") != std::string::npos) {
				LOG_W(("%s, update_parent_properties for prop: %s, value: %s", get_rose_element_uid (m_context_ptr).c_str (), new_prop_name.c_str (), value.c_str ()));
			}

			RoseHelper::write_property_with_lock (
				m_context_ptr
				, tool_name
				, this->make_property_name (prop_name)
				, value
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, true
				, prop_name
			);
		} else {
			LOG_E(("Не удалось сохранить свойство: %s", prop_name.c_str ()));
		}
	} else {
		if (m_context_ptr && PropertyHelperFactory::get ().is_self_generated_source (prop_name)) {

			_bstr_t tool_name_ = tool_name.c_str ();
			RoseHelper::GeneratedSourceSetMap files_properties;
			RoseHelper::GeneratedSourceSetMap pages_properties;
			
			RoseHelper::collect_generated_source_for_parent (
				this->get_unique_id ()
				, prop_name
				, value
				, files_properties
				, pages_properties
			);
			
			RoseHelper::GeneratedSourcePropertiesMap nested_gen_sources;

			IRoseElementPtr real_context = this->get_real_context ();
			if (real_context) {
				RoseHelper::get_updated_nested_generated_source (
					real_context
					, files_properties
					, pages_properties
					, nested_gen_sources
				);

				RoseHelper::update_nested_generated_source_with_lock (real_context, nested_gen_sources);
			} else {
				std::string mess (
					std::string ("Не удалось найти реальный элемент для записи информации о сгенеренном артефакте: ")
					+ this->get_name ()
				);

				GenSupport::ErrorManagerFactory::get ().fatal_error (this->get_unique_id (), mess, GDS_CURRENT_FUNCTION);
				GenSupport::LogManagerFactory::get ().log_error (mess);
			}
		}
	}
	//#UC END# *4A41B92000F2_4A2F96B6030A*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseElement
const std::string RoseItem::get_property_value (const std::string& tool_name, const std::string& prop_name) {
	//#UC START# *4A2F9A710095_4A2F96B6030A*
	std::string value;
	if (this->is_property_exist (tool_name, prop_name)) {
		value = RoseElement::get_property_value (tool_name, prop_name);
	} else if (m_context_ptr) {
		std::string new_prop_name = this->make_property_name (prop_name);

		value = static_cast<const char*> (
			m_context_ptr->GetPropertyValue (
				tool_name.c_str ()
				, new_prop_name.c_str ()
			)
		);
	}

	return value;
	//#UC END# *4A2F9A710095_4A2F96B6030A*
}

// overloaded method from RoseElement
const std::string RoseItem::get_qualified_name () {
	//#UC START# *4A2FB650013B_4A2F96B6030A*
	std::string res;
	if (m_context_ptr) {
		res += m_context_ptr->GetQualifiedName ();
		res += "::" + this->get_name ();
	} else {
		res = this->get_name ();
	}
	return res;
	//#UC END# *4A2FB650013B_4A2F96B6030A*
}

// overloaded method from RoseObject
HRESULT RoseItem::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A2F96B6030A*
	switch (id) {
		case 203:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Documentation: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
					if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK ) {
						return DISP_E_BADVARTYPE;
					}
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&params->rgvarg[0]);
				}
				this->set_documentation (std::string (par__x));
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Documentation: Get Property
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}

                /*
                  bstr_t GetDocumentation();
                */
                if (result) {
					DispatchHelper::make_string_result (this->get_documentation (), result);
                } else {
                    this->get_documentation ();
                }
                return S_OK;

            } 
            break;		
		case 212:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Stereotype: Put Property
				if (params->cArgs != 1) {
					return DISP_E_BADPARAMCOUNT;
				}

                _bstr_t par__x;
				VARIANT x;
				if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
					if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&params->rgvarg[0]);
				}
				this->set_stereotype (std::string (par__x));                
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Stereotype: Get Property
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}

                /*
                  bstr_t GetStereotype();
                */
                if (result) {
					DispatchHelper::make_string_result (this->get_stereotype (), result);
                } else {
                    this->get_stereotype ();
                }
                return S_OK;

            } 
            break;
		case 12872:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetContext: Method
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}

                /*
                  com_ptr<IRoseItem> GetContext();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_context ().Detach (), result);
                } else {
                    this->get_context ();
                }
                return S_OK;

            } 
            break;
		default:
			return RoseElement::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}

	return S_OK;
	//#UC END# *4A2FA53702AA_4A2F96B6030A*
}

// overloaded method from RoseObject
const std::string RoseItem::identify_class () {
	//#UC START# *4A2F96770397_4A2F96B6030A*
	return ROSE_ITEM_TYPE;
	//#UC END# *4A2F96770397_4A2F96B6030A*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseItem::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A2F96B6030A*
	return class_name == ROSE_ITEM_TYPE ? VARIANT_TRUE : RoseElement::is_class (class_name);
	//#UC END# *4A2F954B0069_4A2F96B6030A*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

