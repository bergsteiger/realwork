////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SetVar
//
// %S%f_set_var(имя переменной,элемент|"строка") - установка переменной, связанной с элементом:
// {code}
// %S%f_set_var(TYPE,T)
// %S%f_set_var(NAME,"%SN")
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetVar::SetVar ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B2219A90037_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B2219A90037_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B2219A90037_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B2219A90037_BODY*
}

SetVar::~SetVar () {
	//#UC START# *4B2219A90037_DESTR_BODY*
	//#UC END# *4B2219A90037_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetVar::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4B2219A90037*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string param (params[1]);
	if (GCL::border_with (param.data(), "\"")) {
		param = TemplatePainter::resolve_exp (param, painter);
		std::string text (param.begin () + 1, param.end () - 1);
		AbstractDumperBase_var arg = new TemplatePainter::TextDumper (text.data());
		self->set_var_dumper (var_id, arg.ptr ());
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

		self->set_var_dumper (var_id, dumper);
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4B2219A90037*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

