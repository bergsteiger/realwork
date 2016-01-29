////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseElement.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseElement
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
#include <sstream>
#include <iomanip>
#include "MDProcess/MDAModel/RoseInternal/RosePropertyImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseCollectionImpl.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создает новый элемент, GUID при этом генерится автоматически
RoseElement::RoseElement ()
//#UC START# *4A307E690125_BASE_INIT*
//#UC END# *4A307E690125_BASE_INIT*
{
	//#UC START# *4A307E690125_BODY*
	this->set_unique_id ("NULL");
	
	m_application = RoseHelper::rose_app ();
	if (m_application) {
		m_model = m_application->CurrentModel;
	}
	//#UC END# *4A307E690125_BODY*
}

// создает элемент и назначает ему внешний GUID
RoseElement::RoseElement (const std::string& guid)
//#UC START# *4A3096F600B2_BASE_INIT*
//#UC END# *4A3096F600B2_BASE_INIT*
{
	//#UC START# *4A3096F600B2_BODY*
	this->set_unique_id (guid);

	m_application = RoseHelper::rose_app ();
	if (m_application) {
		m_model = m_application->CurrentModel;
	}
	//#UC END# *4A3096F600B2_BODY*
}

RoseElement::~RoseElement () {
	//#UC START# *4A2F96CC0057_DESTR_BODY*
	//#UC END# *4A2F96CC0057_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

const std::string RoseElement::get_property_value (const std::string& tool_name, const std::string& prop_name) {
	//#UC START# *4A2F9A710095*
	return m_overriden_property[tool_name][prop_name];
	//#UC END# *4A2F9A710095*
}

const std::string RoseElement::get_qualified_name () {
	//#UC START# *4A2FB650013B*
	return this->get_name ();
	//#UC END# *4A2FB650013B*
}

IRosePropertyCollectionPtr RoseElement::get_rose_all_properties () const {
	//#UC START# *4A9BAE98034D*
	IRosePropertyCollectionPtr all_props;

	typedef RoseInternal::RoseCollectionImpl<IRosePropertyCollection, IRoseProperty> RosePropertyCollectionImpl;
	ATL::CComObject<RosePropertyCollectionImpl>* props;
	props->CreateInstance (&props);
	props->QueryInterface (&all_props);
	
	for (
		Base::ToolPropertyMap::const_iterator it = m_overriden_property.begin ()
		; it != m_overriden_property.end ()
		; ++it
	) {
		for (
			Base::PropertyMap::const_iterator prop_it = it->second.begin ()
			; prop_it != it->second.end ()
			; ++prop_it
		) {
			ATL::CComObject<RoseInternal::RosePropertyImpl>* obj;
			ATL::CComObject<RoseInternal::RosePropertyImpl>::CreateInstance (&obj);

			IRosePropertyPtr prop = obj;

			prop->Name = prop_it->first.c_str ();
			prop->Value = prop_it->second.c_str ();
			prop->Type = "String";
			prop->ToolName = it->first.c_str ();

			all_props->Add (prop);
		}
	}

	return all_props;
	//#UC END# *4A9BAE98034D*
}

IRosePropertyCollectionPtr RoseElement::get_rose_tool_properties (const std::string& tool_name) const {
	//#UC START# *4A9BAEF7038F*
	IRosePropertyCollectionPtr all_props;

	typedef RoseInternal::RoseCollectionImpl<IRosePropertyCollection, IRoseProperty> RosePropertyCollectionImpl;
	ATL::CComObject<RosePropertyCollectionImpl>* props;
	props->CreateInstance (&props);
	props->QueryInterface (&all_props);
	
	Base::ToolPropertyMap::const_iterator it = m_overriden_property.find (tool_name);
	if (it != m_overriden_property.end ()) {
		for (
			Base::PropertyMap::const_iterator prop_it = it->second.begin ()
			; prop_it != it->second.end ()
			; ++prop_it
		) {
			ATL::CComObject<RoseInternal::RosePropertyImpl>* obj;
			ATL::CComObject<RoseInternal::RosePropertyImpl>::CreateInstance (&obj);

			IRosePropertyPtr prop = obj;

			prop->Name = prop_it->first.c_str ();
			prop->Value = prop_it->second.c_str ();
			prop->Type = "String";
			prop->ToolName = it->first.c_str ();

			all_props->Add (prop);
		}
	}

	return all_props;
	//#UC END# *4A9BAEF7038F*
}

// вычисляет 48-ми битный хэш строки
unsigned long long RoseElement::hash48 (const std::string& src) const {
	//#UC START# *4A8B83030111*
	//алгоритм из книжки "Фундаментальные алгоритмы на С++ (Р. Седжвик)"
	ACE_UINT64 hash = 0;
	ACE_UINT64 M = 0xFFFFFFFFFFFFLL;
	ACE_UINT64 a = 31415;
	ACE_UINT64 b = 27183;

	for (std::string::const_iterator it = src.begin (); it != src.end (); ++it) {
		hash = (a*hash + static_cast<ACE_UINT64> (*it)) % M;
		a = a*b % (M - 1);		
	}

	return hash;
	//#UC END# *4A8B83030111*
}

// возвращает true, если у элемента есть свойство с заданным именем, иначе false
bool RoseElement::is_property_exist (const std::string& tool_name, const std::string& prop_name) const {
	//#UC START# *4AA0FAA101E6*
	Base::ToolPropertyMap::const_iterator tool_it = m_overriden_property.find (tool_name);
	if (tool_it != m_overriden_property.end ()) {
		return tool_it->second.find (prop_name) != tool_it->second.end ();
	}
	
	return false;
	//#UC END# *4AA0FAA101E6*
}

// из хэша формирует строчку в формате розовского uid'а - 12 символов
const std::string RoseElement::make_rose_uid (unsigned long long hash) const {
	//#UC START# *4A8B830F0273*
	//из 48-ми битного хэша формируем строчку ровно 12 символов
	std::stringstream ss;
	ss << std::setfill ('0') << std::setw (12) << std::hex << hash;
	
	std::string rose_uid = ss.str ();
	GCL::to_upper (rose_uid);
	return rose_uid;
	//#UC END# *4A8B830F0273*
}

VARIANT_BOOL RoseElement::override_property (
	const std::string& tool_name
	, const std::string& prop_name
	, const std::string& value
) {
	//#UC START# *4A2F987B0257*
	std::string& current_value = m_overriden_property[tool_name][prop_name];
	if (current_value != value) {
		current_value = value;
		/*LOG_D((
			"%s property added [%s][%s] = %s"
			, this->identify_class ().c_str ()
			, tool_name.c_str ()
			, prop_name.c_str ()
			, value.c_str ()
		));*/
		this->update_parent_properties (tool_name, prop_name, value);
		return VARIANT_TRUE;
	}

	return VARIANT_FALSE;
	//#UC END# *4A2F987B0257*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseApplicationPtr RoseElement::get_application () const {
	//#UC START# *4A2F981500FE_GET_ACCESSOR*
	return m_application;
	//#UC END# *4A2F981500FE_GET_ACCESSOR*
}

void RoseElement::set_application (IRoseApplicationPtr application) {
	//#UC START# *4A2F981500FE_SET_ACCESSOR*
	m_application = application;
	//#UC END# *4A2F981500FE_SET_ACCESSOR*
}

IRoseModelPtr RoseElement::get_model () const {
	//#UC START# *4A2F982C0055_GET_ACCESSOR*
	if (!m_model) {
		//m_model = get_application ()->
	}
	return m_model;
	//#UC END# *4A2F982C0055_GET_ACCESSOR*
}

void RoseElement::set_model (IRoseModelPtr model) {
	//#UC START# *4A2F982C0055_SET_ACCESSOR*
	m_model = model;
	//#UC END# *4A2F982C0055_SET_ACCESSOR*
}

const std::string& RoseElement::get_name () const {
	//#UC START# *4A2F9720004A_GET_ACCESSOR*
	return m_name;
	//#UC END# *4A2F9720004A_GET_ACCESSOR*
}

void RoseElement::set_name (const std::string& name) {
	//#UC START# *4A2F9720004A_SET_ACCESSOR*
	m_name = name;
	//#UC END# *4A2F9720004A_SET_ACCESSOR*
}

const Base::ToolPropertyMap& RoseElement::get_overriden_property () const {
	//#UC START# *4A2F99E702FD_GET_ACCESSOR*
	return m_overriden_property;
	//#UC END# *4A2F99E702FD_GET_ACCESSOR*
}

const std::string& RoseElement::get_unique_id () const {
	//#UC START# *4A2F9735020E_GET_ACCESSOR*
	return m_unique_id;
	//#UC END# *4A2F9735020E_GET_ACCESSOR*
}

void RoseElement::set_unique_id (const std::string& unique_id) {
	//#UC START# *4A2F9735020E_SET_ACCESSOR*
	//гуид должен быть в Розовском формате, т.е 48-ми битное число
	//в виде строки в 12 символов
	m_unique_id = this->make_rose_uid (this->hash48 (unique_id));
	//#UC END# *4A2F9735020E_SET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseObject
HRESULT RoseElement::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A2F96CC0057*
	switch(id) {
		case 100:
			if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
				// Name: Put Property
				if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

				BSTR par__x;
				VARIANT tmp;
				if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
					
					if (VariantChangeType(&tmp, &params->rgvarg[0], 0, VT_BSTR) != S_OK) {
							return DISP_E_BADVARTYPE;
					}
					par__x = V_BSTR(&tmp);
				} else  {
					par__x = V_BSTR(&params->rgvarg[0]);
				}
				try {
					/*
					  void PutName(const bstr_t& par__x);
					*/
					_bstr_t val  (par__x);
					this->set_name (std::string (val));
				} catch (...) {
					throw;
				}
				return S_OK;

			} else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
				// Name: Get Property
				if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

				try {
					/*
					  bstr_t GetName();
					*/
					if (result) {
						DispatchHelper::make_string_result (this->get_name (), result);
					} else {
						this->get_name();
					}
				} catch (...) {
					throw;
				}
				return S_OK;

			} 
			break;
		case 102:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetUniqueID: Method
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}
                /*
                  bstr_t GetUniqueID();
                */
                if (result) {
					DispatchHelper::make_string_result (this->get_unique_id (), result);					
                } else {
                    this->get_unique_id ();
                }
 
                return S_OK;

            } 
            break;
		case 110:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // OverrideProperty: Method
				if (params->cArgs != 3) {
					return DISP_E_BADPARAMCOUNT;
				}

                _bstr_t par_theToolName;
				VARIANT toolName;
                if (V_VT(&params->rgvarg[2]) != VT_BSTR) {
					if ( VariantChangeType(&toolName, &params->rgvarg[2], 0, VT_BSTR) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par_theToolName = V_BSTR(&toolName);
                } else {
					par_theToolName = V_BSTR(&params->rgvarg[2]);
				}

                _bstr_t par_thePropName;
				VARIANT propName;
                if (V_VT(&params->rgvarg[1]) != VT_BSTR) {
					if ( VariantChangeType(&propName, &params->rgvarg[1], 0, VT_BSTR) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par_thePropName = V_BSTR(&propName);
                } else {
					par_thePropName = V_BSTR(&params->rgvarg[1]);
				}
                _bstr_t par_theValue;
				VARIANT propValue;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
                    if ( VariantChangeType(&propValue, &params->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par_theValue = V_BSTR(&propValue);
                } else {
					par_theValue = V_BSTR(&params->rgvarg[0]);
				}
               /*
                  bool OverrideProperty(const bstr_t& par_theToolName, const bstr_t& par_thePropName, const bstr_t& par_theValue);
                */
                if (result) {
                    V_BOOL(result) = this->override_property (
						std::string (par_theToolName)
						, std::string (par_thePropName)
						, std::string (par_theValue)
					);
                    V_VT(result) = VT_BOOL;
                } else {
					this->override_property (
						std::string (par_theToolName)
						, std::string (par_thePropName)
						, std::string (par_theValue)
					);
                }

                return S_OK;

            } 
            break;
		case 119:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetPropertyValue: Method
				if (params->cArgs != 2) {
					return DISP_E_BADPARAMCOUNT;
				}

                _bstr_t par_theToolName;
				VARIANT toolName;
                if (V_VT(&params->rgvarg[1]) != VT_BSTR) {
					if (VariantChangeType(&toolName, &params->rgvarg[1], 0, VT_BSTR) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par_theToolName = V_BSTR(&toolName);
                } else {
					par_theToolName = V_BSTR(&params->rgvarg[1]);
				}

                _bstr_t par_thePropName;
				VARIANT propName;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR) {
					if ( VariantChangeType(&propName, &params->rgvarg[0], 0, VT_BSTR) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par_thePropName = V_BSTR(&propName);
				} else  {
					par_thePropName = V_BSTR(&params->rgvarg[0]);
				}
                /*
                  bstr_t GetPropertyValue(const bstr_t& par_theToolName, const bstr_t& par_thePropName);
                */
                if (result) {
                    DispatchHelper::make_string_result (
						this->get_property_value (
							std::string (par_theToolName)
							, std::string (par_thePropName)
						)
						, result
					);
                } else {
                    this->get_property_value (
						std::string (par_theToolName)
						, std::string (par_thePropName)
					);
                }
                return S_OK;

            } 
            break;
		case 122:
            if ((flags & DISPATCH_METHOD) != 0) {
                // GetAllProperties: Method
				if (params->cArgs != 0) {
					return DISP_E_BADPARAMCOUNT;
				}

                /*
                  com_ptr<IRosePropertyCollection> GetAllProperties();
                */
                if (result) {
					DispatchHelper::make_dispatch_result (this->get_rose_all_properties ().Detach (), result);
                }
                
				return S_OK;

            } 
            break;
        case 123:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetToolProperties: Method
				if (params->cArgs != 1) {
					return DISP_E_BADPARAMCOUNT;
				}

                BSTR tool_name;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_BSTR)
                {
					if (VariantChangeType(&x, &params->rgvarg[0], 0, VT_BSTR) != S_OK) {
						return DISP_E_BADVARTYPE;
					}
                    tool_name = V_BSTR(&x);
				} else {
					tool_name = V_BSTR(&params->rgvarg[0]);
				}
                
				/*
				  com_ptr<IRosePropertyCollection> GetToolProperties(const bstr_t& par_theToolName);
				*/
				if (result) {
					_bstr_t tool_name_bstr (tool_name);

					DispatchHelper::make_dispatch_result (
						this->get_rose_tool_properties (std::string (tool_name_bstr)).Detach ()
						, result
					);
                }
                
				return S_OK;

            } 
            break;
		case 12523:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Application: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch * par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH) {
					if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK ) {
						return DISP_E_BADVARTYPE;
					}
                    par__x = V_DISPATCH(&x);
				} else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}                
                /*
                  void PutApplication(const com_ptr<IDispatch>& par__x);
                */
				IRoseApplicationPtr app;
				HRESULT hr = par__x->QueryInterface (&app);
				if (FAILED(hr)) {
					throw _com_error (hr);
				}
				this->set_application (app);                
                
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Application: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IDispatch> GetApplication();
                */
                if (result) {
                    V_DISPATCH(result) = this->get_application ().Detach ();
                    V_VT(result) = VT_DISPATCH;
                } else {
                    this->get_application ();
                }
                return S_OK;

            } 
            break;
		case 12524:
            if ( (flags & DISPATCH_PROPERTYPUT) != 0) {
                // Model: Put Property
                if (params->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                IDispatch* par__x;
				VARIANT x;
                if (V_VT(&params->rgvarg[0]) != VT_DISPATCH) {
					if ( VariantChangeType(&x, &params->rgvarg[0], 0, VT_DISPATCH) != S_OK ) {
                            return DISP_E_BADVARTYPE;
					}
                    par__x = V_DISPATCH(&x);
				} else {
					par__x = V_DISPATCH(&params->rgvarg[0]);
				}
                /*
                  void PutModel(const com_ptr<IRoseModel>& par__x);
                */
				IRoseModelPtr model;
				HRESULT hr = par__x->QueryInterface (&model);
				if (FAILED(hr)) {
					throw _com_error (hr);
				}
				this->set_model (model);
                return S_OK;

            } else if ( (flags & DISPATCH_PROPERTYGET) != 0) {
                // Model: Get Property
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  com_ptr<IRoseModel> GetModel();
                */
                if (result) {
					V_DISPATCH(result) = this->get_model ().Detach ();
                    V_VT(result) = VT_DISPATCH;
                } else {
                    this->get_model ();
                }
                return S_OK;
            } 
            break;
        case 12555:
            if ( (flags & DISPATCH_METHOD) != 0) {
                // GetQualifiedName: Method
                if (params->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetQualifiedName();
                */
                if (result) {
					DispatchHelper::make_string_result (this->get_qualified_name (), result);
                } else {
                    this->get_qualified_name ();
                }
                return S_OK;

            } 
            break;

		default:
			return RoseObject::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	}
	return S_OK;
	//#UC END# *4A2FA53702AA_4A2F96CC0057*
}

// overloaded method from RoseObject
const std::string RoseElement::identify_class () {
	//#UC START# *4A2F96770397_4A2F96CC0057*
	return ROSE_ELEMENT_TYPE;
	//#UC END# *4A2F96770397_4A2F96CC0057*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseElement::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A2F96CC0057*
	return class_name == ROSE_ELEMENT_TYPE ? VARIANT_TRUE : RoseObject::is_class (class_name);
	//#UC END# *4A2F954B0069_4A2F96CC0057*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

