////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SplitToList
//
// реализация встроенной функции генератора _split_to_list
// _split_to_list («идентификатор», «строка», «разделитель») - разбивает строку по разделителям,
// фрагменты помещаются в список c заданным идентификатором.  Например:
// %f_split_to_list(ROOT_RELATIVE_PATH,%Sd,/) - разбивает результат %Sd по разделителям /, помещая
// элементы в список ROOT_RELATIVE_PATH
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SplitToList::SplitToList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE46B00AF_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE46B00AF_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE46B00AF_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE46B00AF_BODY*
}

SplitToList::~SplitToList () {
	//#UC START# *4A2CE46B00AF_DESTR_BODY*
	//#UC END# *4A2CE46B00AF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SplitToList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE46B00AF*
	if (params.size () < 3) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 3, params.size ());
	}
	std::string list_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string str = TemplatePainter::resolve_exp(params[1], painter);
	std::string separator = TemplatePainter::resolve_exp(params[2], painter);
	
	GCL::StrVector splited = GCL::split_string_by_sub_string (str.c_str (), separator.c_str ());
	
	TemplatePainter::ContainerDumper* container = get_container (list_id);
	container->clear ();

	for (
		GCL::StrVector::iterator it = splited.begin ()
		; it != splited.end ()
		; ++it
	) {
		AbstractDumperBase_cvar arg = new TemplatePainter::TextDumper (it->data());
		container->add (arg.ptr ());
	}
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CE46B00AF*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

