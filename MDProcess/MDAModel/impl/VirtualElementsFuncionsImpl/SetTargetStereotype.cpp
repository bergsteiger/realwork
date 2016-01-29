////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTargetStereotype
//
// %S%f_set_target_stereotype(agr|lnk|ref) - устанавливает target_stereotyp для атрибута или
// операции. Применима ТОЛЬКО для вирутальных элементов. Если устанавливаемый target_stereotyp не
// указан как разрешенный в шаблоне - бросает исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTargetStereotype.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOperation.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttribute.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetTargetStereotype::SetTargetStereotype ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F54370124_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F54370124_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F54370124_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F54370124_BODY*
}

SetTargetStereotype::~SetTargetStereotype () {
	//#UC START# *4A3F54370124_DESTR_BODY*
	//#UC END# *4A3F54370124_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetTargetStereotype::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A3F54370124*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		IRoseItemPtr item = rad->rose_element ();
		if (item) {			
			std::string target_st = TemplatePainter::resolve_exp (params[0], painter);

			const AbstractDumperBase::Template& tpl = rad->get_template ();
			GCL::StrSet avilable_target_st (tpl.available_target_stereotypes.begin (), tpl.available_target_stereotypes.end ());

			if (
				avilable_target_st.find (target_st) == avilable_target_st.end ()
			) {
				throw Base::FatalError ("Указанный target stereotype не разрешен шаблоном");
			}
			
			RoseHelper::set_target_stereotype (rad, target_st, false);
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A3F54370124*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

