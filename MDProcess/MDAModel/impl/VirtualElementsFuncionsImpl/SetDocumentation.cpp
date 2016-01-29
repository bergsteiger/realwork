////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDocumentation
//
// %S%f_set_documentation(<Документация>) - устанавливает документацию для элемента. Применима
// ТОЛЬКО к виртуальным элементам
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetDocumentation::SetDocumentation ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A51F81701C8_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A51F81701C8_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A51F81701C8_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A51F81701C8_BODY*
}

SetDocumentation::~SetDocumentation () {
	//#UC START# *4A51F81701C8_DESTR_BODY*
	//#UC END# *4A51F81701C8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetDocumentation::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A51F81701C8*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		std::string documentation = TemplatePainter::resolve_exp (params[0], painter);
		rad->set_documentation (documentation);
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A51F81701C8*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

