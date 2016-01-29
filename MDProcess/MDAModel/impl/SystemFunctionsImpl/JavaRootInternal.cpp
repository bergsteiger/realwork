////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::JavaRootInternal
//
// Возвращает корневую директорию для java исходников
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaRootInternal.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

JavaRootInternal::JavaRootInternal ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB8F0250_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB8F0250_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB8F0250_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB8F0250_BODY*
}

JavaRootInternal::~JavaRootInternal () {
	//#UC START# *4A2CEB8F0250_DESTR_BODY*
	//#UC END# *4A2CEB8F0250_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string JavaRootInternal::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEB8F0250*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string dumper_id = TemplatePainter::resolve_exp (params[0], painter);
	std::string::const_iterator it = dumper_id.begin();
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, dumper_id.end ());
	std::string res;
	if (adb) {
		static std::string java_substr ("java/src/java");
		static size_t java_substr_len (java_substr.length ());

		res = adb->get_root_dir (true);
		res += "/";
		res += adb->create_relative_file_name_with_parent();
		std::string::size_type pos = res.find (java_substr);
		if (pos != std::string::npos) {
			res = res.substr (0, pos + java_substr_len);
		}
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += ": dumper ";
		mess += dumper_id;
		mess += " is null";
		throw Base::FatalError (mess);
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CEB8F0250*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

