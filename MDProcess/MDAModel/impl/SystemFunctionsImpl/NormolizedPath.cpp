////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedPath
//
// реализация встроенной функции генератора "_normolized_path".
// _normolized_path(«целевой генератор»,«элемент»), например:
// %f_normolized_path(dll.h,C)
// - выводит путь и имя файла генерации для целевого элемента, относительно пути к файлу генерации
// текущего элемента.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NormolizedPath::NormolizedPath ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC0801DE_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC0801DE_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEC0801DE_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEC0801DE_BODY*
}

NormolizedPath::~NormolizedPath () {
	//#UC START# *4A2CEC0801DE_DESTR_BODY*
	//#UC END# *4A2CEC0801DE_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string NormolizedPath::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEC0801DE*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	AbstractDumperBase::GenID tmp = AbstractDumperBase::s_current_map;
	AbstractDumperBase::s_current_map = TemplatePainter::resolve_exp(params[0], painter);
	
	std::string::const_iterator it = params[1].begin();		
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, params[1].end ());
	
	std::string target_path;
	std::string target_root;
	if (adb) {
		target_path = adb->create_relative_file_name();
		target_root = adb->get_root_dir (false);
	}
	
	AbstractDumperBase::s_current_map = tmp;

	if (target_path != "") {
		return painter->get_main_scope ()->create_normolized_path (target_path.data(), target_root.data());
	} else {
		return std::string ();
	}
	//#UC END# *4A2CE18202C1_4A2CEC0801DE*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

