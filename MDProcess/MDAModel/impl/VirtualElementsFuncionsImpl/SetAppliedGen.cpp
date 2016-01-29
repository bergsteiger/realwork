////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetAppliedGen
//
// %S%f_set_applied_gen(<имя генератора>,<true/false>) - устанавливает или снимает галку Applied
// Generators на элементе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/GCL/str/str_op.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetAppliedGen::SetAppliedGen ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E00E3031F_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E00E3031F_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E00E3031F_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E00E3031F_BODY*
}

SetAppliedGen::~SetAppliedGen () {
	//#UC START# *4A2E00E3031F_DESTR_BODY*
	//#UC END# *4A2E00E3031F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetAppliedGen::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2E00E3031F*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		std::string gen_id = TemplatePainter::resolve_exp (params[0], painter);
		std::string true_or_false = TemplatePainter::resolve_exp (params[1], painter);

		static std::string tool_name (_bstr_t (TOOL_NAME));
		static std::string prop_applgen (_bstr_t(PROP_APPLGEN));

		std::string old_value = rad->get_property_value (tool_name, prop_applgen);
		std::string applied_gens_str = old_value;

		GCL::StrSet applied_gens;
		GCL::split_string_by_sub_string (applied_gens, applied_gens_str.data(), "|");

		if (true_or_false == "true" && applied_gens.find (gen_id) == applied_gens.end ()) {
			applied_gens.insert (gen_id);
		} else if (applied_gens.find (gen_id) != applied_gens.end ()) {
			applied_gens.erase (gen_id);
		}

		applied_gens_str = GCL::join (applied_gens, "|");

		bool prop_updated = old_value != applied_gens_str;

		rad->set_temporary_property (
			tool_name
			, prop_applgen
			, applied_gens_str
		);			

		if (prop_updated) {
			AbstractDumperBase::reset_accepted_generator (rad);
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2E00E3031F*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

