////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetLinkType
//
// %S%f_set_link_type(agr|lnk|ref) - устанавливает тип связи для атрибута. Применима ТОЛЬКО для
// вирутальных элементов. Если устанавливаемый тип связи не казан как разрешенный в шаблоне -
// бросает исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseAttribute.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractAttributeDumper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetLinkType::SetLinkType ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F53400188_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F53400188_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F53400188_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F53400188_BODY*
}

SetLinkType::~SetLinkType () {
	//#UC START# *4A3F53400188_DESTR_BODY*
	//#UC END# *4A3F53400188_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetLinkType::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A3F53400188*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	RoseAbstractAttributeDumper* rad = const_cast<RoseAbstractAttributeDumper*> (dynamic_cast<const RoseAbstractAttributeDumper*> (self));
	if (rad) {
		std::string link_type = TemplatePainter::resolve_exp (params[0], painter);

		static const std::string sAGR_LINK_TYPE = "agr";
		static const std::string sLNK_LINK_TYPE = "lnk";
		static const std::string sREF_LINK_TYPE = "ref";

		if (
			link_type != sAGR_LINK_TYPE 
			&& link_type != sLNK_LINK_TYPE 
			&& link_type != sREF_LINK_TYPE 
		) {
			throw Base::FatalError ("Неверный аргумент функции, должен быть agr|lnk|ref");
		}
		const AbstractDumperBase::Template& tpl = rad->get_template ();
		if (
			(
				link_type == sAGR_LINK_TYPE && !(tpl.link_type & LTF_AGR)
			) || (
				link_type == sLNK_LINK_TYPE && !(tpl.link_type & LTF_LNK)
			) || (
				link_type == sREF_LINK_TYPE && !(tpl.link_type & LTF_REF)
			)
		) {
			throw Base::FatalError ("Тип связи не разрешен шаблоном");
		}
		
		std::string old_link_type = rad->get_link_type ();
		if (old_link_type != link_type) {
			rad->set_link_type (link_type);
			
			if (link_type == sAGR_LINK_TYPE || link_type == sREF_LINK_TYPE) {
				const AbstractDumper* target = dynamic_cast<const AbstractDumper*> (rad->get_target ());
				if (target) {
					VirtualFunctionsHelper::run_spell_with_suppliers (target);
				}
			}
		}
	} else {
		throw Base::FatalError ("Операция применима только к атрибутам");
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A3F53400188*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

