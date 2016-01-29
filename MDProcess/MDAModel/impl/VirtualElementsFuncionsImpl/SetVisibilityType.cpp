////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetVisibilityType
//
// %S%f_set_visability_type(PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess) -
// станавливает тип видиости элемента. Применима ТОЛЬКО для виртуальных элементов. Если тип
// видимости не указан в списке разрешённых шаблоном - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetVisibilityType::SetVisibilityType ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F550B00BA_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F550B00BA_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F550B00BA_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F550B00BA_BODY*
}

SetVisibilityType::~SetVisibilityType () {
	//#UC START# *4A3F550B00BA_DESTR_BODY*
	//#UC END# *4A3F550B00BA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetVisibilityType::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A3F550B00BA*
	if (params.size () < 1) {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += " - wrong parametr count";
		throw Base::FatalError (mess);
	}

	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		std::string visibility_type = TemplatePainter::resolve_exp (params[0], painter);

		static const std::string sPUBLIC_TYPE = "PublicAccess";
		static const std::string sPROTECTED_TYPE = "ProtectedAccess";
		static const std::string sPRIVATE_TYPE = "PrivateAccess";
		static const std::string sIMPLEMENTATION_TYPE = "ImplementationAccess";

		if (
			visibility_type != sPUBLIC_TYPE 
			&& visibility_type != sPROTECTED_TYPE 
			&& visibility_type != sPRIVATE_TYPE 
			&& visibility_type != sIMPLEMENTATION_TYPE 
		) {
			throw Base::FatalError (
				"Неверный аргумент функции, должен быть PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess"
			);
		}
		const AbstractDumperBase::Template& tpl = rad->get_template ();

		if (
			(
				visibility_type == sPUBLIC_TYPE && !(tpl.visability_type & VTF_PUBLIC)
			) || (
				visibility_type == sPROTECTED_TYPE && !(tpl.visability_type & VTF_PROTECTED)
			) || (
				visibility_type == sPRIVATE_TYPE && !(tpl.visability_type & VTF_PRIVATE)
			) || (
				visibility_type == sIMPLEMENTATION_TYPE && !(tpl.visability_type & VTF_IMPL)
			)
		) {
			throw Base::FatalError ("Тип видимости не разрешен шаблоном");
		}
		
		RoseHelper::set_visibility_type (rad, visibility_type);
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A3F550B00BA*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

