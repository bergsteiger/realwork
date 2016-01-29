////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RosePropertyImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RosePropertyImpl
// Файл реализации утилитного набора RosePropertyImpl
//
// содержит реализацию розовского интерфейса IRoseProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RosePropertyImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

//#UC START# *4A9DE9690264_CUSTOM_INCLUDES*
//#UC END# *4A9DE9690264_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A9DE9690264*
STDMETHODIMP RosePropertyImpl::Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu) {
    switch(id) {
		case 202:
            if ( (Flags & DISPATCH_PROPERTYPUT) != 0) {
                // Name: Put Property
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&DispParams->rgvarg[0]);
				}
                
				/*
                  void PutName(const bstr_t& par__x);
                */
				
				this->set_name (std::string (par__x));

                return S_OK;

            } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
                // Name: Get Property
                if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetName();
                */
                if (Result) {
					DispatchHelper::make_string_result (this->get_name (), Result);
				}
                
                return S_OK;

            } 
            break;
        case 203:
            if ( (Flags & DISPATCH_PROPERTYPUT) != 0) {
                // Value: Put Property
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&DispParams->rgvarg[0]);
				}

                /*
                  void PutValue(const bstr_t& par__x);
                */
                
				this->set_value (std::string (par__x));

                return S_OK;

            } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
                // Value: Get Property
                if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetValue();
                */
				if (Result) {
					DispatchHelper::make_string_result (this->get_value (), Result);
				}
                
                return S_OK;

            } 
            break;
        case 205:
            if ( (Flags & DISPATCH_PROPERTYPUT) != 0) {
                // ToolName: Put Property
                if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

                _bstr_t par__x;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&DispParams->rgvarg[0]);
				}
				
				/*
                  void PutToolName(const bstr_t& par__x);
                */
				this->set_tool_name (std::string (par__x));

                return S_OK;

            } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
                // ToolName: Get Property
                if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetToolName();
                */

				if (Result) {
					DispatchHelper::make_string_result (this->get_tool_name (), Result);
				}
                    
                return S_OK;

            } 
            break;
        case 206:
            if ( (Flags & DISPATCH_PROPERTYPUT) != 0) {
                // Type: Put Property
                 _bstr_t par__x;
				VARIANT x;
                if (V_VT(&DispParams->rgvarg[0]) != VT_BSTR)
                {
                    if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_BSTR) != S_OK )
                            return DISP_E_BADVARTYPE;
                    par__x = V_BSTR(&x);
				} else {
					par__x = V_BSTR(&DispParams->rgvarg[0]);
				}
                
                /*
                  void PutType(const bstr_t& par__x);
                */
                
				this->set_type (std::string (par__x));
                return S_OK;

            } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
                // Type: Get Property
                if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

                /*
                  bstr_t GetType();
                */
				if (Result) {
					DispatchHelper::make_string_result (this->get_type (), Result);
				}
                
                return S_OK;

            } 
            break;
		default:
				return DISP_E_MEMBERNOTFOUND;
    }
    return S_OK;
}
//#UC END# *4A9DE9690264*

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

