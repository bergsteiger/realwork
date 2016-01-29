////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetUp
//
// %S%f_set_up(<имя свойства>,<значение UP>) - устанавливает значение юзер-свойства
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUp.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetUp::SetUp ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E007001FB_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E007001FB_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E007001FB_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E007001FB_BODY*
}

SetUp::~SetUp () {
	//#UC START# *4A2E007001FB_DESTR_BODY*
	//#UC END# *4A2E007001FB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetUp::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2E007001FB*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		std::string name = TemplatePainter::resolve_exp (params[0], painter);
		std::string value = TemplatePainter::resolve_exp (params[1], painter);
		IRoseItemPtr item = rad->rose_element ();
		if (item) {
			_bstr_t tool_name (Base::USER_PROPERTY_TOOL);

			rad->set_temporary_property (std::string (tool_name), name, value);			
		} else {
			throw Base::FatalError ("SetUp failed - can't get rose item");
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2E007001FB*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

