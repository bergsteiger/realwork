////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SetVar
//
// реализация встроенной функции генератора _set_var.
// _set_var («идентификатор», «значение») - определяет и инициализирует глобальную переменную
// (область видимость неограничена) типа ЭЛЕМЕНТ МОДЕЛИ или СТРОКА. Например:
// {code}
// %f_set_var (CURRENT_ELEM, S) .... %{CURRENT_ELEM}N
// %f_set_var (PARENT, P) .... %{PARENT}%CN
// %f_set_var (TEMP, "[{%SM=Interface::Class}{non interface}interface]") .... %{TEMP}N
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetVar::SetVar ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDF41025C_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDF41025C_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDF41025C_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDF41025C_BODY*
}

SetVar::~SetVar () {
	//#UC START# *4A2CDF41025C_DESTR_BODY*
	//#UC END# *4A2CDF41025C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetVar::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDF41025C*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string param (params[1]);
	if (GCL::border_with (param.data(), "\"")) {
		param = TemplatePainter::resolve_exp (param, painter);
		std::string text (param.begin () + 1, param.end () - 1);
		AbstractDumperBase_var arg = new TemplatePainter::TextDumper (text.data());
		
		TemplatePainter::set_var_dumper (var_id, arg.ptr ());
	} else {
		std::string::const_iterator it = param.begin();
		const AbstractDumperBase* dumper = painter->get_dumper_by_template(it, param.end ());

		////нужно проверить, если это текстовый дампер - нужно увеличить на нем счетчик ссылок,
		////иначе он может протухнуть
		//const TemplatePainter::TextDumper* text_dumper = dynamic_cast<const TemplatePainter::TextDumper*> (dumper);
		//if (text_dumper) {
		//	text_dumper->addref ();
		//	TemplatePainter::dumpers_heap ().push_back (const_cast<TemplatePainter::TextDumper*> (text_dumper));
		//}

		TemplatePainter::set_var_dumper (var_id, dumper);
	}
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDF41025C*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

