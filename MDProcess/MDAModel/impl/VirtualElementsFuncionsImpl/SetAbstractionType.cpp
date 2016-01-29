////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetAbstractionType
//
// %S%f_set_abstraction_type(abstract|regular|final) - устанавливает тип абтсрактности для
// элемента. Применима ТОЛЬКО для вирутальных элементов. Если тип абстрактности не указан в списке
// разрешенных шаблоном - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClass.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetAbstractionType::SetAbstractionType ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F55F501A5_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F55F501A5_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F55F501A5_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F55F501A5_BODY*
}

SetAbstractionType::~SetAbstractionType () {
	//#UC START# *4A3F55F501A5_DESTR_BODY*
	//#UC END# *4A3F55F501A5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetAbstractionType::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A3F55F501A5*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		IRoseItemPtr item = rad->rose_element ();
		if (item) {			
			std::string abstraction_type = TemplatePainter::resolve_exp (params[0], painter);

			static const std::string sABSTRACT_TYPE = "abstract";
			static const std::string sREGUALR_TYPE = "regular";
			static const std::string sFINAL_TYPE = "final";
			static const std::string sOPTIONAL_TYPE = "optional";

			if (
				abstraction_type != sABSTRACT_TYPE 
				&& abstraction_type != sREGUALR_TYPE 
				&& abstraction_type != sFINAL_TYPE
				&& abstraction_type != sOPTIONAL_TYPE  
			) {
				throw Base::FatalError (
					"Неверный аргумент функции, должен быть abstract|regular|final"
				);
			}
			const AbstractDumperBase::Template& tpl = rad->get_template ();

			if (
				(
					abstraction_type == sABSTRACT_TYPE && !(tpl.abstraction_type & AbstractDumperBase::ATF_ABSTRACT)
				) || (
					abstraction_type == sREGUALR_TYPE && !(tpl.abstraction_type & AbstractDumperBase::ATF_REGULAR)
				) || (
					abstraction_type == sFINAL_TYPE && !(tpl.abstraction_type & AbstractDumperBase::ATF_FINAL)
				) || (
					abstraction_type == sOPTIONAL_TYPE && !(tpl.abstraction_type & AbstractDumperBase::ATF_OPTIONAL)
				)
			) {
				throw Base::FatalError ("Тип абстрактности не разрешен шаблоном");
			}
			
			static std::string tool_name (_bstr_t (TOOL_NAME));
			static std::string prop_name (Base::ABSTRACTION_TYPE);
			
			rad->set_temporary_property (tool_name, prop_name, abstraction_type);
			
			RoseInternal::RoseClass* virtual_cls = item.GetInterfacePtr () 
				? dynamic_cast<RoseInternal::RoseClass*> (item.GetInterfacePtr ()) 
				: 0;
			if (virtual_cls) {
				virtual_cls->set_is_abstract ((abstraction_type == sABSTRACT_TYPE));
			}
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A3F55F501A5*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

