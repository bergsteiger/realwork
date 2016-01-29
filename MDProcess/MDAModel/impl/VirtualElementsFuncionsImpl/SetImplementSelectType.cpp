////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetImplementSelectType
//
// %S%f_set_implement_select_type(all|include|exclude) - устанавливает тип включения для
// реализуемых операций класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClass.h"
#include "MDProcess/MDAModel/Base/Base.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetImplementSelectType::SetImplementSelectType ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F56DD0379_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F56DD0379_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F56DD0379_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F56DD0379_BODY*
}

SetImplementSelectType::~SetImplementSelectType () {
	//#UC START# *4A3F56DD0379_DESTR_BODY*
	//#UC END# *4A3F56DD0379_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetImplementSelectType::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A3F56DD0379*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		std::string target = TemplatePainter::resolve_exp (params[0], painter);		

		const AbstractDumperBase::Template& tpl = rad->get_template ();
		if (!tpl.has_derived_impl) {
			throw Base::FatalError ("Шаблон не позволяет изменять IMPLEMENT_SELECT_TYPE");
		}
		std::string select_type = TemplatePainter::resolve_exp (params[0], painter);

		if (
			select_type != Base::ALL 
			&& select_type != Base::INCLUDE
			&& select_type != Base::EXCLUDE
		) {
			throw Base::FatalError ("Неверный аргумент функции, должен быть all|include|exclude");
		}
		
		std::string tool_name (_bstr_t (TOOL_NAME));
		std::string prop_name (_bstr_t (PROP_IMPLEMENT_SELECT_TYPE));

		rad->set_temporary_property (tool_name, prop_name, select_type);
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A3F56DD0379*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

