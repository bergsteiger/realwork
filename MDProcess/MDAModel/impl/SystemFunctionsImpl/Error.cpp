////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Error.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Error
//
// реализация встроенной функции генератора "_error".
// _error(«сообщение») - выводит сообщение об ошибке и прекращает генерацию
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Error.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Error::Error ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE92600B3_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE92600B3_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE92600B3_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE92600B3_BODY*
}

Error::~Error () {
	//#UC START# *4A2CE92600B3_DESTR_BODY*
	//#UC END# *4A2CE92600B3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string Error::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE92600B3*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	std::string message = TemplatePainter::resolve_exp(params[0], painter);
	const AbstractDumperBase* adb = painter->get_owner () ? painter->get_owner () : painter->get_main_scope ();
	
	if (adb) {
		adb->write_template_error_log(message.c_str ());
	} else {
		GDS_ASSERT_MSG(adb !=0,("Попытка вызывать функции %%f_error при 0-ом %%S и %%B"));
		throw Base::FatalError ("Попытка вызывать функции %f_error при 0-ом %S и %B");
	}
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CE92600B3*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

