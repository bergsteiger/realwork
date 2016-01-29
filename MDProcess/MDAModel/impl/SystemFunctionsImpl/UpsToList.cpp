////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::UpsToList
//
// реализация встроенной функции генератора _ups_to_list.
// _ups_to_list («элемент», «идентификатор») - заполняет в список c заданным идентификатором
// ползовательскими свойствами в формате: «имя свойства» = «значение»
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UpsToList::UpsToList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CED120031_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CED120031_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CED120031_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CED120031_BODY*
}

UpsToList::~UpsToList () {
	//#UC START# *4A2CED120031_DESTR_BODY*
	//#UC END# *4A2CED120031_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string UpsToList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CED120031*
	class local {
	public:
		static const std::string quote_string (const std::string& source) {
			std::string res (source);			
			GCL::str_replace (res, "\"", "\\\"");
			GCL::str_replace (res, "\\", "\\\\");
			res.insert (0, "\"");
			res.append ("\"");

			return res;
		}
	};
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string dumper_id = TemplatePainter::resolve_exp (params[0], painter);
	std::string::const_iterator it = dumper_id.begin();
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, dumper_id.end ());
	
	if (adb != 0) {
		std::string var_id = TemplatePainter::resolve_exp(params[1], painter);
		
		TemplatePainter::ContainerDumper* container = get_container (var_id);
		container->clear ();

		const AbstractDumperBase::Template& tpl = adb->get_template ();
		if (tpl.user_properties_group.is_nil () == false) {
			const AbstractDumperBase::UserPropertyMap& props = tpl.user_properties_group->get_properties ();
			AbstractDumperBase::UserPropertyMap::const_iterator it = props.begin ();
			AbstractDumperBase::UserPropertyMap::const_iterator it_end = props.end ();
			for (; it != it_end; ++it) {
				std::string up_name = local::quote_string (it->first);
				std::string up_value = adb->get_user_property_str (it->first);
				if (up_value.empty ()) {
					up_value = "\"\"";
				} else {
					up_value = local::quote_string (up_value);
				}
				std::string str (up_name + " = " + up_value);
				AbstractDumperBase_cvar arg = new TemplatePainter::TextDumper (str.data());
				container->add (arg.ptr ());

			}			
		}
	}
	return std::string ("");
	//#UC END# *4A2CE18202C1_4A2CED120031*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

