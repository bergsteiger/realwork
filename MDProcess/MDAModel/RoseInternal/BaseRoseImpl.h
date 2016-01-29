////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/BaseRoseImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::BaseRoseImpl
//
// базовый шаблонный класс для реализации COM-интерфейсов Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_BASEROSEIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_BASEROSEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/BaseRoseImpl.h"

//#UC START# *4A35EC9100FA_USER_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
//#UC END# *4A35EC9100FA_USER_INCLUDES*

namespace RoseInternal {

//#UC START# *4A35EC9100FA_USER_DEFINITION*
struct DECLSPEC_UUID("57AEA80B-59BB-41da-BAAC-19165C9318B3")
IVirtual : public IDispatch {	
};

_COM_SMARTPTR_TYPEDEF(IVirtual, __uuidof(IVirtual));

template <class Servant, class MainInterface>
class BaseRoseImpl:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<typename BaseRoseImpl<Servant, MainInterface> >
	, public ATL::IDispatchImpl<MainInterface, &__uuidof(MainInterface)>
	, public ATL::IDispatchImpl<IRoseItem, &__uuidof(IRoseItem)>
	, public ATL::IDispatchImpl<IRoseElement, &__uuidof(IRoseElement)>
	, public ATL::IDispatchImpl<IRoseObject, &__uuidof(IRoseObject)>
	, public ATL::IDispatchImpl<IVirtual, &__uuidof(IVirtual)>
	, public Servant
{
	typedef typename BaseRoseImpl<Servant, MainInterface> ThisClass;
	SET_OBJECT_COUNTER (ThisClass)

public:

	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(ThisClass)
		COM_INTERFACE_ENTRY(MainInterface)
		COM_INTERFACE_ENTRY(IRoseObject)
		COM_INTERFACE_ENTRY(IRoseElement)
		COM_INTERFACE_ENTRY(IRoseItem)
		COM_INTERFACE_ENTRY(IVirtual)
		COM_INTERFACE_ENTRY2(IDispatch,MainInterface)
	END_COM_MAP()

	STDMETHODIMP Invoke (
		DISPID id
		, REFIID riid
		, LCID lcid
		, WORD flags
		, DISPPARAMS* params
		, VARIANT* result
		, LPEXCEPINFO exp_info
		, PUINT arg_err
	);
};

template <class Servant, class MainInterface, class AdditionalInterface>
class BaseRoseImpl2:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<typename BaseRoseImpl2<Servant, MainInterface, AdditionalInterface> >
	, public ATL::IDispatchImpl<MainInterface, &__uuidof(MainInterface)>
	, public ATL::IDispatchImpl<AdditionalInterface, &__uuidof(AdditionalInterface)>
	, public ATL::IDispatchImpl<IRoseItem, &__uuidof(IRoseItem)>
	, public ATL::IDispatchImpl<IRoseElement, &__uuidof(IRoseElement)>
	, public ATL::IDispatchImpl<IRoseObject, &__uuidof(IRoseObject)>
	, public ATL::IDispatchImpl<IVirtual, &__uuidof(IVirtual)>
	, public Servant
{
	typedef typename BaseRoseImpl2<Servant, MainInterface, AdditionalInterface> ThisClass;
	SET_OBJECT_COUNTER (ThisClass)

public:

	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(ThisClass)
		COM_INTERFACE_ENTRY(MainInterface)
		COM_INTERFACE_ENTRY(AdditionalInterface)
		COM_INTERFACE_ENTRY(IRoseObject)
		COM_INTERFACE_ENTRY(IRoseElement)
		COM_INTERFACE_ENTRY(IRoseItem)
		COM_INTERFACE_ENTRY(IVirtual)
		COM_INTERFACE_ENTRY2(IDispatch,MainInterface)
	END_COM_MAP()

	STDMETHODIMP Invoke (
		DISPID id
		, REFIID riid
		, LCID lcid
		, WORD flags
		, DISPPARAMS* params
		, VARIANT* result
		, LPEXCEPINFO exp_info
		, PUINT arg_err
	);
};

/*class RoseOverridenElementImpl:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<RoseOverridenElementImpl>
	, public ATL::IDispatchImpl<IRoseClass, &__uuidof(IRoseClass)>
	, public ATL::IDispatchImpl<IRoseOperation, &__uuidof(IRoseOperation)>
	, public ATL::IDispatchImpl<IRoseAttribute, &__uuidof(IRoseAttribute)>
	, public ATL::IDispatchImpl<IRoseRole, &__uuidof(IRoseRole)>
	, public ATL::IDispatchImpl<IRoseItem, &__uuidof(IRoseItem)>
	, public ATL::IDispatchImpl<IRoseElement, &__uuidof(IRoseElement)>
	, public ATL::IDispatchImpl<IRoseObject, &__uuidof(IRoseObject)>
	, public ATL::IDispatchImpl<IVirtual, &__uuidof(IVirtual)>
	, public RoseOverridenElement
{
	typedef RoseOverridenElementImpl ThisClass;
	SET_OBJECT_COUNTER (ThisClass)

public:

	DECLARE_PROTECT_FINAL_CONSTRUCT()

	BEGIN_COM_MAP(ThisClass)
		COM_INTERFACE_ENTRY(IRoseClass)
		COM_INTERFACE_ENTRY(IRoseAttribute)
		COM_INTERFACE_ENTRY(IRoseOperation)
		COM_INTERFACE_ENTRY(IRoseRole)
		COM_INTERFACE_ENTRY(IRoseObject)
		COM_INTERFACE_ENTRY(IRoseElement)
		COM_INTERFACE_ENTRY(IRoseItem)
		COM_INTERFACE_ENTRY(IVirtual)
		COM_INTERFACE_ENTRY2(IDispatch,IRoseElement)
	END_COM_MAP()

	STDMETHODIMP Invoke (
		DISPID id
		, REFIID riid
		, LCID lcid
		, WORD flags
		, DISPPARAMS* params
		, VARIANT* result
		, LPEXCEPINFO exp_info
		, PUINT arg_err
	);
};*/
//#UC END# *4A35EC9100FA_USER_DEFINITION*

} // namespace RoseInternal

#include "MDProcess/MDAModel/RoseInternal/BaseRoseImpl.i.h"

#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_BASEROSEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
