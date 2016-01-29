////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrConv.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrConv
//
// реализация встроенной функции генератора "_str_conv".
// _str_conv ("<шаблон>","<строка входного формата>","<строка выходного формата>") - пересобирает
// строку из одного формата в другой
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrConv.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StrConv::StrConv ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE49001EC_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE49001EC_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE49001EC_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE49001EC_BODY*
}

StrConv::~StrConv () {
	//#UC START# *4A2CE49001EC_DESTR_BODY*
	//#UC END# *4A2CE49001EC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StrConv::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE49001EC*
	if (params.size () < 3) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 3, params.size ());
	}
	std::string str (params[0].begin()+1, params[0].end()-1);
	str = TemplatePainter::resolve_exp(str, painter);
	std::string in_format (params[1].begin()+1, params[1].end()-1);
	std::string out_format (params[2].begin()+1, params[2].end()-1);

	GCL::convert_to_scanf_format (in_format);
	GCL::convert_to_scanf_format (out_format);

	return GCL::string_converter(str, in_format, out_format);
	//#UC END# *4A2CE18202C1_4A2CE49001EC*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

