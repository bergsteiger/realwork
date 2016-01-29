////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/BaseRoseImpl.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::BaseRoseImpl
// Файл inline реализации утилитного набора BaseRoseImpl
//
// базовый шаблонный класс для реализации COM-интерфейсов Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *4A35EC9100FA_CUSTOM_INCLUDES*
//#UC END# *4A35EC9100FA_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4A35EC9100FA*
template <class Servant, class MainInterface>
STDMETHODIMP BaseRoseImpl<Servant, MainInterface>::Invoke(
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err	
) {
	HRESULT res = this->dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	if (res != S_OK) {
		LOG_E(("%s: Dispatch error %d for method %d", typeid(typename Servant).name(), res, id));
	}

	return res;
}

template <class Servant, class MainInterface, class AdditionalInterface1>
STDMETHODIMP BaseRoseImpl2<Servant, MainInterface, AdditionalInterface1>::Invoke (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err	
) {
	HRESULT res = this->dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	if (res != S_OK) {
		LOG_E(("%s: Dispatch error %d for method %d", typeid(typename Servant).name(), res, id));
	}

	return res;
}
//#UC END# *4A35EC9100FA*

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

