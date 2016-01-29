////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToRGB
//
// реализация встроенной функции генератора _to_rgb
// _to_rgb(«число», «разделитель») - преобразует цвет заданный числом в формат RGB, возвращает
// строчку, «разделитель» - разделитель используемый для отделения цветов (по умолчанию
// используется ","), Например:
// %f_to_rgb(100) - вернёт 100,0,0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToRGB.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ToRGB::ToRGB ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECFB01DE_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECFB01DE_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CECFB01DE_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CECFB01DE_BODY*
}

ToRGB::~ToRGB () {
	//#UC START# *4A2CECFB01DE_DESTR_BODY*
	//#UC END# *4A2CECFB01DE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ToRGB::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CECFB01DE*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string colorref_str = TemplatePainter::resolve_exp(params[0], painter);
	std::string delimetr (",");
	if (params.size () >= 2) {
		delimetr = TemplatePainter::resolve_exp(params[1], painter);
	}
	std::string ret;
	if (colorref_str.empty () == false) {			
		try {
			unsigned long color = boost::lexical_cast<unsigned long> (colorref_str);			
			ret = boost::lexical_cast<std::string> ((unsigned long)GetRValue (color));
			ret += delimetr;
			ret += boost::lexical_cast<std::string> ((unsigned long)GetGValue (color));
			ret += delimetr;
			ret += boost::lexical_cast<std::string> ((unsigned long)GetBValue (color));			
		} catch (boost::bad_lexical_cast&) {
			std::string mess ("Bad param in function: ");
			mess += GDS_CURRENT_FUNCTION;
			mess += " (";
			mess += colorref_str;
			mess += ")";

			throw Base::FatalError (mess);
		}
	}
	return ret;
	//#UC END# *4A2CE18202C1_4A2CECFB01DE*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

