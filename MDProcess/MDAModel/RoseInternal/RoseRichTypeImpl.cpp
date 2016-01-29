////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseRichTypeImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RoseRichTypeImpl
// Файл реализации утилитного набора RoseRichTypeImpl
//
// реализация IRoseRichType
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRichTypeImpl.h"

//#UC START# *4A3B1C2C01EA_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
//#UC END# *4A3B1C2C01EA_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A3B1C2C01EA*
RoseRichTypeImpl::RoseRichTypeImpl () : m_name (), m_value (0), m_delegate (0)
{
}

STDMETHODIMP RoseRichTypeImpl::Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu) {
    switch(id) {
    case 202:
        if ( (Flags & DISPATCH_PROPERTYPUT) != 0) {
            // Value: Put Property
            if (DispParams->cArgs != 1) return DISP_E_BADPARAMCOUNT;

            short par__x;
			VARIANT x;
            if (V_VT(&DispParams->rgvarg[0]) != VT_I2)
            {
				if ( VariantChangeType(&x, &DispParams->rgvarg[0], 0, VT_I2) != S_OK )
                        return DISP_E_BADVARTYPE;
                par__x = V_I2(&x);
			} else {
				par__x = V_I2(&DispParams->rgvarg[0]);
			}
			
			short old_value = m_value;
			m_value = par__x;

			if (get_delegate ()) {
				IRoseRichType* rt = this;
				get_delegate ()->rich_type_value_changed (rt, old_value);
			}

            return S_OK;

        } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
            // Value: Get Property
            if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

            /*
              short GetValue();
            */
            if (Result) {
                V_I2(Result) = m_value;
                V_VT(Result) = VT_I2;
            } 
            return S_OK;
        } 
        break;
    case 203:
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

			std::string old_value (m_name);
			m_name = std::string (par__x);
			
			if (get_delegate ()) {
				IRoseRichType* rt = this;
				get_delegate ()->rich_type_name_changed (rt, old_value);
			}

            return S_OK;

        } else if ( (Flags & DISPATCH_PROPERTYGET) != 0) {
            // Name: Get Property
            if (DispParams->cArgs != 0) return DISP_E_BADPARAMCOUNT;

            /*
              bstr_t GetName();
            */
            if (Result) {
				DispatchHelper::make_string_result (m_name, Result);
            }
            return S_OK;

        } 
        break;
    default:
            return DISP_E_MEMBERNOTFOUND;
    }
    return S_OK;
}

void RoseRichTypeImpl::set_delegate (RoseItem* delegate) {
	m_delegate = delegate;
}

RoseItem* RoseRichTypeImpl::get_delegate () {
	return m_delegate;
}
//#UC END# *4A3B1C2C01EA*

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

