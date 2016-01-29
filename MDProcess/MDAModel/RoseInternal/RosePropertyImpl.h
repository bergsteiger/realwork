////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RosePropertyImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RosePropertyImpl
//
// содержит реализацию розовского интерфейса IRoseProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPROPERTYIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPROPERTYIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseProperty.h"

//#UC START# *4A9DE9690264_USER_INCLUDES*
#include "shared/Core/fix/win_afx.h"
//#UC END# *4A9DE9690264_USER_INCLUDES*

namespace RoseInternal {

//#UC START# *4A9DE9690264_USER_DEFINITION*
class RosePropertyImpl:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<RosePropertyImpl>
	, public ATL::IDispatchImpl<IRoseProperty, &__uuidof(IRoseProperty)>
	, public RoseInternal::RoseProperty
{
	typedef RosePropertyImpl ThisClass;
	SET_OBJECT_COUNTER (ThisClass)

public:
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(ThisClass)
		COM_INTERFACE_ENTRY(IRoseProperty)
		COM_INTERFACE_ENTRY(IDispatch)
	END_COM_MAP()

	STDMETHODIMP Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu);
};
//#UC END# *4A9DE9690264_USER_DEFINITION*

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPROPERTYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
