////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::HasNonEmptyGen
//
// реализация встроенной функции генератора _has_non_empty_gen
// _has_non_empty_gen(«дампер»,«генератор») - возвращает true, если дампер имеет не пустой
// генератор, иначе возвращает false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

HasNonEmptyGen::HasNonEmptyGen ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB4801A1_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB4801A1_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB4801A1_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB4801A1_BODY*
}

HasNonEmptyGen::~HasNonEmptyGen () {
	//#UC START# *4A2CEB4801A1_DESTR_BODY*
	//#UC END# *4A2CEB4801A1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string HasNonEmptyGen::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEB4801A1*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string ret ("false");
	std::string dumper = TemplatePainter::resolve_exp(params[0], painter);
	AbstractDumperBase::GenID gen_id = TemplatePainter::resolve_exp(params[1], painter);
	
	std::string::const_iterator it = dumper.begin();
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, dumper.end ());
	if (adb) {
		const AbstractDumperBase::StereotypeID& model_stereotype (adb->get_model_stereotype_str());
		AbstractDumperBase::Templates::iterator f = AbstractDumperBase::s_templates.find (model_stereotype);

		if (f != AbstractDumperBase::s_templates.end()) {
			AbstractDumperBase::GT_map::iterator gen = f->second.generators.find(gen_id);
			if (
				gen != f->second.generators.end()
				&& gen->second.code_template.empty () == false
			) {
				ret = "true";
			}
		}
	}	
	return ret;
	//#UC END# *4A2CE18202C1_4A2CEB4801A1*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

