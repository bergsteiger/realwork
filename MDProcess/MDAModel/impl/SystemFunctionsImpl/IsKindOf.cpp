////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::IsKindOf
//
// _kind_of(«дампер», «мета-класс») - возвращает true, если мета-класс переданного дампера
// совпадает или является наследником от «мета-класс». Пример использования:
// %f_kind_of(S,SimpleClass::Class)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IsKindOf::IsKindOf ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB690080_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB690080_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB690080_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB690080_BODY*
}

IsKindOf::~IsKindOf () {
	//#UC START# *4A2CEB690080_DESTR_BODY*
	//#UC END# *4A2CEB690080_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string IsKindOf::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEB690080*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string dumper_id = TemplatePainter::resolve_exp (params[0], painter);
	std::string::const_iterator it = dumper_id.begin();
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, dumper_id.end ());
	if (adb) {
		AbstractDumperBase::StereotypeID meta_class (TemplatePainter::resolve_exp (params[1], painter));
		const AbstractDumperBase::StereotypeID& adb_meta_class (adb->get_model_stereotype_str());
		
		class local {
		public:
			static bool is_kind_of_impl (const AbstractDumperBase::StereotypeID& source_meta_class, const AbstractDumperBase::StereotypeID& kind) {
				if (source_meta_class == kind) {
					return true;
				}
				
				AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (source_meta_class);
				for (
					AbstractDumperBase::StereotypeSet::const_iterator it = tpl.base_stereotypes.begin ()
					; it != tpl.base_stereotypes.end ()
					; ++it
				) {
					if (is_kind_of_impl (*it, kind)) {
						return true;
					}
				}

				return false;
			}
		};
		
		if (local::is_kind_of_impl (adb_meta_class, meta_class)) {
			return std::string ("true");
		}
	}
	return std::string ("false");
	//#UC END# *4A2CE18202C1_4A2CEB690080*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

